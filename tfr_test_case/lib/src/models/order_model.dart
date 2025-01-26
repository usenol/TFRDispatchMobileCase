class OrderModel {
  final String id;
  final String orderNumber;
  final String restaurantName;
  final String restaurantAddress;
  final String deliveryDate;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.deliveryDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final populatedOrder = json['populated_order'] as Map<String, dynamic>? ?? {};
    final populatedRestaurant = populatedOrder['populated_restaurant'] as Map<String, dynamic>? ?? {};

    return OrderModel(
      id: json['id']?.toString() ?? '',
      orderNumber: populatedOrder['order_number']?.toString() ?? '',
      restaurantName: populatedRestaurant['name']?.toString() ?? '',
      restaurantAddress: populatedRestaurant['address']?.toString() ?? '',
      deliveryDate: populatedOrder['deliver_date']?.toString() ?? '',
    );
  }
}
