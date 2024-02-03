import 'binary_string_util.dart';

///摩尔斯码工具类
class MorseUtil {
  MorseUtil() {
    _data.forEach((key, value) {
      _registerMorse(key, value);
    });
  }

  ///data
  static const Map _data = {
    'A': "01",
    'B': "1000",
    'C': "1010",
    'D': "100",
    'E': "0",
    'F': "0010",
    'G': "110",
    'H': "0000",
    'I': "00",
    'J': "0111",
    'K': "101",
    'L': "0100",
    'M': "11",
    'N': "10",
    'O': "111",
    'P': "0110",
    'Q': "1101",
    'R': "010",
    'S': "000",
    'T': "1",
    'U': "001",
    'V': "0001",
    'W': "011",
    'X': "1001",
    'Y': "1011",
    'Z': "1100",
    // Numbers
    '0': "11111",
    '1': "01111",
    '2': "00111",
    '3': "00011",
    '4': "00001",
    '5': "00000",
    '6': "10000",
    '7': "11000",
    '8': "11100",
    '9': "11110",
    // Punctuation
    '.': "010101",
    ',': "110011",
    '?': "001100",
    '\'': "011110",
    '!': "101011",
    '/': "10010",
    '(': "10110",
    ')': "101101",
    '&': "01000",
    ':': "111000",
    ';': "101010",
    '=': "10001",
    '+': "01010",
    '-': "100001",
    '_': "001101",
    '"': "010010",
    '\$': "0001001",
    '@': "011010",
  };

  ///code point -> morse
  static Map _alphabets = {};

  ///morse -> code point
  static Map _dictionaries = {};

  static void _registerMorse(String abc, String dict) {
    _alphabets[abc.codeUnitAt(0)] = dict;
    _dictionaries[dict] = abc.codeUnitAt(0);
  }

  final String _dit = '.'; //short mark or dot
  final String _dah = '-'; //longer mark or dash
  final String _split = '/'; //摩尔斯分割符，以它来分割

  ///字符转电码
  String encode(String text) {
    if (text.trim().isEmpty) return "";
    StringBuffer stringBuffer = StringBuffer();
    String tempText = text.toUpperCase();

    for (int i = 0; i < tempText.length; i++) {
      int codePoint = tempText.codeUnitAt(i); //此处获取的是unitCode值，十进制数值
      String word = "";
      //先判断_alphabets当前字符是否在标准摩尔斯电码表字典中
      if (_alphabets.containsKey(codePoint)) {
        word = _alphabets[codePoint];
      } else {
        //将uniCode十进制值转成二进制值
        word = codePoint.toRadixString(2);
      }
      stringBuffer.write(word.replaceAll('0', _dit).replaceAll('1', _dah));
      stringBuffer.write(_split);
    }
    return stringBuffer.toString();
  }

  ///电码转字符
  String decode(String morse) {
    if (morse.trim().isEmpty) return "";
    List<String> splitList = morse.split(_split);
    StringBuffer textBuffer = StringBuffer();
    for (String s in splitList) {
      try {
        if (s.isNotEmpty) {
          String codePoint = s.replaceAll(_dit, '0').replaceAll(_dah, '1');
          String? word = "";
          //判断_dictionaries字典中是否包含此值
          if (_dictionaries.containsValue(codePoint)) {
            codePoint = _dictionaries[codePoint];
          } else {
            //将二进制转成uniCode值，dart中unitCode值是十进制
            word = int.tryParse(codePoint, radix: 2)?.toRadixString(10);
          }
          //将uniCode码转成对应的字符
          textBuffer.writeCharCode(int.tryParse(word ?? "") ?? 0);
        }
      } catch (e) {
        print("解码错误:$e");
      }
    }
    return textBuffer.toString();
  }
}
