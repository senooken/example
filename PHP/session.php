<?php
/// \file      session.php
/// \author    SENOO, Ken
/// \copyright CC0
/// \date      Created: 2019-07-28 Sun
/// \sa        https://senooken.jp/blog/2019/08/03/
/// \brief     PHPでのセッションの実装例。

// Start session.
session_start();

if (isset($_POST['logout'])) {
  // Delete memory data.
  $_SESSION = [];
  // Delete cookie.
  if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', 1,
      $params["path"], $params["domain"], $params["secure"], $params["httponly"]
    );
  }
  // Delete server data.
  session_destroy();
}
?>
<!DOCTYPE html>
<html>
<head><title>Session Test</title></head>
<body>
<section>
<h1>Session Test</h1>

<?php
// Start using session data.
if (!isset($_SESSION['count'])) {
  $count = 0;
} else {
  $count = $_SESSION['count'];
}

// Use session data.
if (isset($_POST['countup'])) {
  ++$count;
} else if (isset($_POST['logout'])) {
  print("Logout.");
  exit;
}

print <<< EOT
Count:  $count <br />
  <form method="post">
    <input type="submit" name="countup" value="Count up" />
    <input type="submit" name="logout" value="Logout" />
  </form>
EOT;

// Register session data.
$_SESSION['count'] = $count;
?>
</section>
<section>
<h1>説明</h1>
<p>PHPでのセッションの実装例を作成した。PHPでのセッションの実装方法は<a href="https://senooken.jp/blog/2019/08/03/">ブログ</a>で説明している。</p>
<p>このサンプルは「改訂版今すぐ導入！PHP×PostgreSQLでつくる最強Webシステム」のp. 76に掲載されている「リスト1.8 セッションの簡単な利用例: session.php」を元にしている。</p>
<p>[Count up] を選択すると，数字が[1]ずつ増加する。[Logout] を選択すると，ログアウト画面となり，[Count] を [0] にリセットする。</p>
<p>ソースコードと実際に動作ページは以下となる。</p>
<ul>
<li>ソースコード: <a href="https://github.com/senooken/example/blob/master/PHP/session.php">https://github.com/senooken/example/blob/master/PHP/session.php</a></li>
<li>動作ページ: <a href="https://example.senooken.jp/PHP/session.php">https://example.senooken.jp/PHP/session.php</a</li>
</ul>
</section>
</body>
</html>
