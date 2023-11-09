// сначала создаем объект самого поста
class Post {
  // все поля являются private
  // это сделано для инкапсуляции данных
  final int _userId;
  final int _id;
  final String _title;
  final String _body;

  // создаем getters для наших полей
  // дабы только мы могли читать их
  int get userId => _userId;
  int get id => _id;
  String get title => _title;
  String get body => _body;

  // Dart позволяет создавать конструкторы с разными именами
  // В данном случае Post.fromJson(json) - это конструктор
  // здесь мы принимаем JSON объект поста и извлекаем его поля
  // обратите внимание, что dynamic переменная
  // может иметь разные типы: String, int, double и т.д.
  Post.fromJson(Map<String, dynamic> json)
      : this._userId = json["userId"],
        this._id = json["id"],
        this._title = json["title"],
        this._body = json["body"];
}

// PostList являются оберткой для массива постов
class PostList {
  final List<Post> posts = [];
  PostList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      posts.add(Post.fromJson(jsonItem));
    }
  }
}

// наше представление будет получать объекты
// этого класса и определять конкретный его
// подтип
abstract class PostResult {}

// указывает на успешный запрос
class PostResultSuccess extends PostResult {
  final PostList postList;
  PostResultSuccess(this.postList);
}

// произошла ошибка
class PostResultFailure extends PostResult {
  final String error;
  PostResultFailure(this.error);
}

// загрузка данных
class PostResultLoading extends PostResult {
  PostResultLoading();
}
