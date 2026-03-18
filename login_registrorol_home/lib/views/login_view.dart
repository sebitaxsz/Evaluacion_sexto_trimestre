import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import 'create_role_view.dart';
import 'home_view.dart';
import '../utils/validators.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                // --- TITULO PRINCIPAL --- //
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Iniciar sesion',
                      style: TextStyle(
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                // -------------------------- //

                // --- TEXTOS PEQUEÑOS --- //
                SizedBox(height: 8),
                Center(
                  child: Text(
                    ' "Recuerda Iniciar Sesion Con las Credenciales de la base de datos" ',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(height: 50),
                // ----------------------- //

                // --- FoRMULARIO --- //
                Consumer<AuthViewModel>(
                  builder: (context, authVM, child) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // --- Campo Email --- //
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            prefixIcon: Icons.email,
                            validator: Validators.validateEmail,
                          ),
                          SizedBox(height: 20),
                          // -------------------- //

                          // --- Campo Contraseña --- //
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Contraseña',
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            validator: Validators.validatePassword,
                          ),
                          const SizedBox(height: 30),
                          // ------------------------ //

                          //  --- Mensaje de error --- //
                          if (authVM.errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red.shade700,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      authVM.errorMessage!,
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 20),
                          // ------------------------ //

                          // --- Botón de inicio de sesión ---//
                          CustomButton(
                            text: 'Iniciar Sesión',
                            isLoading: authVM.isLoading,
                            onPressed: () => _handleLogin(context, authVM),
                          ),
                          // --------------------------------- //

                          // ---- BOTON DE REDIRECCION AL CREACION DE ROL ---- //
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿QUIERES CREAR UN ROL?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CreateRoleView(),
                                    ),
                                  );
                                },
                                child: const Text('CREAR ROL',style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                          // ------------------------------------------------- //
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, AuthViewModel authVM) async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      // Intentar login
      final success = await authVM.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success && context.mounted) {
        // AMENSAJE TEMPORTAL PARA VERIFICAR SI SE INICIO SESION CON EXITO //
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Correcto, iniciando segunda vista :3'),
            backgroundColor: Colors.green,
          ),
        );

        // Aqui se genera una validacion: Si las credenciales son correctas y el inicio de sesion es correcto
        // Cargara la vista #2
        if (success && context.mounted) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          }
        }
      }
    }
  }
}
