import 'package:flutter/material.dart';
import 'package:webinar/app/services/user_service/financial_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/utils.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class BankAccountsPage extends StatefulWidget {
  static const String pageName = '/bank-accounts';
  const BankAccountsPage({super.key});

  @override
  State<BankAccountsPage> createState() => _BankAccountsPageState();
}

class _BankAccountsPageState extends State<BankAccountsPage> {

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(
          title: appText.bankAccount
        ),

        body: FutureBuilder(
          future: FinancialService.getBankAccounts(),
          builder: (context,data) {
            return data.connectionState == ConnectionState.waiting
          ? loading()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: padding(),

              child: Column(
                children: [
                  
                  space(12),

                  ...List.generate(data.data?.length ?? 0, (index) {
                    return Container(
                      padding: padding(horizontal: 16,vertical: 20),
                      margin: const EdgeInsets.only(bottom: 16),
                      width: getSize().width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [boxShadow(Colors.black.withOpacity(.03))],
                        borderRadius: borderRadius()
                      ),

                      child: Column(
                        children: [

                          Image.network(
                            '${Constants.dommain}${data.data?[index].logo}',
                            height: 50,
                          ),

                          space(10),

                          Text(
                            checkTitleWithLanguage(data.data?[index].translations  ?? []) ,
                            style: style16Bold(),
                          ),

                          space(26),

                          ...List.generate(data.data?[index].specifications?.length ?? 0, (i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  checkTitleWithLanguage(data.data![index].specifications![i].translations!),
                                  style: style14Bold(),
                                ),
                                
                                Text(
                                  data.data?[index].specifications?[i].value ?? '',
                                  style: style14Regular().copyWith(color: greyB2),
                                ),
                              ],
                            );
                          })

                        ],
                      ),
                    );
                  })
                ],
              ),

            );
          }
        ),
      )
    );
  }
}