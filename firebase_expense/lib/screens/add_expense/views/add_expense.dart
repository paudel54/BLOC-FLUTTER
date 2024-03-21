import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/custom_text_button.dart';
import 'package:todo/screens/add_expense/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

// to populate a date feild auto populated by default instantancing controller.
  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add Expenses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                onTap: () {},
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.category_sharp,
                    size: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          String iconSelected = '';
                          late Color categoryColor = Colors.white;
                          bool isExpanded = false;
                          return StatefulBuilder(
                            builder: (ctx, setState) {
                              TextEditingController categoryNameController =
                                  TextEditingController();

                              TextEditingController categoryIconController =
                                  TextEditingController();

                              TextEditingController categoryColorController =
                                  TextEditingController();
                              return AlertDialog(
                                title: const Text('Create a Category'),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: categoryNameController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // readOnly: true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.text_fields,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          hintText: 'Name',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: categoryIconController,
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.logo_dev,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.arrow_downward,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          hintText: 'Icons',
                                          border: OutlineInputBorder(
                                            borderRadius: isExpanded
                                                ? const BorderRadius.vertical(
                                                    top: Radius.circular(12),
                                                  )
                                                : BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      isExpanded
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  bottom: Radius.circular(12),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5,
                                                  ),
                                                  itemCount:
                                                      myCategoriesIcons.length,
                                                  itemBuilder:
                                                      (context, int i) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            iconSelected =
                                                                myCategoriesIcons[
                                                                    i];
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: iconSelected ==
                                                                    myCategoriesIcons[
                                                                        i]
                                                                ? Colors.green
                                                                : Colors.blue
                                                                    .shade100,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                              'assets/${myCategoriesIcons[i]}.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: categoryColorController,
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx2) {
                                              return BlocProvider.value(
                                                value: context
                                                    .read<CreateCategoryBloc>(),
                                                child: AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ColorPicker(
                                                          pickerColor:
                                                              Colors.red,
                                                          onColorChanged:
                                                              (value) {
                                                            setState(
                                                              () {
                                                                categoryColor =
                                                                    value;
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Save',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              // debugPrint(
                                                              //     categoryColor
                                                              //         as String?);

                                                              Navigator.pop(
                                                                  ctx2);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: categoryColor,
                                          prefixIcon: const Icon(
                                            Icons.color_lens,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          hintText: 'Color',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      CustomTextButton(
                                        text: 'Save',
                                        onPressed: () {
                                          //Create Category object and POP
                                          Category category = Category.empty;
                                          category.categoryId =
                                              const Uuid().v1();
                                          category.name =
                                              categoryNameController.text;
                                          category.icon = iconSelected;
                                          category.color =
                                              categoryColor.toString();

                                          context
                                              .read<CreateCategoryBloc>()
                                              .add(CreateCategory(category));

                                          // Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 16,
                    color: Colors.grey,
                  ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
