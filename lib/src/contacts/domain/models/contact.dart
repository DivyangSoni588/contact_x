class ContactModel {
  int? id;
  String name;
  String phone;
  String email;
  String? image;
  int? categoryId; // Foreign key

  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.image,
    this.categoryId,
  });

  factory ContactModel.fromMap(Map<String, dynamic> json) => ContactModel(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
    image: json['image'],
    categoryId: json['categoryId'],
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'categoryId': categoryId,
    };
  }
}
