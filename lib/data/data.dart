import 'package:wallpaper_hub/model/categores_model.dart';

final baseUrl = "https://api.unsplash.com";
String apikey = "LQxtQZnr52eUGrb4UDbJiGhZQObXqT3sctyv4WbrS20";
String perPage = "10";
String orientation = "portrait";

List<CategoresModel> getCategories() {
  List<CategoresModel> categories = [];
  CategoresModel categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1517994112540-009c47ea476b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzh8fGNhcnN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Cars";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1551040096-afacb90386de?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmlrZXN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Bikes";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1468971050039-be99497410af?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Motivation";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2l0eXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "City";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1611918126831-0a8352d6196f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJlJTIwYmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Nature";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1477949775154-d739b82400b3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGxpZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Wild Life";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  categoresModel.imageUrl =
      "https://images.unsplash.com/photo-1580089056071-11f31b94fefe?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3RyZWV0JTIwYXJ0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoresModel.categoryName = "Street art";
  categories.add(categoresModel);
  categoresModel = new CategoresModel();

  return categories;
}
