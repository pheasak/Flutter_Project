class Logolanguage {
  final String logo, lang;
  Logolanguage({required this.lang, required this.logo});
  static List<Logolanguage> lslog = [
    Logolanguage(lang: 'English', logo: 'asset/image/uk.png'),
    Logolanguage(lang: 'ខ្មែរ', logo: 'asset/image/kh.png'),
    Logolanguage(lang: '中文', logo: 'asset/image/cn.png'),
  ];
}
