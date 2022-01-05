import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<int> painScore = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int score = 0;
  String message = 'No Pain';

  onScoreChange(int index) {
    setState(() {
      score = index;
    });
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child('scores/$index');
    dbRef.once().then((DataSnapshot snapshot) => {
          setState(() {
            message = snapshot.value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(color: HexColor('B7F2EC')),
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 60 / 100,
                  child: Text(
                    'You have 2 more sessions today',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 170),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Pain Score',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'How does your knee feel now ?',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: PageView.builder(
                      itemCount: painScore.length,
                      scrollDirection: Axis.horizontal,
                      controller: PageController(viewportFraction: 0.2),
                      onPageChanged: (int index) {
                        onScoreChange(index);
                      },
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          top: index == score ? 0 : 30,
                        ),
                        child: Column(
                          key: ValueKey(index),
                          children: [
                            Text(
                              painScore[index].toString(),
                              style: TextStyle(
                                color:
                                    index == score ? Colors.black : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: index == score ? 60 : 30,
                              child: const VerticalDivider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (index == score)
                              Text(
                                message,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
