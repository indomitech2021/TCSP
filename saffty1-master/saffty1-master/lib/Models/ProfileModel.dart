class ProfileModel{
  late var id,name,email,phone,country,code,resume;

  ProfileModel(
      {required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.country,
        required this.code,
        this.resume,
      });
}

