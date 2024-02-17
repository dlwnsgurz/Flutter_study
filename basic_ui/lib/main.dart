import 'package:flutter/material.dart';
import 'package:flutter_study/widgets/button.dart';
import 'package:flutter_study/widgets/currency_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Hey! Selena",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 22),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "\$5 932 122",
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      bgColor: Colors.amber,
                      text: "Transfer",
                      textColor: Colors.black,
                    ),
                    Button(
                        text: "Request",
                        bgColor: Color(0xFF1F2123),
                        textColor: Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white54.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Currency(
                  order: 1,
                  name: "EURO",
                  amount: "6 428",
                  code: "EUR",
                  icon: Icons.euro_rounded,
                  isInverted: false,
                ),
                const Currency(
                  order: 2,
                  name: "Bitcoin",
                  amount: "9 222",
                  code: "BTC",
                  icon: Icons.currency_bitcoin_rounded,
                  isInverted: true,
                ),
                const Currency(
                  order: 3,
                  name: "Dollar",
                  amount: "243 2",
                  code: "USD",
                  icon: Icons.attach_money_rounded,
                  isInverted: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
