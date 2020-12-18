package com.rommelbendel.firstapp;

import android.Manifest;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.SparseArray;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.room.Room;

import com.google.android.gms.vision.Frame;
import com.google.android.gms.vision.text.TextBlock;
import com.google.android.gms.vision.text.TextRecognizer;
import com.google.android.material.button.MaterialButton;
import com.google.android.material.textfield.TextInputLayout;
import com.theartofdev.edmodo.cropper.CropImage;
import com.theartofdev.edmodo.cropper.CropImageView;

import org.opencv.android.BaseLoaderCallback;
import org.opencv.android.LoaderCallbackInterface;
import org.opencv.android.OpenCVLoader;
import org.opencv.android.Utils;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.Rect;
import org.opencv.imgproc.Imgproc;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Haupt extends AppCompatActivity {
    /*private static String FILE_NAME;
    private Vokabel vokabel;
    private int mode;*/

    TextView kategorie;
    EditText vocEn, vocDe;
    ImageView bildVorschau;
    Button insertDe, insertEn, speichern, loeschen;
    MaterialButton low, mediumLow, mediumHigh, high, weiter, auswählen, galleryD, scanD;
    ConstraintLayout navAmount, navMethod, navMethodD;

    private static final int CAMERA_REQUEST_CODE = 200;
    private static final int STORAGE_REQUEST_CODE = 400;
    private static final int IMAGE_PICK_GALLERY_CODE = 1000;
    private static final int IMAGE_PICK_CAMERA_CODE = 1001;

    private static final int FIRST_CROP = 101;
    private static final int SECOND_CROP = 202;
    private static final int THIRD_CROP = 303;
    private static final int FOURTH_CROP = 404;
    private static final int FIFTH_CROP = 505;

    private String m_Text = "";

    String[] cameraPermission;
    String[] storagePermission;

    Uri image_uri;

    private BaseLoaderCallback mLoaderCallback = new BaseLoaderCallback(this) {
        @Override
        public void onManagerConnected(int status) {
            switch (status) {
                case LoaderCallbackInterface.SUCCESS: {
                    try {
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                break;
                default: {
                    super.onManagerConnected(status);
                }
                break;
            }
        }
    };


    @Override
    public void onResume() {
        super.onResume();
        if (!OpenCVLoader.initDebug()) {
            OpenCVLoader.initAsync(OpenCVLoader.OPENCV_VERSION, this, mLoaderCallback);
        } else {
            mLoaderCallback.onManagerConnected(LoaderCallbackInterface.SUCCESS);
        }
    }

   /* @Override
    public void onDestroy() {
        super.onDestroy();

        String[] bitmapNames = {"bit", "bit2", "bit3", "bit4"};

        for (int i = 0; i < 4; i++) {
            File file = new File(getCacheDir().getAbsolutePath() + "/" +
                    bitmapNames[i] + ".png");
            file.delete();
        }
    }

    @Override
    public void onStop() {
        super.onStop();

        String[] bitmapNames = {"bit", "bit2", "bit3", "bit4"};

        for (int i = 0; i < 4; i++) {
            File file = new File(getCacheDir().getAbsolutePath() + "/" +
                    bitmapNames[i] + ".png");
            file.delete();
        }
    }*/

    @Override
    protected void onCreate(Bundle savedInstaceState) {
        super.onCreate(savedInstaceState);
        setContentView(R.layout.activity_haupt);

        final Datenbank db = Room.databaseBuilder(Haupt.this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        final TinyDB tb = new TinyDB(getApplicationContext());

        /*VocEn = findViewById(R.id.ergebnisEn);
        VocDe = findViewById(R.id.ergebnisDe);
        insertDe = findViewById(R.id.createDe);
        insertEn = findViewById(R.id.createEn);*/
        bildVorschau = findViewById(R.id.bildVorschau);
        low = findViewById(R.id.amountLow);
        mediumLow = findViewById(R.id.amountMediumL);
        mediumHigh = findViewById(R.id.amountMediumH);
        high = findViewById(R.id.amountHigh);
        navAmount = findViewById(R.id.navVocAmount);
        navMethod = findViewById(R.id.navMethod);
        navMethodD = findViewById(R.id.navMethodD);
        weiter = findViewById(R.id.navScanWeiter);
        scanD = findViewById(R.id.navScanD);
        auswählen = findViewById(R.id.navGalleryWeiter);
        galleryD = findViewById(R.id.navGalleryD);
        kategorie = findViewById(R.id.headingDataset);
        speichern = findViewById(R.id.speichern);
        loeschen = findViewById(R.id.loeschen);

        cameraPermission = new String[]{Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE};
        storagePermission = new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE};

        Intent getintent = getIntent();
        int cam_id = getintent.getIntExtra("cam_key", 0);
        int gal_id = getintent.getIntExtra("gal_key", 0);

        if (cam_id == 221122) {
            pickCamera();
        } else if (gal_id == 110011) {
            pickGallery();
        }

        if(tb.getBoolean("Done")) {
            RecyclerView vokabelAusgabe = findViewById(R.id.tabelleVoc);
            final TabelleVokabelAdapter stringVokabelAdapter = new TabelleVokabelAdapter(this);
            vokabelAusgabe.setAdapter(stringVokabelAdapter);
            vokabelAusgabe.setLayoutManager(new LinearLayoutManager(this));

            ArrayList<Vokabel> resultVoc = new ArrayList<>();
            ArrayList<String> vocListE = tb.getListString("vocListE");
            ArrayList<String> vocListD = tb.getListString("vocListD");

            for (int i = 0; i < vocListE.size(); i++) {
                resultVoc.add(new Vokabel(vocListE.get(i), vocListD.get(i), "0"));
            }

            stringVokabelAdapter.setVokabelCache(resultVoc);
            kategorie.setText("promised Land");
        } else {
            if(!tb.getBoolean("EnglishDone")) {
                vocabAmount();
            } else {
                vocDeutsch();
            }
        }

        //ImageView home = findViewById(R.id.homeButton);
        //ImageView aufgabe = findViewById(R.id.aufgabeButton);

        /*insertDe.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String[] cropKeys = {"crop2", "crop3", "crop4", "crop5"};
                String[] resultKeys = {"result2", "result3", "result4", "result5"};
                String[] bitmapNames = {"bit", "bit2", "bit3", "bit4"};

                for (int u = 0; u < 4; u++) {
                    tb.putBoolean(cropKeys[u], false);
                    tb.remove(resultKeys[u]);
                    File file = new File(getCacheDir().getAbsolutePath() + "/" +
                            bitmapNames[u] + ".png");
                    file.delete();
                }

                tb.putInt("language", 2);
                vocabAmount();
            }
        });

        insertEn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                tb.putInt("language", 1);
                vocabAmount();
            }
        });

        loeschen.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                loeschenClicked();
            }
        });

        home.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(Haupt.this, home.class);
                Haupt.this.startActivity(myIntent);
                finish();
            }
        });

        aufgabe.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                Intent myIntent = new Intent(Haupt.this, vokabelSet.class);
                Haupt.this.startActivity(myIntent);
            }
        });*/

        loeschen.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                tb.putBoolean("Done", false);
                tb.putBoolean("EnglishDone", false);
                loeschenClicked();

                Haupt.this.recreate();
            }
        });

        speichern.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                if (vocEn.getText().toString().trim().length() != 0) {
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
                                List<String> sListEn = Arrays.asList(vocEn.getText().toString().split("\\n"));
                                List<String> sListDe = Arrays.asList(vocDe.getText().toString().split("\\n"));
                                VokabelnDao vocabDao = db.vokabelnDao();
                                for (int i = 0; i < sListEn.size(); i++) {
                                    Vokabel voc = new Vokabel(sListEn.get(i), sListDe.get(i), m_Text);
                                    vocabDao.insertVokabel(voc);
                                }
                            }
                            FileOutputStream fos = null;
                            try {
                                if (m_Text.trim().length() != 0) {
                                    fos = openFileOutput(m_Text, MODE_PRIVATE);
                                    OutputStreamWriter outputWriter = new OutputStreamWriter(fos);
                                    outputWriter.write(vocEn.getText().toString());
                                    outputWriter.close();
                                    Toast.makeText(getBaseContext(), "erfolgreich gespiechert!",
                                            Toast.LENGTH_LONG).show();
                                } else {
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
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
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
                tb.putBoolean("listExistence", false);
            }
        });
    }

    public void loeschenClicked() {
        //VocEn.setText("");
        //VocDe.setText("");
        bildVorschau.setImageURI(null);
        bildVorschau.setImageBitmap(null);
    }

    /*@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_haupt, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.bildHinzu) {
            showImageImportDialog();
        }
        if (id == R.id.einstellungen) {
            Intent myIntent = new Intent(Haupt.this, einstellung.class);
            Haupt.this.startActivity(myIntent);
            Toast.makeText(this, "Einstellungen", Toast.LENGTH_SHORT).show();
        }

        if (id == R.id.weiteres) {
            Intent myIntent = new Intent(Haupt.this, weiteres.class);
            Haupt.this.startActivity(myIntent);
            Toast.makeText(this, "Weiteres", Toast.LENGTH_SHORT).show();
        }
        return super.onOptionsItemSelected(item);
    }*/

    private void vocabAmount() {
        /*String[] items = {" 4 oder weniger", " 5 bis 10", "mehr als 10"};
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle("Wie viele Vokabeln hast du?");
        dialog.setItems(items, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                TinyDB tb = new TinyDB(getApplicationContext());

                if (i == 0) {
                    tb.putInt("vocAmount", 0);
                    showImageImportDialog();
                }
                if (i == 1) {
                    tb.putInt("vocAmount", 1);
                    showImageImportDialog();
                }
                if (i == 2) {
                    tb.putInt("vocAmount", 2);
                    showImageImportDialog();
                }
            }
        });
        dialog.create().show();*/
        navAmount.setVisibility(View.VISIBLE);
        final TinyDB tb = new TinyDB(getApplicationContext());

        low.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navAmount.setVisibility(View.GONE);

                tb.putInt("vocAmount", 0);
                showImageImportDialog();
            }
        });

        mediumLow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navAmount.setVisibility(View.GONE);

                tb.putInt("vocAmount", 1);
                showImageImportDialog();
            }
        });

        mediumHigh.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navAmount.setVisibility(View.GONE);

                tb.putInt("vocAmount", 1);
                showImageImportDialog();
            }
        });

        high.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navAmount.setVisibility(View.GONE);

                tb.putInt("vocAmount", 2);
                showImageImportDialog();
            }
        });
    }

    private void showImageImportDialog() {
        navMethod.setVisibility(View.VISIBLE);
        final TinyDB tb = new TinyDB(getApplicationContext());
        tb.putInt("languageKey", 1);

        weiter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!checkCameraPermissions()) { //Prüfen ob Berechtigung Kamera erlaubt
                    requestCameraPermissions(); // Berechtigung erteilen
                } else {
                    pickCamera(); // Bild aufnehmen
                }

               navMethod.setVisibility(View.GONE);
            }
        });

        auswählen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!checkStoragePermissions()) { //Prüfen ob Berechtigung Galerie erlaubt
                    requestStoragePermissions();
                } else {
                    pickGallery();
                }

                navMethod.setVisibility(View.GONE);
            }
        });
        /*String[] items = {" Kamera", " Galerie"};
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle("Bild auswählen");
        dialog.setItems(items, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) { //Button Kamera ausgewählt
                    if (!checkCameraPermissions()) { //Prüfen ob Berechtigung Kamera erlaubt
                        requestCameraPermissions(); // Berechtigung erteilen
                    } else {
                        pickCamera(); // Bild aufnehmen
                    }
                }
                if (i == 1) { //Button Galerie ausgewählt
                    if (!checkStoragePermissions()) { //Prüfen ob Berechtigung Galerie erlaubt
                        requestStoragePermissions();
                    } else {
                        pickGallery();
                    }
                }
            }
        });
        dialog.create().show();*/
    }

    private void vocDeutsch() {
        navMethodD.setVisibility(View.VISIBLE);
        final TinyDB tb = new TinyDB(getApplicationContext());
        tb.putInt("languageKey", 2);

        scanD.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!checkCameraPermissions()) {
                    requestCameraPermissions();
                } else {
                    pickCamera();
                }

                navMethodD.setVisibility(View.GONE);
            }
        });

        galleryD.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!checkStoragePermissions()) {
                    requestStoragePermissions();
                } else {
                    pickGallery();
                }

                navMethodD.setVisibility(View.GONE);
            }
        });
        /*String[] items = {" Kamera", " Galerie"};
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle("Bild auswählen");
        dialog.setItems(items, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) { //Button Kamera ausgewählt
                    if (!checkCameraPermissions()) { //Prüfen ob Berechtigung Kamera erlaubt
                        requestCameraPermissions(); // Berechtigung erteilen
                    } else {
                        pickCamera(); // Bild aufnehmen
                    }
                }
                if (i == 1) { //Button Galerie ausgewählt
                    if (!checkStoragePermissions()) { //Prüfen ob Berechtigung Galerie erlaubt
                        requestStoragePermissions();
                    } else {
                        pickGallery();
                    }
                }
            }
        });
        dialog.create().show();*/
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
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        switch (requestCode) {
            case CAMERA_REQUEST_CODE:
                if (grantResults.length > 0) {
                    boolean cameraAccepted = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;
                    if (cameraAccepted) {
                        pickCamera();
                    } else {
                        Toast.makeText(this, "Zugang verweigert!", Toast.LENGTH_SHORT).show();
                    }
                }
                break;

            case STORAGE_REQUEST_CODE:
                if (grantResults.length > 0) {
                    boolean writeStorageAccepted = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;
                    if (writeStorageAccepted) {
                        pickGallery();
                    } else {
                        Toast.makeText(this, "Zugang verweigert!", Toast.LENGTH_SHORT).show();
                    }
                }
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        TinyDB tb = new TinyDB(getApplicationContext());

        if (resultCode == RESULT_OK) {
            if (requestCode == IMAGE_PICK_GALLERY_CODE) {
                assert data != null;
                intentForCropResult(data.getData(), FIRST_CROP);
            }

            if (requestCode == IMAGE_PICK_CAMERA_CODE) {
                intentForCropResult(image_uri, FIRST_CROP);
            }
        }
        if (requestCode == FIRST_CROP) {
            CropImage.ActivityResult ergebnis = CropImage.getActivityResult(data);

            if (resultCode == RESULT_OK) {
                assert ergebnis != null;
                Uri ergebnisUri = ergebnis.getUri();
                bildVorschau.setImageURI(ergebnisUri);

                if (tb.getInt("vocAmount") == 0) {
                    tb.putBoolean("crop2", true);
                    tb.putBoolean("crop3", true);
                    tb.putBoolean("crop4", true);
                    tb.putBoolean("crop5", true);

                    BitmapDrawable bitmapDrawable = (BitmapDrawable) bildVorschau.getDrawable();
                    Bitmap resBitmap = bitmapDrawable.getBitmap();

                    TextRecognizer recognizer = new TextRecognizer.Builder(this).build();
                    String result = textByTesseract(recognizer, resBitmap);
                    tb.putString("result1", result);
                }
            }
            else if (resultCode == CropImage.CROP_IMAGE_ACTIVITY_RESULT_ERROR_CODE) {
                assert ergebnis != null;
                Exception error = ergebnis.getError();
                Toast.makeText(this, "" + error, Toast.LENGTH_SHORT).show();
            }
        }

        boolean secondCrop = tb.getBoolean("crop2");
        boolean thirdCrop = tb.getBoolean("crop3");
        boolean fourthCrop = tb.getBoolean("crop4");
        boolean fifthCrop = tb.getBoolean("crop5");
        String[] bitmapNames = {"bit", "bit2", "bit3", "bit4"};

        if (requestCode == SECOND_CROP) {
            tb.putString("result2", prepareImage(data));
        }
        else if (requestCode == THIRD_CROP) {
            tb.putString("result3", prepareImage(data));
        }
        else if (requestCode == FOURTH_CROP) {
            tb.putString("result4", prepareImage(data));
        }
        else if (requestCode == FIFTH_CROP) {
            tb.putString("result5", prepareImage(data));
        }

        BitmapDrawable bd = (BitmapDrawable) bildVorschau.getDrawable();
        Bitmap bitmap = bd.getBitmap();

        if (!secondCrop) {
            Bitmap[] bitmapArray = set_img_dpi(bitmap);

            try {
                for (int z = 0; z < bitmapArray.length; z++) {
                    bitmapArray[z] = invert(bitmapArray[z]);

                    FileOutputStream fileOutputStream = new FileOutputStream(
                            getCacheDir().getAbsolutePath() +
                                    "/" + bitmapNames[z] + ".png");
                    BufferedOutputStream bos = new BufferedOutputStream(fileOutputStream);
                    bitmapArray[z].compress(Bitmap.CompressFormat.PNG, 100, bos);
                    bos.flush();
                    bos.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Bitmap bit = BitmapFactory.decodeFile(getCacheDir()
                    .getAbsolutePath() + "/" + bitmapNames[0] + ".png");


            intentForCropResult(getImageUri(this, bit), SECOND_CROP);
            tb.putBoolean("crop2", true);
        }
        else if (!thirdCrop) {
            Bitmap bit = BitmapFactory.decodeFile(getCacheDir()
                    .getAbsolutePath() + "/" + bitmapNames[1] + ".png");

            intentForCropResult(getImageUri(this, bit), THIRD_CROP);

            if (tb.getInt("vocAmount") == 1) {
                tb.putBoolean("crop4", true);
                tb.putBoolean("crop5", true);
            }

            tb.putBoolean("crop3", true);
        }
        else if (!fourthCrop) {
            Bitmap bit = BitmapFactory.decodeFile(getCacheDir()
                    .getAbsolutePath() + "/" + bitmapNames[2] + ".png");

            intentForCropResult(getImageUri(this, bit), FOURTH_CROP);
            tb.putBoolean("crop4", true);
        }
        else if (!fifthCrop) {
            Bitmap bit = BitmapFactory.decodeFile(getCacheDir()
                    .getAbsolutePath() + "/" + bitmapNames[3] + ".png");

            intentForCropResult(getImageUri(this, bit), FIFTH_CROP);
            tb.putBoolean("crop5", true);
        }
        else {
            tb.putBoolean("crop2", false);
            tb.putBoolean("crop3", false);
            tb.putBoolean("crop4", false);
            tb.putBoolean("crop5", false);

            for (int i = 0; i < 4; i++) {
                File file = new File(getCacheDir().getAbsolutePath() + "/" +
                        bitmapNames[i] + ".png");
                file.delete();
            }

            String[] results = {
                    tb.getString("result2"),
                    tb.getString("result3"),
                    tb.getString("result4"),
                    tb.getString("result5"),
                    tb.getString("result1")
            };

            if (tb.getInt("languageKey") == 1) {
                String vocR0 = results[4];
                String vocR = results[0];
                String vocR2 = results[1];
                String vocR3 = results[2];
                String vocR4 = results[3];

                if (tb.getInt("vocAmount") == 2) {
                    String s = String.format("%s%s%s%s", vocR, vocR2, vocR3, vocR4);
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(s.split("\\n")));

                    tb.putBoolean("EnglishDone", true);
                    tb.putListString("vocListE", vocList);

                    Haupt.this.recreate();
                }

                if (tb.getInt("vocAmount") == 1) {
                    String s = String.format("%s%s", vocR, vocR2);
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(s.split("\\n")));

                    tb.putBoolean("EnglishDone", true);
                    tb.putListString("vocListE", vocList);

                    Haupt.this.recreate();
                }

                if (tb.getInt("vocAmount") == 0) {
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(vocR0.split("\\n")));

                    tb.putBoolean("EnglishDone", true);
                    tb.putListString("vocListE", vocList);

                    Haupt.this.recreate();
                }
            }

            else if (tb.getInt("languageKey") == 2) {
                String vocR0 = results[4];
                String vocR = results[0];
                String vocR2 = results[1];
                String vocR3 = results[2];
                String vocR4 = results[3];

                if (tb.getInt("vocAmount") == 2) {
                    String s = String.format("%s%s%s%s", vocR, vocR2, vocR3, vocR4);
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(s.split("\\n")));

                    tb.putBoolean("Done", true);
                    tb.putListString("vocListD", vocList);

                    Haupt.this.recreate();
                }

                if (tb.getInt("vocAmount") == 1) {
                    String s = String.format("%s%s", vocR, vocR2);
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(s.split("\\n")));

                    tb.putBoolean("Done", true);
                    tb.putListString("vocListD", vocList);

                    Haupt.this.recreate();
                }

                if (tb.getInt("vocAmount") == 0) {
                    ArrayList<String> vocList = new ArrayList<>(Arrays.asList(vocR0.split("\\n")));

                    tb.putBoolean("Done", true);
                    tb.putListString("vocListD", vocList);

                    Haupt.this.recreate();
                }
            }
        }
        bildVorschau.setImageBitmap(bitmap);
    }

    public String textByTesseract(TextRecognizer recognizer, Bitmap bitmap) {

        String result = null;

        if (!recognizer.isOperational()) {
            Toast.makeText(this, "Fehler", Toast.LENGTH_SHORT).show();
            return result;
        } else {
            Frame frame = new Frame.Builder().setBitmap(bitmap).build();
            SparseArray<TextBlock> items = recognizer.detect(frame);
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < items.size(); i++) {
                TextBlock myItem = items.valueAt(i);
                sb.append(myItem.getValue());
                sb.append("\n");
            }

            result = sb.toString();
            return result;
        }
    }

    public String prepareImage(Intent data) {
        CropImage.ActivityResult res = CropImage.getActivityResult(data);
        assert res != null;
        Uri resUri = res.getUri();

        bildVorschau.setImageURI(resUri);
        BitmapDrawable bitmapDrawable = (BitmapDrawable) bildVorschau.getDrawable();
        Bitmap res1Bitmap = bitmapDrawable.getBitmap();

        TextRecognizer recognizer = new TextRecognizer.Builder(this).build();

        return textByTesseract(recognizer, res1Bitmap);
    }

    public void intentForCropResult(Uri uri, int crop_code) {
        Intent intent = CropImage.activity(uri)
                .setGuidelines(CropImageView.Guidelines.ON_TOUCH)
                .getIntent(getApplicationContext());
        Haupt.this.startActivityForResult(intent, crop_code);
    }

    public Bitmap invert(Bitmap bmp) {
        Mat img = new Mat();
        Utils.bitmapToMat(bmp, img);

        Imgproc.cvtColor(img, img, Imgproc.COLOR_BGR2GRAY);
        Core.bitwise_not(img, img);

        Utils.matToBitmap(img, bmp);
        return bmp;
    }

    private byte saturate(double val) {
        int iVal = (int) Math.round(val);
        iVal = iVal > 255 ? 255 : (Math.max(iVal, 0));
        return (byte) iVal;
    }

    public Mat increaseContrast(Mat img) {
        Mat newImage = Mat.zeros(img.size(), img.type());

        byte[] imageData = new byte[(int) (img.total() * img.channels())];
        img.get(0, 0, imageData);
        byte[] newImageData = new byte[(int) (newImage.total() * newImage.channels())];
        for (int y = 0; y < img.rows(); y++) {
            for (int x = 0; x < img.cols(); x++) {
                for (int c = 0; c < img.channels(); c++) {
                    double pixelValue = imageData[(y * img.cols() + x) * img.channels() + c];
                    pixelValue = pixelValue < 0 ? pixelValue + 256 : pixelValue;
                    newImageData[(y * img.cols() + x) * img.channels() + c]
                            = saturate(0.85 * pixelValue);
                }
            }
        }
        newImage.put(0, 0, newImageData);
        return newImage;
    }

    // SetGrayscale
    private Bitmap setGrayscale(Bitmap img) {
        Bitmap bmap = img.copy(img.getConfig(), true);
        int c;
        for (int i = 0; i < bmap.getWidth(); i++) {
            for (int j = 0; j < bmap.getHeight(); j++) {
                c = bmap.getPixel(i, j);
                byte gray = (byte) (.299 * Color.red(c) + .587 * Color.green(c)
                        + .114 * Color.blue(c));

                bmap.setPixel(i, j, Color.argb(255, gray, gray, gray));
            }
        }
        return bmap;
    }

    // RemoveNoise
    private Bitmap removeNoise(Bitmap img) {
        Bitmap bmap = img.copy(img.getConfig(), true);
        for (int x = 0; x < bmap.getWidth(); x++) {
            for (int y = 0; y < bmap.getHeight(); y++) {
                int pixel = bmap.getPixel(x, y);
                if (Color.red(pixel) < 162 && Color.green(pixel) < 162 && Color.blue(pixel) < 162) {
                    bmap.setPixel(x, y, Color.BLACK);
                }
            }
        }
        for (int x = 0; x < bmap.getWidth(); x++) {
            for (int y = 0; y < bmap.getHeight(); y++) {
                int pixel = bmap.getPixel(x, y);
                if (Color.red(pixel) > 162 && Color.green(pixel) > 162 && Color.blue(pixel) > 162) {
                    bmap.setPixel(x, y, Color.WHITE);
                }
            }
        }
        return bmap;
    }

   /* public Mat deskew(Mat src, double angle) {
        Point center = new Point(src.width()/2, src.height()/2);
        Mat rotImage = Imgproc.getRotationMatrix2D(center, angle, 1.0);
        //1.0 means 100 % scale
        Size size = new Size(src.width(), src.height());
        Imgproc.warpAffine(src, src, rotImage, size, Imgproc.INTER_LINEAR + Imgproc.CV_WARP_FILL_OUTLIERS);
        return src;
    }

    public Bitmap computeSkew(Mat img) {
        img.convertTo(img, CvType.CV_8U);
        Imgproc.cvtColor(img, img, Imgproc.COLOR_BGR2GRAY);

        //Invert the colors (because objects are represented as white pixels, and the background is represented by black pixels)
        Core.bitwise_not( img, img );
        Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new Size(3, 3));

        //We can now perform our erosion, we must declare our rectangle-shaped structuring element and call the erode function
        Imgproc.erode(img, img, element);

        //Find all white pixels
        Mat wLocMat = Mat.zeros(img.size(),img.type());
        Core.findNonZero(img, wLocMat);

        //Create an empty Mat and pass it to the function
        MatOfPoint matOfPoint = new MatOfPoint( wLocMat );

        //Translate MatOfPoint to MatOfPoint2f in order to user at a next step
        MatOfPoint2f mat2f = new MatOfPoint2f();
        matOfPoint.convertTo(mat2f, CvType.CV_32FC2);

        //Get rotated rect of white pixels
        RotatedRect rotatedRect = Imgproc.minAreaRect( mat2f );

        Point[] vertices = new Point[4];
        rotatedRect.points(vertices);
        List<MatOfPoint> boxContours = new ArrayList<>();
        boxContours.add(new MatOfPoint(vertices));
        Imgproc.drawContours( img, boxContours, 0, new Scalar(128, 128, 128), -1);

        double resultAngle = rotatedRect.angle;
        if (rotatedRect.size.width > rotatedRect.size.height)
        {
            rotatedRect.angle += 90.f;
        }

        //Or
        //rotatedRect.angle = rotatedRect.angle < -45 ? rotatedRect.angle + 90.f : rotatedRect.angle;

        Mat result = deskew( img, rotatedRect.angle );
        Bitmap bm = Bitmap.createBitmap(img.cols(), img.rows(), Bitmap.Config.ARGB_8888);
        Utils.matToBitmap(result, bm);

        return bm;
    }*/
    public Bitmap[] set_img_dpi(Bitmap bitImg) {

        OpenCVLoader.initDebug();

        Mat img = new Mat();
        Utils.bitmapToMat(bitImg, img);

        TinyDB tb = new TinyDB(getApplicationContext());
        Bitmap bit = null;
        Bitmap bit2 = null;
        Bitmap bit3 = null;
        Bitmap bit4 = null;

        if (tb.getInt("vocAmount") == 0) {
            bit = Bitmap.createBitmap(img.cols(), img.rows(), Bitmap.Config.ARGB_8888);
            Utils.matToBitmap(img, bit);
        }

        if (tb.getInt("vocAmount") == 1) {
            Rect rect = new Rect(0, 0, img.width(), (img.height() / 2) + (img.height() / 10));
            Mat resized = new Mat(img, rect);

            Rect rect2 = new Rect(0, (img.height() / 2) - (img.height() / 10), img.width(), (img.height() / 2) + (img.height() / 10));
            Mat resized2 = new Mat(img, rect2);

            bit = Bitmap.createBitmap(resized.cols(), resized.rows(), Bitmap.Config.ARGB_8888);
            Utils.matToBitmap(resized, bit);

            bit2 = Bitmap.createBitmap(resized2.cols(), resized2.rows(), Bitmap.Config.ARGB_8888);
            Utils.matToBitmap(resized2, bit2);
        }

        if (tb.getInt("vocAmount") == 2) {
            Rect rect = new Rect(0, 0, img.width(), (img.height() / 4) + (img.height() / 10));
            Mat resized = new Mat(img, rect);

            Rect rect2 = new Rect(0, (img.height() / 4) - (img.height() / 20), img.width(), (img.height() / 4) + (img.height() / 10));
            Mat resized2 = new Mat(img, rect2);

            Rect rect3 = new Rect(0, (img.height() / 2) - (img.height() / 20), img.width(), (img.height() / 4) + (img.height() / 10));
            Mat resized3 = new Mat(img, rect3);

            Rect rect4 = new Rect(0, (img.height() / 4) * 3 - (img.height() / 10), img.width(), (img.height() / 4) + (img.height() / 10));
            Mat resized4 = new Mat(img, rect4);


            bit = Bitmap.createBitmap(resized.cols(), resized.rows(), Bitmap.Config.ARGB_8888);
            bit2 = Bitmap.createBitmap(resized2.cols(), resized2.rows(), Bitmap.Config.ARGB_8888);
            bit3 = Bitmap.createBitmap(resized3.cols(), resized3.rows(), Bitmap.Config.ARGB_8888);
            bit4 = Bitmap.createBitmap(resized4.cols(), resized4.rows(), Bitmap.Config.ARGB_8888);

            Bitmap[] bitmaps = {bit, bit2, bit3, bit4};
            Mat[] mats = {resized, resized2, resized3, resized4};

            for (int i = 0; i < bitmaps.length; i++) {
                Utils.matToBitmap(mats[i], bitmaps[i]);
            }
        }

        return new Bitmap[]{bit, bit2, bit3, bit4};
    }

    /*public Bitmap removeShadow(Mat img){
        Mat satImg;
        Imgproc.cvtColor(img, img, Imgproc.COLOR_RGB2HSV);
        ArrayList<Mat> channels = new ArrayList<>();
        Core.split(img, channels);
        satImg = channels.get(1);

        Imgproc.medianBlur(satImg , satImg , 11);
        Imgproc.adaptiveThreshold(satImg , satImg , 255, Imgproc.ADAPTIVE_THRESH_MEAN_C, Imgproc.THRESH_BINARY, 401, -10);

        Bitmap bit =  Bitmap.createBitmap(img.cols(), img.rows(), Bitmap.Config.ARGB_8888);
        Utils.matToBitmap(satImg, bit);
        return bit;
    }*/
    public Uri getImageUri(Context inContext, Bitmap inImage) {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();

        inImage.compress(Bitmap.CompressFormat.PNG, 100, bytes);
        String path = MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage, "Title", null);

        return Uri.parse(path);
    }
}