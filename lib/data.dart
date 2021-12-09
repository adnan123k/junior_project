import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

const textDirection = TextDirection.rtl;
const drawerColor = Color(0xffFFE459);
const textFieldRadius = 10.0;
const raisedButtonRadius = 10.0;
const raisedButtonColor = Color(0xff0F52BA);
const cursorColor = Color(0xff000000);
const _assetsFolder = "assets/image/";
const String logoImage = _assetsFolder + "logo.png";
const String logingInImage = _assetsFolder + "loginInImage.jpeg";
const String arabic = _assetsFolder + "arabic.jpeg";
const String english = _assetsFolder + "english.jpeg";
const String french = _assetsFolder + "french.jpeg";
const String geography = _assetsFolder + "geography.jpg";
const String lifeSkills = _assetsFolder + "lifeSkills.jpg";
const String math = _assetsFolder + "math.jpg";
const String music = _assetsFolder + "music.jpeg";
const String physicsAndChemistry = _assetsFolder + "physics_and_chemistry.webp";
const String sciences = _assetsFolder + "sciences.jpg";

const List<String> subjectImage = [
  math,
  arabic,
  english,
  french,
  geography,
  lifeSkills,
  music,
  physicsAndChemistry,
  sciences
];

const List<String> subjectName = [
  "رياضيات",
  "عربي",
  "انجليزي",
  "فرنسي",
  "جغرافية",
  "مهارات الحياة",
  "موسيقى",
  "فيزياء و كيمياء",
  "علوم"
];
const padding = 10.0;

const List<String> questionsType = [
  "اختيارات متعدد بخيار وحيد صحيح",
  "اختيارات متعدد باكثر من خيار",
  "اجابة بجملة"
];

const String url = "https://.com/";

const String logIn = "";
const String logOut = "";
const String updatePointurl = "";
const String top10StudentUrl = "";
const String getUserDisscusionUrl = "";
const String getAllDisscusionUrl = "";
const String getAllCommentsUrl = "";
const String putLikeOnDiscussionUrl = "";
const String putLikeOnCommentUrl = "";
const String deleteDisscusionUrl = "";
const String deleteCommentUrl = "";
const String postCommentUrl = "";
const String postDiscussionUrl = "";
Map<String, String> headers = {
  "Accept": "application/json",
  'Accept-Encoding': 'gzip, deflate, br',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json'
};
