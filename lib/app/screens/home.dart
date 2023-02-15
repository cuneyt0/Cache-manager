import 'package:cache_manager/app/model/user.dart';
import 'package:cache_manager/core/cache_manager/hive_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user =
        User(id: 1, token: 'eyblaasdas.aasdasdasd.asdasd', name: "Cuneyt");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  await HiveHelper.shared
                      .clear<User>(boxName: HiveHelper.userBoxKey);
                  await HiveHelper.shared
                      .add<User>(boxName: HiveHelper.userBoxKey, data: user);
                },
                child: const Text("Kaydet")),
            TextButton(
              onPressed: () async {
                var a = HiveHelper.shared.getValues<User>(
                  boxName: HiveHelper.userBoxKey,
                );

                print(a.first.name);
              },
              child: const Text("Get"),
            )
          ],
        ),
      ),
    );
  }
}
