import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 209, 176, 240),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
