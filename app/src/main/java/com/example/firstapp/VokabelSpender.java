package com.example.firstapp;

import android.content.Context;
import android.widget.Toast;

import androidx.room.Room;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class VokabelSpender {
    public final Datenbank db;
    public VokabelnDao vokabelnDao;

    public String kategorie;

    private List<String> antworten;
    private String antwort;
    private String frage;
    private List<Vokabel> nutzbareVokabeln;
    private List<Vokabel> alleVokabeln;
    private Context context;
    private int index;

    public VokabelSpender(Context context, String kategorie) {
        this.db = Room.databaseBuilder(context, Datenbank.class, "Vokabeln").build();
        this.vokabelnDao = db.vokabelnDao();
        this.kategorie = kategorie;
        this.context = context;
        this.alleVokabeln = this.vokabelnDao.getAlle();
    }

    public List getQuizFrage() {
        this.nutzbareVokabeln = vokabelnDao.getKategorieVokabeln(this.kategorie);
        if (this.nutzbareVokabeln.size() != 0) {
            index = new Random().nextInt(this.nutzbareVokabeln.size());
            this.frage = this.nutzbareVokabeln.get(index).getVokabelENG();
            return Arrays.asList(this.frage, this.antworten);
        } else {
            Toast.makeText(this.context, "keine Vokabeln gefunden", Toast.LENGTH_SHORT).show();
            return Collections.emptyList();
        }
    }

    private String getFalscheAntwort(String frage) {
        do {
            index = new Random().nextInt(this.alleVokabeln.size());
            antwort = this.alleVokabeln.get(index).getVokabelDE();
        } while (antwort.equals(frage));

        return antwort;
    }
}
