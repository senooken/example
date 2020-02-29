@extends('layouts.app')
@section('content')

<div class="card-body">
  <div class="card-title">
    本のタイトル
  </div>

  @include('common.errors')

  <form action="{{ url('books') }}" method="POST" class="form-horizontal">
    {{ csrf_field() }}
    <div class="form-group">
      <div class="col-sm-6">
        <input type="text" name="item_name" class="form-control" />
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

@endsection
