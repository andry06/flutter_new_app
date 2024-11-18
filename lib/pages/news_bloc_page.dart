import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttter_news_app/pages/bloc/all_news/all_news_bloc.dart';

class NewsBlocPage extends StatefulWidget {
  const NewsBlocPage({super.key});

  @override
  State<NewsBlocPage> createState() => _NewsBlocPageState();
}

class _NewsBlocPageState extends State<NewsBlocPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<AllNewsBloc>().add(GetAllNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc News'),
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('search'),
                suffixIcon: InkWell(
                  onTap: () {
                    context.read<AllNewsBloc>().add(
                          ClickSearchNews(query: searchController.text),
                        );
                  },
                  child: const Icon(
                    Icons.search,
                  ),
                ),
              ),
              controller: searchController,
              onChanged: (value) {
                if (value.length >= 3) {
                  context.read<AllNewsBloc>().add(
                        ClickSearchNews(query: searchController.text),
                      );
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AllNewsBloc, AllNewsState>(
              builder: (context, state) {
                if (state is AllNewsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AllNewsLoaded) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          state.articles[index].urlToImage ??
                              'https://i.pravatar.cc/150?img=3',
                          width: 50,
                        ),
                        title: Text('${state.articles[index].title}'),
                        subtitle: Text('${state.articles[index].author}'),
                        trailing: const Icon(Icons.navigate_next_outlined),
                      );
                    },
                    itemCount: state.articles.length,
                    separatorBuilder: (context, index) => const Divider(),
                  );
                } else {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
