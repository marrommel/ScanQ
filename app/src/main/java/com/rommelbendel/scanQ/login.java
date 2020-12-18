package com.rommelbendel.firstapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.textfield.TextInputEditText;

import java.util.Objects;

public class login extends AppCompatActivity {

    private TextInputEditText user;
    private TextInputEditText password;
    private Button logIn;
    private TextView forgot;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);

        user =  findViewById(R.id.user);
        password =  findViewById(R.id.password);
        logIn = findViewById(R.id.logIn);
        forgot = findViewById(R.id.forgot);

        logIn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(Objects.requireNonNull(user.getText()).toString().toLowerCase().equals("marcel") ||
                        user .getText().toString().toLowerCase().equals("justus")){
                    if(Objects.requireNonNull(password.getText()).toString().equals("123456")){
                        Intent intent = new Intent(login.this, home.class);
                        login.this.startActivity(intent);
                        finish();
                    }else{
                        //Fehler
                    }
                }else{
                    //Fehler
                }
            }
        });
    }
}
