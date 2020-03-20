package jp.senooken.android.edittextinlistview;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // OK case
        ListView listView1 = findViewById(R.id.listView1);
        listView1.setAdapter(new MyArrayAdapter(this, new String[]{"1", "2"}));

        // NG case
        List<Map<String, String>> list = new ArrayList<>();
        HashMap<String, String> map1 = new HashMap<>();
        map1.put("key", "3");
        list.add(map1);
        HashMap<String, String> map2 = new HashMap<>();
        map2.put("key", "4");
        list.add(map2);

        SimpleAdapter adapter = new SimpleAdapter(
                this, list, R.layout.list_item, new String[]{"key"}, new int[]{R.id.edit_text});
        ListView listView2 = findViewById(R.id.listView2);
        listView2.setAdapter(adapter);

        // OK case
        List<Map<String, String>> list3 = new ArrayList<>();
        HashMap<String, String> map3 = new HashMap<>();
        map3.put("bullet", "5");
        map3.put("edit_text", "55");
        list3.add(map3);
        HashMap<String, String> map4 = new HashMap<>();
        map4.put("bullet", "6");
        map4.put("edit_text", "66");
        list3.add(map4);

        ListView listView3 = findViewById(R.id.listView3);
        listView3.setAdapter(
                new MySimpleAdapter(this, list3)
        );
    }

    private class MyArrayAdapter extends ArrayAdapter<String> {
        final String[] values_;

        MyArrayAdapter(Context context, String[] values) {
            super(context, R.layout.list_item, values);
            values_ = values;
        }

        @Override @NonNull
        public View getView(final int position, View convertView, @NonNull ViewGroup parent) {
            convertView = getLayoutInflater().inflate(R.layout.list_item, parent, false);
            EditText editText = convertView.findViewById(R.id.edit_text);
            editText.setText(values_[position]);
            editText.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                }

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {
                }

                @Override
                public void afterTextChanged(Editable s) {
                    values_[position] = s.toString();
                }
            });
            return convertView;
        }
    }

    private class MySimpleAdapter extends SimpleAdapter {
        private final List<? extends Map<String, String>> data_;
        // MySimpleAdapter(Context context, List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
        MySimpleAdapter(Context context, List<? extends Map<String, String>> data) {
            super(context, data, R.layout.list_item2
                    , new String[]{"bullet", "edit_text"}, new int[]{R.id.bullet, R.id.edit_text2});
            data_ = data;
        }

        @Override
        public View getView(final int position, View convertView, ViewGroup parent) {
            convertView = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.list_item2, parent, false);
            TextView textView = convertView.findViewById(R.id.bullet);
            textView.setText(data_.get(position).get("bullet"));
            EditText editText = convertView.findViewById(R.id.edit_text2);
            editText.setText(data_.get(position).get("edit_text"));
            editText.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                }

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {
                }

                @Override
                public void afterTextChanged(Editable s) {
                    data_.get(position).put("edit_text", s.toString());
                }
            });
            return convertView;
        }
    }
}