import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../services/firebase_service.dart';
import 'success_screen.dart';

class FormScreen extends StatefulWidget {
  final String discoverySource;

  const FormScreen({super.key, required this.discoverySource});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedServices = [];
  String name = '';
  String phone = '';
  String email = '';
  String company = '';
  String? message;
  bool wantsMeeting = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? _tempPhone;

  final List<String> serviceOptions = [
    "Real Estate",
    "Car Hire",
    "Logistics",
    "Solar Installation",
    "CCTV Installation"
  ];

  Future<void> _selectDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final success = await FirebaseService.submitLead(
        services: selectedServices,
        name: name,
        phone: phone,
        email: email,
        company: company,
        message: message ?? '',
        discoverySource: widget.discoverySource,
        wantsMeeting: wantsMeeting,
        scheduledDate: wantsMeeting && selectedDate != null
            ? selectedDate!.toIso8601String()
            : null,
        scheduledTime: wantsMeeting && selectedTime != null
            ? selectedTime!.format(context)
            : null,
      );

      if (success) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SuccessScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Submission failed.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lead Form")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Select Service(s) Interested In:"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: serviceOptions.map((option) {
                  return FilterChip(
                    label: Text(option),
                    selected: selectedServices.contains(option),
                    onSelected: (selected) {
                      setState(() {
                        if (selected && !selectedServices.contains(option)) {
                          selectedServices.add(option);
                        } else {
                          selectedServices.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: "Full Name"),
                onSaved: (val) => name = val!,
                validator: (val) => val!.isEmpty ? "Required" : null,
              ),
              IntlPhoneField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                initialCountryCode: 'NG',
                onChanged: (phoneNumber) => _tempPhone = phoneNumber.completeNumber,
                onSaved: (phoneNumber) =>
                phone = _tempPhone ?? phoneNumber!.completeNumber,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Email Address"),
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => email = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  if (!val.contains("@")) return "Enter a valid email";
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Company Name",
                  hintText: "If no company, repeat your name or leave blank",
                ),
                onSaved: (val) => company = val ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Message"),
                maxLines: 3,
                onSaved: (val) => message = val,
              ),
              const SizedBox(height: 16),
              const Text("Would you like to schedule a consultation?"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Yes"),
                      value: true,
                      groupValue: wantsMeeting,
                      onChanged: (val) => setState(() => wantsMeeting = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("No"),
                      value: false,
                      groupValue: wantsMeeting,
                      onChanged: (val) => setState(() => wantsMeeting = val!),
                    ),
                  ),
                ],
              ),
              if (wantsMeeting)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(selectedDate == null
                        ? "No date selected"
                        : "Date: ${selectedDate!.toLocal().toString().split(' ')[0]}"),
                    Text(selectedTime == null
                        ? "No time selected"
                        : "Time: ${selectedTime!.format(context)}"),
                    ElevatedButton(
                      onPressed: () => _selectDateTime(context),
                      child: const Text("Pick Date & Time"),
                    )
                  ],
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
