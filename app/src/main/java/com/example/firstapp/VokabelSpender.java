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
    public final VokabelnDao vokabelnDao;

    public String kategorie;

    private final List<Vokabel> alleVokabeln;

    private List<String> antworten;
    private String antwort;
    private String frage;
    private List<Vokabel> nutzbareVokabeln;
    private Context context;
    private int index;
    private String richtigeAntwort;

    public VokabelSpender(Context context, String kategorie) {
        this.db = Room.databaseBuilder(context, Datenbank.class, "Vokabeln").build();
        this.vokabelnDao = db.vokabelnDao();
        this.kategorie = kategorie;
        this.context = context;
        this.alleVokabeln = this.vokabelnDao.getAlle();
    }

    public void setKategorie(String kategorie) {
        this.kategorie = kategorie;
    }

    public List getQuizFrageENG() {
        this.nutzbareVokabeln = this.vokabelnDao.getKategorieVokabeln(this.kategorie);

        if (this.nutzbareVokabeln.size() != 0) {
            index = new Random().nextInt(this.nutzbareVokabeln.size());

            this.frage = this.nutzbareVokabeln.get(index).getVokabelENG();
            this.antworten.clear();
            antwort = this.nutzbareVokabeln.get(index).getVokabelDE();
            this.antworten.add(antwort);

            for (int i = 0; i < 3; i++) {
                this.antworten.add(getFalscheAntwortDE(antwort));
            }

            Collections.shuffle(this.antworten);//Antworten mischen
            return Arrays.asList(this.frage, this.antworten);
        } else {
            Toast.makeText(this.context, "keine Vokabeln gefunden", Toast.LENGTH_SHORT).show();
            return Collections.emptyList();
        }
    }

    private String getFalscheAntwortDE(String richtigeAntwort) {
        do {
            index = new Random().nextInt(this.alleVokabeln.size());
            antwort = this.alleVokabeln.get(index).getVokabelDE();
        } while (antwort.equals(richtigeAntwort) || this.antworten.contains(antwort));

        return antwort;
    }

    public List getQuizFrageDE() {
        this.nutzbareVokabeln = this.vokabelnDao.getKategorieVokabeln(this.kategorie);

        if (this.nutzbareVokabeln.size() != 0) {
            index = new Random().nextInt(this.nutzbareVokabeln.size());

            this.frage = this.nutzbareVokabeln.get(index).getVokabelDE();
            this.antworten.clear();
            antwort = this.nutzbareVokabeln.get(index).getVokabelENG();
            this.antworten.add(antwort);

            for (int i = 0; i < 3; i++) {
                this.antworten.add(getFalscheAntwortENG(this.frage));
            }

            Collections.shuffle(this.antworten);//Antworten mischen
            return Arrays.asList(this.frage, this.antworten);
        } else {
            Toast.makeText(this.context, "keine Vokabeln gefunden", Toast.LENGTH_SHORT).show();
            return Collections.emptyList();
        }
    }

    private String getFalscheAntwortENG(String richtigeAntwort) {
        do {
            index = new Random().nextInt(this.alleVokabeln.size());
            antwort = this.alleVokabeln.get(index).getVokabelENG();
        } while (antwort.equals(richtigeAntwort) || this.antworten.contains(antwort));

        return antwort;
    }

    public boolean proofAntwortDE(String frage, String antwort) {
        richtigeAntwort = this.vokabelnDao.getAntwortDE(frage);
        return antwort.equals(richtigeAntwort);
    }

    public boolean proofAntwortENG(String frage, String antwort) {
        richtigeAntwort = this.vokabelnDao.getAntwortENG(frage);
        return antwort.equals(richtigeAntwort);
    }

}
