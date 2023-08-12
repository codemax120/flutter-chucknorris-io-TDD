import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:chuck_norris_io/features/random/presentation/widgets/categories.dart';
import 'package:chuck_norris_io/features/random/presentation/widgets/category.dart';
import 'package:chuck_norris_io/features/random/presentation/widgets/custom_button.dart';
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
  RandomEntity randomEntity = RandomEntity.empty();

  final randomBloc = getIt<RandomBloc>();

  @override
  void initState() {
    randomBloc.add(const GetRandomEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider.value(
        value: randomBloc,
        child: BlocConsumer<RandomBloc, RandomState>(
          listener: (context, state) {
            if (state is SuccessGetRandomState) {
              randomEntity = state.randomEntity;
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: _principalBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _principalBody(RandomState state) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      children: [
        SizedBox(
          height: 5.h,
        ),
        Image.network(
          "https://avatars.githubusercontent.com/u/17794049?s=280&v=4",
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(
          height: 5.h,
        ),
        Visibility(
          visible: state is LoadingState,
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        Visibility(
          visible: state is! LoadingState,
          child: _contentBody(),
        ),
      ],
    );
  }

  Widget _contentBody() {
    return Column(
      children: [
        Visibility(
          visible: randomEntity.categories.isNotEmpty,
          child: Categories(title: 'Categories', list: randomEntity.categories),
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
          height: 5.h,
        ),
        CustomButton(
          title: 'Try again',
          callback: () {
            randomBloc.add(const GetRandomEvent());
          },
        ),
      ],
    );
  }
}
