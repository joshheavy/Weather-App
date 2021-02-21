import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/repositories/repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String city) async{
    try{
      emit(WeatherLoading());
      final Weather weather = await _weatherRepository.getWeather(city);
      emit(WeatherLoaded(weather: weather));
    } catch (e){
      emit(WeatherFailure(error: e));
    }
  }
}
