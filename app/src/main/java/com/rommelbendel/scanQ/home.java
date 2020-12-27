package com.rommelbendel.scanQ;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import com.rommelbendel.scanQ.impaired.visually.OnCommandListener;
import com.rommelbendel.scanQ.impaired.visually.VoiceControl;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;


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

        TinyDB tinyDB = new TinyDB(home.this);
        boolean viMode = tinyDB.getBoolean("VI_Mode");

        tinyDB.registerOnSharedPreferenceChangeListener(new SharedPreferences.OnSharedPreferenceChangeListener() {
            @Override
            public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
                if (key.equals("VI_Mode")) {
                    Intent reloadIntent = new Intent(home.this, home.class);
                    home.this.startActivity(reloadIntent);
                    finish();
                }
            }
        });

        if (viMode) {   //Prüfung, ob der Blindenmodus gewünscht ist.
            final VoiceControl voiceControl = new VoiceControl(home.this);
            voiceControl.setOnCommandListener(new OnCommandListener() {
                @Override
                public boolean onCommand(String command) {
                    if (command.toLowerCase().equals("starte das quiz")) {
                        Intent quizIntent = new Intent(home.this, quiz_voice.class);
                        home.this.startActivity(quizIntent);
                        return true;
                    } else if (command.toLowerCase().equals("einscannen")) {
                        voiceControl.informHelpNeeded();
                        return true;
                    }
                    else {
                        return false;
                    }
                }

                @Override
                public void onCommandNotFound(String mostLikelyCommand, List<String> commands) {
                    voiceControl.informCommandNotFound();
                }
            });
            voiceControl.informVoiceControlActive();
            voiceControl.listen();
        } else {
            up = findViewById(R.id.up);
            down = findViewById(R.id.down);
            Switch visuallyImpairedModeSwitch = findViewById(R.id.visually_impaired_mode_switch);
            neu = findViewById(R.id.homeToNew);
            Button quiz = findViewById(R.id.homeToQuiz);
            Button settings = findViewById(R.id.homeToEinstellungen);
            data = findViewById(R.id.homeToData);
            help = findViewById(R.id.help);

            visuallyImpairedModeSwitch.setChecked(false);

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

            visuallyImpairedModeSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                @Override
                public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                    TinyDB tinyDB = new TinyDB(home.this);
                    tinyDB.putBoolean("VI_Mode", isChecked);
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
                    Intent myIntent = new Intent(home.this, quiz_voice.class);
                    home.this.startActivity(myIntent);
                    //Toast.makeText(home.this, "derzeit nicht verfügbar", Toast.LENGTH_SHORT).show();
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
}
