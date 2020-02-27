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
    return view('welcome');
});

Route::post('/books', function (Request $request) {
});

Route::delete('/book/{book}', function (Book $book) {
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
