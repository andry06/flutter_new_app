// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fluttter_news_app/data/datasources/news_remote_datasource.dart';
import 'package:fluttter_news_app/data/models/news_response_model.dart';

class NewsProvider extends ChangeNotifier {
  //state
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  NewsState state = NewsState(status: StateEnum.loading, data: []);

  //event get news
  void getNews() async {
    final response = await NewsRemoteDatasource().getNews();
    _articles = response.articles ?? [];
    state = state.copyWith(status: StateEnum.success, data: _articles);
    notifyListeners();
  }

  void search(String data) async {
    state = state.copyWith(status: StateEnum.loading);
    notifyListeners();
    final response = await NewsRemoteDatasource().search(data);
    _articles = response.articles ?? [];
    state = state.copyWith(status: StateEnum.success, data: _articles);
    notifyListeners();
  }
}

enum StateEnum { loading, success, error }

class NewsState {
  final StateEnum status;
  final List<Article> data;

  NewsState({required this.status, required this.data});

  NewsState copyWith({
    StateEnum? status,
    List<Article>? data,
  }) {
    return NewsState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
