class IntroModel {
  String image;
  String title;
  String description;

  IntroModel(
      {required this.image, required this.title, required this.description});
}

List<IntroModel> listIntro = [
  IntroModel(image: 'assets/svg/on1.svg', title: 'ابحث عن دكتور متخصص', description: 'اكشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات.'),
  IntroModel(image: 'assets/svg/on2.svg', title: 'سهولة الحجز ', description: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.'),
  IntroModel(image: 'assets/svg/on3.svg', title: 'امن وسري', description: 'كن مطمئنا الأن خصوصيتك وأمانك هما أهم أولوياتنا.'),
];
