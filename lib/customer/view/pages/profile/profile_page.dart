import 'package:flutter/material.dart';
import 'package:pipi/customer/view/pages/profile/logged_view.dart';
import 'package:pipi/customer/viewmodel/providers/user_provider.dart';
import 'package:pipi/services/log_service.dart';
import 'package:provider/provider.dart';

import 'unlogged_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    Log.d("profile page  => ${provider.user}");
    return Scaffold(
      body: provider.user.role == "anonymous"
          ? const UnLoggedView()
          : const LoggedView(),
    );
  }
}
