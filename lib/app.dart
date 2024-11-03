import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_cubit.dart';
import 'package:chat_app_flutter/core/common/cubit/app_auth/app_auth_state.dart';
import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Socket _socket = serviceLocator<Socket>();
  @override
  void initState() {
    super.initState();

    // connect socket
    _socket.onConnect((_) {
      print('connect to socket');
    });

    // call check authentication
    context.read<AppAuthCubit>().checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocBuilder<AppAuthCubit, AppAuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            // Trạng thái đã đăng nhập, hiển thị màn hình
            return const ChatScreen();
          } else if (state is Unauthenticated) {
            // Trạng thái chưa đăng nhập, hiển thị màn hình Login
            return const LoginScreen();
          }
          // Hiển thị màn hình chờ trong khi kiểm tra trạng thái đăng nhập
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
