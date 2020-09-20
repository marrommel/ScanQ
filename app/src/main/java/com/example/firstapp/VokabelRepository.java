package com.example.firstapp;

import java.util.List;

public class VokabelRepository implements VokabelDatenInterface {

    private VokabelDatenInterface dbLocalDataSource;
    private static VokabelRepository dbInstance;

    public VokabelRepository(VokabelDatenInterface dbLocalDataSource) {
        this.dbLocalDataSource = dbLocalDataSource;
    }

    public static VokabelRepository getInstance(VokabelDatenInterface dbLocalDataSource) {
        if (dbInstance == null) {
            dbInstance = new VokabelRepository(dbLocalDataSource);
        }
        return dbInstance;
    }

    @Override
    public List<Vokabel> getAlle() {
        return dbLocalDataSource.getAlle();
    }

    @Override
    public List<Vokabel> getMarkierte(boolean markiert) {
        return dbLocalDataSource.getMarkierte(markiert);
    }

    @Override
    public List<Vokabel> getKategorieVokabeln(String kategorie) {
        return dbLocalDataSource.getKategorieVokabeln(kategorie);
    }

    @Override
    public Boolean isMarkiert(String de) {
        return dbLocalDataSource.isMarkiert(de);
    }

    @Override
    public String getAntwortDE(String vokabelENG) {
        return dbLocalDataSource.getAntwortDE(vokabelENG);
    }

    @Override
    public String getAntwortENG(String vokabelDE) {
        return dbLocalDataSource.getAntwortENG(vokabelDE);
    }

    @Override
    public int getAnswered(int id) {
        return dbLocalDataSource.getAnswered(id);
    }

    @Override
    public List<Vokabel> getAlreadyAnswered(int answered) {
        return dbLocalDataSource.getAlreadyAnswered(answered);
    }

    @Override
    public int getId(String de) {
        return dbLocalDataSource.getId(de);
    }

    @Override
    public void updateVokabelENG(String alt, String neu) {
        dbLocalDataSource.updateVokabelENG(alt, neu);
    }

    @Override
    public void updateVokabelDE(String alt, String neu) {
        dbLocalDataSource.updateVokabelDE(alt, neu);
    }

    @Override
    public void updateMarkierung(String de, boolean markiert) {
        dbLocalDataSource.updateMarkierung(de, markiert);
    }

    @Override
    public void updateAnswered(int id, int answered) {
        dbLocalDataSource.updateAnswered(id, answered);
    }

    @Override
    public void deleteVokabelWithId(int id) {
        dbLocalDataSource.deleteVokabelWithId(id);
    }

    @Override
    public void deleteVokabelWithENG(String vokabelENG) {
        dbLocalDataSource.deleteVokabelWithENG(vokabelENG);
    }

    @Override
    public void deleteVokabelWithDE(String vokabelDE) {
        dbLocalDataSource.deleteVokabelWithDE(vokabelDE);
    }

    @Override
    public void deleteKategorie(String kategorie) {
        dbLocalDataSource.deleteKategorie(kategorie);
    }

    @Override
    public void insertVokabel(Vokabel vokabel) {
        dbLocalDataSource.insertVokabel(vokabel);
    }

    @Override
    public void insertAlleVokabeln(Vokabel... vokabeln) {
        dbLocalDataSource.insertAlleVokabeln(vokabeln);
    }

    @Override
    public void updateVokabel(Vokabel vokabel) {
        dbLocalDataSource.updateVokabel(vokabel);
    }

    @Override
    public void deleatVokabel(Vokabel vokabel) {
        dbLocalDataSource.deleatVokabel(vokabel);
    }
}
