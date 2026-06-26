import '../../domain/entities/company_info.dart';

class CompanyInfoModel {
  const CompanyInfoModel({
    this.id,
    this.name = '',
    this.tradeName = '',
    this.gstin = '',
    this.cin = '',
    this.pan = '',
    this.tan = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.website = '',
    this.phone = '',
    this.logoUrl,
  });

  final int? id;
  final String name;
  final String tradeName;
  final String gstin;
  final String cin;
  final String pan;
  final String tan;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String website;
  final String phone;
  final String? logoUrl;

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) {
    return CompanyInfoModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['company_name'] as String? ?? '',
      tradeName: json['trade_name'] as String? ?? '',
      gstin: json['gstin'] as String? ?? '',
      cin: json['cin'] as String? ?? '',
      pan: json['pan'] as String? ?? '',
      tan: json['tan'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pinCode: json['pin_code'] as String? ?? '',
      website: json['website'] as String? ?? '',
      phone: json['official_phone'] as String? ?? '',
      logoUrl: json['logo'] as String?,
    );
  }

  Map<String, dynamic> toUpdateJson() => {
    'company_name': name,
    'trade_name': tradeName,
    'gstin': gstin,
    'cin': cin,
    'pan': pan,
    'tan': tan,
    'address': address,
    'city': city,
    'state': state,
    'pin_code': pinCode,
    'website': website,
    'official_phone': phone,
  };

  CompanyInfo toEntity() => CompanyInfo(
    id: id,
    name: name,
    tradeName: tradeName,
    gstin: gstin,
    cin: cin,
    pan: pan,
    tan: tan,
    address: address,
    city: city,
    state: state,
    pinCode: pinCode,
    website: website,
    phone: phone,
    logoUrl: logoUrl,
  );

  static CompanyInfoModel fromEntity(CompanyInfo e) => CompanyInfoModel(
    id: e.id,
    name: e.name,
    tradeName: e.tradeName,
    gstin: e.gstin,
    cin: e.cin,
    pan: e.pan,
    tan: e.tan,
    address: e.address,
    city: e.city,
    state: e.state,
    pinCode: e.pinCode,
    website: e.website,
    phone: e.phone,
    logoUrl: e.logoUrl,
  );
}
