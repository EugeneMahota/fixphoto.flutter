import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/users-module/users_view_model.dart';
import 'package:tirmobile/users-module/widgets/users_list.dart';

class UsersScreen extends StatefulWidget {
  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State {
  final UsersViewModel model = serviceLocator<UsersViewModel>();
  final String pageTitle = 'Users';

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  void dispose() {
    model.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersViewModel>(
      create: (context) => model,
      child: Consumer<UsersViewModel>(
        builder: (context, model, child) => usersPage(model),
      ),
    );
  }

  Scaffold usersPage(UsersViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Column(
        children: [
          UsersList(users: model.users),
        ],
      ),
    );
  }
}
