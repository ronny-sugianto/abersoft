import 'package:abersoft/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<AuthenticateCubit, BaseState>(
              builder: (context, state) => Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 235,
                              height: 53,
                              child: Image(
                                alignment: Alignment.center,
                                image: AssetImage('assets/images/logo.png'),
                              ),
                            ),
                            const SizedBox(height: 100),
                            TextFormField(
                              controller: _username,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(8),
                                hintText: 'Username',
                                hintStyle: const TextStyle(),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: _password,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(8),
                                hintText: 'Password',
                                hintStyle: const TextStyle(),
                              ),
                            ),
                            const SizedBox(height: 24),
                            PrimaryButtonWidget(
                              onTap: () =>
                                  context.read<AuthenticateCubit>().login(
                                        username: _username.text,
                                        password: _password.text,
                                      ),
                              title: 'LOGIN',
                            )
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
                  )),
        ),
      );
}
