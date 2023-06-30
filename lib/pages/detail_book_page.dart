import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BookWise/data/delete_book/delete_book_bloc.dart';
import 'package:BookWise/data/fetch_book/fetch_book_bloc.dart';
import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/pages/edit_book_page.dart';
import 'package:BookWise/pages/homepage.dart';
import 'package:BookWise/shared/shared_value.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBookPage extends StatefulWidget {
  final BookModel book;

  const DetailBookPage({
    super.key,
    required this.book,
  });

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFEFEFE),
        foregroundColor: Color(0xff252525),
        actions: [
          // Icon(
          //   Icons.bookmark_outline_rounded,
          //   size: 30,
          // ),
          // const SizedBox(width: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookPage(
                    book: widget.book,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Container(
        color: Color(0xffFEFEFE),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 80),
        child: Scrollbar(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                width: 162,
                height: 228,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.book.image.replaceAll('http://localhost:4000\\', imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                widget.book.title,
                style: GoogleFonts.lato().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Color(
                      0xff252525,
                    )),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                widget.book.author,
                style: GoogleFonts.lato().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff82868E),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                '${widget.book.releaseYear} - ${widget.book.genre}',
                style: GoogleFonts.lato().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff252525),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Text(
                widget.book.description,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocProvider(
                      create: (context) => DeleteBookBloc(),
                      child: BlocConsumer<DeleteBookBloc, DeleteBookState>(
                        listener: (context, state) {
                          if (state is DeleteBookSuccess) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageScreen(),
                              ),
                              (route) => false,
                            );
                          }

                          if (state is DeleteBookFailed) {
                            print('Error delete book : ${state.e}');
                          }
                        },
                        builder: (context, state) {
                          if (state is DeleteBookLoading) {
                            return AlertDialog(
                              content: Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 200,
                                child: Column(
                                  children: [
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    const SizedBox(height: 20),
                                    Text('Loading'),
                                  ],
                                ),
                              ),
                            );
                          }

                          return AlertDialog(
                            title: Column(
                              children: [
                                Image.asset(
                                  'images/delete_icon.png',
                                  width: 108,
                                  height: 108,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  "Delete",
                                  style: GoogleFonts.lato().copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff252525),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            content: Text(
                              "Are you sure you want to delete this item ?",
                              style: GoogleFonts.lato().copyWith(
                                color: Color(0xff252525),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 117,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(17),
                                          color: Color(0xffEFEFEF),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.lato().copyWith(color: Color(0xff82868E), fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        print('Delete');
                                        print('ID : ${widget.book.id}');
                                        context.read<DeleteBookBloc>().add(DeleteBook(widget.book.id!));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 117,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(17),
                                          color: Color(0xffFF5B5B),
                                        ),
                                        child: Text(
                                          'Delete',
                                          style: GoogleFonts.lato().copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 160,
                height: double.infinity,
                child: Text(
                  'Delete',
                  style: GoogleFonts.lato().copyWith(
                    color: Color(0xffFF5B5B),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 160,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Color(0xff015DFA),
                ),
                child: Text(
                  'Back',
                  style: GoogleFonts.lato().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
