import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_event.dart';
import 'package:inbound/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;

  UserBloc(this._userService) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      // Handle FetchUser event here
      try {
        final user = await _userService.getUserById(event.userId);
        print(user);
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(UserError());
        }
      } catch (error) {
        emit(UserError());
      }
    });
  }

  Stream<UserState> mapEventToState(UserEvent event, userId) async* {}
}
