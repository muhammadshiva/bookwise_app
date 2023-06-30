import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BookWise/data/fetch_book/fetch_book_bloc.dart';
import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/pages/add_book_page.dart';
import 'package:BookWise/pages/detail_book_page.dart';
import 'package:BookWise/shared/shared_value.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
        child: ListView(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Book',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff252525),
                    ),
                  ),
                  TextSpan(
                    text: 'Wise',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff015DFA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Explore, Engage, and Empower Through sReading',
              style: GoogleFonts.lato().copyWith(
                color: Color(0xff82868E),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              width: double.infinity,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.all(5),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    print('Query : $searchQuery');
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'List Books',
              style: GoogleFonts.lato().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(
                  0xff252525,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: BlocProvider(
                create: (context) => FetchBookBloc()..add(FetchBooks()),
                child: BlocBuilder<FetchBookBloc, FetchBookState>(
                  builder: (context, state) {
                    if (state is FetchBookLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FetchBookSuccess) {
                      if (state.books.isEmpty) {
                      } else {
                        final List<BookModel> books = state.books;
                        return ListView.builder(
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            final BookModel book = books[index];

                            if (searchQuery.isNotEmpty &&
                                !book.title.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ) &&
                                !book.author.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ) &&
                                !book.releaseYear.toString().toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ) &&
                                !book.genre.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ) &&
                                !book.description.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    )) {
                              return Container();
                            }

                            return cardBook(
                              book.image.replaceAll('http://localhost:4000\\', imageUrl),
                              book.title,
                              book.author,
                              book.releaseYear,
                              book.genre,
                              book.description,
                              book,
                            );
                          },
                        );
                      }
                    } else if (state is FetchBookFailed) {
                      print(state.e);
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 150),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/404_book.png', width: 300),
                          const SizedBox(height: 20),
                          Text(
                            'No Book Available.',
                            style: GoogleFonts.lato().copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xff252525,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addBook',
        backgroundColor: Color(0xff015DFA),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Widget cardBook(String image, String title, String author, int year, String genre, String description, BookModel book) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 3),
      width: double.infinity,
      height: 182,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 127,
            height: 182,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Warna bayangan
                  spreadRadius: 0, // Radius penyebaran bayangan
                  blurRadius: 8, // Radius blur bayangan
                  offset: Offset(0, 4), // Posisi bayangan (x, y)
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  image,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                width: 207,
                child: Text(
                  title,
                  style: GoogleFonts.lato().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff252525),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                author,
                style: GoogleFonts.lato().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff82868E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$year - $genre',
                style: GoogleFonts.lato().copyWith(
                  color: Color(0xff252525),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 206,
                child: Text(
                  description,
                  style: GoogleFonts.lato().copyWith(
                    color: Color(0xff252525),
                  ),
                  maxLines: 4,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBookPage(
                        book: book,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xff015DFA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Details',
                    style: GoogleFonts.lato().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
