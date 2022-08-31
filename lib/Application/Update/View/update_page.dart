import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Configuration/utils.dart';
import '../../../Data/Models/post_model.dart';
import '../Bloc/update_bloc.dart';

class UpdatePage extends StatelessWidget {
  static const id = "/update_page";
  final Post post;

  const UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBloc(),
      child: Builder(
        builder: (context) {
          var bloc = context.read<UpdateBloc>();
          return BlocListener<UpdateBloc, UpdateState>(
            listener: (context, state) {
              if (state is UpdateSuccessState) {
                Utils.fireSnackBar(state.successMSG, context);
                Navigator.pop(context, "refresh");
              }

              if (state is UpdateErrorState) {
                Utils.fireSnackBar(state.errorMSG, context);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Update Page"),
                actions: [
                  TextButton(
                    onPressed: () {
                      bloc.add(UpdatePostEvent(post));
                    },
                    child: const Text("Save",
                        style: TextStyle(color: Colors.white, fontSize: 19)),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: bloc.titleController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(hintText: "Title"),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: bloc.bodyController,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(hintText: "Body"),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<UpdateBloc, UpdateState>(
                    builder: (context, state) {
                      if (state is UpdateInitialState && state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
