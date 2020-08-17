# flutter_morse_util

##一个基于flutter开发的跨端的摩尔斯标准密码工具，支持在线解码/编码，和离线解码/编码。

[中文文档](https://github.com/M78Code/flutter_morse_util.git/README.md)

[github](https://github.com/M78Code/flutter_morse_util)

## 使用方法:

### 安装依赖：

安装之前请查看最新版本
新版本如有问题请使用上一版
```
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_morse_util: ^0.0.1
```

### Example

``` dart
// Import package
import 'package:flutter_morse_util/morse_util.dart'

// Instantiate it
MorseUtil _morseUtil = MorseUtil();

//start encode/decode
_morseUtil.encode('摩尔斯'); // --..-...--.-..-/-.---.....-.-../--..-.--.-.----/
_morseUtil.decode('--..-...--.-..-/-.---.....-.-../--..-.--.-.----/');j // 摩尔斯

[example demo](/example/lib/main.dart)

```
