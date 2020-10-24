import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

 rateMyApp(BuildContext context){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Thank You for rating Us'),
        content: RatingBar(
    rating: 3,
    icon:Icon(Icons.star,size:30,color: Colors.grey,),
    starCount: 5,
    spacing: 5.0,
    size: 40,
    isIndicator: false,
    allowHalfRating: true,
    onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                  print('Number of stars-->  $value');
                  isIndicator.value=true;
      },
     color: Colors.amber,
      ),
      );
    }
  );
}

void visitWebsite() async {
  const String websiteUrl = 'https://earthquake.usgs.gov/';

  try{
    if(await canLaunch(websiteUrl)){
      await launch(websiteUrl, forceWebView: true, enableJavaScript: true);
    } else {
      //!!Do nothing
    }
  }catch(e){
    print(e);
  }
}

void donateToUs() async {
  const String donate = 'https://dashboard.flutterwave.com/donate/rrjoiftomtxn';
  try{
    if(await canLaunch(donate)){
      await launch(donate);
    }
  }catch(errorDonating){
    print(errorDonating);
  }
}

void shareApp(BuildContext context){
  String shareText = "https://play.google.com/store/apps/ \nCheck out this app on PlayStore, It allows you to see places where EarthQuake has ever happened";

  Share.share(shareText, subject: 'DynamicQuake [Finding EarthQuakes]');
}

