package com.example.firstapp;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.List;

public class dateien extends AppCompatActivity implements AdapterView.OnItemClickListener {

    private ListView listView;
    private static final int anzeigen = 111;
    private static final int bearbeiten = 222;
    private static final int loeschen = 444;

    private static int MY_REQUEST_CODE = 1000;

    private final List<Datei> dateiList = new ArrayList<>();
    private ArrayAdapter<Datei> listViewAdapter;

   /* private ImageView home;
    private ImageButton neu;*/

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dateien);

        //ListView aus xml ansprechen
        this.listView = (ListView) findViewById(R.id.listView);
        //Datenbank
        datenbank db = new datenbank(this);
        db.createDefaultNotesIfNeed();

        List<Datei> list = db.getAlleDateien();
        this.dateiList.addAll(list);

        // neuer Adapter
        // 1. Kontext
        // 2. Reihenlayout
        // 3. ID des TextViews
        // 4. Datenliste

        this.listViewAdapter = new ArrayAdapter<>(this,
                android.R.layout.simple_list_item_1,
                android.R.id.text1, this.dateiList);

        this.listView.setAdapter(this.listViewAdapter);
        registerForContextMenu(this.listView);

        this.listView.setOnItemClickListener(this);

        /*String m_text = getIntent().getStringExtra("datei_name");

        try {
            FileInputStream fileIn = openFileInput(m_text);
            InputStreamReader InputRead = new InputStreamReader(fileIn);

            char[] inputBuffer = new char[100];
            String s = "";
            int charRead;

            while ((charRead = InputRead.read(inputBuffer)) > 0) {
                // char to string conversion
                String readstring = String.copyValueOf(inputBuffer, 0, charRead);
                s += readstring;
            }
            InputRead.close();
            ArrayList<String> dateiArray = new ArrayList<>();

            final LinearLayout linearLayout = (LinearLayout) findViewById(R.id.dateien);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT
            );
            params.setMargins(0, 40, 0, 0);
            for (int i = 0; i < 6; i++) {
                final CardView card = new CardView(this);
                final TextView text = new TextView(this);
                dateiArray.add(s);
                text.setText(dateiArray.get(i));
                linearLayout.addView(card);
                card.addView(text);
                card.setRadius(15);
                card.setLayoutParams(params);
                text.setPadding(65,35,65,35);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }*/


        /*home = (ImageView) findViewById(R.id.homeButton);
        neu = (ImageButton) findViewById(R.id.neuButton);

        home.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(dateien.this, Haupt.class);
                dateien.this.startActivity(myIntent);
                finish();
            }
        });

        neu.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(dateien.this, einstellung.class);
                dateien.this.startActivity(myIntent);
                finish();
            }
        });*/
    }

    public void onItemClick(AdapterView<?> l, View v, int position, long id) {
        Toast.makeText(getBaseContext(), id+1 + ". " + dateiList.get(position),
                Toast.LENGTH_LONG).show();
        // Then you start a new Activity via Intent
        Intent intent = new Intent(this, certaindata.class);
        intent.putExtra("position", position);
        startActivity(intent);
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view,
                                   ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, view, menuInfo);
        menu.setHeaderTitle("Menü");

        menu.add(0, anzeigen, 0, "anzeigen");
        menu.add(0,bearbeiten, 2,  "bearbeiten");
        menu.add(0, loeschen, 4, "löschen");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo
                info = (AdapterView.AdapterContextMenuInfo)item.getMenuInfo();
        final Datei ausgewaehlteDatei = (Datei) this.listView.getItemAtPosition(info.position);

        if(item.getItemId() == anzeigen){
            //weiterleitung
        }
        else if(item.getItemId() == bearbeiten) {
            //bearbeitung
        }
        else if(item.getItemId() == loeschen){
            new AlertDialog.Builder(this)
            .setMessage(ausgewaehlteDatei.getDateiTitel()+" wirklich löschen?")
            .setCancelable(false)
            .setPositiveButton("Ja", new DialogInterface.OnClickListener(){
                public  void  onClick(DialogInterface dialog, int id) {
                    dateiLoeschen(ausgewaehlteDatei);
                }
            })
            .setNegativeButton("Nein", null)
            .show();
        }
        else{
            return false;
        }
        return false;
    }

    private void dateiLoeschen(Datei datei){
        datenbank db = new datenbank(this);
        db.dateiLoeschen(datei);
        this.dateiList.remove(datei);
        this.listViewAdapter.notifyDataSetChanged();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        super.onActivityResult(requestCode, resultCode, data);

        if(requestCode == Activity.RESULT_OK && requestCode == MY_REQUEST_CODE){
            boolean needRefresh = data.getBooleanExtra("aktualisieren", true);
            if(needRefresh){
                this.dateiList.clear();
                datenbank db = new datenbank(this);
                List<Datei> list = db.getAlleDateien();
                this.dateiList.addAll(list);

                this.listViewAdapter.notifyDataSetChanged();
            }
        }
    }
}
