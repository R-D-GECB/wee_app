import 'package:flutter/material.dart';

class HerbariumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'About Wee',
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
        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 25.0, 10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WEE Herbarium (Educational Aid)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'WEE (Scottish language) meaning small, it is a new approach of digital herbarium meant for the educational purpose. The specimens are mounted on a handmade paper card (purchased) with QR codes. The herbarium is meant for preserving materials like macro- algae, macro-fungi, lichens, bryophytes, floral parts, smaller angiosperms, etc. The herbarium sheet is having two sides (face 1 & face 2). The herbarium sheet is having a size of 14 x 10.5 cm (2 mm thick).',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'Face 1 (front) : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0, height: 10.0),
              Text(
                'Used to display the dried specimen and two QR codes. The lower side is mounted with a green strip of size 3 x 10.5 cm. The lower-left corner is mounted with QR code 1 (2.5 x 2.5 cm) used to retrieve data available in the main label. The lower right corner is mounted with QR code 2 (2.5 x 2.5 cm) to retrieve the scientific name of the taxon with the author, other citations, detailed descriptions, distribution, useful web links etc. The central portion of the green label (upper) is occupied with a narrow strip of scale (4 cm) showing mm divisions. Below the scale, there is a rectangular colour code to ensure the true colours are represented while digitizing the image.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'Face 2 (back) : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0, height: 10.0),
              Text(
                'The upper half portion is occupied with a specimen pouch of size 6.5 x 8.5 cm used to keep dried specimens, flower parts or stamens for molecular studies, morphological studies or SEM analysis. The lower half portion occupies a data pouch of 7.5 x 5 cm, opening to the bottom. This space is for keeping datasheet of the specimen. The datasheet having a size of 21 x 14 cm on glossy paper of apx. 130 gsm thickness. The paper is folded (3 fold + 1 fold) and inserted into the pouch. The paper is printed with scientific name with author, citations, detailed descriptions, distribution, other information, useful web links, colour photographs, etc. A herbarium label of size 6.5 x 9.5 cm is mounted on face lower half (on the data pouch) indicating the details such as the name of the institution with the place, date of collection, collection number, the scientific name with the author, family, notes, locality, GPS reading and name of the collector.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'Herbarium Pouch : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0, height: 10.0),
              Text(
                'Each herbarium sheet is kept in a paper cover (white) of size 16.5 x 11.5 cm and labelled with a QR code 3 (2.5 x 2.5 cm) on the right upper corner and a pouch label indicating name of the species with author and family (2 x 8 cm) at the centre. The material kept in the cover with a pouch of silica crystals (5 gm).',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'Reading Codes : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0, height: 10.0),
              Text(
                'Details available in QR codes can be easily read by a QR code reader installed in your mobile phone or any QR code reader. The image of face 1 can be captured using a phone/camera (digitize) and further details can be retrieved from the QR codes. Face 2 representing the hard copy of data available in the QR codes and detailed descriptions and other details along with photographs.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'WEE APP (android) ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'It is an app developed to generate labels and datasheet of WEE herbarium. Data input of the WEE app software include:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '1.Name of the organization (CAPITAL- auto font sized to the first line)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '2.Place, locality &amp; pin code (small letter-auto font sized to the second line)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '3.Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '4.Collection number/ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '5.Scientific Name (bold & italics)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '6.Author citation (normal)-auto font sized',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '7.Tabs for infraspecic category (epithet and author citation)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '8.Family (CAPITAL)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '9.Notes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '10.Name of the collector',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '11.Locality: place, district and state',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '12.Coordinates',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '13.Collected by',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '14.Scientific name with citation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '15.Key characters of the species',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '16.Distribution',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '17.Flowering & fruiting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '18.Useful web links for further reference',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                '19.Upload the Image/images for datasheet generation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Text(
                'The App generates 3 QR codes, a label, green label strip with a scale and colour codes (optional), herbarium label and pouch label in specified size and colour. It can be printed on sticker paper and used for the preparation of WEE herbarium. The app also generates a data sheet with detailed description and photographs in PDF format.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
