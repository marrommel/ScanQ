package com.rommelbendel.scanQ;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class quiz_menu extends AppCompatActivity {

    private Button quizMulti, quizEngl, quizGer;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz_menu);

        quizMulti = (Button) findViewById(R.id.playMult);
        quizEngl = (Button) findViewById(R.id.playEng);
        quizGer = (Button) findViewById(R.id.playGer);

        quizMulti.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz_menu.this, quiz.class);
                intent.putExtra("quiz", 1);
                quiz_menu.this.startActivity(intent);
            }
        });

        quizEngl.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz_menu.this, quiz.class);
                intent.putExtra("quiz", 2);
                quiz_menu.this.startActivity(intent);
            }
        });

        quizGer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz_menu.this, quiz_voice.class);
                intent.putExtra("quiz", 3);
                quiz_menu.this.startActivity(intent);
            }
        });
    }
}
