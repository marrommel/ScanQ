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

    @Query("SELECT *FROM VOKABELN WHERE kategorie = :kategorie")
    List<Vokabel> getKategorieVokabeln(String kategorie);

    @Query("UPDATE VOKABELN SET vokabelENG = :neu WHERE vokabelENG = :alt")
    void updateVokabelENG(String alt, String neu);

    @Query("UPDATE VOKABELN SET vokabelDE = :neu WHERE vokabelDE = :alt")
    void updateVokabelDE(String alt, String neu);

    @Query("UPDATE vokabeln SET markiert = :markiert WHERE id = :id")
    void updateMarkierung(int id, boolean markiert);

    @Query("DELETE FROM VOKABELN WHERE id = :id")
    void deleteVokabelWithId(int id);

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
