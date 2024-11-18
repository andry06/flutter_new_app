// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_news_bloc.dart';

@immutable
sealed class AllNewsEvent {}

class GetAllNews extends AllNewsEvent {}

class ClickSearchNews extends AllNewsEvent {
  final String query;
  ClickSearchNews({
    required this.query,
  });
}
