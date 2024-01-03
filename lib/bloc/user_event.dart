import 'package:inbound/models/user.dart';

abstract class UserEvent {}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser(this.userId);
}

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class UserError extends UserState {}
