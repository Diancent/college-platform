import '../data/repository.dart';
import '../models/post.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PostController extends ControllerMVC {
  // создаем наш репозиторий
  final Repository repo = Repository();

  // конструктор нашего контроллера
  PostController();

  // первоначальное состояние - загрузка данных
  PostResult currentState = PostResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final postList = await repo.fetchPosts();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PostResultSuccess(postList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PostResultFailure("Нет интернета"));
    }
  }
}
