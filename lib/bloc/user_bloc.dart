import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/models/user.dart';
import 'package:inbound/services/user_service.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;

  UserBloc(this._userService) : super(UserInitial()) {
    on<AddUser>((event, emit) async {
      // Handle FetchUser event here
      emit(UserLoading());
      try {
        final user = await _userService.createUser(event.user);
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
    on<FetchUser>((event, emit) async {
      // Handle FetchUser event here
      emit(UserLoading());
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

    on<AddCategory>((event, emit) async {
      // Handle FetchUser event here
      emit(UserLoading());
      try {
        final isCategoryAdded =
            await _userService.addCategory(event.user.id!, event.category);

        print(isCategoryAdded);
        if (isCategoryAdded) {
          event.user.categories.add(event.category);
          emit(UserLoaded(event.user));
        } else {
          emit(UserError());
        }
      } catch (error) {
        emit(UserError());
      }
    });

    on<AddUserToCategory>((event, emit) async {
      // Handle FetchUser event here
      emit(UserLoading());
      try {
        final isAdded = await _userService.addUserToCategory(
          event.user.id!,
          event.connectId,
          event.category,
        );
        print(isAdded);
        if (isAdded) {
          emit(UserLoaded(event.user));
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

class SenderBloc extends Bloc<SenderEvent, SenderState> {
  final UserService _userService;

  SenderBloc(this._userService) : super(SenderInitial()) {
    on<FetchSender>((event, emit) async {
      // Handle FetchUser event here
      emit(SenderLoading());
      try {
        final sender = await _userService.getUserById(event.senderId);
        print(sender);
        if (sender != null) {
          emit(SenderLoaded(sender));
        } else {
          emit(SenderError());
        }
      } catch (error) {
        emit(SenderError());
      }
    });
  }

  Stream<UserState> mapEventToState(UserEvent event, userId) async* {}
}

class ConnectsBloc extends Bloc<ConnectsEvent, ConnectsState> {
  final UserService _userService;

  ConnectsBloc(this._userService) : super(ConnectsInitial()) {
    on<FetchConnects>((event, emit) async {
      emit(ConnectsLoading());
      // Handle FetchUser event here
      try {
        final connect = await _userService.getConnectsById(event.userId);
        print(connect.categories);
        emit(ConnectsLoaded(connect));
      } catch (error) {
        print('Error : $error');
        emit(ConnectsError());
      }
    });
  }

  Stream<UserState> mapEventToState(ConnectsEvent event, userId) async* {}
}
