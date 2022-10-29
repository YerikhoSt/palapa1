import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palapa1/models/chat_model_statis.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TanyaKamiPage extends StatefulWidget {
  const TanyaKamiPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TanyaKamiPage> createState() => _TanyaKamiPageState();
}

class _TanyaKamiPageState extends State<TanyaKamiPage> {
  bool valuefirst = false;

  int _currentIndex = 0;
  bool isWrite = false;

  bool isSearch = false;
  bool attach = false;
  bool more = false;
  bool moreTwo = false;
  final TextEditingController _controllerChat = TextEditingController();
  bool emojiShowing = false;
  String? _token;
  int? _user_id;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  _onBackspacePressed() {
    _controllerChat
      ..text = _controllerChat.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controllerChat.text.length));
  }

  List<ChatMessage> _messagesList = <ChatMessage>[];

  Future<void> _getData() async {
    await _sharePrefs();
    fetchData(
      'api/live-chat/get',
      method: FetchDataMethod.post,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
      params: <String, dynamic>{
        'token': _token,
        'user_id_to': 1,
      },
    ).then((dynamic value) {
      print(value);
      for (final i in value['data']) {
        final ChatMessage val = ChatMessage(
          messageContent: i['message'],
          messageType: 'receiver',
        );
        setState(() {
          _messagesList.add(val);
        });
      }
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.primaryColor.withOpacity(0.6),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: isSearch
              ? () {
                  setState(() {
                    isSearch = false;
                  });
                }
              : () {
                  Navigator.pop(context);
                },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Config.whiteColor,
            ),
          ),
        ),
        leadingWidth: isSearch ? 50 : 40,
        title: GestureDetector(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade300,
                ),
                child: Center(
                  child: Icon(
                    Icons.headset_mic_outlined,
                    color: Config.blackColor,
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Admin',
                  style: Config.whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: Config.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: ListView(
              padding: const EdgeInsets.only(
                bottom: 120,
              ),
              children: <Widget>[
                ListView.builder(
                  itemCount: _messagesList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 5, bottom: 5),
                      child: Align(
                        alignment:
                            (_messagesList[index].messageType == 'receiver'
                                ? Alignment.topLeft
                                : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                (_messagesList[index].messageType == 'receiver'
                                    ? Colors.grey.shade200
                                    : Config.primaryColor.withOpacity(0.6)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          child: Text(
                            _messagesList[index].messageContent,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          cursorColor: Config.blackColor,
                          controller: _controllerChat,
                          onChanged: (String value) {
                            if (value == '') {
                              setState(() {
                                isWrite = false;
                              });
                            } else {
                              setState(() {
                                isWrite = true;
                              });
                            }
                          },
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            hintText: 'Write message...',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                await fetchData(
                                  'api/live-chat/send',
                                  method: FetchDataMethod.post,
                                  tokenLabel: TokenLabel.xa,
                                  extraHeader: <String, String>{
                                    'Authorization': 'Bearer ${_token}'
                                  },
                                  params: <String, dynamic>{
                                    'pesan': _controllerChat.text,
                                    'token': _token,
                                    'user_id_to': _user_id,
                                  },
                                ).then((dynamic value) {
                                  print(value);
                                  final ChatMessage val = ChatMessage(
                                    messageContent: _controllerChat.text,
                                    messageType: 'sender',
                                  );
                                  setState(() {
                                    _messagesList.add(val);
                                    _controllerChat.clear();
                                  });
                                });
                              },
                              child: const Icon(
                                Icons.send,
                                size: 23,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
