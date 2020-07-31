package com.example.firstapp;

import java.io.Serializable;

public class Datei implements Serializable {
    private int DateiId;
    private  String DateiTitel;

    public Datei(){}

    public Datei(String DateiTitel) {
        this.DateiTitel = DateiTitel;
    }

    public  Datei(int DateiId, String DateiTitel){
        this.DateiId = DateiId;
        this.DateiTitel = DateiTitel;
    }

    public int getDateiId(){
        return DateiId;
    }

    public void setDateiId(int DateiId) {
        this.DateiId = DateiId;
    }
    public String getDateiTitel() {
        return DateiTitel;
    }

    public void setDateiTitel(String DateiTitel) {
        this.DateiTitel = DateiTitel;
    }

    @Override
    public  String toString() {
        return this.DateiTitel;
    }
}
