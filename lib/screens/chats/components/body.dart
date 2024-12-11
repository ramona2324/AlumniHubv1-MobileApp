import '../../../components/buttons/filled_outline_button.dart';
import '../../../constants.dart';
import 'package:flutter/material.dart';
import '../../../models/Chat.dart';
import '../../message/message_screen.dart';
import 'chat_card.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding * 0.75),
            color: primaryColor,
            child: Row(
              children: [
                FillOutlineButton(press: () {}, text: 'Recent Message'),
                const SizedBox(width: kDefaultPadding),
                FillOutlineButton(
                  press: () {},
                  text: 'Active',
                  isFilled: false,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagesScreen()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

