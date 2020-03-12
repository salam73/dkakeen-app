import 'package:madayen/pages/jobs_page.dart';
import 'package:flutter/material.dart';

class JobWidget extends StatelessWidget {
  final Job job;

  const JobWidget({Key key, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: Container(
        child: Center(child: Text(job.jobaccount[0].description)),
      ),
    );
  }
}
