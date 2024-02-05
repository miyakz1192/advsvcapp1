import 'package:flutter/material.dart';
import 'advice_summary_model.dart';

class DialogDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会話詳細'),
      ),
      body: Container(
        color: Colors.deepPurple,
      ),
    );
  }
}