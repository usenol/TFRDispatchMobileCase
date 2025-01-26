import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/api_service.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(const OrdersInitial()) {
    on<LoadOrders>(_onLoadOrders);
  }

  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(const OrdersLoading());

    try {
      final orders = await ApiService.getOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
} 