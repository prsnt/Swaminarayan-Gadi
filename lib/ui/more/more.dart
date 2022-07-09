import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:appstructure/utils/widgets_dir.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: Container(
          margin:  EdgeInsets.only(left: Dimentions.widthMargin05,right: Dimentions.widthMargin10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsDir().backBtn(),
              /*moreOption(AppLocalizations.of(context)!.locations),
              moreOption(AppLocalizations.of(context)!.about_us),
              moreOption(AppLocalizations.of(context)!.contact_us),
              moreOption(AppLocalizations.of(context)!.terms_service),
              moreOption(AppLocalizations.of(context)!.privacy_policy)*/
              moreOption('assets/images/place.png', 'Locations'),
              moreOption('assets/images/about_us.png', 'About Us'),
              moreOption('assets/images/call.png', 'Contact Us'),
              moreOption(
                  'assets/images/terms_condition.png', 'Terms & Service'),
              moreOption('assets/images/privacy_policy.png', 'Privacy Policy'),
              Container(
                margin:  EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.heightMargin35),
                child: Text(
                  'Settings'.toUpperCase(),

                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: widgetDropdown('Themes','Dark Mode','assets/images/themes.png'),
              ),
              widgetDropdown('Language','English','assets/images/translate.png'),
              Padding(
                padding:
                 EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.heightMargin25, right: Dimentions.widthMargin15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/version.png',
                          height: Dimentions.widthMargin20,
                          width: Dimentions.widthMargin20,
                          color: Theme.of(context).iconTheme.color,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: Dimentions.widthMargin15),
                          child: Text(
                            'Version',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '1.5',
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetDropdown(String name,String selectedString,String imgUrl)
  {
    return Padding(
      padding:
      EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.heightMargin25, right: Dimentions.widthMargin15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imgUrl,
                height: Dimentions.widthMargin20,
                width: Dimentions.widthMargin20,
                color: Theme.of(context).iconTheme.color,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin15),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedString,
                style: Theme.of(context).textTheme.bodyText2,
              ),
               Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:CustomColors.IconColor,
                  size: Dimentions.widthMargin15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget moreOption(String imageUrl, String title) {
    return Padding(
      padding:  EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.widthMargin25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            height: Dimentions.widthMargin20,
            width: Dimentions.widthMargin20,
            color: Theme.of(context).iconTheme.color,
            fit: BoxFit.fill,
          ),
          Padding(
            padding:  EdgeInsets.only(left: Dimentions.widthMargin15),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }
}
