import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugasbloc/bloc/order_bloc.dart';
import 'package:tugasbloc/main_layout.dart';
import 'package:tugasbloc/page/detail_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController makananController = TextEditingController();
  final TextEditingController minumanController = TextEditingController();
  final TextEditingController jumlahMakananController = TextEditingController();
  final TextEditingController jumlahMinumanController = TextEditingController();
  int totalHarga = 0;
  final _formKey = GlobalKey<FormState>();

  // void calculateTotalPrice() {
  //   int jumlahMakanan = int.tryParse(jumlahMakananController.text) ?? 0;
  //   int jumlahMinuman = int.tryParse(jumlahMinumanController.text) ?? 0;

  //   setState(() {
  //     totalHarga = (jumlahMakanan * 32000) + (jumlahMinuman * 5000);
  //   });
  // }

  @override
  void dispose() {
    makananController.dispose();
    minumanController.dispose();
    jumlahMakananController.dispose();
    jumlahMinumanController.dispose();
    super.dispose();
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String errorMessage,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: MainLayout.labelColor),
        prefixIcon: Icon(icon, color: MainLayout.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: MainLayout.inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: MainLayout.primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: MainLayout.inputFillColor,
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? errorMessage : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailOrderPage(
                makanan: state.makanan,
                minuman: state.minuman,
                jumlahMakanan: state.jumlahMakanan.toString(),
                jumlahMinuman: state.jumlahMinuman.toString(),
                totalHarga: state.totalHarga,
              ),
            ),
          );
        } else if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: MainLayout(
        title: 'Order Menu',
        showAppBar: true,
        child: Container(
          color: MainLayout.backgroundColor,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'What would you like to have?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MainLayout.textTileColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fill in the details below to complete your order.',
                      style: TextStyle(
                        fontSize: 14,
                        color: MainLayout.textSubtitleColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.fastfood_rounded,
                                color: MainLayout.accentOrange,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Food Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MainLayout.textTileColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            controller: makananController,
                            label: 'Food Name',
                            icon: Icons.lunch_dining_rounded,
                            errorMessage: 'Please enter your food order',
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            controller: jumlahMakananController,
                            label: 'Quantity (Food)',
                            icon: Icons.format_list_numbered_rounded,
                            keyboardType: TextInputType.number,
                            errorMessage: 'Please enter food quantity',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.local_drink_rounded,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Drink Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MainLayout.textTileColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            controller: minumanController,
                            label: 'Drink Name',
                            icon: Icons.coffee_rounded,
                            errorMessage: 'Please enter your drink order',
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            controller: jumlahMinumanController,
                            label: 'Quantity (Drink)',
                            icon: Icons.format_list_numbered_rounded,
                            keyboardType: TextInputType.number,
                            errorMessage: 'Please enter drink quantity',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        final isLoading = state is OrderLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<OrderBloc>().add(
                                      OrderSubmitted(
                                        makanan: makananController.text,
                                        minuman: minumanController.text,
                                        jumlahMakanan:
                                            int.tryParse(
                                              jumlahMakananController.text,
                                            ) ??
                                            0,
                                        jumlahMinuman:
                                            int.tryParse(
                                              jumlahMinumanController.text,
                                            ) ??
                                            0,
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: MainLayout.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: MainLayout.primaryColor.withOpacity(
                              0.5,
                            ),
                          ),
                          child: isLoading? 
                          const SizedBox(height: 22, width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.5
                          ))
                          : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long_rounded),
                              SizedBox(width: 8),
                              Text(
                                'Place Order',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}