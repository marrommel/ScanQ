package com.example.firstapp;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

@Dao
public interface KategorienDao {
    @Insert
    void insertKategorie(Kategorie kategorie);

    @Insert
    void insertAlleKategorien(Kategorie... kategorien);
}
