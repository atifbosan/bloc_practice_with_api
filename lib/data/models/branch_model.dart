class BranchModel {
  int? branchCode;
  String? branchName;
  String? shortName;
  String? description;
  String? createdOn;
  int? createdBy;
  String? modifiedOn;
  int? modifiedBy;
  String? logoPath;
  String? faviconPath;
  String? logoPathForReports;

  BranchModel(
      {this.branchCode,
      this.branchName,
      this.shortName,
      this.description,
      this.createdOn,
      this.createdBy,
      this.modifiedOn,
      this.modifiedBy,
      this.logoPath,
      this.faviconPath,
      this.logoPathForReports});

  BranchModel.fromJson(Map<String, dynamic> json) {
    branchCode = json['BranchCode'];
    branchName = json['BranchName'];
    shortName = json['ShortName'];
    description = json['Description'];
    createdOn = json['CreatedOn'];
    createdBy = json['CreatedBy'];
    modifiedOn = json['ModifiedOn'];
    modifiedBy = json['ModifiedBy'];
    logoPath = json['LogoPath'];
    faviconPath = json['FaviconPath'];
    logoPathForReports = json['LogoPathForReports'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BranchCode'] = this.branchCode;
    data['BranchName'] = this.branchName;
    data['ShortName'] = this.shortName;
    data['Description'] = this.description;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    data['ModifiedOn'] = this.modifiedOn;
    data['ModifiedBy'] = this.modifiedBy;
    data['LogoPath'] = this.logoPath;
    data['FaviconPath'] = this.faviconPath;
    data['LogoPathForReports'] = this.logoPathForReports;
    return data;
  }
}
