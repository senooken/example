@extends('layouts.app')

@section('content')
<div class="row">
  <div class="col-md-12">
    @include('common.errors')
    <form action="{{ url('books/update') }}" method="POST">
      <!-- item_name -->
      <div class="form-group">
        <label for="item_name">Title</label>
        <input type="text" name="item_name" class="form-control" value="{{$book->item_name}}">
      </div>
      <!-- item_number -->
      <div class="form-group">
        <label for="item_number">Number</label>
        <input type="text" name="item_number" class="form-control" value="{{$book->item_number}}">
      </div>
      <!-- item_amount -->
      <div class="form-group">
        <label for="item_amount">Amount</label>
        <input type="text" name="item_amount" class="form-control" value="{{$book->item_amount}}">
      </div>
      <!-- published -->
      <div class="form-group">
        <label for="published">published</label>
        <input type="text" name="published" class="form-control" value="{{$book->published}}">
      </div>

      <div class="well well-sm">
        <button type="submit" class="btn btn-primary">Save</button>
        <a class="btn btn-link pull-right" href="{{url('/')}}">
          Back
        </a>
      </div>
      <input type="hidden" name="id" value="{{$book->id}}" />
      {{csrf_field()}}
    </form>
  </div>
</div>
@endsection

