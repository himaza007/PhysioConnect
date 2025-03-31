import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';

/// A customizable text field widget with consistent styling and
/// additional features like validation and formatting
// class CustomTextField extends StatelessWidget {
//   final String label;
//   final String? hint;
//   final String? errorText;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final Function(String)? onChanged;
//   final List<TextInputFormatter>? inputFormatters;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final VoidCallback? onSuffixIconPressed;
//   final bool readOnly;
//   final String? Function(String?)? validator;
//   final int? maxLines;
//   final int? maxLength;

//   /// Creates a styled text field with various customization options
//   ///
//   /// [label] - Label text above the field
//   /// [hint] - Optional placeholder text
//   /// [errorText] - Optional error message to display
//   /// [obscureText] - Whether to hide the text (for passwords)
//   /// [controller] - Controller to manage the text input
//   /// [keyboardType] - Keyboard type for specific input formats
//   /// [onChanged] - Callback when text changes
//   /// [inputFormatters] - Formatters to restrict or format input
//   /// [prefixIcon] - Optional icon at the beginning of the field
//   /// [suffixIcon] - Optional icon at the end of the field
//   /// [onSuffixIconPressed] - Callback when suffix icon is pressed
//   /// [readOnly] - Whether the field is read-only
//   /// [validator] - Function to validate input
//   /// [maxLines] - Maximum number of lines (defaults to 1)
//   /// [maxLength] - Maximum number of characters allowed
//   const CustomTextField({
//     Key? key,
//     required this.label,
//     this.hint,
//     this.errorText,
//     this.obscureText = false,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.onChanged,
//     this.inputFormatters,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onSuffixIconPressed,
//     this.readOnly = false,
//     this.validator,
//     this.maxLines = 1,
//     this.maxLength,
//   }) : super(key: key);

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool readOnly;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.readOnly = false,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field label
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),

        // Text field
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
          inputFormatters: inputFormatters,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,

            // Prefix icon if provided
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: AppTheme.midnightTeal)
                    : null,

            // Suffix icon with optional tap callback
            suffixIcon:
                suffixIcon != null
                    ? IconButton(
                      icon: Icon(suffixIcon, color: AppTheme.midnightTeal),
                      onPressed: onSuffixIconPressed,
                    )
                    : null,

            // Counter text style
            counterStyle: Theme.of(context).textTheme.bodyMedium,

            // Error style
            errorStyle: TextStyle(color: AppTheme.errorRed, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
