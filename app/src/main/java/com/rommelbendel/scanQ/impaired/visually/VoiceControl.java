package com.rommelbendel.scanQ.impaired.visually;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.SpeechRecognizer;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.constraintlayout.widget.ConstraintLayout;

import com.rommelbendel.scanQ.R;

import org.jetbrains.annotations.Nullable;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Objects;


public class VoiceControl {

    private final Context owner;
    private OnCommandListener commandListener;
    private final Activity ownerActivity;
    private final int originalLayoutID;
    private final ConstraintLayout rootLayout;
    private HashMap<String, String> commandAndMethod;

    public VoiceControl(Context owner) {
        this.owner = owner;
        this.ownerActivity = (Activity) this.owner;

        MediaPlayer mediaPlayer = new MediaPlayer();
        mediaPlayer.setVolume(50, 50);

        this.originalLayoutID = this.ownerActivity.findViewById(android.R.id.content).getRootView().getId();
        this.ownerActivity.setContentView(R.layout.visually_impaired_mode_screen);

        this.rootLayout = ownerActivity.findViewById(R.id.visually_impaired_mode_root);
        final Context dialogContext = this.owner;
        final Activity dialogOwnerActivity = this.ownerActivity;
        final int dialogOriginalLayoutID = this.originalLayoutID;
        this.rootLayout.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View v) {
                AlertDialog.Builder exitModeDialog = new AlertDialog.Builder(dialogContext);
                exitModeDialog.setTitle("Hinweis");
                exitModeDialog.setMessage("Wollen Sie den Blindenmodus wirklich beenden?");
                exitModeDialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        setOnCommandListener(null);
                        dialogOwnerActivity.setContentView(dialogOriginalLayoutID);
                        dialog.cancel();
                    }
                });
                exitModeDialog.setNegativeButton("Abbrechen", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();
                    }
                });
                exitModeDialog.show();
                return true;
            }
        });

    }

    public void setOnCommandListener(@Nullable OnCommandListener commandListener) {
        this.commandListener = commandListener;
    }

    public void listen() {
        if (this.commandListener != null) {
            final OnCommandListener commandListener = this.commandListener;
            final SpeechRecognizer speechRecognizer = SpeechRecognizer.createSpeechRecognizer(owner);
            speechRecognizer.setRecognitionListener(new RecognitionListener() {
                @Override
                public void onReadyForSpeech(Bundle params) {

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
                    speechRecognizer.stopListening();
                    informError();
                    listen();
                }

                @Override
                public void onResults(Bundle results) {
                    boolean executed = false;
                    List<String> commands = Objects.requireNonNull(results.getStringArrayList(
                            SpeechRecognizer.RESULTS_RECOGNITION));
                    commands = checkForCommands(commands);
                    if (!commands.isEmpty()) {
                        for (int i = 0; i < commands.size(); i++) {
                            if (commandListener.onCommand(commands.get(i))) {
                                speechRecognizer.stopListening();
                                executed = true;
                                break;
                            }
                        }

                        if (!executed) {
                            commandListener.onCommandNotFound(commands.get(0), commands);
                            speechRecognizer.stopListening();
                            listen();
                        }
                    } else {
                        speechRecognizer.stopListening();
                        listen();
                    }

                }

                @Override
                public void onPartialResults(Bundle partialResults) {
                    boolean executed = false;
                    List<String> commands = Objects.requireNonNull(partialResults.getStringArrayList(
                            SpeechRecognizer.RESULTS_RECOGNITION));
                    commands = checkForCommands(commands);
                    if (!commands.isEmpty()) {
                        for (int i = 0; i < commands.size(); i++) {
                            if (commandListener.onCommand(commands.get(i))) {
                                speechRecognizer.stopListening();
                                executed = true;
                                break;
                            }
                        }

                        if (!executed) {
                            commandListener.onCommandNotFound(commands.get(0), commands);
                            speechRecognizer.stopListening();
                            listen();
                        }
                    } else {
                        speechRecognizer.stopListening();
                        listen();
                    }
                }

                @Override
                public void onEvent(int eventType, Bundle params) {

                }
            });

            speechRecognizer.startListening(new Intent());
        }
    }

    // TO DO: variables Aktivierungswort mit TinyDB String und Namen vorlesen bei Appstart
    private List<String> checkForCommands(List<String> results) {
        List<String> possibleCommands = new ArrayList<>();
        for (int i = 0; i < results.size(); i++) {
            String result = results.get(i);
            if (result.split(" ")[0].toLowerCase().equals("trainer")) {
                possibleCommands.add(result.replace("trainer ", ""));
            }
        }
        return possibleCommands;
    }

    private OnCommandListener findCommandMethods() {
        this.commandAndMethod = new HashMap<>();
        OnCommandListener onCommandListener;
        Method[] methods = this.owner.getClass().getMethods();
        for (Method method: methods) {
            if (method.isAnnotationPresent(DoOnVoiceCommand.class)) {
                DoOnVoiceCommand doOnVoiceCommand = method.getAnnotation(DoOnVoiceCommand.class);
                String command = doOnVoiceCommand.commands()[0];
                if (command.equals("")) {
                    command = method.getName();
                }
                this.commandAndMethod.put(command, method.getName());
            }
        }

        onCommandListener = new OnCommandListener() {
            @Override
            public boolean onCommand(String command) {
                if (VoiceControl.this.commandAndMethod.containsKey(command)) {
                    try {
                        Method method = VoiceControl.this.owner.getClass().getMethod(
                                VoiceControl.this.commandAndMethod.get(command.toLowerCase()));
                        method.invoke(VoiceControl.this.owner);
                    } catch (NoSuchMethodException | IllegalAccessException |
                            InvocationTargetException | SecurityException e) {
                        e.printStackTrace();
                    }
                    return true;
                } else {
                    return false;
                }
            }

            @Override
            public void onCommandNotFound(String mostLikelyCommand, List<String> possibleCommands) {
                VoiceControl.this.informCommandNotFound();
            }
        };

        return onCommandListener;
    }

    private List<HashMap<Integer, String>> findTextToRead() throws IllegalArgumentException {
        HashMap<Integer, String> textsGerman = new HashMap<>();
        HashMap<Integer, String> textsEnglish = new HashMap<>();

        Field[] fields = this.owner.getClass().getFields();
        for (Field field : fields) {
            if (field.isAnnotationPresent(ReadOut.class)) {
                ReadOut readOut = field.getAnnotation(ReadOut.class);
                if (readOut.language().equals("DE")) {
                    try {
                        textsGerman.put(readOut.position(), getTextFromField(field));
                    } catch (IllegalAccessException e) {
                        textsGerman.put(readOut.position(), "");
                        e.printStackTrace();
                    }
                } else if (readOut.language().equals("EN")) {
                        try {
                            textsEnglish.put(readOut.position(), getTextFromField(field));
                        } catch (IllegalAccessException e) {
                            textsEnglish.put(readOut.position(), "");
                            e.printStackTrace();
                        }
                } else {
                    throw new IllegalArgumentException();
                }
            }
        }
        List<HashMap<Integer, String>> texts = new ArrayList<>();
        texts.add(textsGerman);
        texts.add(textsEnglish);
        return texts;
    }

    private String getTextFromField(Field field) throws IllegalAccessException {
        String text;
        if (field.getType().isAssignableFrom(String.class)) {
            text = (String) field.get(field);

        } else if (field.getType().isAssignableFrom(TextView.class)) {
            text = (String) ((TextView) field.get(field)).getText();
        } else {
            text = "";
        }
        return text;
    }

    private void informError() {
        final TextToSpeech textToSpeech = new TextToSpeech(owner, new OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    Log.d("TTS", "initialized");
                } else {
                    Log.d("TTS", "error");
                }
            }
        });

        textToSpeech.setLanguage(Locale.GERMANY);
        textToSpeech.speak("Fehler bei der Spracherkennung",
                TextToSpeech.QUEUE_FLUSH, null, null);
        textToSpeech.shutdown();
    }

    public void informCommandNotFound() {
        final TextToSpeech textToSpeech = new TextToSpeech(owner, new OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    Log.d("TTS", "initialized");
                } else {
                    Log.d("TTS", "error");
                }
            }
        });

        textToSpeech.setLanguage(Locale.GERMANY);
        textToSpeech.speak("Kommando nicht gefunden",
                TextToSpeech.QUEUE_FLUSH, null, null);
        textToSpeech.shutdown();
    }

    public void informHelpNeeded() {
        final TextToSpeech textToSpeech = new TextToSpeech(owner, new OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    Log.d("TTS", "initialized");
                } else {
                    Log.d("TTS", "error");
                }
            }
        });

        textToSpeech.setLanguage(Locale.GERMANY);
        textToSpeech.speak("Bitte lassen Sie sich von einem Sehenden helfen.",
                TextToSpeech.QUEUE_FLUSH, null, null);
        textToSpeech.shutdown();
    }

    public void informVoiceControlActive() {
        Toast.makeText(owner, "Sprachsteuerung aktiv", Toast.LENGTH_SHORT).show();

        final TextToSpeech textToSpeech = new TextToSpeech(owner, new OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    Log.d("TTS", "initialized");
                } else {
                    Log.d("TTS", "error");
                }
            }
        });

        textToSpeech.setLanguage(Locale.GERMANY);
        textToSpeech.speak("Sprachsteuerung aktiv",
                TextToSpeech.QUEUE_FLUSH, null, null);
        textToSpeech.shutdown();
    }

}
