import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:pr_app_weather/theme_app.dart';
import 'package:pr_app_weather/weather_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        
      ],
    child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String image = "";
  String temp = "";
  String city = "";
  String state = "";
 
  Future<void> getData() async {
    Dio dio = Dio();
    Response response = await dio.get(
      "https://api.openweathermap.org/data/2.5/weather",
      queryParameters: {
        "lat": 42.882004,
        "lon": 74.582748,
        "appid": "99e8a0fe0e835bd24d899cd8d3a93d2e",
        "units": "metric",
        "lang": "ru",
      },
    );

    final model = WeatherModel.fromJson(response.data);
    
    
    image = model.weather?.first.icon ?? "";
    temp = model.name ?? "";
    city = model.main?.temp.toString() ?? "";
   

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: context.watch<ThemeProvider>().getBgColor,
      appBar: AppBar(
           backgroundColor: context.watch<ThemeProvider>().getAbColor,
        title:  Center(child: Padding(
          padding: EdgeInsets.only(right: 50),
          child: Text("Bishkek",
          
          style: TextStyle(
           color:context.watch<ThemeProvider>().getTextColor,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
        )),
        leading: IconButton(
            onPressed: () {
              context.read<ThemeProvider>().changeTheme();
            },
            icon: context.watch<ThemeProvider>().getAbIcon,
            ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state),
            Image.network(
              "https://openweathermap.org/img/wn/$image@2x.png",
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            Text(
              city,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              temp,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
          ],
        ),
      ),
    );
  }
}