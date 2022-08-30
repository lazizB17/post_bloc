import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_bloc/Data/Models/post_model.dart';
import '../../../Domain/post_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PostRepository postRepository = PostRepository.instance;

  HomeBloc() : super(const HomeInitialState([])) {
    on<HomePostGetEvent>(getPosts);
  }

  Future<void> getPosts(HomePostGetEvent event, Emitter<HomeState> emit) async {
    var result = await postRepository.getAllPost();
    emit(HomePostGetState(result));
  }

  Future<void> deletePosts(HomeDeleteEvent event, Emitter<HomeState> emit) async {
    final state = this.state;
    if(state is HomePostGetState) {
      emit(HomePostLoadingState());
      await postRepository.deletePost(event.id);
    }
    var result = await postRepository.getAllPost();
    emit(HomePostGetState(result));
  }
}
