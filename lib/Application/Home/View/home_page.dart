import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:post_bloc/Application/Home/Bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomePostGetEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Posts Bloc"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomePostGetState) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    extentRatio: 0.5,
                    dismissible: DismissiblePane(onDismissed: () {
                      context
                          .read<HomeBloc>()
                          .add(HomeDeleteEvent(id: state.items[index].id));
                    }),
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          context
                              .read<HomeBloc>()
                              .add(HomeDeleteEvent(id: state.items[index].id));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_outline,
                      ),
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        state.items[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        state.items[index].body,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
