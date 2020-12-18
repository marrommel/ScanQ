package com.rommelbendel.firstapp;

import java.util.ArrayList;
import java.util.List;

public class QuizFrage {
    private String frage;
    private Vokabel frageVokabel;
    private List<String> antworten;
    private String type;
    private boolean beantwortet;
    private int answerId;

    public QuizFrage(Vokabel frageVokabel, List<Vokabel> falscheAntworten, String type) {
        this.beantwortet = false;
        this.type = type; //type ist "ENGtoDE" oder "DEtoENG"
        this.frageVokabel = frageVokabel;

        if (this.type.equals("ENGtoDE")) {
            this.frage = frageVokabel.getVokabelENG();

            this.antworten = new ArrayList<>();
            this.antworten.add(frageVokabel.getVokabelDE());
            for (int i = 0; i < falscheAntworten.size(); i++) {
                this.antworten.add(falscheAntworten.get(i).getVokabelDE());
            }
        } else {
            this.frage = frageVokabel.getVokabelDE();

            this.antworten = new ArrayList<>();
            this.antworten.add(frageVokabel.getVokabelENG());
            for (int i = 0; i < falscheAntworten.size(); i++) {
                this.antworten.add(falscheAntworten.get(i).getVokabelENG());
            }
        }
    }

    public boolean checkAntwort(String antwort) {
        if (antwort.equals(this.antworten.get(0))) {
            this.beantwortet = true;
            return true;
        } else {
            return false;
        }
    }

    public int isBeantwortet() {
        return this.frageVokabel.getAnswered();
    }

    public String getFrage() {
        return frage;
    }

    public List<String> getAntworten() {
        return antworten;
    }

    public Vokabel getFrageVokabel() {
        return frageVokabel;
    }

    public boolean isAlreadyAnswered() {
        return beantwortet;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }
}
