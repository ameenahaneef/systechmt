part of 'bloc_bloc.dart';

@immutable
sealed class BlocState {}

final class BlocInitial extends BlocState {}

class BlocLoading extends BlocState{}

class BlocLoaded extends BlocState{
  final List<Student> stud;

  BlocLoaded({required this.stud});
}

class BlocError extends BlocState{
  final String error;

  BlocError(this.error);
}
