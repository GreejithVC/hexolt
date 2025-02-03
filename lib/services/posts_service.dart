import '../models/post_model.dart';
import '../networks/api_handler.dart';
import '../networks/api_urls.dart';

class PostsService {
  ApiHandler apiHandler = ApiHandler();

  Future<List<Post>> fetchPosts(int start) async {
    final response = await apiHandler.get(
        url: "${ApiUrls.postsUrl}?_start=$start&_limit=10");
    return Post.fromListJson(response);
  }
}
