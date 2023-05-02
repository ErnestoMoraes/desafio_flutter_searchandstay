// ignore_for_file: unnecessary_string_interpolations, avoid_print
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/messages.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/size_extensions.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/colors_app.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/text_styles.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/widgets/my_input_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Messages {
  final formKey = GlobalKey<FormState>();
  TextEditingController matriculaEC = TextEditingController();
  TextEditingController senhaEC = TextEditingController();
  bool _obscuredText = true;

  @override
  void dispose() {
    matriculaEC.dispose();
    senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(context.percentWidth(.03)),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: context.percentHeight(.3),
                      ),
                      Text(
                        'Search and Stay',
                        style: TextStyles.instance.texLabelH1.copyWith(
                          color: ColorsApp.instance.cardwhite,
                          fontSize: 35,
                          fontWeight:
                              TextStyles.instance.textButtonLabel.fontWeight,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: matriculaEC,
                        keyboardType: TextInputType.number,
                        style: TextStyles.instance.texLabelH4.copyWith(
                          color: ColorsApp.instance.labelblack1,
                          fontSize: 20,
                          fontWeight:
                              TextStyles.instance.textButtonLabel.fontWeight,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'matricula',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: senhaEC,
                        obscureText: _obscuredText,
                        style: TextStyles.instance.texLabelH4.copyWith(
                          color: ColorsApp.instance.labelblack1,
                          fontSize: 20,
                          fontWeight:
                              TextStyles.instance.textButtonLabel.fontWeight,
                        ),
                        decoration: InputDecoration(
                          hintText: 'senha',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscuredText = !_obscuredText;
                              });
                            },
                            icon: Icon(
                                _obscuredText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorsApp.instance.labelblack1,
                                size: 25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: MyInputButton(
                                height: 60,
                                label: 'Login',
                                onPressed: () {
                                  if (matriculaEC.text == '123123' &&
                                      senhaEC.text == '123123') {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/home');
                                  } else {
                                    showError('Matricula ou senha inválida');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.percentHeight(.1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// controller
//   ..runJavaScript(
//       "javascript:document.getElementById('txtLogin').value = '${matriculaEC.text}'")
//   ..runJavaScript(
//       "javascript:document.getElementById('txtSenha').value = '${senhaEC.text}'")
//   ..runJavaScript(
//       "javascript:document.forms['frmLogin'].submit()");
// print('foi');