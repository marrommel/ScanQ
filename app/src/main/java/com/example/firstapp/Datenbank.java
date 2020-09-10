package com.example.firstapp;

import androidx.room.Database;
import androidx.room.RoomDatabase;

@Database(entities = {Vokabel.class, Kategorie.class}, version = 2)
public abstract class Datenbank extends RoomDatabase {
    public abstract VokabelnDao vokabelnDao();
    public abstract KategorienDao kategorienDao();
}
