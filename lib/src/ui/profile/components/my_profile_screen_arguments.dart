class MyProfileArguments{
  final String first_name;
  final String last_name;
  final String email;
  final String mobile_no;
  final String user_name;
  final String gender;
  final String dob;
  final String nationality_name_en;
  final String nationality_name_ar;
  final String city_name;
  final String city_name_ar;
  final String country_name_en;
  final String country_name_ar;
  final String photo;
  final int nationality_id;
  final int country_id;
  final String city;




  MyProfileArguments(
      {
        required this.nationality_id,
        required this.country_id,
        required this.city,
        required this.photo,
        required this.first_name,
        required this.last_name,
        required this.email,
        required this.mobile_no,
        required this.user_name,
        required this.gender,
        required this.dob,
        required this.nationality_name_en,
        required this.nationality_name_ar,
        required this.city_name,
        required this.city_name_ar,
        required this.country_name_en,
        required this.country_name_ar
      });


}