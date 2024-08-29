import 'package:flutter/material.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_attachment_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_checkbox_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_datepicker_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_dropdown_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_input_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_radio_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_textarea_widget.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_toggle_widget.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/locator.dart';

class RegisterConfigModel {
  String? selectedTimezone;
  List<String>? selectRolesDuringRegistration;
  String? showCertificateAdditionalInRegister;
  String? showOtherRegisterMethod;
  ReferralSettings? referralSettings;
  FormFields? formFields;
  String? registerMethod;
  UserLanguage? userLanguage;
  bool? showGoogleLoginButton;
  bool? showFacebookLoginButton;

  RegisterConfigModel(
      {this.selectedTimezone,
      this.selectRolesDuringRegistration,
      this.showCertificateAdditionalInRegister,
      this.showOtherRegisterMethod,
      this.referralSettings,
      this.formFields,
      this.registerMethod,
      this.userLanguage,
      this.showGoogleLoginButton,
      this.showFacebookLoginButton});

  RegisterConfigModel.fromJson(Map<String, dynamic> json) {
    selectedTimezone = json['selectedTimezone'];
    selectRolesDuringRegistration =
        json['selectRolesDuringRegistration'].cast<String>();
    showCertificateAdditionalInRegister =
        json['showCertificateAdditionalInRegister'];
    showOtherRegisterMethod = json['showOtherRegisterMethod'];
    referralSettings = json['referralSettings'] != null
        ? ReferralSettings.fromJson(json['referralSettings'])
        : null;
    formFields = json['formFields'] != null
        ? FormFields.fromJson(json['formFields'])
        : null;
    registerMethod = json['register_method'];
    userLanguage = json['user_language'] != null
        ? UserLanguage.fromJson(json['user_language'])
        : null;
    showGoogleLoginButton = json['show_google_login_button'];
    showFacebookLoginButton = json['show_facebook_login_button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedTimezone'] = selectedTimezone;
    data['selectRolesDuringRegistration'] = selectRolesDuringRegistration;
    data['showCertificateAdditionalInRegister'] =
        showCertificateAdditionalInRegister;
    data['showOtherRegisterMethod'] = showOtherRegisterMethod;
    if (referralSettings != null) {
      data['referralSettings'] = referralSettings!.toJson();
    }
    if (formFields != null) {
      data['formFields'] = formFields!.toJson();
    }
    data['register_method'] = registerMethod;
    if (userLanguage != null) {
      data['user_language'] = userLanguage!.toJson();
    }
    data['show_google_login_button'] = showGoogleLoginButton;
    data['show_facebook_login_button'] = showFacebookLoginButton;
    return data;
  }
}

class ReferralSettings {
  bool? status;
  bool? usersAffiliateStatus;
  String? affiliateUserCommission;
  String? storeAffiliateUserCommission;
  String? affiliateUserAmount;
  String? referredUserAmount;
  String? referralDescription;

  ReferralSettings(
      {this.status,
      this.usersAffiliateStatus,
      this.affiliateUserCommission,
      this.storeAffiliateUserCommission,
      this.affiliateUserAmount,
      this.referredUserAmount,
      this.referralDescription});

  ReferralSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usersAffiliateStatus = json['users_affiliate_status'];
    affiliateUserCommission = json['affiliate_user_commission'];
    storeAffiliateUserCommission = json['store_affiliate_user_commission'];
    affiliateUserAmount = json['affiliate_user_amount'];
    referredUserAmount = json['referred_user_amount'];
    referralDescription = json['referral_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['users_affiliate_status'] = usersAffiliateStatus;
    data['affiliate_user_commission'] = affiliateUserCommission;
    data['store_affiliate_user_commission'] = storeAffiliateUserCommission;
    data['affiliate_user_amount'] = affiliateUserAmount;
    data['referred_user_amount'] = referredUserAmount;
    data['referral_description'] = referralDescription;
    return data;
  }
}

class FormFields {
  int? id;
  String? url;
  String? cover;
  String? image;
  int? enableLogin;
  int? enableResubmission;
  int? enableWelcomeMessage;
  int? enableTankYouMessage;
  String? welcomeMessageImage;
  String? tankYouMessageImage;
  int? startDate;
  int? endDate;
  int? enable;
  int? createdAt;
  String? title;
  String? headingTitle;
  String? description;
  String? welcomeMessageTitle;
  String? welcomeMessageDescription;
  String? tankYouMessageTitle;
  String? tankYouMessageDescription;
  List<Fields>? fields;
  List<Translations>? translations;

  FormFields(
      {this.id,
      this.url,
      this.cover,
      this.image,
      this.enableLogin,
      this.enableResubmission,
      this.enableWelcomeMessage,
      this.enableTankYouMessage,
      this.welcomeMessageImage,
      this.tankYouMessageImage,
      this.startDate,
      this.endDate,
      this.enable,
      this.createdAt,
      this.title,
      this.headingTitle,
      this.description,
      this.welcomeMessageTitle,
      this.welcomeMessageDescription,
      this.tankYouMessageTitle,
      this.tankYouMessageDescription,
      this.fields,
      this.translations});

  FormFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    cover = json['cover'];
    image = json['image'];
    enableLogin = json['enable_login'];
    enableResubmission = json['enable_resubmission'];
    enableWelcomeMessage = json['enable_welcome_message'];
    enableTankYouMessage = json['enable_tank_you_message'];
    welcomeMessageImage = json['welcome_message_image'];
    tankYouMessageImage = json['tank_you_message_image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    enable = json['enable'];
    createdAt = json['created_at'];
    title = json['title'];
    headingTitle = json['heading_title'];
    description = json['description'];
    welcomeMessageTitle = json['welcome_message_title'];
    welcomeMessageDescription = json['welcome_message_description'];
    tankYouMessageTitle = json['tank_you_message_title'];
    tankYouMessageDescription = json['tank_you_message_description'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['cover'] = cover;
    data['image'] = image;
    data['enable_login'] = enableLogin;
    data['enable_resubmission'] = enableResubmission;
    data['enable_welcome_message'] = enableWelcomeMessage;
    data['enable_tank_you_message'] = enableTankYouMessage;
    data['welcome_message_image'] = welcomeMessageImage;
    data['tank_you_message_image'] = tankYouMessageImage;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['enable'] = enable;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['heading_title'] = headingTitle;
    data['description'] = description;
    data['welcome_message_title'] = welcomeMessageTitle;
    data['welcome_message_description'] = welcomeMessageDescription;
    data['tank_you_message_title'] = tankYouMessageTitle;
    data['tank_you_message_description'] = tankYouMessageDescription;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  int? id;
  int? formId;
  String? type;
  int? isRequired;
  String? title;
  List<Options>? options;
  List<FieldTranslations>? fieldTranslations;


  var userSelectedData;


  Fields(
      {this.id,
      this.formId,
      this.type,
      this.isRequired,
      this.title,
      this.options,
      this.fieldTranslations});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formId = json['form_id'];
    type = json['type'];
    isRequired = json['required'];
    title = json['title'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      fieldTranslations = <FieldTranslations>[];
      json['translations'].forEach((v) {
        fieldTranslations!.add(FieldTranslations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['form_id'] = formId;
    data['type'] = type;
    data['required'] = isRequired;
    data['title'] = title;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (fieldTranslations != null) {
      data['field_translations'] =
          fieldTranslations!.map((v) => v.toJson()).toList();
    }
    return data;
  }


  Widget getWidget(){
    switch (type) {

      case 'input':
        return RegisterInputWidget(
          (data){
            userSelectedData = data;
          }, 
          false, 
          getTitle()
        );
      
      case 'number':
        return RegisterInputWidget(
          (data){
            userSelectedData = data;
          }, 
          true, 
          getTitle()
        );
      
      case 'upload':
        return RegisterAttachmentWidget(
          (data){
            userSelectedData = data;
          }, 
          getTitle()
        );
      
      case 'date_picker':
        return RegisterDatePickerWidget(
          (data){
            userSelectedData = data.toString();
          }, 
          getTitle()
        );
     
      case 'toggle':
        return RegisterToggleWidget(
          (data){
            userSelectedData = data;
          }, 
          getTitle()
        );
      
      case 'textarea':
        return RegisterTextareaWidget(
          (data){
            userSelectedData = data;
          }, 
          getTitle()
        );
      
      case 'dropdown':
        return RegisterDropDownWidget(
          (data){
            userSelectedData = data;
          }, 
          getTitle(),
          options ?? []
        );
      
      case 'checkbox':
        return RegisterCheckboxWidget(
          (data){
            userSelectedData = data;
            // print(userSelectedData.runtimeType);
          }, 
          getTitle(),
          options ?? []
        );
      
      case 'radio':
        return RegisterRadioWidget(
          (data){
            userSelectedData = data;
            // print(userSelectedData.runtimeType);
          }, 
          getTitle(),
          options ?? []
        );

      default:
        return const SizedBox();
    }

  }


  String getTitle(){

    String title = '';
    
    for (FieldTranslations element in fieldTranslations ?? []) {
      if(element.locale == locator<AppLanguage>().currentLanguage){
        title = element.title ?? '';
      }
    }

    if(title.isEmpty){
      for (FieldTranslations element in fieldTranslations ?? []) {
        if(element.locale == 'en'){
          title = element.title ?? '';
        }
      }
    }

    return title;
  }

}

class Options {
  int? id;
  int? formFieldId;
  String? title;
  List<FieldTranslations>? fieldTranslations;

  Options({this.id, this.formFieldId, this.title, this.fieldTranslations});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formFieldId = json['form_field_id'];
    title = json['title'];
    if (json['translations'] != null) {
      fieldTranslations = <FieldTranslations>[];
      json['translations'].forEach((v) {
        fieldTranslations!.add(FieldTranslations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['form_field_id'] = formFieldId;
    data['title'] = title;
    if (fieldTranslations != null) {
      data['translations'] = fieldTranslations!.map((v) => v.toJson()).toList();
    }
    return data;
  }


  String getTitle(){

    String title = '';
    
    for (FieldTranslations element in fieldTranslations ?? []) {
      if(element.locale == locator<AppLanguage>().currentLanguage){
        title = element.title ?? '';
      }
    }

    if(title.isEmpty){
      for (FieldTranslations element in fieldTranslations ?? []) {
        if(element.locale == 'en'){
          title = element.title ?? '';
        }
      }
    }

    return title;
  }

}

class FieldTranslations {
  int? id;
  int? formFieldOptionId;
  String? locale;
  String? title;

  FieldTranslations({this.id, this.formFieldOptionId, this.locale, this.title});

  FieldTranslations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formFieldOptionId = json['form_field_option_id'];
    locale = json['locale'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['form_field_option_id'] = formFieldOptionId;
    data['locale'] = locale;
    data['title'] = title;
    return data;
  }
}


class UserLanguage {
  String? aR;
  String? eN;
  String? eS;

  UserLanguage({this.aR, this.eN, this.eS});

  UserLanguage.fromJson(Map<String, dynamic> json) {
    aR = json['AR'];
    eN = json['EN'];
    eS = json['ES'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AR'] = aR;
    data['EN'] = eN;
    data['ES'] = eS;
    return data;
  }
}