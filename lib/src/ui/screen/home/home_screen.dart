import 'package:abersoft/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => ProductCubit(
              abersoftRepository: context.read<BaseAbersoftRepository>(),
            )..initialize(),
            child: BlocBuilder<ProductCubit, BaseState<Product>>(
                builder: (context, state) {
              if (state is LoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Out Portofolio',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                RouteName.addProductScreen,
                              );
                              context.read<ProductCubit>()..initialize();
                            },
                            child: Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Best Product',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Container(
                        height: 96,
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.data?.listBestProduct?.length ?? 0,
                          itemBuilder: (context, i) => Container(
                            width: 145,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.data?.listBestProduct?[i].imageUrl ??
                                      '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            margin: EdgeInsets.only(right: 4),
                            child: Center(
                              child: Text(
                                'PRODUCT $i',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'All Product',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 20,
                            childAspectRatio: 145 / 96,
                          ),
                          itemCount: state.data?.listAllProduct?.length ?? 0,
                          itemBuilder: (context, i) => SizedBox(
                            height: 96,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    state.data?.listAllProduct?[i].imageUrl ??
                                        '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'PRODUCT $i',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      );
}
