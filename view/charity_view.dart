import 'package:charity_watch/model/charity_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CharityView extends StatefulWidget {
  CharityView(this.charity);

  final Charity charity;

  @override
  _CharityViewState createState() => _CharityViewState(charity);
}

class _CharityViewState extends State<CharityView> {
  _CharityViewState(this.charity);
  final Charity charity;

  @override
  Widget build(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Color gradeColor(String color) {
      if (color.contains('A')) {
        return Colors.greenAccent;
      } else if (color.contains('B')) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }

    final top = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                charity.charity,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 34.0,
                ),
              ),
              Text(
                charity.category,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.normal,
                  color: Colors.white60,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                charity.grade,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.normal,
                  color: gradeColor(charity.grade),
                  fontSize: 85.0,
                ),
              ),
              Text(
                charity.effectiveness,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 65.0,
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                "${charity.charity} uses ${charity.effectiveness} of it's "
                "donations directly towards their charity work.  The outstanding "
                "percentage is used towards overhead and salaries of employees.",
                maxLines: 5,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final bottom = Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            onPressed: () async {
              await _launchURL(charity.url);
            },
            child: Text(
              "See More Info",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ],
    );

    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xff21263b),
              const Color(0xff272e46),
              const Color(0xff303a5a),
              const Color(0xff3c4871),
              const Color(0xff3f4c77),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 30,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
                child: top,
              ),
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
