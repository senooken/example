@extends('layouts.app')
@section('content')

<div class="card-body">

  @include('common.errors')

  <!-- 本のタイトル -->
  <form action="{{ url('books') }}" method="POST" class="form-horizontal">
    {{ csrf_field() }}
    <div class="form-row">
      <div class="form-group col-md-6">
        <label for="book" class="col-sm-3 control-label">Book</label>
        <input type="text" name="item_name" class="form-control" />
      </div>
      <div class="form-group col-md-6">
        <label for="amount" class="col-sm-3 control-label">金額</label>
        <input type="text" name="item_amount" class="form-control" />
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-md-6">
        <label for="number" class="col-sm-3 control-label">数</label>
        <input type="text" name="item_number" class="form-control" />
      </div>
      <div class="form-group col-md-6">
        <label for="published" class="col-sm-3 control-label">公開日</label>
        <input type="date" name="published" class="form-control" />
      </div>
    </div>
    <div class="form-row">
      <div class="col-sm-offset-3 col-sm-6">
        <button type="submit" class="btn btn-primary">
          Save
        </button>
      </div>
    </div>
  </form>
</div>

@if (count($books) > 0 )
<div class="card-body">
  <div class="card-title">
    現在の本
  </div>
  <div class="card-body">
    <table class="table table-striped task-table">
      <thead>
        <th>本一覧</th>
        <th>&nbsp;</th>
      </thead>
      <tbody>
      @foreach ($books as $book)
        <tr>
          <td class="table-text">
            <div>{{ $book->item_name }}</div>
          </td>
          <!-- Update -->
          <td>
            <form action="{{ url("booksedit/" . $book->id) }}" method="POST">
              {{ csrf_field() }}
              <button type="submit" class="btn btn-primary">
                更新
              </button>
            </form>
          </td>
          <!-- Delete book. -->
          <td>
            <form action="{{ url("book/" . $book->id) }}" method="POST">
              {{ csrf_field() }}
              {{ method_field('DELETE') }}
              <button type="submit" class="btn btn-danger">
                削除
              </button>
            </form>
          </td>
        </tr>
      @endforeach
      </tbody>
    </table>
  </div>
</div>
@endif

<div class="row">
  <div class="col-md-4 offset-md-4">
    {{ $books->links() }}
  </div>
</div>

@endsection
