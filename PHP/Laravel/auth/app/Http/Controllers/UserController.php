<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class UserController extends Controller {
  // 1. コンストラクターでauth.firstミドルウェアを指定する。
  public function __construct() {
    $this->middleware('auth.fisrt');
  }

  // 2. "user"のURIで呼び出されるgetIndexメソッドは，一覧表示ページでページ付けのためにユーザーレコードを5件ずつ表示する。ビューインスタンスのwithメソッドで取得したインスタンスを渡している。第1引数はビューで使用する変数名，第2引数がその変数の内容となる。
  public function getInex() {
    $users = User::paginate(5);
    return view('user.index')->with('users', $users);
  }

  // 3. "user/remove/ユーザーID" のURIで呼び出されるgetRemoveメソッドでユーザーを削除する。
  public function getRemove($userId) {
    $user = User::findOrFail($userId);
    $user->delete();
    return redirect()->back()->with('status', 'ユーザーを削除しました');
  }

  // 4. "user/edit/ユーザーID" のURIにより呼び出されるgetRemoveメソッドで
  public function getEdit($userId) {
    $user = User::findOrFail($userId);
    return view('user.edit')->withUser($user);
  }
}

