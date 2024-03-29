package com.rommelbendel.firstapp;

import java.util.List;

public class VokabelDatenQuelle implements VokabelDatenInterface {

    private VokabelnDao vokabelnDao;
    private VokabelDatenQuelle dbInstance;

    @Override
    public List<Vokabel> getAlle() {
        return vokabelnDao.getAlle().getValue();
    }

    @Override
    public List<Vokabel> getMarkierte(boolean markiert) {
        return vokabelnDao.getMarkierte(markiert).getValue();
    }

    @Override
    public List<Vokabel> getKategorieVokabeln(String kategorie) {
        return vokabelnDao.getKategorieVokabeln(kategorie).getValue();
    }

    @Override
    public Boolean isMarkiert(String de){
        return vokabelnDao.isMarkiert(de).getValue();
    }

    @Override
    public String getAntwortDE(String vokabelENG) {
        return vokabelnDao.getAntwortDE(vokabelENG).getValue();
    }

    @Override
    public String getAntwortENG(String vokabelDE) {
        return vokabelnDao.getAntwortENG(vokabelDE).getValue();
    }

    @Override
    public int getAnswered(int id) {
        return vokabelnDao.getAnswered(id).getValue();
    }

    @Override
    public List<Vokabel> getAlreadyAnswered(int answered) {
        return vokabelnDao.getAlreadyAnswered(answered).getValue();
    }

    @Override
    public int getId(String de) {
        return vokabelnDao.getId(de).getValue();
    }

    @Override
    public void updateVokabelENG(String alt, String neu) {
        vokabelnDao.updateVokabelENG(alt, neu);
    }

    @Override
    public void updateVokabelDE(String alt, String neu) {
        vokabelnDao.updateVokabelDE(alt, neu);
    }

    @Override
    public void updateMarkierung(String de, boolean markiert) {
        vokabelnDao.updateMarkierung(de, markiert);
    }

    @Override
    public void updateAnswered(int id, int answered) {
        vokabelnDao.updateAnswered(id, answered);
    }

    @Override
    public void deleteVokabelWithId(int id) {
        vokabelnDao.deleteVokabelWithId(id);
    }

    @Override
    public void deleteVokabelWithENG(String vokabelENG) {
        vokabelnDao.deleteVokabelWithENG(vokabelENG);
    }

    @Override
    public void deleteVokabelWithDE(String vokabelDE) {
        vokabelnDao.deleteVokabelWithDE(vokabelDE);
    }

    @Override
    public void deleteKategorie(String kategorie) {
        vokabelnDao.deleteKategorie(kategorie);
    }

    @Override
    public void insertVokabel(Vokabel vokabel) {
        vokabelnDao.insertVokabel(vokabel);
    }

    @Override
    public void insertAlleVokabeln(Vokabel... vokabeln) {
        vokabelnDao.insertAlleVokabeln(vokabeln);
    }

    @Override
    public void updateVokabel(Vokabel vokabel) {
        vokabelnDao.updateVokabel(vokabel);
    }

    @Override
    public void deleatVokabel(Vokabel vokabel) {
        vokabelnDao.deleatVokabel(vokabel);
    }
}
