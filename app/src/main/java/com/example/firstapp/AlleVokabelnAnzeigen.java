package com.example.firstapp;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.textfield.TextInputLayout;

import java.util.List;

public class AlleVokabelnAnzeigen extends AppCompatActivity {

    private VokabelViewModel vokabelViewModel;
    private RecyclerView datenbankAusgabe;

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.datenausgabe);

        RecyclerView vokabelAusgabe = findViewById(R.id.vokabelAusgabe);
        final VokabelAusgabeAdapter vokabelAusgabeAdapter = new VokabelAusgabeAdapter(this);
        vokabelAusgabe.setAdapter(vokabelAusgabeAdapter);
        vokabelAusgabe.setLayoutManager(new LinearLayoutManager(this));

        vokabelViewModel = new ViewModelProvider(this).get(VokabelViewModel.class);
        vokabelViewModel.getAlleVokabeln().observe(this, new Observer<List<Vokabel>>() {
            @Override
            public void onChanged(@Nullable final List<Vokabel> vokabels) {
                vokabelAusgabeAdapter.setVokabelCache(vokabels);
            }
        });

        final ImageButton addButton = findViewById(R.id.addButton);
        ScrollView scrollView = findViewById(R.id.ScrollView);
        scrollView.setOnScrollChangeListener(new View.OnScrollChangeListener() {
            @Override
            public void onScrollChange(View v, int scrollX, int scrollY, int oldScrollX, int oldScrollY) {
                if (oldScrollY > scrollY) {
                    addButton.setVisibility(View.VISIBLE);
                }
                else {
                    addButton.setVisibility(View.INVISIBLE);
                }
            }
        });

        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final AlertDialog.Builder neueVokabelDialogBuilder = new AlertDialog.Builder(AlleVokabelnAnzeigen.this);
                neueVokabelDialogBuilder.setTitle("Vokabel hinzufügen");
                neueVokabelDialogBuilder.setMessage("Wie möchtest du fortfahren?");

                neueVokabelDialogBuilder.setPositiveButton("manuell", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();

                        Intent intentManuell = new Intent(AlleVokabelnAnzeigen.this, VokabelManuell.class);
                        AlleVokabelnAnzeigen.this.startActivity(intentManuell);
                        finish();
                    }
                });

                neueVokabelDialogBuilder.setNeutralButton("scannen", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Toast toast = Toast.makeText(AlleVokabelnAnzeigen.this, "scannen", Toast.LENGTH_SHORT);
                        toast.show();
                        dialog.cancel();
                    }
                });

                neueVokabelDialogBuilder.setNegativeButton("abbrechen", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();
                    }
                });

                neueVokabelDialogBuilder.show();
            }
        });

        /*
        vokabelViewModel = new ViewModelProvider(this).get(VokabelViewModel.class);

        vokabelViewModel.getAlleVokabeln().observe(this, new Observer<List<Vokabel>>() {
            @Override
            public void onChanged(@Nullable final List<Vokabel> vokabels) {

            }
        });
         */
    }
}
