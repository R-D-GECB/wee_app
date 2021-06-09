import 'package:flutter/material.dart';

class ProcedureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Procedure',
          style: TextStyle(
            fontSize: 30.0,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Procedure for preparation of WEE Herbarium',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '1.Prepare a handmade paper card of size (14 x 10.5cm).',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '2.Prepare and mount paper pouch of size 8.5 x 6.5 cm on face 2 upper half used to keep dried plant materials, flower parts or stamens for molecular studies, morphological studies of SEM analysis.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '3.Prepare and mount pouch of size 7.5 x 5 cm, opening to the bottom for datasheet insertion.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '4.Prepare a description of the material.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '5.Press and dry the plant materials suitable for the herbarium.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '6.Identify the species with authentic literature, types, prologue etc and collect all the relevant data required for the herbarium.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '7.Generate QR code 1, 2 and 3 using WEE App software.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '8.Generate face 2 herbarium label and mount on the data pouch.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '9.Generate a green label on the lower side of the face 1(size 3 x 10.5 cm).',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '10.Mount QR code 1 (2 x 2 cm) on the lower-left corner of face 1 to retrieve the data available in the herbarium label (face 2).',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '11.Mount QR 2 on the lower right corner (2.5 x 2.5 cm) to retrieve the scientific name of the taxon with author and other citations, detailed descriptions, distribution, useful web links etc.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '12.Mount the central portion of the green label with a narrow strip of scale (4 cm) showing mm divisions. Below the scale, a rectangular colour code to ensure that true colours are represented while digitizing the image.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '13.Generate datasheet and keep in the data pouch on the face 2.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '14.Mount the dried plant specimen on the space available in the face 1.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '15.Keep dried specimens in the specimen pouch on face 2.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '16.Prepare herbarium pouch (white) of size 16.5 x 11.5 cm and labelled with QR code 3 (2.5 x 2.5 cm) on the right upper corner and a label indicating the name of the species with author and family (2 x 8 cm) at the centre. Keep the materials in the cover with a pouch of silica crystals (5 gm).',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 20.0, height: 20.0),
                Text(
                  '17.Arrange the specimen in suitable boxes according to an accepted system of classification for future reference.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/sample.jpg'),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
