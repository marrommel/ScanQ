package com.example.firstapp;

import android.content.Context;

import androidx.room.Room;

import org.jetbrains.annotations.NotNull;

import java.util.concurrent.Executor;

public class VokabelVerwalter {
    private Context context;

    public Datenbank db;
    public VokabelnDao vokabelnDao;

    static class ThreadPerTaskExecutor implements Executor {

        @Override
        public void execute(@NotNull Runnable runnable) {
            Thread thread = new Thread(runnable);
            thread.start();
        }
    }

    public VokabelVerwalter(@NotNull Context context) {
        this.context = context;
        this.db = Room.databaseBuilder(context, Datenbank.class, "VokabelnDatenbank").build();
        this.vokabelnDao = db.vokabelnDao();
    }

    public void speichern(@NotNull String englisch, @NotNull String deutsch, @NotNull String kategorie) {
        final Vokabel vokabel = new Vokabel(englisch, deutsch, kategorie);
        final VokabelnDao vokabelnDao = this.vokabelnDao;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                vokabelnDao.insertVokabel(vokabel);
            }
        });
    }

    public void deleteByENG(@NotNull final String englisch) {
        final VokabelnDao vokabelnDao = this.vokabelnDao;
        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                vokabelnDao.deleteVokabelWithENG(englisch);
            }
        });
    }

    public void deleteByDE(@NotNull final String deutsch) {
        final VokabelnDao vokabelnDao = this.vokabelnDao;
        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                vokabelnDao.deleteVokabelWithDE(deutsch);
            }
        });
    }
}
