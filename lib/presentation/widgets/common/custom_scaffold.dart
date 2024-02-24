import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.bottonBar,
      this.colorAppBar,
      this.iconAppBar,
      required this.route});
  final Widget title;
  final Widget body;
  final Widget? bottonBar;
  final Color? colorAppBar;
  final Widget? iconAppBar;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorAppBar,
          centerTitle: true,
          title: title,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => route),
                );
              },
              icon: iconAppBar ?? const Icon(Icons.close)),
        ),
        body: body,
        bottomNavigationBar: bottonBar,
      ),
    );
  }
}
