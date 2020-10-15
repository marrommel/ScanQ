package com.example.firstapp;

import android.app.Application;

import androidx.lifecycle.LiveData;

import org.jetbrains.annotations.NotNull;

import java.util.List;

public class VokabelRepository {

    private final VokabelnDao repoVokabelnDao;

    private LiveData<List<Vokabel>> repoAlleVokabeln;
    private LiveData<List<Vokabel>> repoMarkierteVokabeln;
    private LiveData<List<Vokabel>> repoKategorieVokabeln;
    private LiveData<Boolean> repoIsMarkiert;
    private LiveData<String> repoAntwortDE;
    private LiveData<String> repoAntwortENG;
    private LiveData<Integer> repoAnswered;
    private LiveData<Vokabel> repoAlreadyAnswered;
    private LiveData<Integer> repoId;

    VokabelRepository(@NotNull Application application) {
        Datenbank db = Datenbank.getDatenbank(application);
        repoVokabelnDao = db.vokabelnDao();

        repoAlleVokabeln = repoVokabelnDao.getAlle();
    }

    LiveData<List<Vokabel>> getAlleVokabeln() {
        return repoAlleVokabeln;
    }

    /*
    LiveData<List<Vokabel>> getAlleMarkiertenVokabeln(boolean markiert) {
        return repoVokabelnDao.getMarkierte(markiert);
    }

    LiveData<List<Vokabel>> getAlleKategorieVokabeln(String kategorie) {
        return repoVokabelnDao.getKategorieVokabeln(kategorie);
    }

    LiveData<Boolean> isVokabelMarkiert(String de) {
        return repoVokabelnDao.isMarkiert(de);
    }

    LiveData<String> getAntwortTextDE(String vokabelENG) {
        return repoVokabelnDao.getAntwortDE(vokabelENG);
    }

    LiveData<String> getAntwortTextENG(String vokabelDE) {
        return repoVokabelnDao.getAntwortENG(vokabelDE);
    }

    LiveData<Integer> getAnsweredCount(int id) {
        return repoVokabelnDao.getAnswered(id);
    }

    LiveData<List<Vokabel>> getAlreadyAnsweredVokabeln(int answers) {
        return repoVokabelnDao.getAlreadyAnswered(answers);
    }
    */

    void insertAlleVokabeln(final Vokabel... vokabeln) {
        Datenbank.databaseWriteExecutor.execute(new Runnable() {
            @Override
            public void run() {
                repoVokabelnDao.insertAlleVokabeln(vokabeln);
            }
        });
    }

    void insertVokabel(final Vokabel vokabel) {
        Datenbank.databaseWriteExecutor.execute(new Runnable() {
            @Override
            public void run() {
                repoVokabelnDao.insertVokabel(vokabel);
            }
        });
    }

}
