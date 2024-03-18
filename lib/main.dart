import 'package:flutter/material.dart';
import 'package:pr_app_weather/get_weather_provider.dart';
import 'package:pr_app_weather/theme_app.dart';
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
        ChangeNotifierProvider(
          create: (context) => GetWeatherProvider(),
        ),
      ],
      child: MaterialApp(
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
  @override
  void initState() {
    context.read<GetWeatherProvider>().getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getWeatherProvider = context.watch<GetWeatherProvider>();

    final TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBgColor,
      appBar: AppBar(
        backgroundColor: context.watch<ThemeProvider>().getAbColor,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getWeatherProvider.getWeather(
                      cityName: controller.text,
                    );
                  },
                ),
                hintText: getWeatherProvider.model.name,
                hintStyle: TextStyle(
                  color: context.watch<ThemeProvider>().getTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                  color: context.watch<ThemeProvider>().getTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.read<ThemeProvider>().changeTheme();
          },
          icon: context.watch<ThemeProvider>().getAbIcon,
        ),
      ),
      body: getWeatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getWeatherProvider.model.main?.temp.toString() ?? ''),
                  Image.network(
                    "https://openweathermap.org/img/wn/${getWeatherProvider.model.weather?.first.icon}@2x.png",
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    getWeatherProvider.model.weather?.first.description
                            ?.toString() ??
                        '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    getWeatherProvider.model.main?.feelsLike.toString() ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
    );
  }
}
