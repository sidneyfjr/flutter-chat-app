import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Logo(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    titulo: 'Ya tienes una cuenta?',
                    subTitulo: 'Ingresa ahora!',
                  ),
                  Text(
                    'Terminos y Condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomImput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardtype: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomImput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardtype: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomImput(
            icon: Icons.lock_outline,
            placeholder: 'Contrasena',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
              text: 'Crear Cuenta',
              onPressd: authService.autenticando
                  ? null
                  : () async {
                      print(nameCtrl.text);
                      print(emailCtrl.text);
                      print(passCtrl.text);
                      final registroOk = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passCtrl.text.trim());

                      if (registroOk == true) {
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        print(registroOk);
                         mostrarAlerta(context, 'Registro incorreto', registroOk);
                      }
                    }),
        ],
      ),
    );
  }
}
