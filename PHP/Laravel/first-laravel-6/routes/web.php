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
    'item_name' => 'required|min:3|max:255',
    'item_number' => 'required|min:1|max:3',
    'item_amount' => 'required|max:6',
    'published' => 'required|max:255',
  ]);

  if ($validator->fails()) {
    return redirect('/')->withInput()->withErrors($validator);
  }

  $books = new Book;
  $books->item_name = $request->item_name;
  $books->item_number = $request->item_number;
  $books->item_amount = $request->item_amount;
  $books->published = $request->published;
  $books->save();
  return redirect('/');
});

Route::delete('/book/{book}', function (Book $book) {
  $book->delete();
  return redirect('/');
});


// 更新画面
Route::post('/booksedit/{books}', function(Book $books) {
  return view('booksedit', ['book' => $books]);
});

// 更新処理
Route::post('/books/update', function(Request $request) {
  $validator = Validator::make($request->all(), [
    'id' => 'required',
    'item_name' => 'required|min:3|max:255',
    'item_number' => 'required|min:1|max:3',
    'item_amount' => 'required|max:6',
    'published' => 'required',
  ]);

  if ($validator->fails()) {
    return redirect('/')->withInput()->withErrors($validator);
  }

  // Update date.
  $books = Book::find($request->id);
  $books->item_name = $request->item_name;
  $books->item_number = $request->item_number;
  $books->item_amount = $request->item_amount;
  $books->published = $request->published;
  $books->save();
  return redirect('/');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
