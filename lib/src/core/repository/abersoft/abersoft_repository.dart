part of 'base_abersoft_repository.dart';

class AbersoftRepository extends BaseAbersoftRepository {
  final BaseSharedPrefClient sharedPrefClient;
  final BaseApiClient apiClient;

  AbersoftRepository({
    required this.sharedPrefClient,
    required this.apiClient,
  });

  @override
  Future<Product?> addProduct({
    required String name,
    required String description,
    required File image,
  }) async {
    Product? product;

    // Create a FormData object
    var formData = FormData();

    // Append data to the FormData object
    formData.fields.add(MapEntry('productName', name));
    formData.fields.add(MapEntry('productDecription', description));

    // Append an image file to the FormData object
    formData.files.add(
      MapEntry(
        'productImage',
        await MultipartFile.fromFile(image.path),
      ),
    );

    final token = await sharedPrefClient.getByKey(TOKEN, SharedPrefType.string);

    Response response = await apiClient.post(
      '/products',
      data: formData,
      token: token,
    );

    if (response.data != null) {
      product = Product.fromJson(response.data);
    }

    return product;
  }

  @override
  Future<Product?> getListProduct() async {
    Product? product;

    final token = await sharedPrefClient.getByKey(TOKEN, SharedPrefType.string);

    Response response = await apiClient.get('/products', token: token);

    if (response.data != null) {
      product = Product.fromJson(response.data);
    }

    return product;
  }

  @override
  Future<String?> login({
    required String username,
    required String password,
  }) async {
    String? token;

    Response response = await apiClient.post('/login', data: {
      'username': username,
      'password': password,
    });

    if (response.data != null) {
      token = response.data['token'];
      await sharedPrefClient.saveByKey(token, TOKEN, SharedPrefType.string);
    }

    return token;
  }

  @override
  Future<bool> isLogged() async {
    final token = await sharedPrefClient.getByKey(TOKEN, SharedPrefType.string);
    return token != null;
  }
}
