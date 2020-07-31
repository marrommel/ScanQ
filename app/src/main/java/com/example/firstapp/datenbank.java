package com.example.firstapp;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class datenbank extends SQLiteOpenHelper {
    public datenbank(Context context) {
        super(context, "ScanQ", null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        Log.i("SQLite", "MyDatabaseHelper.onCreate ... ");
        String tab_erstellen = " CREATE TABLE " + "Datei_Namen" + " ( " +
                "id INTEGER PRIMARY KEY, name" +
                " TEXT ) ";

        db.execSQL(tab_erstellen);

        String voc_tab_erstellen = " CREATE TABLE Vocab ( " +
                "id INTEGER PRIMARY KEY, engl TEXT, deutsch TEXT ) ";

        db.execSQL(voc_tab_erstellen);
    }

    @Override
    public  void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS Datei_Namen");

        onCreate(db);
    }

    public void createDefaultNotesIfNeed()  {
        int count = this.getDateiAnzahl();
        if(count ==0 ) {
            Datei datei1 = new Datei("Wir sind Beispiele.");
            Datei datei2 = new Datei ("Du kannst uns löschen, wenn du willst!");
            this.neu(datei1);
            this.neu(datei2);
        }
    }

     public void neu(Datei datei) {
        Log.i("SQLite", "MyDatabaseHelper.neu ... " + datei.getDateiTitel());
        SQLiteDatabase db = this.getWritableDatabase();

         ContentValues values = new ContentValues();
         values.put("name", datei.getDateiTitel());

         //Reihe einsetzen
         db.insert("Datei_Namen", null, values);
         db.close();
    }

    /*public void neuVocD(Datei datei) {
        Log.i("SQLite", "MyDatabaseHelper.neu ... " + datei.getDateiTitel());
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("deutsch", datei.getDateiTitel());

        //Reihe einsetzen
        db.insert("Vocab", null, values);
        db.close();
    }*/

    public void neuVocE(Datei datei) {
        Log.i("SQLite", "MyDatabaseHelper.neu ... " + datei.getDateiTitel());
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("name", datei.getDateiTitel());

        //Reihe einsetzen
        db.insert("Datei_Namen", null, values);
        db.close();
    }

    /*public Datei getDatei(int id) {
        Log.i("SQLite", "MyDatabaseHelper.getDatei... " + id);

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.query("Datei_Namen", new String[] {"id","name"},"id=?",
                new String[] {String.valueOf(id)},null,null,null,null);

        if (cursor != null){
            cursor.moveToFirst();
        }

        Datei datei = new Datei(Integer.parseInt(cursor.getString(0)),
                cursor.getString(1));
        return  datei;
    }*/

    public List<Datei>getAlleDateien(){
        Log.i("SQLite", "MyDatabaseHelper.getAlleDateien ... ");

        List<Datei> dateiList = new ArrayList<>();
        String selectQuery = "SELECT * FROM Datei_Namen";

        SQLiteDatabase db = this.getWritableDatabase();
        @SuppressLint("Recycle") Cursor cursor = db.rawQuery(selectQuery, null);

        if(cursor.moveToFirst()){
            do{
                Datei datei = new Datei();
                datei.setDateiId(Integer.parseInt(cursor.getString(0)));
                datei.setDateiTitel(cursor.getString(1));

                dateiList.add(datei);
            } while(cursor.moveToNext());
        }
        return dateiList;
    }

    public List<Datei>getAllVocabE(){
        Log.i("SQLite", "MyDatabaseHelper.getAlleDateien ... ");

        List<Datei> dateiList = new ArrayList<>();
        String selectQuery = "SELECT * FROM Vocab";

        SQLiteDatabase db = this.getWritableDatabase();
        @SuppressLint("Recycle") Cursor cursor = db.rawQuery(selectQuery, null);

        if(cursor.moveToFirst()){
            do{
                Datei datei = new Datei();
                datei.setDateiId(Integer.parseInt(cursor.getString(0)));
                datei.setDateiTitel(cursor.getString(1));

                dateiList.add(datei);
            } while(cursor.moveToNext());
        }
        return dateiList;
    }

    public int getDateiAnzahl(){
        Log.i("SQLite", "MyDatabaseHelper.getDateiAnzahl ... ");

        String countQuery = "SELECT * FROM Datei_Namen";
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(countQuery, null);

        int Anzahl = cursor.getCount();

        cursor.close();
        return Anzahl;
    }

    public void updateDateien(Datei datei) {
        Log.i("SQLite", "MyDatabaseHelper.updateDateien ... ");
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("name",datei.getDateiTitel());

        // Reihe updaten
        /*return (void entfernen)*/ db.update("Datei_Namen", values, "id=?",
                new String[]{String.valueOf(datei.getDateiId())});
    }

    public void dateiLoeschen(Datei datei){
        Log.i("SQLite", "MyDatabaseHelper.dateiLoeschen ... ");
        SQLiteDatabase db = this.getWritableDatabase();
        db.delete("Datei_Namen", "id=?",
                new String[]{String.valueOf(datei.getDateiId())});
        db.close();
    }
}
