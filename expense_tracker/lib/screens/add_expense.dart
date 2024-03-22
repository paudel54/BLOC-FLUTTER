import 'package:expense_tracker/bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/input_form.dart';
import '../widgets/button.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
  });

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  // to populate a date feild auto populated by default instantancing controller.
  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );
    super.initState();
  }

  addTransaction(Transaction transaction) {
    context.read<TransactionBloc>().add(
          AddTransaction(transaction),
        );
    context.read<TransactionBloc>().add(CalculateTransaction());
  }

  removeTransaction(Transaction transaction) {
    context.read<TransactionBloc>().add(
          RemoveTransaction(transaction),
        );
    context.read<TransactionBloc>().add(CalculateTransaction());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'NEW TRANSACTION',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 3,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Expense',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                        return Switch(
                            value: state.isSwitch,
                            onChanged: (value) {
                              context
                                  .read<TransactionBloc>()
                                  .add(ToggleSwitch());
                            });
                      },
                    ),
                    const Text(
                      'Income',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                customSizedBoxFormField(
                  controller: expenseController,
                  hintText: 'Enter total Amount.',
                  icon: Icons.currency_rupee,
                  height: 70, // Adjust the height as needed
                ),
                const SizedBox(height: 12),
                customSizedBoxFormField(
                  controller: remarkController,
                  hintText: 'Enter your Remarks',
                  icon: Icons.note_add,
                  height: 80, // Adjust the height as needed
                ),
                TextFormField(
                  controller: dateController,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );
                    if (newDate != null) {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.date_range,
                      size: 20,
                      color: Colors.grey,
                    ),
                    hintText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    return CustomTextButton(
                      text: 'Save',
                      onPressed: () {
                        addTransaction(Transaction(
                            value: double.parse(expenseController.text),
                            isIncome: state.isSwitch,
                            remark: remarkController.text,
                            date: selectDate));
                        expenseController.text = '';
                        remarkController.text = '';
                        Navigator.pop(context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
