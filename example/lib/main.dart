import 'package:example/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Morse-master'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();
  TextEditingController inputController = TextEditingController();

  //摩斯解码工具类
  MorseUtil _morseUtil = MorseUtil();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        //用来防止软键盘弹出时遮挡页面
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
//        height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: _inputWidget(),
              ),
              Expanded(
                child: _decodeBtnWidget(),
              ),
              Expanded(
                child: _netMorseBtnWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///摩尔斯电码输入框
  Widget _inputWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        minLines: 100,
//        autofocus: true,
        controller: inputController,
        maxLines: null,
        //无行数限制
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(border: OutlineInputBorder(), hintText: '请输入摩尔斯电码/中文'),
      ),
    );
  }

  ///编码/解码功能按钮
  Widget _decodeBtnWidget() {
    return Container(
      width: 100,
      height: 60,
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              elevation: 5,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.deepPurpleAccent,
//              padding: EdgeInsets.all(15),
              child: Text(
                '编码(字符转电码)',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                morseEncode();
              },
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: MaterialButton(
              elevation: 5,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.deepPurpleAccent,
              child: Text(
                '解码(电码转字符)',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                morseDecode();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///在线编码/解码按钮
  Widget _netMorseBtnWidget() {
    return Container(
      width: 100,
      height: 60,
      margin: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
      child: ElevatedButton(
        onPressed: _launchURL,
        child: Text(
          '使用网络morse编/解码',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://tool.lu/morse';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///摩尔斯解码
  void morseDecode() {
    String decodeString = inputController.text;
    if (decodeString.isEmpty) {
      ToastUtil.showGravityToast(
        '请输入摩尔斯码',
        ToastGravity.CENTER,
      );
      return;
    }
    try {
      if (decodeString.startsWith(RegExp('-')) || decodeString.startsWith(RegExp('.'))) {
        String decodeResult = _morseUtil.decode(decodeString);
        //设置文本显示
        inputController.text = decodeResult;
      } else {
        int index_dit = decodeString.indexOf(RegExp('.'));
        int index_dah = decodeString.indexOf(RegExp('-'));
        if (index_dit == -1 || index_dah == -1) {
          //设置文本清空
          inputController.text = '';
          return;
        }
        if (index_dit > index_dah) {
          String dahString = decodeString.substring(index_dah).trim();
          String dahResult = _morseUtil.decode(dahString);
          //设置文本显示
          inputController.text = dahResult;
        } else {
          String ditString = decodeString.substring(index_dit).trim();
          String ditResult = _morseUtil.decode(ditString);
          //设置文本显示
          inputController.text = ditResult;
        }
      }
    } catch (e) {
      print('解码失败');
      inputController.text = '';
    }
  }

  ///摩尔斯编码
  void morseEncode() {
    String decodeString = inputController.text;
    if (decodeString.isEmpty) {
      ToastUtil.showGravityToast(
        '请输入文本或字符',
        ToastGravity.CENTER,
      );
      return;
    }
    try {
      String encodeString = _morseUtil.encode(decodeString);
      //设置文本显示
      inputController.text = encodeString;
    } catch (e) {
      print('编码失败');
      inputController.text = '';
    }
  }
}
