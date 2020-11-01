import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isEmojiVisible;
  final bool isKeyboardVisible;
  final Function onBlurred;
  final ValueChanged<String> onSentMessage;
  final focusNode = FocusNode();

  InputWidget({
    @required this.controller,
    @required this.isEmojiVisible,
    @required this.isKeyboardVisible,
    @required this.onSentMessage,
    @required this.onBlurred,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5)),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            buildEmoji(),
            Expanded(child: buildTextField()),
            buildSend(),
          ],
        ),
      );

  Widget buildEmoji() => Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: IconButton(
          icon: Icon(
            isEmojiVisible
                ? Icons.keyboard_rounded
                : Icons.emoji_emotions_outlined,
          ),
          onPressed: onClickedEmoji,
        ),
      );

  Widget buildTextField() => TextField(
        focusNode: focusNode,
        controller: controller,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration.collapsed(
          hintText: 'Type your message...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      );

  Widget buildSend() => Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            if (controller.text.trim().isEmpty) {
              return;
            }

            onSentMessage(controller.text);
            controller.clear();
          },
        ),
      );

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    onBlurred();
  }
}
