package com.example.firstapp;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.textfield.TextInputLayout;

import java.util.List;

public class AlleVokabelnAnzeigen extends AppCompatActivity {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dateien);

        VokabelSpender vokabelSpender = new VokabelSpender(this);
        List<Vokabel> alleVokabeln = vokabelSpender.getAlleVokabeln();

        TableLayout tabelle = findViewById(R.id.VokabelTabelle);

        if (!alleVokabeln.isEmpty()) {
            for (int i = 0; i < alleVokabeln.size(); i++) {
                final Vokabel vokabel = alleVokabeln.get(i);

                TableRow row = new TableRow(this);
                if (vokabel.isMarkiert()) {
                    row.setBackgroundColor(Color.parseColor("#8E44AD"));
                }

                row.setClickable(true);
                row.setTag(0, vokabel);

                row.setOnLongClickListener(new View.OnLongClickListener() {
                    @Override
                    public boolean onLongClick(View view) {
                        final Vokabel rowVokabel = (Vokabel) view.getTag(0);

                        AlertDialog.Builder optionsBuilder = new AlertDialog.Builder(AlleVokabelnAnzeigen.this);
                        optionsBuilder.setTitle("Optionen");
                        optionsBuilder.setNeutralButton("löschen", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(getApplicationContext());
                                vokabelVerwalter.deleteVokabel(rowVokabel);
                            }
                        });
                        optionsBuilder.setNegativeButton("abbrechen", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                dialogInterface.cancel();
                            }
                        });
                        optionsBuilder.setNeutralButton("bearbeiten", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                AlertDialog.Builder editBuilder = new AlertDialog.Builder(AlleVokabelnAnzeigen.this);
                                editBuilder.setTitle("bearbeiten");

                                final EditText inputENG = new EditText(AlleVokabelnAnzeigen.this);
                                final TextInputLayout textInputLayout = new TextInputLayout(AlleVokabelnAnzeigen.this);
                                inputENG.setText(rowVokabel.getVokabelENG());
                                textInputLayout.setPadding(75, 0, 75, 20);
                                editBuilder.setView(textInputLayout);
                                textInputLayout.addView(inputENG);

                                final EditText inputDE = new EditText(AlleVokabelnAnzeigen.this);
                                final TextInputLayout textInputLayoutDE = new TextInputLayout(AlleVokabelnAnzeigen.this);
                                inputDE.setText(rowVokabel.getVokabelDE());
                                textInputLayoutDE.setPadding(75, 0, 75, 20);
                                editBuilder.setView(textInputLayoutDE);
                                textInputLayoutDE.addView(inputDE);

                                editBuilder.setPositiveButton("speichern", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(getApplicationContext());
                                        vokabelVerwalter.updateVokabel(rowVokabel.getVokabelENG(), inputENG.getText().toString(), rowVokabel.getVokabelDE(), inputDE.getText().toString());
                                    }
                                });

                                editBuilder.setNegativeButton("abbrechen", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.cancel();
                                    }
                                });
                                editBuilder.show();
                            }
                        });
                        if (vokabel.isMarkiert()) {
                            optionsBuilder.setNeutralButton("markieren", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(getApplicationContext());
                                    vokabelVerwalter.markiere(rowVokabel);
                                }
                            });
                        } else {
                            optionsBuilder.setNeutralButton("markierung entfernen", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(getApplicationContext());
                                    vokabelVerwalter.markierungEntfernen(rowVokabel);
                                }
                            });
                        }
                        optionsBuilder.show();

                        return true;
                    }
                });

                TextView englisch = new TextView(this);
                englisch.setText(vokabel.getVokabelENG());
                row.addView(englisch);

                TextView deutsch = new TextView(this);
                deutsch.setText(vokabel.getVokabelDE());
                row.addView(deutsch);

                TextView kategorie = new TextView(this);
                kategorie.setText(vokabel.getKategorie());
                row.addView(kategorie);

                tabelle.addView(row);
            }
        } else {
            Toast.makeText(AlleVokabelnAnzeigen.this, "keine Vokabeln gefunden", Toast.LENGTH_LONG);
        }
    }
}
