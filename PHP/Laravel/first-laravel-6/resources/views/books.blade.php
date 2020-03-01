@extends('layouts.app')
@section('content')

<div class="card-body">

  @include('common.errors')

  <form action="{{ url('books') }}" method="POST" class="form-horizontal">
    {{ csrf_field() }}
    <div class="form-group">
      <div class="card-title">
        本のタイトル
      </div>
      <div class="col-sm-6">
        <input type="text" name="item_name" class="form-control" />
      </div>
      <div class="card-title">
        本の数量
      </div>
      <div class="col-sm-6">
        <input type="number" name="item_number" class="form-control" />
      </div>
      <div class="card-title">
        本の金額
      </div>
      <div class="col-sm-6">
        <input type="number" name="item_amount" class="form-control" />
      </div>
      <div class="card-title">
        本の公開日時
      </div>
      <div class="col-sm-6">
        <input type="date" name="published" class="form-control" />
      </div>
    </div>
    <div class="form-group">
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


@endsection
