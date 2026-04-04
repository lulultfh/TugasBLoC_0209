import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderSubmitted>(_onOrderSubmitted);
    on<OrderReset>(_onOrderReset);
  }
  Future<void> _onOrderSubmitted(
    OrderSubmitted event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    await Future.delayed(const Duration(microseconds: 500));

    final int totalHarga =
        (event.jumlahMakanan * 32000) + (event.jumlahMinuman * 5000);
    emit(OrderSuccess(makanan: event.makanan, minuman: event.minuman, jumlahMakanan: event.jumlahMakanan, jumlahMinuman: event.jumlahMinuman, totalHarga: totalHarga));
  }
  void _onOrderReset(OrderReset event, Emitter<OrderState> emit){
    emit(OrderInitial());
  }
}
