import 'package:flutter/material.dart';

class DailyQuotes extends StatefulWidget {
  const DailyQuotes({Key? key}) : super(key: key);

  @override
  _DailyQuotesState createState() => _DailyQuotesState();
}

class _DailyQuotesState extends State<DailyQuotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: Container(
            child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return cell('Satsang is like a wish-fulfilling tree; one attains whatever is desired.','- Purushotampriyadasji Swami Maharaj');
          },
        )),
      ),
    );
  }

  Widget cell(String quote,String from) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/daily_quote_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset('assets/images/starting_quote.png'),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Image.asset(
                        alignment: AlignmentDirectional.centerStart,
                        'assets/images/standing_line_dq.png',
                        height: 20,
                        width: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Text(
                        quote,style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFFF8240),
                        size: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 50,
                    child: Text(from,
                        style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(
                'assets/images/ending_quote_icon.png',
              ),
            )
          ]),
        ));
  }
}
