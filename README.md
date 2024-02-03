# flutter_morse_util

一个基于flutter开发的跨端的摩尔斯标准密码工具，支持在线解码/编码，和离线解码/编码。


## 项目环境
- flutter     --version v3.16.9
- dart        --version v3.2.6
- Framework   --version 41456452f2
- Engine      --version f40e976bed

## 使用方法:

### 安装依赖：
    这个项目使用了flutter开发，请确保你本地安装了相关开发环境。
#### 1，检查版本号是否正确
        flutter --version
#### 2，运行命令查看是否需要安装其他依赖
        flutter doctor
#### 3，运行启动
        flutter pub get
        flutter run
            
```
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_morse_util: ^0.0.3
```

### Example

``` dart
// Import package
import 'package:flutter_morse_util/morse_util.dart'

// Instantiate it
MorseUtil _morseUtil = MorseUtil();

//start encode/decode
_morseUtil.encode('摩尔斯'); // --..-...--.-..-/-.---.....-.-../--..-.--.-.----/
_morseUtil.decode('--..-...--.-..-/-.---.....-.-../--..-.--.-.----/'); // 摩尔斯


[example demo](/example/lib/main.dart)

```
