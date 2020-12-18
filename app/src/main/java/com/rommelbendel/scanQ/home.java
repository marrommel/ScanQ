package com.rommelbendel.firstapp;

import android.content.Intent;
import android.content.SharedPreferences;
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
    private Button quiz;
    private Button settings;
    private Button logOut;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        up = findViewById(R.id.up);
        down = findViewById(R.id.down);
        neu = findViewById(R.id.homeToNew);
        quiz = findViewById(R.id.homeToQuiz);
        settings = findViewById(R.id.homeToEinstellungen);
        logOut = findViewById(R.id.logOut);
        data = findViewById(R.id.homeToData);
        help = findViewById(R.id.help);

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
                Intent myIntent = new Intent(home.this, test.class);
                home.this.startActivity(myIntent);
            }
        });

        data.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, vokabelSet.class);
                myIntent.putExtra("quiz", 4);
                home.this.startActivity(myIntent);
            }
        });

        quiz.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent myIntent = new Intent(home.this, quiz_menu.class);
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

        logOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SharedPreferences mySPR = getSharedPreferences("login", 0);
                SharedPreferences.Editor editor = mySPR.edit();
                editor.putString("myKey1", "false");
                editor.apply();

                Intent myIntent = new Intent(home.this, login.class);
                home.this.startActivity(myIntent);
                finish();
            }
        });


        //Google Account Info
        /*GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(this);
        if (account != null) {
            String personName = account.getDisplayName();
            String personGivenName = account.getGivenName();
            String personFamilyName = account.getFamilyName();
            String personEmail = account.getEmail();
            String personId = account.getId();
            Uri personPhoto = account.getPhotoUrl();
        }*/
    }
}
