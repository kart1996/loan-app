import 'package:bhgala/screens/second_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:place_picker/place_picker.dart';
import 'package:get/get.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var genderOptions = ['Male', 'Female', 'Other'];
  final _formKey = GlobalKey<FormBuilderState>();

  final nameController = TextEditingController();

  final genderController = TextEditingController();

  final dobController = TextEditingController();

  final fnameController = TextEditingController();

  final mnameController = TextEditingController();

  final resaddController = TextEditingController();

  final peraddController = TextEditingController();

  final nrstlmrkController = TextEditingController();

  final telnoController = TextEditingController();

  final mobnoController = TextEditingController();

  final emailController = TextEditingController();

  final aadharController = TextEditingController();

  final panController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  void showPlacePicker() async {
    //var customLocation;
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCNTEoWF3v-9aGQE5w8tNEg0oh0REWlcig",
              //displayLocation: customLocation,
            )));

    // Handle the result in your way
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhgala'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Name of the Applicant',
                    controller: nameController,
                    onChanged: null,
                    decoration: InputDecoration(
                        labelText: 'Name of the Applicant',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 20)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderDateTimePicker(
                    name: 'Date of Birth',
                    inputType: InputType.date,
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    initialDatePickerMode: DatePickerMode.year,
                    controller: dobController,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderDropdown(
                    name: 'Gender',
                    decoration: InputDecoration(labelText: 'Gender'),
                    allowClear: true,
                    hint: Text('Select Gender'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    valueTransformer: (val) => val?.toString(),
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  FormBuilderTextField(
                    name: 'Gender',
                    onChanged: null,
                    controller: genderController,
                    decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 20)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Father\'s Name',
                    onChanged: null,
                    controller: fnameController,
                    decoration: InputDecoration(
                        labelText: 'Father\'s Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 20)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Mother\'s Name',
                    onChanged: null,
                    controller: mnameController,
                    decoration: InputDecoration(
                        labelText: 'Mother\'s Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 20)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Residential Address',
                    onChanged: null,
                    controller: resaddController,
                    decoration: InputDecoration(
                        labelText: 'Residential Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 50)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Permanent Address',
                    onChanged: null,
                    controller: peraddController,
                    decoration: InputDecoration(
                        labelText: 'Permanent Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 50)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.gps_fixed),
                    title: ElevatedButton(
                      child: Text('Get GPS location of \nResidential Address'),
                      onPressed: () {
                        showPlacePicker();
                      },
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Telephone Number',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: null,
                    controller: telnoController,
                    decoration: InputDecoration(
                        labelText: 'Telephone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 10)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Mobile Number',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: null,
                    controller: mobnoController,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 10)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Email id',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: null,
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email id',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                      FormBuilderValidators.max(context, 10)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Aadhar Number',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: null,
                    controller: aadharController,
                    decoration: InputDecoration(
                        labelText: 'Aadhar Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 18)
                    ]),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FormBuilderTextField(
                    name: 'Pan Number',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: null,
                    controller: panController,
                    decoration: InputDecoration(
                        labelText: 'Pan Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 18)
                    ]),
                  ),
                  // FormBuilderImagePicker(
                  //   name: 'Photo of the applicant',
                  //   decoration: const InputDecoration(labelText: 'Pick Photos'),
                  //   maxImages: 1,
                  // ),
                  //const SizedBox(height: 15),
                  // ElevatedButton(
                  //     child: Text(''),
                  //     onPressed: () {
                  //       if (_formKey.currentState.saveAndValidate()) {
                  //         print(_formKey.currentState.value);
                  //       }
                  //     })
                  // ElevatedButton(
                  //     onPressed: () {
                  //       _openFileExplorer();
                  //     },
                  //     child: Text('Upload Ration Card')),
                  // Text('$_fileName'),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(SecondPage());
                      },
                      child: Text('Next Page'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
