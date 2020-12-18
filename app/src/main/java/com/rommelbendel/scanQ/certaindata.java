package com.rommelbendel.firstapp;

import android.content.Intent;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class certaindata extends AppCompatActivity{

    private final List<Vokabel> dateiList = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dateien);

        Datenbank db = Datenbank.getDatenbank(getApplicationContext());
        List<Vokabel> list = db.vokabelnDao().getAlle().getValue();
        this.dateiList.addAll(list);

        Intent intent = getIntent();
        int id = intent.getIntExtra("position", 0);

        try {
            FileInputStream fileIn = openFileInput(dateiList.get(id).toString());
            InputStreamReader InputRead = new InputStreamReader(fileIn);

            char[] inputBuffer = new char[100];
            StringBuilder s = new StringBuilder();
            int charRead;

            while ((charRead = InputRead.read(inputBuffer)) > 0) {
                // char to string conversion
                s.append(String.copyValueOf(inputBuffer, 0, charRead));
            }
            InputRead.close();

            List<String> sList = Arrays.asList(s.toString().split("\\n"));

            final ScrollView scroll = (ScrollView) findViewById(R.id.scroll);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.MATCH_PARENT
            );
            params.setMargins(30, 40, 30, 40);
            final LinearLayout linearLayout = new LinearLayout(this);
            final CardView card = new CardView(this);
            final TextView text = new TextView(this);
            String textInhalt = s.toString() + "\n" + "Ergebnis Zeile 20:\n" + sList.get(20);
            text.setText(textInhalt);
            scroll.addView(linearLayout);
            linearLayout.addView(card);
            card.addView(text);
            card.setRadius(15);
            card.setLayoutParams(params);
            text.setPadding(65,35,65,35);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
