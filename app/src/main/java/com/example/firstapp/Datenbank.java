package com.example.firstapp;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

@Database(entities = {Vokabel.class}, version = 2)
public abstract class Datenbank extends RoomDatabase {
    public static final String DATABASE_NAME = "VokabelDatenbank";

    public abstract VokabelnDao vokabelnDao();

    private static Datenbank dbInstance;

    public static Datenbank getInstance(Context context) {
        if (dbInstance == null){
            dbInstance = Room.databaseBuilder(context, Datenbank.class, DATABASE_NAME).fallbackToDestructiveMigration().build();
        }
        return dbInstance;
    }
}
