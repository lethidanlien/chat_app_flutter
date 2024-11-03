import 'package:chat_app_flutter/features/chat/presentation/bloc/chat_view/chat_view_bloc.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/setting_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/group_create_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/app_bar_chat.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/chat_user_list.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/chat/search_chat.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ChatViewBloc>().add(GetAllChatEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarChat(
          group_button: () {
            Navigator.push(context, GroupCreateScreen.route());
          },
        ),
        body: Column(
          children: [
            SearchBarChat(),
            Expanded(
              child: BlocBuilder<ChatViewBloc, ChatViewState>(
                builder: (context, state) {
                  if (state is ChatViewLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ChatViewFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is ChatViewSuccess) {
                    return ChatUserList(chats: state.chats);
                  } else {
                    return Center(child: Text('No chats available'));
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                Navigator.push(context, ChatScreen.route());
              } else if (_currentIndex == 1) {
                Navigator.push(context, ContactScreen.route());
              } else if (_currentIndex == 2) {
                Navigator.push(context, SettingScreen.route());
              }
            });
          },
        ),
      ),
    );
  }
}
