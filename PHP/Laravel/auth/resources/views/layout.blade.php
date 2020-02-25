<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <!-- 1. -->
    <title> @yield('title') </title>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pre/0.6.0/pure-min.css" />
    <meta name="viewport" content="width=device-width, initiali-scale=1" />
    <style>
      * { background-color: white; }
      div { margin-bottom: 1em; }
    </style>
  </head>
  <body>
    <div id="content" class="pure-g">
      <!-- 2 -->
      @if (session('status'))
      <div class="pure-u-1">
        <!-- 3 -->
        <div class="status"><p>{{ session('status') }}</p></div>
      </div>
      @endif
      <div class="pure-u-1">
        <!-- 4 -->
        @yield('content')
      </div>
    </div>
  </body>
</html>
