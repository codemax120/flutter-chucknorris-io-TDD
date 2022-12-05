import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RandomChuckNorrisScreen extends StatefulWidget {
  static const routeName = '/';

  const RandomChuckNorrisScreen({Key? key}) : super(key: key);

  @override
  State<RandomChuckNorrisScreen> createState() =>
      _RandomChuckNorrisScreenState();
}

class _RandomChuckNorrisScreenState extends State<RandomChuckNorrisScreen> {
  RandomEntity randomEntity = const RandomEntity(
    id: "",
    url: "",
    value: "",
    iconUrl: "",
    createdAt: "",
    updatedAt: "",
    categories: [],
  );

  @override
  Widget build(BuildContext context) {
    final randomBloc = getIt<RandomBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<RandomBloc>(
        create: (context) {
          randomBloc.add(const GetRandomEvent());
          return randomBloc;
        },
        child: BlocConsumer<RandomBloc, RandomState>(
          listener: (context, state) {
            if (state is SuccessGetRandomState) {
              setState(() {
                randomEntity = state.randomEntity;
              });
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: state is LoadingGetRandomState
                    ? _loading()
                    : _principalBody());
          },
        ),
      ),
    );
  }

  Widget _principalBody() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      children: [
        SizedBox(
          height: 10.h,
        ),
        Image.network(
          "https://avatars.githubusercontent.com/u/17794049?s=280&v=4",
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          randomEntity.value,
          textAlign: TextAlign.justify,
          style: GoogleFonts.jost(
            fontWeight: FontWeight.w800,
            fontSize: 0.3.dp,
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
      ],
    );
  }

  Widget _loading() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
