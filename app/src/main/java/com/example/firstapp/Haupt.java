package com.example.firstapp;

import android.Manifest;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.AndroidRuntimeException;
import android.util.Log;
import android.util.SparseArray;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.room.Room;

import com.google.android.gms.vision.Frame;
import com.google.android.gms.vision.text.TextBlock;
import com.google.android.gms.vision.text.TextRecognizer;
import com.google.android.material.textfield.TextInputLayout;
import com.theartofdev.edmodo.cropper.CropImage;
import com.theartofdev.edmodo.cropper.CropImageView;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Haupt extends AppCompatActivity {
    //final Datenbank db = Room.databaseBuilder(getApplicationContext(), Datenbank.class, "Vokabeln").build();

    private static String FILE_NAME;
    //private Datei datei;
    private int mode;
    //private VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(this);

    EditText ergebnisEt;
    ImageView bildVorschau;

    private static final int CAMERA_REQUEST_CODE = 200;
    private static final int STORAGE_REQUEST_CODE = 400;
    private static final int IMAGE_PICK_GALLERY_CODE = 1000;
    private static final int IMAGE_PICK_CAMERA_CODE = 1001;
    private static final int MODE_CREATE = 1;
    private static final int MODE_EDIT = 2;

    private String m_Text = "";

    String[] cameraPermission;
    String[] storagePermission;

    Uri image_uri;

    @Override
    protected void onCreate(Bundle savedInstaceState){


        super.onCreate(savedInstaceState);
        setContentView(R.layout.activity_haupt);

        Intent getintent = getIntent();
        int cam_id = getintent.getIntExtra("cam_key", 0);
        int gal_id = getintent.getIntExtra("gal_key", 0);

        if(cam_id == 221122){
            pickCamera();
        }else if(gal_id == 110011) {
            pickGallery();
        }

        ergebnisEt = findViewById(R.id.ergebnisEt);
        bildVorschau = findViewById(R.id.bildVorschau);

        cameraPermission = new String[]{Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE};
        storagePermission = new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE};

        ImageView home = findViewById(R.id.homeButton);
        ImageView aufgabe = findViewById(R.id.aufgabeButton);
        /*ImageButton neu = (ImageButton) findViewById(R.id.neuButton);
        ImageButton neuClicked = (ImageButton) findViewById(R.id.neuClicked);*/
        Button anzeigen = findViewById(R.id.anzeigen);
        Button speichern = findViewById(R.id.speichern);
        Button loeschen = findViewById(R.id.loeschen);

        loeschen.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                loeschenClicked();
            }
        });

        /*
        Intent intent = this.getIntent();
        this.datei = (Datei) intent.getSerializableExtra("Datei");
        if(datei== null)  {
            this.mode = MODE_CREATE;
        } else  {
            this.mode = MODE_EDIT;
            this.ergebnisEt.setText(datei.getDateiTitel());
        }
         */

        home.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(Haupt.this, einstellung.class);
                Haupt.this.startActivity(myIntent);
                finish();
            }
        });

        aufgabe.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(Haupt.this, AlleVokabelnAnzeigen.class);
                myIntent.putExtra("datei_name", m_Text);
                Haupt.this.startActivity(myIntent);
            }
        });

        speichern.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                if(ergebnisEt.getText().toString().trim().length() != 0) {
                    AlertDialog.Builder builder = new AlertDialog.Builder(Haupt.this);
                    builder.setTitle("Kategorie: ");

                    final EditText input = new EditText(Haupt.this);
                    final TextInputLayout textInputLayout = new TextInputLayout(Haupt.this);
                    textInputLayout.setPadding(75, 0, 75, 20);
                    builder.setView(textInputLayout);
                    textInputLayout.addView(input);

                    builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            m_Text = input.getText().toString();

                            if (m_Text.trim().length() != 0) {
                                List<String> vokabelnText = Arrays.asList(ergebnisEt.getText().toString().split(" "));
                                final VokabelVerwalter vokabelVerwalter = new VokabelVerwalter(Haupt.this);
                                //Diese Vorgehensweise muss überarbeitet werden!
                                for (int i = 0; i < vokabelnText.size(); i+= 2) {
                                    final String vokabelENG = vokabelnText.get(i);
                                    try {
                                        final String vokabelDE = vokabelnText.get(i + 1);
                                        vokabelVerwalter.speichern(vokabelENG, vokabelDE, m_Text);
                                    } catch (java.lang.ArrayIndexOutOfBoundsException e) {
                                        Log.i("Speicherfehler", e.toString());
                                        AlertDialog.Builder builder = new AlertDialog.Builder(Haupt.this);
                                        builder.setTitle(vokabelENG + " bedeutet: ");

                                        final EditText inputDE = new EditText(Haupt.this);
                                        final TextInputLayout textInputLayout = new TextInputLayout(Haupt.this);
                                        textInputLayout.setPadding(75, 0, 75, 20);
                                        builder.setView(textInputLayout);
                                        textInputLayout.addView(inputDE);

                                        builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialogInterface, int i) {
                                                String vocDE = inputDE.getText().toString();
                                                vokabelVerwalter.speichern(vokabelENG, vocDE, m_Text);
                                            }
                                        });
                                    }
                                }

                            }
                            /*
                            try {
                                if(m_Text.trim().length() != 0) {
                                    fos = openFileOutput(FILE_NAME, MODE_PRIVATE);
                                    OutputStreamWriter outputWriter = new OutputStreamWriter(fos);
                                    outputWriter.write(ergebnisEt.getText().toString());
                                    outputWriter.close();
                                } else{
                                    Toast.makeText(getBaseContext(), "Bitte Dateinamen eingeben!",
                                            Toast.LENGTH_LONG).show();
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                                Toast.makeText(getBaseContext(), "Bitte Dateinamen eingeben!",
                                        Toast.LENGTH_LONG).show();
                            } finally {
                                if (fos != null) {
                                    try {
                                        fos.close();
                                        speichernClicked();
                                        insertVocabE();
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }*/
                        }
                    });
                    builder.setNegativeButton("abbrechen", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.cancel();
                        }
                    });
                    builder.show();
                } else {
                    Toast.makeText(getApplicationContext(),
                            "Bitte Inhalt eingeben", Toast.LENGTH_LONG).show();
                }
            }
        });

        /*neuClicked.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                FileOutputStream fos = null;
                FILE_NAME = "test";

                neu.setVisibility(View.VISIBLE);
                neuClicked.setVisibility(View.GONE);

                try {
                    fos = openFileOutput(FILE_NAME, MODE_PRIVATE);
                    OutputStreamWriter outputWriter=new OutputStreamWriter(fos);
                    outputWriter.write(ergebnisEt.getText().toString());
                    outputWriter.close();

                    //display file saved message
                    Toast.makeText(getBaseContext(), "Datei erfolgreich gespeichert!",
                            Toast.LENGTH_SHORT).show();
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    if (fos != null) {
                        try {
                            fos.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        });*/

        anzeigen.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                try {
                    FileInputStream fileIn = openFileInput(FILE_NAME);
                    InputStreamReader InputRead = new InputStreamReader(fileIn);

                    char[] inputBuffer = new char[100];
                    StringBuilder s = new StringBuilder();
                    int charRead;

                    while ((charRead = InputRead.read(inputBuffer)) > 0) {
                        // char to string conversion
                        String readstring = String.copyValueOf(inputBuffer, 0, charRead);
                        s.append(readstring);
                    }
                    InputRead.close();
                    ergebnisEt.setText(s.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }
/*
    public void speichernClicked(){
        datenbank db = new datenbank(this);
        String title = this.m_Text;

        if(title.equals("")){
            Toast.makeText(getApplicationContext(),
                    "Bitte Dateinamen eingeben", Toast.LENGTH_LONG).show();
            return;
        }
        if(mode == MODE_CREATE ) {
            this.datei= new Datei(title);
            db.neu(datei);
        } else  {
            this.datei.setDateiTitel(title);
            db.updateDateien(datei);
        }

        Toast.makeText(getApplicationContext(),
                "erfolgreich gespeichert", Toast.LENGTH_LONG).show();
    }

 */
/*
    public void insertVocabE(){
        datenbank db = new datenbank(this);

        try {
            FileInputStream fileIn = openFileInput(m_Text);
            InputStreamReader InputRead = new InputStreamReader(fileIn);

            char[] inputBuffer = new char[100];
            StringBuilder s = new StringBuilder();
            int charRead;

            while ((charRead = InputRead.read(inputBuffer)) > 0) {
                // char to string conversion
                s.append(String.copyValueOf(inputBuffer, 0, charRead));
            }
            InputRead.close();

            List<String> sList = Arrays.asList(s.toString().split("\\n"));

            int i;
            for(i=0; i<sList.size(); i++) {
                this.datei = new Datei(sList.get(i));
                db.neuVocE(datei);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

 */

    /*public void insertVocabD(){
        datenbank db = new datenbank(this);
        List<String> sList = Arrays.asList(ergebnisEt.getText().toString().split("\\n"));

        int i;
        for(i=0; i<sList.size(); i++) {
            this.datei = new Datei(sList.get(i));
            db.neuVocD(datei);
        }
    }*/

    public void loeschenClicked()  {
        ergebnisEt.setText("");
        bildVorschau.setImageURI(null);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        getMenuInflater().inflate(R.menu.menu_haupt, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.bildHinzu){
            showImageImportDialog();
        }
        if(id == R.id.einstellungen){
            Intent myIntent = new Intent(Haupt.this, einstellung.class);
            Haupt.this.startActivity(myIntent);
            Toast.makeText(this, "Einstellungen", Toast.LENGTH_SHORT).show();
        }

        if(id == R.id.weiteres){
            Intent myIntent = new Intent(Haupt.this, weiteres.class);
            Haupt.this.startActivity(myIntent);
            Toast.makeText(this, "Weiteres", Toast.LENGTH_SHORT).show();
        }
        return super.onOptionsItemSelected(item);
    }

    private void showImageImportDialog() {
        String[] items = {" Kamera", " Galerie"};
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle("Bild auswählen");
        dialog.setItems(items, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                if ( i == 0){ //Button Kamera ausgewählt
                    if(!checkCameraPermissions()){ //Prüfen ob Berechtigung Kamera erlaubt
                        requestCameraPermissions(); // Berechtigung erteilen
                    }
                    else{
                        pickCamera(); // Bild aufnehmen
                    }
                }
                if( i == 1){ //Button Galerie ausgewählt
                    if(!checkStoragePermissions()){ //Prüfen ob Berechtigung Galerie erlaubt
                        requestStoragePermissions();
                    }
                    else{
                        pickGallery();
                    }
                }
            }
        });
        dialog.create().show();
    }

    private void pickGallery() {
        Intent intent = new Intent(Intent.ACTION_PICK);
        intent.setType("image/*");
        startActivityForResult(intent, IMAGE_PICK_GALLERY_CODE);
    }

    private void requestStoragePermissions() {
        ActivityCompat.requestPermissions(this, storagePermission, STORAGE_REQUEST_CODE);
    }

    private boolean checkStoragePermissions() {
        return ContextCompat.checkSelfPermission(this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE) == (PackageManager.PERMISSION_GRANTED);
    }

    private void pickCamera() {
        ContentValues values = new ContentValues();
        values.put(MediaStore.Images.Media.TITLE, "neues Bild");
        values.put(MediaStore.Images.Media.DESCRIPTION, "Texterkennung");
        image_uri = getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);

        Intent cameraIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, image_uri);
        startActivityForResult(cameraIntent, IMAGE_PICK_CAMERA_CODE);
    }

    private void requestCameraPermissions() {
        ActivityCompat.requestPermissions(this, cameraPermission, CAMERA_REQUEST_CODE);
    }

    private boolean checkCameraPermissions() {
        boolean ergebnis = ContextCompat.checkSelfPermission(this,
                Manifest.permission.CAMERA) == (PackageManager.PERMISSION_GRANTED);
        boolean ergebnis1 = ContextCompat.checkSelfPermission(this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE) == (PackageManager.PERMISSION_GRANTED);
        return ergebnis && ergebnis1;
    }

    // Berechtigungen erwalten und Ergebnisse ausgeben
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode){
            case CAMERA_REQUEST_CODE:
                if(grantResults.length > 0){
                   boolean cameraAccepted = grantResults[0] ==
                    PackageManager.PERMISSION_GRANTED;
                   /*boolean writeStorageAccepted = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;*/
                   if(cameraAccepted /*&& writeStorageAccepted*/){
                       pickCamera();
                   }
                   else{
                       Toast.makeText(this, "Zugang verweigert!", Toast.LENGTH_SHORT).show();
                   }
                }
                break;

            case STORAGE_REQUEST_CODE:
                if(grantResults.length > 0){
                    boolean writeStorageAccepted = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;
                    if(writeStorageAccepted){
                        pickGallery();
                    }
                    else{
                        Toast.makeText(this, "Zugang verweigert!", Toast.LENGTH_SHORT).show();
                    }
                }
                break;
        }
    }

    //Bildergebnis verwalten
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            if (requestCode == IMAGE_PICK_GALLERY_CODE) {
                // Bild aus Galerie zuschneiden
                /*wenn Probleme, entfernen*/assert data != null;
                CropImage.activity(data.getData()).setGuidelines(CropImageView.Guidelines.ON).start(this);
            }
            if (requestCode == IMAGE_PICK_CAMERA_CODE) {
                // Bild aus Kamera zuschneiden
                CropImage.activity(image_uri).setGuidelines(CropImageView.Guidelines.ON).start(this);
            }
        }
        // zugeschnittenes Bild erhalten
        if (requestCode == CropImage.CROP_IMAGE_ACTIVITY_REQUEST_CODE) {
            CropImage.ActivityResult ergebnis = CropImage.getActivityResult(data);
            if (resultCode == RESULT_OK) {
                /*wenn Probleme, entfernen*/assert ergebnis != null;
                Uri ergebnisUri = ergebnis.getUri(); // Bild uri erhalten
                bildVorschau.setImageURI(ergebnisUri); // Bild im ImageView anzeigen

                // bitmap aus Bild machen
                BitmapDrawable bitmapDrawable = (BitmapDrawable) bildVorschau.getDrawable();
                Bitmap bitmap = bitmapDrawable.getBitmap();

                TextRecognizer recognizer = new TextRecognizer.Builder(getApplicationContext()).build();

                if (!recognizer.isOperational()) {
                    Toast.makeText(this, "Fehler", Toast.LENGTH_SHORT).show();
                } else {
                    Frame frame = new Frame.Builder().setBitmap(bitmap).build();
                    SparseArray<TextBlock> items = recognizer.detect(frame);
                    StringBuilder sb = new StringBuilder();
                    // Text aus sb erhalten
                    for (int i = 0; i < items.size(); i++) {
                        TextBlock myItem = items.valueAt(i);
                        sb.append(myItem.getValue());
                        sb.append("\n");
                    }
                    // Text in EditText setzen
                    ergebnisEt.setText(sb.toString());
                }
            } else if (resultCode == CropImage.CROP_IMAGE_ACTIVITY_RESULT_ERROR_CODE) {
                /*wenn Probleme, entfernen*/assert ergebnis != null;
                Exception error = ergebnis.getError();
                Toast.makeText(this, "" + error, Toast.LENGTH_SHORT).show();
            }
        }
    }
}