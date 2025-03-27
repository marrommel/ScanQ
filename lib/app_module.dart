import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/home/activity_home.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<Database>(Database.new, config: BindConfig(onDispose: (db) => db.close()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => Scaffold(
        appBar: null,
        body: SafeArea(child: const ActivityHome()),

        //   ListView(children: [
        //   Container(
        //       margin: const EdgeInsets.all(15),
        //       child: Material(
        //           elevation: 3,
        //           borderRadius: const BorderRadius.all(Radius.circular(5)),
        //           child: Container(padding: const EdgeInsets.all(20), child: const ActivityHome())))
        // ]),
      ),
    );
  }
}
