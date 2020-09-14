package com.example.firstapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

public class home extends AppCompatActivity {

    private FloatingActionButton up;
    private FloatingActionButton down;
    private Button neu;
    private Button data;
    private CardView help;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        up = (FloatingActionButton) findViewById(R.id.up);
        down = (FloatingActionButton) findViewById(R.id.down);
        neu = (Button) findViewById(R.id.homeToNew);
        Button quiz = (Button) findViewById(R.id.homeToQuiz);
        Button settings = (Button) findViewById(R.id.homeToEinstellungen);
        data = (Button) findViewById(R.id.homeToData);
        help = (CardView) findViewById(R.id.help);

        down.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                help.setVisibility(View.VISIBLE);
                up.setVisibility(View.VISIBLE);
                neu.setVisibility(View.GONE);
                data.setVisibility(View.GONE);
                down.setVisibility(View.GONE);
            }
        });

        up.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                help.setVisibility(View.GONE);
                up.setVisibility(View.GONE);
                neu.setVisibility(View.VISIBLE);
                data.setVisibility(View.VISIBLE);
                down.setVisibility(View.VISIBLE);
            }
        });

        neu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, Haupt.class);
                home.this.startActivity(myIntent);
            }
        });


        data.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, AlleVokabelnAnzeigen.class);
                home.this.startActivity(myIntent);
            }
        });

        quiz.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, quiz.class);
                home.this.startActivity(myIntent);
            }
        });

        settings.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, einstellung.class);
                home.this.startActivity(myIntent);
            }
        });
    }
}
