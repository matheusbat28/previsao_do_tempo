import 'package:flutter/material.dart';
import 'api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();
  String cityName = '';
  String cityTemp = '';
  String cityTempMax = '';
  String cityTempMin = '';
  String city = 'palhoça';
  String weatherCondition = '';
  String weatherDescription = '';
  IconData weatherIcon = Icons.cloud;

  @override
  void initState() {
    super.initState();
    dataTempo();
  }

  void dataTempo() {
    getTempo(city).then((data) {
      setState(() {
        cityName = data['name'];
        cityTemp = data['main']['temp'].toString();
        cityTempMax = data['main']['temp_max'].toString();
        cityTempMin = data['main']['temp_min'].toString();
        weatherCondition = data['weather'][0]['main'];
        weatherDescription = data['weather'][0]['description'];
        switch (weatherCondition) {
          case 'Clear':
            weatherIcon = Icons.wb_sunny;
            break;
          case 'Clouds':
            weatherIcon = Icons.cloud;
            break;
          default:
            weatherIcon = Icons.help;
        }
      });
    }).catchError((error) {
      setState(() {
        cityName = 'Erro na solicitação';
        cityTemp = 'Erro na solicitação';
        cityTempMax = 'Erro na solicitação';
        cityTempMin = 'Erro na solicitação';
        weatherCondition = 'Erro na solicitação';
        weatherDescription = 'Erro na solicitação';
      });
    });
  }

  void fetchWeatherData() {
    getTempo(cityName).then((data) {
      setState(() {
        cityName = data['name'];
        cityTemp = data['main']['temp'].toString();
        cityTempMax = data['main']['temp_max'].toString();
        cityTempMin = data['main']['temp_min'].toString();
        weatherCondition = data['weather'][0]['main'];
        weatherDescription = data['weather'][0]['description'];
        switch (weatherCondition) {
          case 'Clear':
            weatherIcon = Icons.wb_sunny;
            break;
          case 'Clouds':
            weatherIcon = Icons.cloud;
            break;
          default:
            weatherIcon = Icons.help;
        }
      });
    }).catchError((error) {
      setState(() {
        cityName = 'Erro na solicitação';
        cityTemp = 'Erro na solicitação';
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          city,
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.white]),
        ),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 70),
              alignment: Alignment.center,
              width: double.infinity,
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${cityTemp.substring(0, 2)}°C',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 65),
                  ),
                  Icon(
                    weatherIcon,
                    size: 25,
                    color: Colors.white,
                  ),
                  Text(
                    weatherDescription,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Max ${cityTempMax.substring(0, 2)}°C - Min ${cityTempMin.substring(0, 2)}°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              )),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 30),
            child: TextField(
              controller: cityController,
              onChanged: (value) => {
                setState(() {
                  city = value;
                  dataTempo();
                }),
              },
              decoration: InputDecoration(
                  labelText: 'Cidade',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          )
        ]),
      ),
    );
  }
}
