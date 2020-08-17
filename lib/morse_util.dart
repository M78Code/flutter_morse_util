
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
    if (text == null || '' == text.trim()) return "";
    StringBuffer stringBuffer = StringBuffer();
    String tempText = text.toUpperCase();

    for (int i = 0; i < tempText.length; i++) {
      int codePoint = tempText.codeUnitAt(i);
      String word = _alphabets[codePoint];
      if (null == word) {
        word = toBinaryString(codePoint);
      }
      stringBuffer.write(word.replaceAll('0', _dit).replaceAll('1', _dah));
      stringBuffer.write(_split);
    }
    return stringBuffer.toString();
  }

  ///电码转字符
  String decode(String morse) {
    if (null == morse || '' == morse.trim()) return '';
    List<String> splitList = morse.split(_split);
    StringBuffer textBuffer = StringBuffer();
    try {
      for (String s in splitList) {
        if (s.isNotEmpty) {
          String word = s.replaceAll(_dit, '0').replaceAll(_dah, '1');
          int codePoint = _dictionaries[word];
          if (codePoint == null) {
            codePoint = binaryToDecimalString(word);
          }
          textBuffer.writeCharCode(codePoint);
        }
      }
    } catch (e) {}
    return textBuffer.toString();
  }
}
