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

abstract class SenderEvent {}

class FetchSender extends SenderEvent {
  final String senderId;

  FetchSender(this.senderId);
}

abstract class SenderState {}

class SenderInitial extends SenderState {}

class SenderLoading extends SenderState {}

class SenderLoaded extends SenderState {
  final User sender;

  SenderLoaded(this.sender);
}

class SenderError extends SenderState {}
