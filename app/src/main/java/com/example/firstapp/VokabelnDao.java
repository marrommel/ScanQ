package com.example.firstapp;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

@Dao
public interface VokabelnDao {
    @Query("SELECT * FROM VOKABELN")
    List<Vokabel> getAlle();

    @Query("SELECT * FROM VOKABELN WHERE markiert = :markiert")
    List<Vokabel> getMarkierte(boolean markiert);

    @Query("SELECT * FROM VOKABELN WHERE kategorie = :kategorie")
    List<Vokabel> getKategorieVokabeln(String kategorie);

    @Query("SELECT markiert FROM VOKABELN WHERE vokabelDE = :de")
    Boolean isMarkiert(String de);

    @Query("SELECT vokabelDE FROM VOKABELN WHERE vokabelENG = :vokabelENG LIMIT 1")
    String getAntwortDE(String vokabelENG);

    @Query("SELECT vokabelENG FROM VOKABELN WHERE vokabelDE = :vokabelDE LIMIT 1")
    String getAntwortENG(String vokabelDE);

    @Query("SELECT answered FROM VOKABELN WHERE id = :id")
    int getAnswered(int id);

    @Query("SELECT * FROM VOKABELN WHERE answered = :answered")
    List<Vokabel> getAlreadyAnswered(int answered);

    @Query("SELECT id FROM VOKABELN WHERE vokabelDE = :de")
    int getId(String de);

    @Query("UPDATE VOKABELN SET vokabelENG = :neu WHERE vokabelENG = :alt")
    void updateVokabelENG(String alt, String neu);

    @Query("UPDATE VOKABELN SET vokabelDE = :neu WHERE vokabelDE = :alt")
    void updateVokabelDE(String alt, String neu);

    @Query("UPDATE VOKABELN SET markiert = :markiert WHERE vokabelDE = :de")
    void updateMarkierung(String de, boolean markiert);

    @Query("UPDATE VOKABELN SET answered = :answered WHERE id = :id")
    void updateAnswered(int id, int answered);

    @Query("DELETE FROM VOKABELN WHERE id = :id")
    void deleteVokabelWithId(int id);

    @Query("DELETE FROM VOKABELN WHERE vokabelENG = :vokabelENG")
    void deleteVokabelWithENG(String vokabelENG);

    @Query("DELETE FROM VOKABELN WHERE vokabelDE = :vokabelDE")
    void deleteVokabelWithDE(String vokabelDE);

    @Query("DELETE FROM VOKABELN WHERE kategorie = :kategorie")
    void deleteKategorie(String kategorie);

    @Insert
    void insertVokabel(Vokabel vokabel);

    @Insert
    void insertAlleVokabeln(Vokabel... vokabeln);

    @Update
    void updateVokabel(Vokabel vokabel);

    @Delete
    void deleatVokabel(Vokabel vokabel);
}