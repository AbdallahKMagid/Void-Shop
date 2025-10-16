class AuthModel {
  final id;
  final email;

  AuthModel({required this.id, required this.email});

  factory AuthModel.getAuthModel(final id, final email) {
    return AuthModel(id: id, email: email);
  }
}
