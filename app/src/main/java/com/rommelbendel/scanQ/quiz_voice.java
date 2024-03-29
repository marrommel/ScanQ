package com.rommelbendel.scanQ;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.os.Vibrator;
import android.speech.RecognitionListener;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.google.android.material.button.MaterialButton;

import java.util.Collections;
import java.util.List;
import java.util.Objects;


public class quiz_voice extends AppCompatActivity{

    private ImageButton button_voice_input;
    private TextView vokabelAnzeige;
    private Button button_ok;
    private Button button_bearbeiten;
    private ImageButton button_next;
    private ImageButton button_previous;
    private EditText answer_text;
    private TextView points;
    private CardView quizCard;
    private LinearLayout quizLayout;
    private CardView resultCard;
    private TextView resultRichtig;
    private TextView resultFalsch;
    private MaterialButton button_restart;

    private boolean recordAudio;
    private SpeechRecognizer speechRecognizer;
    private VokabelViewModel vokabelViewModel;
    private LiveData<List<Vokabel>> alleVokabelnLiveData;
    private List<Vokabel> quizFrageVokabeln; //diese Liste wird durchgegangen
    private Bundle frage_und_antwort; //Speicher für die Antworten
    private int frageNummer = 0;
    private String language_from = "DE";
    private int punkte = 0;

    //private float x1,x2;
    //private final int WIPE_MIN = 120;


    private final ActivityResultLauncher<String> requestPermissionLauncher =
            registerForActivityResult(new ActivityResultContracts.RequestPermission(), new ActivityResultCallback<Boolean>() {
                @Override
                public void onActivityResult(Boolean isGranted) {
                    if (isGranted) {
                        recordAudio = true;
                    } else {
                        recordAudio = false;
                        AlertDialog.Builder featureUnaviable = new AlertDialog.Builder(quiz_voice.this);
                        featureUnaviable.setTitle("nicht verfügbar");
                        featureUnaviable.setMessage("Dieses Quiz benötigt Zugriff auf das Mikrophon um vollständig zu funktionieren.");
                        featureUnaviable.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.cancel();
                            }
                        });
                        featureUnaviable.show();
                    }
                }
            });


    @SuppressLint("ClickableViewAccessibility")
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quiz_voice);

        button_voice_input = findViewById(R.id.button_voice_record);
        vokabelAnzeige = findViewById(R.id.voc);
        button_ok = findViewById(R.id.button_OK);
        button_bearbeiten = findViewById(R.id.button_bearbeiten);
        answer_text = findViewById(R.id.input_voice_to_text);
        button_next = findViewById(R.id.quizright);
        button_previous = findViewById(R.id.quizleft);
        points = findViewById(R.id.points);
        resultCard = findViewById(R.id.resultCard1);
        quizCard = findViewById(R.id.questionCard1);
        quizLayout = findViewById(R.id.frage_layout);
        resultRichtig = findViewById(R.id.countRight);
        resultFalsch = findViewById(R.id.countWrong);
        button_restart = findViewById(R.id.restart1);

        resultCard.setVisibility(View.INVISIBLE);

        vokabelViewModel = new ViewModelProvider(this).get(VokabelViewModel.class);
        alleVokabelnLiveData = vokabelViewModel.getAlleVokabeln();

        alleVokabelnLiveData.observe(this, new Observer<List<Vokabel>>() {
            @Override
            public void onChanged(List<Vokabel> vokabeln) {
                if (vokabeln != null) {
                    if (vokabeln.size() != 0) {
                        quizFrageVokabeln = alleVokabelnLiveData.getValue();
                        assert quizFrageVokabeln != null;
                        Collections.shuffle(quizFrageVokabeln);
                        startQuiz();
                    } else {
                        AlertDialog.Builder warnung = new AlertDialog.Builder(quiz_voice.this);
                        warnung.setTitle("Quiz kann nicht gestartet werden");
                        warnung.setMessage("Es sind keine Vokabeln vorhanden.");
                        warnung.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.cancel();
                                Intent backIntent = new Intent(quiz_voice.this, home.class);
                                quiz_voice.this.startActivity(backIntent);
                                finish();
                            }
                        });
                        warnung.show();
                    }
                }
            }
        });

        button_voice_input.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                v.onTouchEvent(event);
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        if (checkRecordAudioPermission()) {
                            speechRecognizer = SpeechRecognizer.createSpeechRecognizer(quiz_voice.this);
                            speechRecognizer.setRecognitionListener(new RecognitionListener() {
                                @RequiresApi(api = Build.VERSION_CODES.R)
                                @Override
                                public void onReadyForSpeech(Bundle params) {
                                    ((Vibrator) getSystemService(VIBRATOR_SERVICE)).vibrate(50);
                                    answer_text.setBackgroundColor(Color.parseColor("#107575"));
                                    answer_text.setTextColor(Color.parseColor("#ffffff"));
                                    Toast.makeText(quiz_voice.this, "Aufnahme gestartet", Toast.LENGTH_SHORT).show();
                                }

                                @Override
                                public void onBeginningOfSpeech() {

                                }

                                @Override
                                public void onRmsChanged(float rmsdB) {

                                }

                                @Override
                                public void onBufferReceived(byte[] buffer) {

                                }

                                @Override
                                public void onEndOfSpeech() {

                                }

                                @Override
                                public void onError(int error) {
                                    Toast.makeText(quiz_voice.this, "Fehler bei der Aufnahme", Toast.LENGTH_SHORT).show();
                                }

                                @Override
                                public void onResults(Bundle results) {
                                    String answer = Objects.requireNonNull(results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)).get(0);
                                    answer_text.setText(answer);
                                }

                                @Override
                                public void onPartialResults(Bundle partialResults) {
                                    String answer = Objects.requireNonNull(partialResults.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)).get(0);
                                    answer_text.setText(answer);
                                }

                                @Override
                                public void onEvent(int eventType, Bundle params) {

                                }
                            });
                            speechRecognizer.startListening(new Intent());
                        } else {
                            requestRecordAudioPermission();
                        }
                        return true;

                    case MotionEvent.ACTION_UP:
                        v.performClick();
                        speechRecognizer.stopListening();
                        ((Vibrator) getSystemService(VIBRATOR_SERVICE)).vibrate(50);
                        answer_text.setBackgroundColor(Color.parseColor("#ffffff"));
                        answer_text.setTextColor(Color.parseColor("#107575"));
                        Toast.makeText(quiz_voice.this, "Aufnahme beendet", Toast.LENGTH_SHORT).show();
                        return true;
                }
                return false;
            }
        });

    }

    @SuppressLint("ClickableViewAccessibility")
    private void startQuiz() {

        alleVokabelnLiveData.removeObservers(this);

        alleVokabelnLiveData.observe(this, new Observer<List<Vokabel>>() {
            @Override
            public void onChanged(List<Vokabel> vokabeln) {
                Log.d("Data has changed", "alleVokabelnLiveData has changed");
                int changeIndex = -1;
                if (vokabeln.size() == quizFrageVokabeln.size()) {
                    Log.d("Observer", "change");
                    for (int i = 0; i < quizFrageVokabeln.size(); i++) {
                        if (!vokabeln.contains(quizFrageVokabeln.get(i))) {
                            quizFrageVokabeln.remove(i);
                            changeIndex = i;
                            break;
                        }
                    }
                    for (int i = 0; i < vokabeln.size(); i++) {
                        if (!quizFrageVokabeln.contains(vokabeln.get(i))) {
                            Vokabel neueVokabel = vokabeln.get(i);
                            if (changeIndex != -1) {
                                quizFrageVokabeln.add(changeIndex, neueVokabel);
                            } else {
                                quizFrageVokabeln.add(neueVokabel);
                            }
                            break;
                        }
                    }
                } else if (quizFrageVokabeln.size() < vokabeln.size()){
                    for (int i = 0; i < vokabeln.size(); i++) {
                        if (!quizFrageVokabeln.contains(vokabeln.get(i))) {
                            quizFrageVokabeln.add(vokabeln.get(i));
                            Log.d("Observer", "add");
                            break;
                        }
                    }

                } else {
                    for (int i = 0; i < quizFrageVokabeln.size(); i++) {
                        if (!vokabeln.contains(quizFrageVokabeln.get(i))) {
                            quizFrageVokabeln.remove(i);
                            Log.d("Observer", "remove");
                            break;
                        }
                    }

                }

            }
        });

        frage_und_antwort = new Bundle();

        button_next.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                nextQuestion();
            }
        });

        button_previous.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                previousQuestion();
            }
        });

        button_ok.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checkAnswer();
            }
        });

        button_bearbeiten.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final AlertDialog.Builder optionsDialog = new AlertDialog.Builder(quiz_voice.this);
                optionsDialog.setTitle("Was möchtest du machen?");

                String[] options = {"löschen", "markieren", "bearbeiten"};
                optionsDialog.setItems(options, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        switch (which) {
                            case 0:
                                Toast.makeText(quiz_voice.this, "Vokabel löschen", Toast.LENGTH_SHORT).show();
                                vokabelViewModel.deleteVokabel(quizFrageVokabeln.get(frageNummer - 1));
                                nextQuestion();
                                break;
                            case 1:
                                Toast.makeText(quiz_voice.this, "markieren", Toast.LENGTH_SHORT).show();
                                break;
                            case 2:
                                Toast.makeText(quiz_voice.this, "bearbeiten", Toast.LENGTH_SHORT).show();
                                break;
                        }
                        dialog.cancel();
                    }
                });
                optionsDialog.show();
            }
        });

        /*
        quizLayout.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        x1 = event.getX();
                        break;
                    case MotionEvent.ACTION_UP:
                        x2 = event.getX();
                        if (Math.abs(x2 - x1) >= WIPE_MIN) {
                            if (x1 < x2) {  //nach rechts
                                previousQuestion();
                            } else {    //nach links
                                nextQuestion();
                            }
                        }
                        break;
                }
                return quiz_voice.super.onTouchEvent(event);
            }
        });
         */

        nextQuestion();
    }

    private void nextQuestion() {
        if (frageNummer == quizFrageVokabeln.size()) {
            frageNummer = 1;
        } else {
            frageNummer ++;
        }
        prepareQuestion();
        Vokabel vokabel = quizFrageVokabeln.get(frageNummer - 1);
        setQuestion(vokabel);
    }

    private void previousQuestion() {
        if (frageNummer == 1) {
            frageNummer = quizFrageVokabeln.size();
        } else {
            frageNummer --;
        }
        prepareQuestion();
        Vokabel vokabel = quizFrageVokabeln.get(frageNummer - 1);
        setQuestion(vokabel);
    }

    private void prepareQuestion() {
        if (language_from.equals("DE")) {
            if (frage_und_antwort.containsKey(quizFrageVokabeln.get(frageNummer - 1).getVokabelDE())) {
                String answer = frage_und_antwort.getString(quizFrageVokabeln.get(frageNummer - 1).getVokabelDE());
                answer_text.setText(answer);
                button_voice_input.setEnabled(false);
                button_ok.setEnabled(false);
                answer_text.setEnabled(false);
                if (quizFrageVokabeln.get(frageNummer - 1).getVokabelENG().equals(answer)) {
                    quizLayout.setBackgroundColor(Color.rgb(88, 214, 141));
                    Log.d("prepareQuestion", "Frage richtig");
                } else {
                    quizLayout.setBackgroundColor(Color.rgb(236, 112, 99));
                    Log.d("prepareQuestion", "Frage falsch");
                }
            } else {
                answer_text.setText("");
                button_voice_input.setEnabled(true);
                button_ok.setEnabled(true);
                answer_text.setEnabled(true);
                quizLayout.setBackgroundColor(Color.WHITE);
            }
        } else {
            if (frage_und_antwort.containsKey(quizFrageVokabeln.get(frageNummer - 1).getVokabelENG())) {
                String answer = frage_und_antwort.getString(quizFrageVokabeln.get(frageNummer - 1).getVokabelENG());
                answer_text.setText(answer);
                button_voice_input.setEnabled(false);
                button_ok.setEnabled(false);
                answer_text.setEnabled(false);
                if (quizFrageVokabeln.get(frageNummer - 1).getVokabelDE().equals(answer)) {
                    quizLayout.setBackgroundColor(Color.rgb(88, 214, 141));
                } else {
                    quizLayout.setBackgroundColor(Color.rgb(236, 112, 99));
                }
            } else {
                answer_text.setText("");
                button_voice_input.setEnabled(true);
                button_ok.setEnabled(true);
                answer_text.setEnabled(true);
                quizLayout.setBackgroundColor(Color.WHITE);
            }
        }
    }

    private void setQuestion(Vokabel vokabel) {
        String anzeige;
        if (language_from.equals("DE")) {
            anzeige = vokabel.getVokabelDE();
        } else {
            anzeige = vokabel.getVokabelENG();
        }
        vokabelAnzeige.setText(anzeige);

        /*
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            TextToSpeech tts = new TextToSpeech(quiz_voice.this, new TextToSpeech.OnInitListener() {
                @Override
                public void onInit(int status) {
                    if (status == TextToSpeech.SUCCESS) {
                        Log.d("TTS", "initialisierung erfolgreich");
                    } else {
                        Log.d("TTS", "initialisierung fehlgeschlagen");
                    }
                }
            });
            tts.setLanguage(Locale.GERMAN);
            tts.speak(anzeige, TextToSpeech.QUEUE_ADD, null);
        }
         */

    }

    @SuppressLint("DefaultLocale")
    private void checkAnswer() {
        button_voice_input.setEnabled(false);
        button_ok.setEnabled(false);
        answer_text.setEnabled(false);
        String antwort = answer_text.getText().toString().trim();
        String loesung;
        Vokabel frageVokabel = quizFrageVokabeln.get(frageNummer -1);
        if (language_from.equals("DE")) {
            frage_und_antwort.putString(frageVokabel.getVokabelDE(), antwort);
            loesung = frageVokabel.getVokabelENG();
        } else {
            frage_und_antwort.putString(frageVokabel.getVokabelENG(), antwort);
            loesung = frageVokabel.getVokabelDE();
        }

        Log.d("checkAnswer", antwort + " == " + loesung);

        if (antwort.equals(loesung)) {
            givePoint();
            quizLayout.setBackgroundColor(Color.rgb(88, 214, 141));
        } else {
            quizLayout.setBackgroundColor(Color.rgb(236, 112, 99));
        }

        boolean solved = true;
        for (int i = 0; i < quizFrageVokabeln.size(); i++) {
            if (language_from.equals("DE")) {
                if (!frage_und_antwort.containsKey(quizFrageVokabeln.get(i).getVokabelDE())) {
                    solved = false;
                    break;
                }
            } else {
                if (!frage_und_antwort.containsKey(quizFrageVokabeln.get(i).getVokabelENG())) {
                    solved = false;
                    break;
                }
            }
        }
        if (solved) {
            button_bearbeiten.setEnabled(false);
            button_next.setEnabled(false);
            button_previous.setEnabled(false);

            resultRichtig.setText(String.format("%d Fragen richtig", punkte));
            resultFalsch.setText(String.format("%d Fragen falsch", quizFrageVokabeln.size() - punkte));

            resultCard.setVisibility(View.VISIBLE);
            quizCard.setVisibility(View.INVISIBLE);

            button_restart.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent restart = new Intent(quiz_voice.this, quiz_voice.class);
                    quiz_voice.this.startActivity(restart);
                }
            });
        }

    }

    private void givePoint() {
        punkte ++;
        points.setText(String.valueOf(punkte));
        Log.d("Punkte", String.valueOf(punkte));
    }

    private boolean checkRecordAudioPermission() {
        return ContextCompat.checkSelfPermission(quiz_voice.this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED;
    }

    private void requestRecordAudioPermission() {
        requestPermissionLauncher.launch(Manifest.permission.RECORD_AUDIO);
    }

}
