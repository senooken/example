<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use App\Book;
use Illuminate\Http\Request;

Route::get('/', function () {
  $books = Book::orderBy('created_at', 'asc')->get();
  return view('books', ['books' => $books]);
});

Route::post('/books', function (Request $request) {
  $validator = Validator::make($request->all(), [
    'item_name' => 'required|max:255',
  ]);

  if ($validator->fails()) {
    return redirect('/')->withInput()->withErros($validator);
  }

  $books = new Book;
  $books->item_name = $request->item_name;
  $books->item_number = '1';
  $books->item_amount = '1000';
  $books->published = '2017-03-07 00:00:00';
  $books->save();
  return redirect('/');
});

Route::delete('/book/{book}', function (Book $book) {
  $book->delete();
  return redirect('/');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
