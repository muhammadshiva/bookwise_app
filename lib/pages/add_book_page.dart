import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BookWise/data/create_book/create_book_bloc.dart';
import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/models/create_book_model.dart';
import 'package:BookWise/pages/homepage.dart';
import 'package:BookWise/shared/shared_method.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController releaseController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      setState(() {
        _imageFile = File(pickedImage.path);
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  _uploadBook(BuildContext context) async {
    var byteDataImage = _imageFile!.readAsBytesSync();

    var multipartFile = MultipartFile.fromBytes(
      'photo',
      byteDataImage,
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType("image", "jpg"),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookBloc(),
      child: BlocConsumer<CreateBookBloc, CreateBookState>(
        listener: (context, state) {
          if (state is CreateBookSuccess) {
            print('Success create book');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePageScreen()),
              (route) => false,
            );
          }

          if (state is CreateBookFailed) {
            print(state.e);
          }
        },
        builder: (context, state) {
          if (state is CreateBookLoading) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Create Book',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                backgroundColor: Color(0xffFEFEFE),
                foregroundColor: Colors.black87,
                elevation: 0,
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Create Book',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              backgroundColor: Color(0xffFEFEFE),
              foregroundColor: Colors.black87,
              elevation: 0,
            ),
            body: Container(
              color: Color(0xffFEFEFE),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
                child: ListView(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cover Image',
                            style: GoogleFonts.lato().copyWith(
                              color: Color(0xff252525),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_imageFile != null)
                                Container(
                                  alignment: Alignment.center,
                                  height: 240,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Color(0xffDBDBDB)),
                                  ),
                                  child: SizedBox(
                                    width: 152,
                                    height: 218,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(_imageFile!),
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  alignment: Alignment.center,
                                  height: 240,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Color(0xffDBDBDB)),
                                  ),
                                  child: Text(
                                    'No image selected.',
                                    style: GoogleFonts.lato(),
                                  ),
                                ),
                              const SizedBox(height: 20),
                              Text(
                                'Pick Image From',
                                style: GoogleFonts.lato().copyWith(
                                  color: Color(0xff252525),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Spacer(),
                                  pickImageButton('Gallery', 1),
                                  const SizedBox(width: 10),
                                  pickImageButton('Camera', 2),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          formField('Title', titleController, 'Title'),
                          formField('Author', authorController, 'Author'),
                          formField('Genre', genreController, 'Genre'),
                          formField('Description', descriptionController, 'Description', 5),
                          formField('Release Year', releaseController, 'Release Year'),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: InkWell(
                  onTap: () {
                    var byteDataImage = _imageFile!.readAsBytesSync();

                    print('File : $_imageFile');
                    print('ByteData Image : $byteDataImage');
                    print('Title : ${titleController.text}');
                    print('Author : ${authorController.text}');
                    print('Genre : ${genreController.text}');
                    print('Description : ${descriptionController.text}');

                    context.read<CreateBookBloc>().add(
                          CreateBook(
                            CreateBookModel(
                              title: titleController.text,
                              author: authorController.text,
                              description: descriptionController.text,
                              releaseYear: int.parse(releaseController.text),
                              genre: genreController.text,
                              image: byteDataImage,
                            ),
                          ),
                        );

                    // if (formKey.currentState!.validate()) {
                    //   print('Success');
                    //   print(titleController.text);
                    //   print(authorController.text);
                    //   print(genreController.text);
                    //   print(descriptionController.text);
                    //   print(releaseController.text);
                    // } else {
                    //   print('Failed');
                    // }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Color(0xff015DFA),
                    ),
                    child: Text(
                      'Save',
                      style: GoogleFonts.lato().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  Widget pickImageButton(String title, int id) {
    return InkWell(
      onTap: () {
        print('ID Pick : $id');
        if (id == 1) {
          _pickImage(ImageSource.gallery);
        } else {
          _pickImage(ImageSource.camera);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Color(0xff015DFA),
        ),
        child: Text(
          title,
          style: GoogleFonts.lato().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget uploadImage() {
    return GestureDetector(
      onTap: () async {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cover Image',
            style: GoogleFonts.lato().copyWith(
              color: Color(0xff252525),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/image_add.png', width: 80, height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget formField(String title, TextEditingController textEditingController, String label, [int? maxLines]) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato().copyWith(
              color: Color(0xff252525),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              alignLabelWithHint: true,
            ),
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field is empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
