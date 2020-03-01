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

Route::post('/books', 'BooksController@store');

Route::delete('/book/{book}', function (Book $book) {
  $book->delete();
  return redirect('/');
});


// 更新画面
Route::post('/booksedit/{books}', function(Book $books) {
  return view('booksedit', ['book' => $books]);
});

// 更新処理
Route::post('/books/update', 'BooksController@update');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
