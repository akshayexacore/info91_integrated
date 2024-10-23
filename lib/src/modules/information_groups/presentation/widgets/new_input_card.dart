import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewInputCard extends StatefulWidget {
  final double fontsize;
  final double height;
  final bool readOnly;
  final bool formatter;
  final TextEditingController controller;
  final int maxLines;
  final Color colors;
  final String? label;
  final String? keyboardType;
  final bool isBorder;
  final bool showValidator;
  final String? Function(String?)? validator;
  final String? validatorMessage;
  final String title;
  final String? hint;

  final bool password;
  final bool direction;
  const NewInputCard({
    super.key,
    this.isBorder = true,
    required this.controller,
    this.label,
    this.keyboardType,
    this.hint,
    this.formatter = false,
    this.readOnly = false,
    this.password = false,
    this.direction = false,
    this.showValidator = false,
    required this.title,
    this.validatorMessage,
    this.colors = const Color(0xffC3C7C9),
    this.maxLines = 1,
    this.height = 50,
    this.fontsize = 13,
    this.validator,
  });

  @override
  State<NewInputCard> createState() => _NewInputCardState();
}

class _NewInputCardState extends State<NewInputCard> {
  bool show = false;
  @override
  void initState() {
    super.initState();
    show = widget.password;
  }

  InputBorder? borderStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
            color: widget.isBorder
                ? AppColors.text.withOpacity(.5)
                : Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text == "null"
        ? widget.controller.text = ""
        : widget.controller.text;

    return widget.direction == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                    fontSize: widget.fontsize,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text),
              ),
              const SizedBox(height: 3),
              widget.keyboardType == "int"
                  ? Container(
                      alignment: Alignment.center,
                      height: widget.height,

                      // color: widget.colors,
                      // color: Colors.grey.shade200,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: widget.readOnly,
                        maxLines: widget.maxLines,
                        controller: widget.controller,
                        obscureText: show,
                        keyboardType:
                            widget.formatter ? TextInputType.number : null,
                        inputFormatters: widget.formatter
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.readOnly
                              ? const Color(0xffF2F3F5).withOpacity(.2)
                              : Colors.white,
                          suffixIcon: widget.password
                              ? IconButton(
                                  icon: show
                                      ? const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 18,
                                        ),
                                  onPressed: () {
                                    show = !show;
                                    setState(() {});
                                  },
                                )
                              : null,
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            //fontStyle: FontStyle.italic,
                          ),
                          // label: Text(
                          //   widget.label,
                          // ),
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          hintText: widget.label,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff3E4F5B).withOpacity(.1))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff3E4F5B).withOpacity(.1))),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.topLeft,
                      // height: widget.height,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: widget.readOnly,
                        maxLines: widget.maxLines,
                        controller: widget.controller,
                        obscureText: show,
                        validator: widget.showValidator
                            ? widget.validator ??
                                (value) {
                                  if (value == null || value.isEmpty) {
                                    return widget.validatorMessage ??
                                        'This is a mandatory field';
                                  }
                                  return null; // Valid input
                                }
                            : null,
                        keyboardType:
                            widget.formatter ? TextInputType.number : null,
                        inputFormatters: widget.formatter
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : null,
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: widget.readOnly
                              ? const Color(0xffF2F3F5).withOpacity(.2)
                              : Colors.transparent,
                          suffixIcon: widget.password
                              ? IconButton(
                                  icon: show
                                      ? const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 18,
                                        ),
                                  onPressed: () {
                                    show = !show;
                                    setState(() {});
                                  },
                                )
                              : null,
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            //fontStyle: FontStyle.italic,
                          ),
                          // label: Text(
                          //   widget.label,
                          // ),
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.text.withOpacity(.8),
                              fontWeight: FontWeight.w400),
                          hintText: widget.label,
                          disabledBorder: borderStyle(),
                          enabledBorder: borderStyle(),
                          border: borderStyle(),
                          focusedBorder: borderStyle(),
                        ),
                      ),
                    ),
            ],
          )
        : SizedBox(
            height: 300,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: widget.fontsize, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .003),
                SizedBox(
                  height: widget.height,
                  // color: widget.colors,
                  // color: Colors.grey.shade200,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: widget.maxLines,
                    controller: widget.controller,
                    obscureText: show,
                    decoration: InputDecoration(
                      suffixIcon: widget.password
                          ? IconButton(
                              icon: show
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 18,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      size: 18,
                                    ),
                              onPressed: () {
                                show = !show;
                                setState(() {});
                              },
                            )
                          : null,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        //fontStyle: FontStyle.italic,
                      ),
                      // label: Text(
                      //   widget.label,
                      // ),
                      hintStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                      hintText: widget.label,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: widget.colors)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CustomDropDownWidget<T> extends StatelessWidget {
  final String title;
  final double fontsize;
  final List<T> itemList;
  final T? selectedItem;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final String Function(T) getItemTAble;

  const CustomDropDownWidget(
      {super.key,
      required this.title,
      this.fontsize = 13,
      required this.getItemTAble,
      required this.itemList,
      required this.onChanged,
      required this.selectedItem,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: fontsize,
              fontWeight: FontWeight.w400,
              color: AppColors.text),
        ),
        const SizedBox(height: 3),
        DropdownButtonFormField2<T>(
            //focusColor: Colors.white,
            //dropdownColor: Colors.white,
            decoration: dropdownDecoration.copyWith(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 14.h),
              focusColor: Colors.transparent,
              prefixIconConstraints: BoxConstraints.tight(const Size(2, 0)),
              prefixIcon: Container(
                width: 0,
              ),
            ),
            hint: Text(
              hintText ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.text.withOpacity(.8),
                  fontWeight: FontWeight.w400),
            ),
            alignment: Alignment.centerLeft,
            validator: (value) {
              if (value == null) {
                return 'This is a mandatory field';
              }
              return null; // Valid input
            },
            //underline: const SizedBox(),
            buttonStyleData: const ButtonStyleData(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.transparent),
                padding: EdgeInsets.symmetric(horizontal: 0),
                elevation: 0,
                overlayColor: WidgetStatePropertyAll(Colors.white)),
            dropdownStyleData: const DropdownStyleData(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.white),
            ),
            // Initial Value
            // value:itemList.contains(selectedItem) ? selectedItem : null,
            isExpanded: false,
            // Down Arrow Icon
            iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                iconSize: 13),
            // Array list of items
            items: itemList.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  getItemTAble(e),
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: onChanged),
      ],
    );
  }
}

class CustomDropSearcDownWidget<T> extends StatelessWidget {
  final String title;
  final double fontsize;
  final List<T> itemList;
  final T? selectedItem;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final String Function(T) getItemLabel;

  const CustomDropSearcDownWidget({
    super.key,
    required this.title,
    this.fontsize = 13,
    required this.getItemLabel,
    required this.itemList,
    required this.onChanged,
    required this.selectedItem,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: fontsize,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 3),
        DropdownSearch<T>(
          items: itemList,
          selectedItem: selectedItem,
          itemAsString: getItemLabel,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: dropdownDecoration.copyWith(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 14.h),
              focusColor: Colors.transparent,
            ),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: true, // Enable the search feature
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search",
              ),
            ),
          ),
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return 'This is a mandatory field';
            }
            return null;
          },
        ),
      ],
    );
  }
}

InputDecoration dropdownDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.text.withOpacity(.5), width: 1),
      borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.text.withOpacity(.5), width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.text.withOpacity(.5), width: 1),
      borderRadius: BorderRadius.circular(10)),
);
