abstract interface class IOrderRepository {
  Future<Map> createOrder({required Map<String, int> orderJson});
}