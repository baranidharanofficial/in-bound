part of "user_bloc.dart";

abstract class UserEvent {}

class AddUser extends UserEvent {
  final User user;

  AddUser(this.user);
}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser(this.userId);
}

class AddCategory extends UserEvent {
  final User user;
  final String category;

  AddCategory(this.user, this.category);
}

class AddUserToCategory extends UserEvent {
  final User user;
  final String connectId;
  final String category;

  AddUserToCategory(this.user, this.connectId, this.category);
}

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class CategoryAdded extends UserState {
  CategoryAdded();
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

abstract class ConnectsEvent {}

class FetchConnects extends ConnectsEvent {
  final String userId;

  FetchConnects(this.userId);
}

abstract class ConnectsState {}

class ConnectsInitial extends ConnectsState {}

class ConnectsLoading extends ConnectsState {}

class ConnectsLoaded extends ConnectsState {
  final Connect connect;

  ConnectsLoaded(this.connect);
}

class ConnectsError extends ConnectsState {}
