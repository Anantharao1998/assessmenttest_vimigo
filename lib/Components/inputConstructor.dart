class InputData {
  String user;
  String phone;
  String checkin;

  InputData({required this.user, required this.phone, required this.checkin});

  @override
  String toString() => '{user: $user , phone: $phone , check-in: $checkin }';
}
