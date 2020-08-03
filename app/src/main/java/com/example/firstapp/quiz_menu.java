package com.example.firstapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class quiz_menu extends AppCompatActivity {

    private Button quizMulti;
    private Button quizGer;
    private Button quizEngl;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz_menu);

        quizMulti = (Button) findViewById(R.id.playMult);
        quizGer = (Button) findViewById(R.id.playGer);
        quizEngl = (Button) findViewById(R.id.playEng);

        quizMulti.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz_menu.this, quiz.class);
                quiz_menu.this.startActivity(intent);
            }
        });

        quizGer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        quizEngl.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz_menu.this, quiz2.class);
                quiz_menu.this.startActivity(intent);
            }
        });
    }
}
