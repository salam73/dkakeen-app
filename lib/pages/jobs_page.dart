import 'package:madayen/widgets/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Job {
  final String title;
  final String pic;
  final List<JobAccount> jobaccount;

  Job(this.title, this.pic, this.jobaccount);
}

class JobAccount {
  final String title;
  final String description;

  JobAccount(this.title, this.description);
}

class ItemBuilder2 {
  int i = 0;

  String S({String url = 'https://picsum.photos/100/100?random=1'}) {
    return url;
  }

  List<Job> listJob() {
    return [
      Job('نجار قالب', S(url: 'http://salam.dk/img/najar.png'), [
        JobAccount(
            'نجاب قالب',
            'سلام الكشيمري , تليفون : ٣١٢٢٣٣٨٨ \n'
                'سلام الكشيمري , تليفون : ٣١٢٢٣٣٨٨ \n'
                'سلام الكشيمري , تليفون : ٣١٢٢٣٣٨٨ \n'
                'سلام الكشيمري , تليفون : ٣١٢٢٣٣٨٨ \n'
                'سلام الكشيمري , تليفون : ٣١٢٢٣٣٨٨ \n')
      ]),
      Job(
          'مبرمج أجهزة',
          S(url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQoWKEnszlGC4Vl1XK4qjvNd265EZet6MnT_YeGk9F_Gx6vpEAL'),
          [JobAccount('نجاب قالب', '')]),
      Job('صيانة مكائن خياطة', S(url: 'http://salam.dk/img/makna_rep.jpeg'),
          [JobAccount('نجاب قالب', '')]),
      Job('كهربائي', S(url: 'http://salam.dk/img/electric.png'),
          [JobAccount('', '')]),
      Job('سباك تأسيسات صحية', S(url: 'http://salam.dk/img/bath_rep.png'),
          [JobAccount('', '')]),
      Job('مصور مناسبات', S(), [JobAccount('', '')]),
      Job('خلفة بناء وتطبيق ارضيات', S(), [JobAccount('', '')]),
      Job('صيانة طبخات وغسالات', S(url: 'http://salam.dk/img/ketchen_rep.png'),
          [JobAccount('', '')]),
      Job('حداد', S(url: 'http://salam.dk/img/hadad.png'),
          [JobAccount('', '')]),
      Job('صباغ منازل', S(), [JobAccount('', '')]),
      Job('لياخ', S(), [JobAccount('', '')]),
      Job('خلفة سيراميك', S(), [JobAccount('', '')]),
      Job('تركيب وصيانة', S(), [JobAccount('', '')]),
      Job('تركيب وفتح غرف النوم', S(), [JobAccount('', '')]),
      Job('', S(), [JobAccount('', '')]),
    ];
  }
}

class JobsPage extends StatelessWidget {
  var jobSections = ItemBuilder2().listJob();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: jobSections
            //.where((job) => job.jobaccount[0].description != '')
            .map(
              (f) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobWidget(job: f)));
                },
                child: Card(
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              f.title,
                              style: GoogleFonts.almarai(fontSize: 20),
                            )),
                      ),
                      Card(
                        elevation: 4,
                        child: Image.network(
                          f.pic,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}
