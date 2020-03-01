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

// 本ダッシュボードを表示
Route::get('/', 'BooksController@index');

// 登録処理
Route::post('/books', 'BooksController@store');

// 更新画面
Route::post('/booksedit/{books}', 'BooksController@edit');

// 更新処理
Route::post('/books/update', 'BooksController@update');

// 本を削除
Route::delete('/book/{book}', 'BooksController@destroy');

Auth::routes();

Route::get('/home', 'BooksController@index')->name('home');
