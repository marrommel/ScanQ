package com.example.firstapp;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.migration.Migration;
import androidx.sqlite.db.SupportSQLiteDatabase;

import org.jetbrains.annotations.NotNull;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Database(entities = {Vokabel.class}, version = 2)
public abstract class Datenbank extends RoomDatabase {
    public static final String DATABASE_NAME = "VokabelDatenbank";

    public abstract VokabelnDao vokabelnDao();

    private static volatile Datenbank INSTANCE;
    private static final int NUMBER_OF_THREADS = 4;
    static final ExecutorService databaseWriteExecutor = Executors.newFixedThreadPool(NUMBER_OF_THREADS);

    static Datenbank getDatenbank(@NotNull final Context context) {
        if (INSTANCE == null) {
            synchronized (Datenbank.class) {
                if (INSTANCE == null) {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), Datenbank.class, DATABASE_NAME).build();
                }
            }
        }
        return INSTANCE;
    }

    /*
    static final Migration MIGRATION_1_2  = new Migration(1, 2) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE vokabeln ADD COLUMN markiert BOOLEAN");
        }
    };
    static final Migration MIGRATION_2_3 = new Migration(2, 3) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {

        }
    };
     */
}
