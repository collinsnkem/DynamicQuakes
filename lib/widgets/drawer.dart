import 'package:earthquake_app/screens/feedback.dart';
import 'package:earthquake_app/widgets/drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Image.asset(
            'images/logo.png',
            width: 270,
          ),
          Divider(thickness: 2, height: 50),
          //! VISIT WEBSITE
          GestureDetector(
            onTap: () => visitWebsite(),
            child: ListTile(
              title: Text('Visit Website'),
              leading: Icon(MaterialCommunityIcons.web),
            ),
          ),
          //! DONATE (COLLINS loves Cryptocurrency :-))
          GestureDetector(
            onTap: () => donateToUs(),
            child: ListTile(
              title: Text('Donate'),
              leading: Icon(FontAwesome.money),
            ),
          ),
          //! RATE COLLINS
          GestureDetector(
            onTap: () {
              rateMyApp(context);
            },
            child: ListTile(
              title: Text('Rate Me'),
              leading: Icon(EvilIcons.like),
            ),
          ),
          //! SHARE APP TO FRIEND
          InkWell(
            onTap: () => shareApp(context),
                      child: ListTile(
              title: Text('Share to friend'),
              leading: Icon(AntDesign.sharealt),
            ),
          ),
          //! FEEDBACK
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return QuakeFeedback();
              }));
            },
                      child: ListTile(
              title: Text('Feedback'),
              leading: Icon(Entypo.new_message),
            ),
          ),
          //! ABOUT US (THE APP & DEVELOPER)
          ListTile(
            title: Text('About'),
            leading: Icon(AntDesign.questioncircleo),
          ),
          //! EXITING THE APP
          InkWell(
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: ListTile(
              title: Text('Exit App'),
              leading: Icon(Ionicons.ios_exit),
            ),
          ),
        ],
      ),
    );
  }
}
