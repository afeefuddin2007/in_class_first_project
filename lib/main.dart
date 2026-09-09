import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsDemo(),
    );
  }
}

class TabsDemo extends StatefulWidget {
  const TabsDemo({super.key});

  @override
  State<TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1
          Container(
            color: Colors.lightBlue[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Tab 1',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Hello!'),
                            content: const Text(
                              'This is an Alert Dialog.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Show Alert'),
                  ),
                ],
              ),
            ),
          ),

          // TAB 2 - IMAGE + TEXTFIELD
          Container(
            color: Colors.green[50],
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    const Text(
                      'Image Tab',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Image.network(
                      'https://picsum.photos/400/250',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,

                      loadingBuilder:
                          (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return const SizedBox(
                          width: 300,
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },

                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          width: 300,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Colors.red,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Image could not load',
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // TAB 3
          Container(
            color: Colors.orange[50],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Button pressed in Tab 3!',
                      ),
                    ),
                  );
                },
                child: const Text('Click Me'),
              ),
            ),
          ),

          // TAB 4
          Container(
            color: Colors.purple[50],
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.flutter_dash),
                    title: Text('Item 1'),
                    subtitle: Text(
                      'Details displayed inside a Card',
                    ),
                  ),
                ),

                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Item 2'),
                    subtitle: Text(
                      'Second list item',
                    ),
                  ),
                ),

                

                
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'In-Class 01 · My First Tabs App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}