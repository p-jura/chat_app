import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatBubble({
    required this.message,
    required this.isMe,
    required this.userName,
    required this.userImage,
    Key? key,
  }) : super(key: key);
  final String userName;
  final String userImage;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Stack(
              alignment: isMe
                  ? AlignmentDirectional.topStart
                  : AlignmentDirectional.topEnd,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 300, minWidth: 100),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isMe
                            ? themeData.colorScheme.onBackground
                            : themeData.colorScheme.primary,
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                    color: isMe
                        ? themeData.colorScheme.secondary
                        : themeData.colorScheme.background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: isMe
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(15)
                          : const Radius.circular(15),
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${!isMe ? '$userName ...' : '... Me'} ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isMe
                                ? themeData.colorScheme.background
                                : themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        message,
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: isMe
                                  ? themeData.colorScheme.background
                                  : themeData.colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                ),
                if (!isMe)
                  CircleAvatar(
                      backgroundColor: themeData.colorScheme.primary,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(userImage),
                      )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
