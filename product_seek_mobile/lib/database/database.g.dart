// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao _userDaoInstance;

  ProductDao _productDaoInstance;

  CategoryDao _categoryDaoInstance;

  StoreDao _storeDaoInstance;

  CartDao _cartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserModel` (`id` INTEGER, `name` TEXT, `email` TEXT, `phone_number` TEXT, `address` TEXT, `role` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductModel` (`id` INTEGER, `title` TEXT, `images` TEXT, `price` REAL, `description` TEXT, `category_id` INTEGER, `store_id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StoreModel` (`id` INTEGER, `name` TEXT, `email` TEXT, `contact` TEXT, `address` TEXT, `followers` TEXT, `mapUrl` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CategoryModel` (`id` INTEGER, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartItemModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `product` TEXT, `quantity` INTEGER, `total_price` REAL, `status` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  StoreDao get storeDao {
    return _storeDaoInstance ??= _$StoreDao(database, changeListener);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'UserModel',
            (UserModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone_number': item.phoneNumber,
                  'address': item.address,
                  'role': item.role
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userModelMapper = (Map<String, dynamic> row) => UserModel(
      row['id'] as int,
      row['name'] as String,
      row['email'] as String,
      row['phone_number'] as String,
      row['address'] as String,
      row['role'] as String);

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  @override
  Future<UserModel> getUserDetail(int id) async {
    return _queryAdapter.query('SELECT * FROM UserModel WHERE id = ?',
        arguments: <dynamic>[id], mapper: _userModelMapper);
  }

  @override
  Future<void> remoteItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserModel');
  }

  @override
  Future<void> addUserData(UserModel userModel) async {
    await _userModelInsertionAdapter.insert(
        userModel, OnConflictStrategy.replace);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'ProductModel',
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId,
                  'store_id': item.storeId
                },
            changeListener),
        _productModelUpdateAdapter = UpdateAdapter(
            database,
            'ProductModel',
            ['id'],
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId,
                  'store_id': item.storeId
                },
            changeListener),
        _productModelDeletionAdapter = DeletionAdapter(
            database,
            'ProductModel',
            ['id'],
            (ProductModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'images': item.images,
                  'price': item.price,
                  'description': item.description,
                  'category_id': item.categoryId,
                  'store_id': item.storeId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _productModelMapper = (Map<String, dynamic> row) => ProductModel(
      row['id'] as int,
      row['title'] as String,
      row['images'] as String,
      row['price'] as double,
      row['description'] as String,
      row['category_id'] as int,
      row['store_id'] as int);

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  final UpdateAdapter<ProductModel> _productModelUpdateAdapter;

  final DeletionAdapter<ProductModel> _productModelDeletionAdapter;

  @override
  Stream<List<ProductModel>> getProducts() {
    return _queryAdapter.queryListStream('SELECT * FROM ProductModel LIMIT 30',
        queryableName: 'ProductModel',
        isView: false,
        mapper: _productModelMapper);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM ProductModel where id =?',
        arguments: <dynamic>[id], mapper: _productModelMapper);
  }

  @override
  Stream<List<ProductModel>> getProductsByCategory(int categoryId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ProductModel WHERE category_id =? LIMIT 30',
        arguments: <dynamic>[categoryId],
        queryableName: 'ProductModel',
        isView: false,
        mapper: _productModelMapper);
  }

  @override
  Stream<List<ProductModel>> getSearchresults(String name) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ProductModel WHERE title LIKE ?',
        arguments: <dynamic>[name],
        queryableName: 'ProductModel',
        isView: false,
        mapper: _productModelMapper);
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> addProducts(List<ProductModel> product) async {
    await _productModelInsertionAdapter.insertList(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _productModelUpdateAdapter.update(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeProduct(ProductModel product) async {
    await _productModelDeletionAdapter.delete(product);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryModelInsertionAdapter = InsertionAdapter(
            database,
            'CategoryModel',
            (CategoryModel item) =>
                <String, dynamic>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _categoryModelMapper = (Map<String, dynamic> row) =>
      CategoryModel(row['id'] as int, row['name'] as String);

  final InsertionAdapter<CategoryModel> _categoryModelInsertionAdapter;

  @override
  Stream<CategoryModel> getCategory() {
    return _queryAdapter.queryStream('SELECT * FROM CategoryModel',
        queryableName: 'CategoryModel',
        isView: false,
        mapper: _categoryModelMapper);
  }

  @override
  Stream<CategoryModel> getCategoryFromId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM CategoryModel WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'CategoryModel',
        isView: false,
        mapper: _categoryModelMapper);
  }

  @override
  Future<void> addCategory(CategoryModel categoryModel) async {
    await _categoryModelInsertionAdapter.insert(
        categoryModel, OnConflictStrategy.replace);
  }
}

class _$StoreDao extends StoreDao {
  _$StoreDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _storeModelInsertionAdapter = InsertionAdapter(
            database,
            'StoreModel',
            (StoreModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'contact': item.contact,
                  'address': item.address,
                  'followers': item.followers,
                  'mapUrl': item.mapUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _storeModelMapper = (Map<String, dynamic> row) => StoreModel(
      row['id'] as int,
      row['name'] as String,
      row['email'] as String,
      row['contact'] as String,
      row['address'] as String,
      row['followers'] as String,
      row['mapUrl'] as String);

  final InsertionAdapter<StoreModel> _storeModelInsertionAdapter;

  @override
  Stream<StoreModel> getStore() {
    return _queryAdapter.queryStream('SELECT * FROM StoreModel',
        queryableName: 'StoreModel', isView: false, mapper: _storeModelMapper);
  }

  @override
  Future<StoreModel> getStoreFromId(int id) async {
    return _queryAdapter.query('SELECT * FROM StoreModel WHERE id = ?',
        arguments: <dynamic>[id], mapper: _storeModelMapper);
  }

  @override
  Future<void> addStore(StoreModel storeModel) async {
    await _storeModelInsertionAdapter.insert(
        storeModel, OnConflictStrategy.replace);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemModelInsertionAdapter = InsertionAdapter(
            database,
            'CartItemModel',
            (CartItemModel item) => <String, dynamic>{
                  'id': item.id,
                  'product': item.product,
                  'quantity': item.quantity,
                  'total_price': item.totalPrice,
                  'status': item.status
                },
            changeListener),
        _cartItemModelUpdateAdapter = UpdateAdapter(
            database,
            'CartItemModel',
            ['id'],
            (CartItemModel item) => <String, dynamic>{
                  'id': item.id,
                  'product': item.product,
                  'quantity': item.quantity,
                  'total_price': item.totalPrice,
                  'status': item.status
                },
            changeListener),
        _cartItemModelDeletionAdapter = DeletionAdapter(
            database,
            'CartItemModel',
            ['id'],
            (CartItemModel item) => <String, dynamic>{
                  'id': item.id,
                  'product': item.product,
                  'quantity': item.quantity,
                  'total_price': item.totalPrice,
                  'status': item.status
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _cartItemModelMapper = (Map<String, dynamic> row) =>
      CartItemModel(
          row['id'] as int,
          row['product'] as String,
          row['quantity'] as int,
          row['total_price'] as double,
          row['status'] as String);

  final InsertionAdapter<CartItemModel> _cartItemModelInsertionAdapter;

  final UpdateAdapter<CartItemModel> _cartItemModelUpdateAdapter;

  final DeletionAdapter<CartItemModel> _cartItemModelDeletionAdapter;

  @override
  Stream<List<CartItemModel>> getCartItems() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM CartItemModel WHERE status = "pending"',
        queryableName: 'CartItemModel',
        isView: false,
        mapper: _cartItemModelMapper);
  }

  @override
  Future<CartItemModel> checkExistingItem(String product) async {
    return _queryAdapter.query(
        'SELECT * FROM CartItemModel WHERE status="pending" AND product =?',
        arguments: <dynamic>[product],
        mapper: _cartItemModelMapper);
  }

  @override
  Future<void> remoteItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CartItemModel');
  }

  @override
  Future<void> addItemToCart(CartItemModel cartItem) async {
    await _cartItemModelInsertionAdapter.insert(
        cartItem, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateItem(CartItemModel item) async {
    await _cartItemModelUpdateAdapter.update(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> remoteItem(CartItemModel cartItem) async {
    await _cartItemModelDeletionAdapter.delete(cartItem);
  }
}
