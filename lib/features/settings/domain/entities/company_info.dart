class CompanyInfo {
  const CompanyInfo({
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

  CompanyInfo copyWith({
    int? id,
    String? name,
    String? tradeName,
    String? gstin,
    String? cin,
    String? pan,
    String? tan,
    String? address,
    String? city,
    String? state,
    String? pinCode,
    String? website,
    String? phone,
    String? logoUrl,
  }) {
    return CompanyInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      tradeName: tradeName ?? this.tradeName,
      gstin: gstin ?? this.gstin,
      cin: cin ?? this.cin,
      pan: pan ?? this.pan,
      tan: tan ?? this.tan,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
