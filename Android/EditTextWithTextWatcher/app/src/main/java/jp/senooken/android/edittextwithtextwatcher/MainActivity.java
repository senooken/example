package jp.senooken.android.edittextwithtextwatcher;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText et = findViewById(R.id.editText);
        et.addTextChangedListener(new MyTextWatcher());
    }

    private class MyTextWatcher implements TextWatcher {
        private final TextView afterTextChanged_ = findViewById(R.id.afterTextChanged);
        private final TextView beforeTextChanged_ = findViewById(R.id.beforeTextChanged);
        private final TextView onTextChanged_ = findViewById(R.id.onTextChanged);

        @Override
        public void afterTextChanged(Editable s) {
            String input= s.toString();
            afterTextChanged_.setText(input);
        }

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            String input= "start=" + start
                    + ", count=" + count
                    + ", after=" + after
                    + ", s=" + s.toString();
            beforeTextChanged_.setText(input);
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            String input= "start=" + start
                    + ", before=" + before
                    + ", count=" + count
                    + ", s=" + s.toString();
            onTextChanged_.setText(input);
        }
    }
}
