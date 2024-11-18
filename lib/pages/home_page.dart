import 'package:flutter/material.dart';
import 'package:fluttter_news_app/pages/news_bloc_page.dart';
import 'package:fluttter_news_app/pages/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<NewsProvider>().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewsBlocPage();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.forward))
        ],
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
                    String data = searchController.text;
                    context.read<NewsProvider>().search(data);
                  },
                  child: const Icon(
                    Icons.search,
                  ),
                ),
              ),
              controller: searchController,
            ),
          ),
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, state, child) {
                if (state.state.status == StateEnum.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.articles.isEmpty) {
                  return const Center(
                    child: Text('No data'),
                  );
                }
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
