package com.rommelbendel.firstapp;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import org.jetbrains.annotations.NotNull;

import java.util.List;


public class VokabelViewModel extends AndroidViewModel {

    private VokabelRepository vokabelRepository;

    private LiveData<List<Vokabel>> alleVokabeln;

    public VokabelViewModel(@NotNull Application application) {
        super(application);
        vokabelRepository = new VokabelRepository(application);
        alleVokabeln = vokabelRepository.getAlleVokabeln();
    }

    LiveData<List<Vokabel>> getAlleVokabeln() {
        return alleVokabeln;
    }

    public void insertVokabel(@NotNull Vokabel vokabel) {
        vokabelRepository.insertVokabel(vokabel);
    }

    public void insertAlleVokabeln(@NotNull Vokabel... vokabeln) {
        vokabelRepository.insertAlleVokabeln(vokabeln);
    }
}
