import 'dart:io';

import 'package:abersoft/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => ProductCubit(
              abersoftRepository: context.read<BaseAbersoftRepository>(),
            ),
            child: BlocConsumer<ProductCubit, BaseState>(
              listener: (context, state) {
                if(state is SuccessState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Product',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 46,
                            horizontal: 40,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    setState(
                                        () => _image = File(pickedFile.path));
                                  }
                                },
                                child: Container(
                                  height: 156,
                                  margin: const EdgeInsets.only(bottom: 35),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                    image: _image != null
                                        ? DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('PRODUCT IMAGE'),
                                ),
                              ),
                              TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(8),
                                  hintText: 'Product Name',
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 9),
                              TextFormField(
                                controller: _description,
                                maxLines: null,
                                maxLength: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.all(8),
                                  hintText: 'Product Description',
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              PrimaryButtonWidget(
                                onTap: () => _image != null
                                    ? context.read<ProductCubit>().upload(
                                          name: _name.text,
                                          description: _description.text,
                                          image: _image!,
                                        )
                                    : null,
                                title: 'Upload',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is LoadingState) ...[
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.white.withOpacity(.8),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
