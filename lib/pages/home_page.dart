import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_radio_ai_based/ai_utils.dart';
import 'package:fm_radio_ai_based/models/radio.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyRadio>? ro;
  @override
  void initState() {
    fetchRadios();

    super.initState();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    // Map<String, dynamic> jsonData = jsonDecode(radioJson);

    final decodedData = jsonDecode(radioJson);

    var radioData = decodedData["radios"];

    MyradioList.radios =
        List.from(radioData).map<MyRadio>((e) => MyRadio.fromJson(e)).toList();
    ro = MyradioList.radios;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(ro);

    return Scaffold(
      drawer: const  Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(
                  colors: [
                    AIColors.primaryColor2,
                    AIColors.primaryColor1,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
              .make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
                primaryColor: Vx.purple300, secondaryColor: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(100.0).p16(),
          if (ro != null && ro!.isNotEmpty)
            Box(ro: ro)
          else
            const CircularProgressIndicator().centered(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Icon(CupertinoIcons.stop_circle,
                color: Colors.white, size: 50.0),
          ).pOnly(bottom: context.safePercentHeight * 12),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.ro,
  }) : super(key: key);

  final List<MyRadio>? ro;

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      aspectRatio: 1.0,
      itemCount: ro!.length,
      itemBuilder: (context, index) {
        final rad = ro![index];
        return VxBox(
          child: ZStack(
            [
              Positioned(
                top: 0.0,
                right: 0.0,
                child: VxBox(
                  child: rad.category.text.uppercase.white.make().px16(),
                ).height(40).black.alignCenter.withRounded(value: 10.0).make(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: VStack(
                  [
                    rad.name.text.xl3.white.bold.make(),
                    5.heightBox,
                    rad.tagline.text.sm.white.semiBold.make(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: [
                    const Icon(
                      CupertinoIcons.play_circle,
                      color: Colors.white,
                    ),
                    10.heightBox,
                    "Double tap to play".text.gray300.make(),
                  ].vStack())
            ],
          ),
        )
            .clip(Clip.antiAlias)
            .bgImage(
              DecorationImage(
                image: NetworkImage(rad.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            )
            .border(color: Colors.black, width: 5.0)
            .withRounded(value: 50.0)
            .make()
            .p16();
      },
    ).centered();
  }
}
