import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';

class CareerGuidePage extends StatefulWidget {
  //const CareerGuidePage({Key? key}) : super(key: key);

  @override
  _CareerGuidePageState createState() => _CareerGuidePageState();
}

class _CareerGuidePageState extends State<CareerGuidePage> {

  final String appbarTitle = "Career Guidance";
  var optionsList = [
    {
      "icon": FontAwesomeIcons.newspaper,
      "text": "Subscribe to our newsletter",
    },
    {
      "icon": FontAwesomeIcons.questionCircle,
      "text": "Request a career guidance workshop at your school",
    },
    {
      "icon": FontAwesomeIcons.directions,
      "text": "Utilize Our Mentorship Programme",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimeWidgetsHeaders(appbarTitle),
              SizedBox(height: 25,),
              careerOfTheDaySlider(context),
              careerOptionsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget careerOfTheDaySlider (BuildContext context){
    return CarouselSlider(
        items: [careerSlide(context), careerSlide(context)],
        options: CarouselOptions(
          autoPlay: true,
        ),
    );
  }

  Widget careerSlide (BuildContext context){

    String imagePath = "https://images.unsplash.com/photo-1524514587686-e2909d726e9b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
    String heading = "Mechanical Engineering";
    String subHeading = "A career prospect with endless possibilities";

    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: buildCardDescription(imagePath, heading, subHeading),
        ),
        Positioned(
          top: -5,
          right: 20,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Career of the day',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget buildCardDescription(String imagePath, String title, String subTitle){
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: NetworkImage(imagePath),
          height: 200,
          fit: BoxFit.cover,
        ),
        Wrap(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            SizedBox(height: 24,),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Colors.indigo,
                      width: 2.5,
                      style: BorderStyle.solid,
                    ),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              onPressed: (){},
              child: Text('Read More...'),
            )
          ],
        ),
      ],
    );

  }


  Widget careerOptionsList(BuildContext context){
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: optionsList.length,
        itemBuilder: (context, index){
          return Card(
            child: InkWell(
              onTap: (){},
              child: ListTile(
                leading: FaIcon(
                  (optionsList[index])["icon"],
                  size: 14,
                  color: Colors.deepOrange,
                ),
                title: Wrap(
                  children: [
                    Text(
                      (optionsList[index])["text"],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
