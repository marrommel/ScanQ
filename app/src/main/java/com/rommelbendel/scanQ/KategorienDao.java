package com.rommelbendel.firstapp;

import androidx.room.Dao;
import androidx.room.Insert;

@Dao
public interface KategorienDao {
    @Insert
    void insertKategorie(Kategorie kategorie);

    @Insert
    void insertAlleKategorien(Kategorie... kategorien);
}
