package com.rommelbendel.firstapp;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.room.Room;

import java.util.ArrayList;
import java.util.List;

public class vokabelSet extends AppCompatActivity implements AdapterView.OnItemClickListener{
    private ListView listView;

    private final List<String> vocabList = new ArrayList<>();
    private ArrayAdapter<String> listViewAdapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.vokabel_set);

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();

        this.listView = findViewById(R.id.listViewSet);

        List<String> list = db.vokabelnDao().getAlleKategorie();
        this.vocabList.addAll(list);

        this.listViewAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_list_item_2,
                android.R.id.text1, this.vocabList) {
            @Override
            public View getView(int position, View convertView, ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                TextView text1 = (TextView) view.findViewById(android.R.id.text1);
                TextView text2 = (TextView) view.findViewById(android.R.id.text2);

                text1.setTextSize(27);
                text1.setTextColor(Color.parseColor("#147874"));
                text1.setPadding(25,0,0,45);
                text2.setTextSize(15);
                text2.setPadding(0,0,0,35);
                text2.setText("10 von 30 beantwortet");
                return view;
            }
        };

        this.listView.setAdapter(this.listViewAdapter);

        this.listView.setOnItemClickListener(this);
        registerForContextMenu(this.listView);
    }
    public void onItemClick(AdapterView<?> l, View v, int position, long id) {
        // Toast.makeText(getBaseContext(), id+1 + ". " + vocabList.get(position).getKategorie(),
        //       Toast.LENGTH_LONG).show();
        Intent intent = getIntent();
        int quizId = intent.getIntExtra("quiz", 0);
        Class[] quizes = {null, quiz.class, quiz2.class, quiz3.class, AlleVokabelnAnzeigen.class};

        Intent intent1 = new Intent(this, quizes[quizId]);
        intent1.putExtra("set", position);
        startActivity(intent1);
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view,
                                    ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, view, menuInfo);
        menu.setHeaderTitle("Menü");

        menu.add(0,13, 2,  "bearbeiten");
        menu.add(0, 14, 4, "löschen");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo
                info = (AdapterView.AdapterContextMenuInfo)item.getMenuInfo();
        final Vokabel ausgewaehlteDatei = (Vokabel) this.listView.getItemAtPosition(info.position);

        if(item.getItemId() == 14){
            //löschen
        }
        else if(item.getItemId() == 13) {
            //bearbeitung
        }
        else{
            return false;
        }
        return false;
    }
}
