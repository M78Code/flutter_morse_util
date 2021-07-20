import 'dart:math';

///二进制转String
String binaryToString(int n) {
  StringBuffer textBuffer = StringBuffer();
  try {
    for (int i = 31; i >= 0; i--) {
      textBuffer.write(n >> i & 1);
    }
  } catch (e) {
    print('binary to string is failed');
  }
  return textBuffer.toString();
}

///二进制转十进制
num binaryToDecimalString(String s) {
  if (s.isNotEmpty) {
    try {
      num total = 0;
      List<String> list = s.split('');
      num size = list.length;
      for (int i = 0; i < size; i++) {
        total += int.parse(list[i]) * pow(2, size - 1 - i);
      }
      return total;
    } catch (e) {
      print('binary to decimal is failed');
    }
  }
  return 0;
}

///截取二进制高位的0
///eg：000000001000为1000
String replacePrefixZero(String s) {
  if (s.isNotEmpty) {
    RegExp reg = RegExp('^(0+)');
    return s.replaceAll(reg, '');
  }
  return '';
}

String toBinaryString(int i) {
  String binString = binaryToString(i);
  return replacePrefixZero(binString);
}
