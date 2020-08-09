package com.example.firstapp;

import androidx.room.Database;
import androidx.room.RoomDatabase;

@Database(entities = {Vokabel.class}, version = 1)
public abstract class Datenbank extends RoomDatabase {
    public abstract VokabelnDao vokabelnDao();
}
