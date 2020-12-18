package com.rommelbendel.firstapp;

import java.util.List;

public interface VokabelDatenInterface {
    List<Vokabel> getAlle();
    List<Vokabel> getMarkierte(boolean markiert);
    List<Vokabel> getKategorieVokabeln(String kategorie);
    Boolean isMarkiert(String de);
    String getAntwortDE(String vokabelENG);
    String getAntwortENG(String vokabelDE);
    int getAnswered(int id);
    List<Vokabel> getAlreadyAnswered(int answered);
    int getId(String de);
    void updateVokabelENG(String alt, String neu);
    void updateVokabelDE(String alt, String neu);
    void updateMarkierung(String de, boolean markiert);
    void updateAnswered(int id, int answered);
    void deleteVokabelWithId(int id);
    void deleteVokabelWithENG(String vokabelENG);
    void deleteVokabelWithDE(String vokabelDE);
    void deleteKategorie(String kategorie);
    void insertVokabel(Vokabel vokabel);
    void insertAlleVokabeln(Vokabel... vokabeln);
    void updateVokabel(Vokabel vokabel);
    void deleatVokabel(Vokabel vokabel);
}
