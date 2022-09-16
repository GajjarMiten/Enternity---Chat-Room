class Singleton<T> {
  static final Map<Type, dynamic> _instances = <Type, dynamic>{};

  factory Singleton() {
    final type = T;
    if (_instances.containsKey(type)) {
      return _instances[type];
    } else {
      final instance = Singleton._internal();
      _instances[type] = instance;
      return instance as Singleton<T>;
    }
  }

  Singleton._internal();
}
