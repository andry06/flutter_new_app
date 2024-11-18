// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_news_bloc.dart';

@immutable
sealed class AllNewsState {}

final class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsLoaded extends AllNewsState {
  final List<Article> articles;
  AllNewsLoaded({
    required this.articles,
  });
}

class AllNewsError extends AllNewsState {
  final String message;
  AllNewsError({
    required this.message,
  });
}
