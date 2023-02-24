import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_metamask_wallet/metamask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //

    return ChangeNotifierProvider(
        create: (context) => MetamaskProvider()..int(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Stack(children: [
              Center(
                child: Consumer<MetamaskProvider>(
                  builder: (context, provider, child) {
                    late final String text;

                    if (provider.isConnected && provider.isInOperationChain) {
                      text = 'Connected';
                    } else if (provider.isConnected &&
                        !provider.isInOperationChain) {
                      text =
                          'Wrong chain. Please connect to ${MetamaskProvider.operationgChain}';
                    } else if (provider.isEnabled) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Click the button...'),
                          const SizedBox(height: 8),
                          CupertinoButton(
                            onPressed: () =>
                                context.read<MetamaskProvider>().connect(),
                            color: Colors.white,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                  width: 300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      text = 'Please use a Web3 supported browser.';
                    }

                    return ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.purple, Colors.blue, Colors.red],
                      ).createShader(bounds),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    );
                  },
                ),
              ),

              // Consumer<MetamaskProvider>(builder: (context, provider, child) {
              //   return CupertinoButton(
              //     onPressed: () {},
              //     color: Colors.white,
              //     child: Row(
              //       children:  [
              //         Image.network("https://avatars.githubusercontent.com/u/6250754?s=200&v=4",width: 300,)
              //       ],
              //     ),
              //   );
              // }),
            ]),
          );
        });
  }
}
