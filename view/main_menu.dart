import 'package:charity_watch/api/filter_api.dart';
import 'package:charity_watch/api/get_all_api.dart';
import 'package:charity_watch/model/charity_model.dart';
import 'package:charity_watch/view/charity_view.dart';
import 'package:charity_watch/view/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dough/dough.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<Charity> charityList = [];
  List<Charity> charityListOrigin = [];
  int charityLength = 0;
  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateCharityList();
  }

  void callback() {
    setState(() {});
  }

  updateCharityList() async {
    charityListOrigin = await getAllCharities();
    setState(() {
      charityLength = charityListOrigin.length;
      charityList = charityListOrigin;
    });
  }

  Color gradeColor(String color) {
    if (color.contains('A')) {
      return Colors.green;
    } else if (color.contains('B')) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  charityRow(Charity charity) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharityView(
              charity,
            ),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 12,
                      child: Text(
                        "${charity.charity}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${charity.grade}",
                        style: TextStyle(
                          color: gradeColor(charity.grade),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showFilter(BuildContext context) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var _categories = <String>[
              "Youth Development",
              "Veterans & Military",
              "Terminally or Chronically Ill",
              "Peace & International Relations",
              "Mental Health & Disabilities",
              "LGBTQ Rights & Advocacy",
              "Jewish & Israel",
              "International Relief & Development",
              "Hunger",
              "Human Services",
              "Homelessness & Housing Charities",
              "Hispanic",
              "Health",
              "Environment",
              "Disabled",
              "Crime & Fire Prevention",
              "Consumer Protection & Legal Aid",
              "Civil Rights & Advocacy",
              "Child Sponsorship",
              "Child Protection",
              "Cancer",
              "Blind & Visually Impaired",
              "Animal & Animal Protection",
              "American Indian",
              "African-American"
            ];

            String selectedCategory;

            return StatefulBuilder(
              builder: (context, setState) {
                return CustomAlertDialog(
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCategory,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                            hint: Text(
                              "Select Category to Filter",
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: _categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.black,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              setState(() {
                                charityLength = 0;
                                charityList = [];
                              });
                              charityList =
                                  await filterCharities(selectedCategory);
                              charityLength = charityList.length;
                              setState(() {});
                              callback();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Apply Filter",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.black,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              setState(() {
                                charityLength = 0;
                                charityList = [];
                              });
                              charityList = await getAllCharities();
                              charityLength = charityList.length;
                              setState(() {});
                              callback();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Reset List",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          });
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: PressableDough(
        child: FloatingActionButton(
          onPressed: () async {
            await showFilter(context);
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.menu),
        ),
      ),
      body: Container(
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
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: charityLength,
                itemBuilder: (context, index) {
                  return charityRow(charityList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
