import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("S E T T I N G S"),
      ),
      body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              //switch
              Switch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              )
            ],
          )),
    );
  }
}
