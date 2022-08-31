import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:post_bloc/Data/Models/post_model.dart';
import 'package:post_bloc/Domain/post_repository.dart';
part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  PostRepository postRepository = PostRepository.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  UpdateBloc() : super(const UpdateInitialState(false)) {
    on<UpdatePostEvent>(updatePost);
  }

  Future<void> updatePost(UpdatePostEvent event, Emitter<UpdateState> emit) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();

    if(title.isEmpty || body.isEmpty) {
      emit(const UpdateErrorState("All fields are required!!!"));
      return;
    }

    emit(const UpdateInitialState(true));
    Post json = Post(id: event.post.id, title: title, body: body, userId: event.post.userId);
    var result = await postRepository.updatePost(json);

    if(result) {
      emit(const UpdateSuccessState("Post successfully edited!"));
    } else {
      emit(const UpdateErrorState("Post wasn't edited!"));
    }
  }
}
