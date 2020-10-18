package com.example.firstapp;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

public class VokabelManuell extends AppCompatActivity {

    private VokabelViewModel vokabelViewModel;

    private EditText inputEnglisch;
    private EditText inputDeutsch;
    private EditText inputKategorie;
    private RadioButton radioButtonMarkierung;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vokabel_manuell);

        vokabelViewModel = new ViewModelProvider(this).get(VokabelViewModel.class);

        inputEnglisch = findViewById(R.id.inputEnglisch);
        inputDeutsch = findViewById(R.id.inputDeutsch);
        inputKategorie = findViewById(R.id.inputKategorie);
        radioButtonMarkierung = findViewById(R.id.radioButton_markierung);
        Button buttonOk = findViewById(R.id.button_ok);
        Button buttonAbbrechen = findViewById(R.id.button_abbrechen);

        buttonOk.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final String englisch = inputEnglisch.getText().toString();
                final String deutsch = inputDeutsch.getText().toString();
                final String kategorie = inputKategorie.getText().toString();
                final boolean markiert = radioButtonMarkierung.isChecked();

                if (!englisch.isEmpty()) {
                    if (!deutsch.isEmpty()){
                        if (!kategorie.isEmpty()) {
                            Vokabel neueVokabel = new Vokabel(englisch, deutsch, kategorie);
                            if (markiert) {
                                neueVokabel.setMarkiert(true);
                            }
                            vokabelViewModel.insertVokabel(neueVokabel);

                            inputEnglisch.setText("");
                            inputDeutsch.setText("");
                            radioButtonMarkierung.setChecked(false);

                            Toast toast = Toast.makeText(VokabelManuell.this, "Vokabel wurde gespeichert", Toast.LENGTH_SHORT);
                            toast.show();

                        } else {
                            inputKategorie.setBackgroundColor(Color.RED);
                        }
                    } else {
                        inputDeutsch.setBackgroundColor(Color.RED);
                    }
                } else {
                    inputEnglisch.setBackgroundColor(Color.RED);
                }
            }
        });

        buttonAbbrechen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                back();
            }
        });
    }

    private void back() {
        Intent intentBack = new Intent(VokabelManuell.this, AlleVokabelnAnzeigen.class);
        VokabelManuell.this.startActivity(intentBack);
    }
}
