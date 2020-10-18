package com.example.firstapp;;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.room.Room;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.Executor;


public class VokabelSpender {

    private Context context;

    public Datenbank db;
    public VokabelnDao vokabelnDao;
    public List<Vokabel> alleVokabeln;
    public List<Vokabel> kategorieVokabeln;
    public List<Vokabel> answeredVokabeln;


    static class ThreadPerTaskExecutor implements Executor {

        @Override
        public void execute(@NotNull Runnable runnable) {
            Thread thread = new Thread(runnable);
            thread.start();
        }
    }

    /*
    static class DirectExecuter implements Executor {
        @Override
        public void execute(@NotNull Runnable runnable) {
            runnable.run();
        }
    }
    */

    public VokabelSpender(@NotNull Context context) {
        this.context = context;
        final Datenbank db = Room.databaseBuilder(context, Datenbank.class, "VokabelnDatenbank").build();
        this.vokabelnDao = db.vokabelnDao();
    }

    public void setAlleVokabeln(@NotNull List<Vokabel> alleVokabeln) {
        Log.i("setAlleVokabeln", alleVokabeln.toString());
        this.alleVokabeln = alleVokabeln;
    }

    public List<Vokabel> getAlleVokabeln() {
        final VokabelnDao vokabelnDao = this.vokabelnDao;
        //List<Vokabel> alleVokabeln;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                final List<Vokabel> alleVokabeln = vokabelnDao.getAlle();

                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        Log.i("getAlleVokabeln", alleVokabeln.toString());
                        setAlleVokabeln(alleVokabeln);
                    }
                });
            }
        });
        return this.alleVokabeln;
    }

    public void setKategorieVokabeln(@NotNull List<Vokabel> kategorieVokabeln) {
        this.kategorieVokabeln = kategorieVokabeln;
    }

    public List<Vokabel> getKategorieVokabeln(final String kategorie) {
        final VokabelnDao vokabelnDao = this.vokabelnDao;
        List<Vokabel> kategorieVokabeln;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                final List<Vokabel> kategorieVokabeln = vokabelnDao.getKategorieVokabeln(kategorie);

                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        setKategorieVokabeln(kategorieVokabeln);
                    }
                });
            }
        });

        return this.kategorieVokabeln;
    }

    public Vokabel getRandomVokabel(String kategorie) {
        Log.i("getRandomVokabel", kategorie);
        List<Vokabel> vokabeln;
        if (kategorie.equals("alle")) {
            vokabeln = getAlleVokabeln();

        } else {
            vokabeln = getKategorieVokabeln(kategorie);
        }
        int index = new Random().nextInt(vokabeln.size());
        return vokabeln.get(index);
    }

    public List<Vokabel> getQuizFrage(String kategorie) {
        List<Vokabel> frageAntworten = new ArrayList<>();
        Vokabel frage = getRandomVokabel(kategorie);
        frageAntworten.add(frage);

        List<Vokabel> falscheAntworten = getAlleVokabeln();
        falscheAntworten.remove(frage);

        for (int i = 0; i < 3; i++) {
            Vokabel antwort = falscheAntworten.get(new Random().nextInt(falscheAntworten.size()));
            frageAntworten.add(antwort);
            falscheAntworten.remove(antwort);
        }

        return frageAntworten;
    }

    public void insertVokabeln(final Vokabel... vokabeln) {
        final VokabelnDao vokabelnDao = this.vokabelnDao;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                vokabelnDao.insertAlleVokabeln(vokabeln);
            }
        });
    }

    public void setAnsweredVokabeln(List<Vokabel> answeredVokabeln) {
        this.answeredVokabeln = answeredVokabeln;
    }

    public List<Vokabel> getAlreadyAnswered(final int answered) {
        final VokabelnDao vokabelnDao = this.vokabelnDao;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                final List<Vokabel> answeredVokabeln = vokabelnDao.getAlreadyAnswered(answered);

                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        setAnsweredVokabeln(answeredVokabeln);
                    }
                });
            }
        });

        return this.answeredVokabeln;
    }

    public List<QuizFrage> generateQuiz(String kategorie, String type) {
        List<QuizFrage> fragen = new ArrayList<>();

        List<Vokabel> kategorieVokabeln = getKategorieVokabeln(kategorie);

        Vokabel frage;
        List<Vokabel> antworten = new ArrayList<>();

        for (int i = 0; i < kategorieVokabeln.size(); i++) {
            frage = kategorieVokabeln.get(i);
            List<Vokabel> falscheAntworten = getAlleVokabeln();
            falscheAntworten.remove(frage);

            for (int count = 0; count < 3; count++) {
                Vokabel antwort = falscheAntworten.get(new Random().nextInt(falscheAntworten.size()));
                antworten.add(antwort);
                falscheAntworten.remove(antwort);
            }

            fragen.add(new QuizFrage(frage, antworten, type));

            antworten.clear();
        }

        return fragen;
    }

    /*
    public void setVokabeln() {
        final VokabelnDao vokabelnDao = this.vokabelnDao;

        new ThreadPerTaskExecutor().execute(new Runnable() {
            @Override
            public void run() {
                Vokabel vokabel = new Vokabel("car", "Auto", "Unit1");
                Vokabel vokabel1 = new Vokabel("window", "Fenster", "Unit1");
                vokabelnDao.insertAlleVokabeln(vokabel, vokabel1);
            }
        });
    }
    */
}
