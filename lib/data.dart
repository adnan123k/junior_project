import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

const textDirection = TextDirection.rtl;
const drawerColor = Color(0xffFFE459);
const textFieldRadius = 10.0;
const raisedButtonRadius = 10.0;
const raisedButtonColor = Color(0xff0F52BA);
const cursorColor = Color(0xff000000);
const String _assetsFolder = "assets/image/";
const String logoImage = _assetsFolder + "logo.png";
const String logingInImage = _assetsFolder + "loginInImage.jpeg";

const String calculasImage = _assetsFolder + "calculus.png";
const String algabraImage = _assetsFolder + "algabra.jpg";
const String engineerImage = _assetsFolder + "engineer.jpg";
const String learnImage = _assetsFolder + "learn.jpg";
const String playImage = _assetsFolder + "play.webp";
const String background = _assetsFolder + "background.jpg";
const padding = 10.0;

const List<String> questionsType = [
  "اختيارات متعدد بخيار وحيد صحيح",
  "اختيارات متعدد باكثر من خيار",
  "اجابة بجملة"
];

const List<String> algabraLessons = [
  "الأعداد الطبيعية",
  "الأعداد الصحيحة(الجمعوالطرح)",
  "الأعداد الصحيحة(الضربوالقسمة)",
  "الأعداد العادية",
  "الأعداد العاديةومعلم المستوي",
  "العبارات الجبرية",
  "حل المعادلات"
];

const List<String> engineerLessons = [
  "متوازي الأضلاع ومركز التناظر",
  "مساحة متوازي الأضلاع",
  "مستقيمان متوازيان وثالث قاطع",
  "الانتقال من الشكل الرباعي إلى متوازي الأضلاع",
  "حالات خاصة:مستطيل،معين،مربع",
  "التناظر المركزي",
  "إيجاد النظير بالنسبة إلى نقطة",
  "مراكز ومحاور التناظر",
  "التناسب",
  "النسبة المئوية",
  "واحدات القياس",
  "مقياس الرسم",
  "المعدل والحركة المنتظمة",
  "تصنيف المثلث",
  "مجموع قياسات زوايا المثلث",
  "رسم المثلث",
  "رسم الدائرة المارة برؤوس المثلث",
  "مساحة المثلث",
  "مساحة الدائرة",
  "الموشور القائم",
  "الأسطوانة الدورانية"
];

const List<String> calculusLessons = [
  "التمثيلات البيانية",
  "مخطط الانتشار والارتباط",
  "الأحداث واحتمالاتها"
];

const String passedImage = _assetsFolder + "winner.jpg";
const String failedImage = _assetsFolder + "try_again.jpg";
const String url = "http://10.0.2.2:8000/api/";

const String logIn = "sign_in";
const String signUp = "sign_up";
const String logOut = "sign_out";
const String updatePointurl = "update_point";
const String top10StudentUrl = "top";
const String getUserDisscusionUrl = "get_user_discussion";
const String getAllDisscusionUrl = "get_video_discussion/";
const String getAllCommentsUrl = "get_discussion_comment/";
const String putLikeOnDiscussionUrl = "toggle_like_on_discussion/";
const String putLikeOnCommentUrl = "toggle_like_on_comment/";
const String deleteDisscusionUrl = "delete_discussion/";
const String deleteCommentUrl = "delete_comment/";
const String postCommentUrl = "post_comment";
const String postDiscussionUrl = "post_discussion";
const String getAllSubjectionsUrl = "get_subject";
const String getLessonVideo = "get_videos/";
const String getAllTeacher = "get_teacher";
const String addVideoUrl = "add_video";
const String putVideoUrl = "put_video/";
const String deleteVideoUrl = "delete_video/";
const String getLevelsUrl = "get_subject_levels/";
const String blockUserUrl = "block_user/";
const String deleteTeacherUrl = "delete_teacher/";
const String putTeacherUrl = "put_teacher/";
const String addTeacherUrl = "add_teacher";
const String addQuestionUrl = "add_question/";
const String postUserLevelUrl = "post_user_level/";
const String postQuestionAttempUrl = "post_user_attemp";

const String getQuiz = "getQuiz/";
Map<String, String> headers = {
  "Accept": "application/json",
  'Accept-Encoding': 'gzip, deflate, br',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json'
};
