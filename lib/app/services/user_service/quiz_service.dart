import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/list_quiz_model.dart';
import 'package:webinar/app/models/quize_model.dart';
import 'package:webinar/common/components.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';

class QuizService{

  static Future<List<ListQuizModel>> getList()async{
    List<ListQuizModel> data = [];

    // try{
      String url = '${Constants.baseUrl}instructor/quizzes/list';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        
        for (var j = 0; j < jsonResponse['data']['quizzes'].length; j++) {
          
          int counter = 0;
          int userGradeSum = 0;
          
          if(jsonResponse['data']['quizzes_results'] != null){
            try{
              
              for (var i = 0; i < jsonResponse['data']['quizzes_results'].length; i++) {

                if(jsonResponse['data']['quizzes_results'][i]['quiz_id'] == jsonResponse['data']['quizzes'][j]['id']){
                  counter++;
                  userGradeSum += int.tryParse(jsonResponse['data']['quizzes_results'][i]['user_grade']?.toString() ?? '0') ?? 0;
                }
              }
            }catch(e){}
            // print('---------');
            // print(counter);
            // print(userGradeSum / counter);
          }
          
          jsonResponse['data']['quizzes'][j]['avrage'] = (userGradeSum / counter);
          jsonResponse['data']['quizzes'][j]['studentCount'] = counter;
          
          data.add(ListQuizModel.fromJson(jsonResponse['data']['quizzes'][j]));
        }

        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    // }catch(e){
    //   return data;
    // }
  }

  static Future<List<QuizModel>> getMyResults()async{
    List<QuizModel> data = [];

    try{
      String url = '${Constants.baseUrl}panel/quizzes/results/my-results';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data']['results'].forEach((json){
          data.add(QuizModel.fromJson(json));
        });

        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    }catch(e){
      return data;
    }
  }

  static Future<List<QuizModel>> getStudentResults()async{
    List<QuizModel> data = [];

    try{
      String url = '${Constants.baseUrl}panel/quizzes/results/my-student-result';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data']['results'].forEach((json){
          data.add(QuizModel.fromJson(json));
        });

        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    }catch(e){
      return data;
    }
  }
  

  static Future<List<Quiz>> getNotParticipated()async{
    List<Quiz> data = [];

    try{
      String url = '${Constants.baseUrl}panel/quizzes/not_participated';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data']['quizzes'].forEach((json){
          data.add(Quiz.fromJson(json));
        });

        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    }catch(e){
      return data;
    }
  }
  
  static Future<Map?> startQuiz(int quizId) async {
    try{
      String url = '${Constants.baseUrl}panel/quizzes/$quizId/start';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){

        return {
          'quiz' : Quiz.fromJson(jsonResponse['data']['quiz']),
          'quiz_result_id' : jsonResponse['data']['quiz_result_id']
        };
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future<QuizModel?> reviewQuiz(int quizId, String beforTab) async {
    try{
      
      
      String url = beforTab == 'StudentResults' ? '${Constants.baseUrl}panel/quizzes/results/$quizId' : '${Constants.baseUrl}panel/quizzes/$quizId/result';
      print(url);


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){

        // Map<String, dynamic> data = {};
        
        // data['id'] = jsonResponse['data']['quizResult']['id'];
        // data['quiz'] = jsonResponse['data']['quizResult']['quiz'];
        // data['answer_sheet'] = jsonResponse['data']['userAnswers'];

        if(beforTab == 'StudentResults'){
          return QuizModel.fromJson(jsonResponse['data']['quizResultDetails']);
        }else{
          return QuizModel.fromJson(jsonResponse['data']);
        }

      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<bool> storeResult(int quizId,int quizResultId, List<Question> questions) async {
    try{
      String url = '${Constants.baseUrl}panel/quizzes/$quizId/store-result';
      // print(url);

      List data = [
        ...List.generate(questions.length, (index) {

          if(questions[index].type == 'descriptive'){
            return {
              'question_id' : questions[index].id,
              'answer' : questions[index].inputController.text.trim(),
            };

          }else{
            return {
              'question_id' : questions[index].id,
              'answer' : questions[index].answers?.singleWhere((element) => element?.isSelected == true, orElse: () => Answer())?.id,
            };
          }

        })
      ];

      data.removeWhere((element) => element['answer'] == null);
      

      Response res = await httpPostWithToken(
        url, 
        {
          "quiz_result_id" : quizResultId,
          "answer_sheet" : data
        }
      );
      

      var jsonResponse = jsonDecode(res.body);
      // print(jsonResponse);
      
      if(jsonResponse?['success'] ?? false){

        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future<bool> storeReview(int quizResultId, List<Question> questions) async {
    try{
      String url = '${Constants.baseUrl}panel/quizzes/results/$quizResultId/review';

      List<int> qId = [];
      List aId = [];
      List gId = [];

      for (var item in questions) {
        if(item.type == 'descriptive'){
          qId.add(item.id!);
          aId.add(null);
          gId.add(item.gradeForUser.toString());
        }
      }

      Map body = {};

      for (var i = 0; i < qId.length; i++) {
        body.addEntries(
          {
            'value$i' : {
              "question_id" : qId[i],
              "answer" : aId[i],
              "grade" : gId[i]
            }
          }.entries
        );
      }

      Response res = await httpPostWithToken(
        url, 
        body
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message'].toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }

}