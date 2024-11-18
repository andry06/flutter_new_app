import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttter_news_app/data/datasources/news_remote_datasource.dart';
import 'package:fluttter_news_app/data/models/news_response_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'all_news_event.dart';
part 'all_news_state.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  AllNewsBloc() : super(AllNewsInitial()) {
    on<GetAllNews>((event, emit) async {
      emit(AllNewsLoading());
      final response = await NewsRemoteDatasource().getNews();
      emit(AllNewsLoaded(articles: response.articles!));
    });

    on<ClickSearchNews>((event, emit) async {
      emit(AllNewsLoading());
      final response = await NewsRemoteDatasource().search(event.query);
      emit(AllNewsLoaded(articles: response.articles!));
    });
  }
}
