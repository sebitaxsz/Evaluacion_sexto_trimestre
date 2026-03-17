import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/role_viewmodel.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import 'home_view.dart';

class CreateRoleView extends StatefulWidget {
  const CreateRoleView({super.key});

  @override
  State<CreateRoleView> createState() => _CreateRoleViewState();
}

class _CreateRoleViewState extends State<CreateRoleView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoleViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Un Nuevo Rol'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<RoleViewModel>(
            builder: (context, roleVM, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Crea un nuevo ROL',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa los campos para crear un nuevo rol en la base de datos',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Campo Nombre
                            CustomTextField(
                              controller: _nameController,
                              label: 'Nombre del Rol',
                              prefixIcon: Icons.badge,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingresa El nombre Del Nuevo Rol';
                                }
                                if (value.length < 5) {
                                  return 'Mínimo 5 letras';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Campo Descripción
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Descripcion Del Nuevo Rol :3',
                                prefixIcon: const Icon(Icons.description),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No es posible continuar sin una descripcion del rol';
                                }
                                if (value.length < 5) {
                                  return 'Mínimo 5 caracteres en la descripcion';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            // Mensaje de éxito
                            if (roleVM.successMessage != null)
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.green),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        roleVM.successMessage!,
                                        style: const TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                            //  Mensaje de error
                            if (roleVM.errorMessage != null)
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        roleVM.errorMessage!,
                                        style:  TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            //  -- Botón Guardar -- //
                            CustomButton(
                              text: 'Guardar Rol',
                              isLoading: roleVM.isLoading,
                              onPressed: () => _handleCreateRole(context, roleVM),
                            ),
                            Center(child: Text('No darle 2 veces al guardar rol ya que se buguea, solucion a futuro', style: TextStyle(fontSize: 20),)),
                            
                            SizedBox(height: 10),
                            
                            // Botón Continuar : Claramente solo me sirve si lo anterior es exitoso
                            if (roleVM.successMessage != null)
                              CustomButton(
                                text: 'Continuar al Home',
                                color: Colors.green,
                                onPressed: () => _navigateToHome(context),
                              ),
                              
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleCreateRole(BuildContext context, RoleViewModel roleVM) async {
    roleVM.clearMessages();
    
    if (_formKey.currentState?.validate() ?? false) {
      await roleVM.createRole(
        _nameController.text,
        _descriptionController.text,
      );
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}