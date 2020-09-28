import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';

class HouseDetails {
  String description;
  String area;
  String location;
  String phone;
  String email;
  String price;
  String detailsAboutHouse;
  String image;
  String areaCityName;
  String areaCityAddress;
  String properityId;
  dynamic isFavourit;
  Property property;
  HouseDetails({
    this.price = "",
    this.property,
    this.description = "",
    this.image,
    this.area = "",
    this.email = "",
    this.phone = "",
    this.properityId,
    this.areaCityName = "",
    this.areaCityAddress = "",
    this.detailsAboutHouse = "",
    this.location = "",
    this.isFavourit = null,
  });

  // String showFullHouseDetails(){
  //   return  String name = "${pro.propertySpecs[index].name}";
  //   name += ":";
  //   for (int i = 0; i < pro.propertySpecs[index].propertyOptions.length; i++) {
  //     name += " " +
  //         pro.propertySpecs[index].propertyOptions[i].typeOption
  //             .name +
  //         " ";
  //   }
  // }
}
