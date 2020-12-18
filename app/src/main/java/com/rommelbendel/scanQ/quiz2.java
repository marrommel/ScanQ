package com.rommelbendel.firstapp;

import androidx.appcompat.app.AppCompatActivity;

public class quiz2 extends AppCompatActivity {

   /* private TextView points2, vocE,  richtigText, falschText, sucsess, countR, countW;
    private EditText loesung, vocEdit;
    private TextInputLayout layoutloesung;
    private Button check;
    private MaterialButton restart, save;
    private ImageButton prevoius, next;
    private CardView richtig, falsch, mainCard, resultCard;
    private final List<Vokabel> vocabList = new ArrayList<>();

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz2);

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        List<Vokabel> list = db.vokabelnDao().getAlle();
        this.vocabList.addAll(list);

        final SharedPreferences mSPR = quiz2.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor editor = mSPR.edit();
        editor.putInt("myKey1", 0);
        editor.apply();

        final SharedPreferences sharedPref = quiz2.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor edit = sharedPref.edit();
        edit.putInt("vocKey2", 0);
        edit.apply();

        layoutloesung = findViewById(R.id.loesungEBox);
        loesung = findViewById(R.id.loesungE);
        check = findViewById(R.id.check);
        richtig = findViewById(R.id.richtig);
        falsch = findViewById(R.id.falsch);
        vocE = findViewById(R.id.vocD);
        vocEdit = findViewById(R.id.vocDEdit);
        points2 = findViewById(R.id.points2);
        sucsess = findViewById(R.id.succsess2);
        countR = findViewById(R.id.countRight2);
        countW = findViewById(R.id.countWrong2);
        resultCard = findViewById(R.id.resultCard2);
        resultCard.setVisibility(View.GONE);
        mainCard = findViewById(R.id.mainCard2);
        restart = findViewById(R.id.restart2);
        prevoius = findViewById(R.id.quiz2left);
        next = findViewById(R.id.quiz2right);
        richtigText = findViewById(R.id.right2);
        falschText = findViewById(R.id.wrong2);
        save = findViewById(R.id.editButton);

        mainCard.setVisibility(View.VISIBLE);
        richtig.setVisibility(View.GONE);
        falsch.setVisibility(View.GONE);

        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final int currentPoints = mSPR.getInt("myKey1",0);
                int newPoint = currentPoints+1;
                String rightVoc = db.vokabelnDao().getAntwortDE(vocE.getText().toString());
                boolean antwort = loesung.getText().toString().toLowerCase().trim().equals(rightVoc.trim().toLowerCase());
                String textRichtig =vocE.getText().toString() + "= " + rightVoc;
                layoutloesung.setVisibility(View.GONE);
                check.setVisibility(View.GONE);
                if(antwort){
                    richtig.setVisibility(View.VISIBLE);
                    richtigText.setText(textRichtig);
                    points2.setText(String.valueOf(newPoint));
                    editor.putInt("myKey1", newPoint);
                    editor.apply();
                    final int vocId = db.vokabelnDao().getIdByEn(vocE.getText().toString());
                    insert(vocId, 1);
                }else{
                    falsch.setVisibility(View.VISIBLE);
                    falschText.setText(textRichtig);
                    final int vocId = db.vokabelnDao().getIdByEn(vocE.getText().toString());
                    insert(vocId, 2);
                }
            }
        });

        prevoius.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(vocE.getVisibility() == View.VISIBLE) {
                    switchQuestions(-1);
                } else if(vocE.getVisibility() == View.GONE) {
                    //Text der Nachricht sollte umgeschrieben werden
                    Toast.makeText(quiz2.this, "Vokabel wird beareitet...", Toast.LENGTH_SHORT).show();
                }
            }
        });

        next.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(vocE.getVisibility() == View.VISIBLE) {
                    switchQuestions(1);
                } else if(vocE.getVisibility() == View.GONE) {
                    //Text der Nachricht sollte umgeschrieben werden
                    Toast.makeText(quiz2.this, "Vokabel wird beareitet...", Toast.LENGTH_SHORT).show();
                }
            }
        });

        restart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(quiz2.this, quiz2.class);
                startActivity(intent);
                finish();
                final SharedPreferences mySPR = quiz2.this.getPreferences(Context.MODE_PRIVATE);
                final SharedPreferences.Editor editor = mySPR.edit();
                editor.putInt("myKey1", 0);
                editor.apply();

                final Datenbank db = Room.databaseBuilder(quiz2.this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
                for(int i=0; i<vocabList.size(); i++) {
                    db.vokabelnDao().updateAnswered(vocabList.get(i).getId(), 0);
                    db.vokabelnDao().updateMarkierung(vocabList.get(i).getVokabelDE(), false);
                }
            }
        });

        vocE.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                String[] items;
                final boolean markiert = db.vokabelnDao().isMarkiertEng(vocE.getText().toString());
                if(!markiert) {
                    items = new String[]{" Vokabel markieren", " Vokabel bearbeiten"};
                } else {
                    items = new String[]{" Markierung aufheben", " Vokabel bearbeiten"};
                }
                AlertDialog.Builder dialog = new AlertDialog.Builder(quiz2.this);
                dialog.setItems(items, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if ( i == 0){
                            if(markiert) {
                                db.vokabelnDao().updateMarkierungEng(vocE.getText().toString(), false);
                                vocE.setTextColor(Color.parseColor("#219a95"));
                                Toast.makeText(quiz2.this, "Markierung erfolgreich entfernt", Toast.LENGTH_SHORT).show();
                            }
                            else {
                                db.vokabelnDao().updateMarkierungEng(vocE.getText().toString(), true);
                                vocE.setTextColor(Color.parseColor("#FF00FF"));
                                Toast.makeText(quiz2.this, "Vokabel erfolgreich markiert", Toast.LENGTH_SHORT).show();
                            }
                        }
                        if( i == 1){
                            vocE.setVisibility(View.GONE);
                            vocEdit.setText(vocE.getText().toString());
                            save.setVisibility(View.VISIBLE);
                            layoutloesung.setVisibility(View.GONE);
                            check.setVisibility(View.GONE);
                            vocEdit.setVisibility(View.VISIBLE);
                        }
                    }
                });
                dialog.create().show();
                return false;
            }
        });

        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //Update der Vokabel in Datenbank
                vocE.setVisibility(View.VISIBLE);
                check.setVisibility(View.VISIBLE);
                layoutloesung.setVisibility(View.VISIBLE);
                vocEdit.setVisibility(View.GONE);
                save.setVisibility(View.GONE);
                //if(Update ist erfolgreich)
                Toast.makeText(quiz2.this, "Vokabel erfolgreich geändert", Toast.LENGTH_SHORT).show();
            }
        });
    }
    @Override
    public void onDestroy() {
        super.onDestroy();
        SharedPreferences mySPR = getSharedPreferences("point2", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }

    @Override
    protected void onStop() {
        super.onStop();
        SharedPreferences mySPR = getSharedPreferences("point2", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }

    private void insert(int id, int answerId) {
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        db.vokabelnDao().updateAnswered(id, answerId);
    }

    void switchQuestions(int value){
        final SharedPreferences sharedPref = quiz2.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor edit = sharedPref.edit();
        final int currentvoc = sharedPref.getInt("vocKey2", 0);
        int newVoc = currentvoc + value;
        if(newVoc >= vocabList.size()) {
            newVoc = 0;
        }
        if(newVoc < 0) {
            newVoc = vocabList.size()-1;
        }
        edit.putInt("vocKey2", newVoc);
        edit.apply();

        vocE.setText(vocabList.get(newVoc).getVokabelENG());

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        final int vocId = db.vokabelnDao().getIdByEn(vocE.getText().toString());
        final int answered = db.vokabelnDao().getAnswered(vocId);
        String rightVoc = db.vokabelnDao().getAntwortDE(vocE.getText().toString());
        String textRichtig =vocE.getText().toString() + "= " + rightVoc;

        if(answered == 0) {
            richtig.setVisibility(View.GONE);
            falsch.setVisibility(View.GONE);
            check.setVisibility(View.VISIBLE);
            layoutloesung.setVisibility(View.VISIBLE);
            loesung.setText("");
        } else if(answered ==  1){
            check.setVisibility(View.GONE);
            layoutloesung.setVisibility(View.GONE);
            richtig.setVisibility(View.VISIBLE);
            richtigText.setText(textRichtig);
        } else if(answered == 2){
            check.setVisibility(View.GONE);
            layoutloesung.setVisibility(View.GONE);
            falsch.setVisibility(View.VISIBLE);
            falschText.setText(textRichtig);
        }

        final List<Vokabel> alreadyAnswered = db.vokabelnDao().getAlreadyAnswered(0);
        if (alreadyAnswered.size() == 0) {
            quizResult();
        }

        final boolean markiert = db.vokabelnDao().isMarkiertEng(vocE.getText().toString());
        if(markiert) {
            vocE.setTextColor(Color.parseColor("#FF00FF"));
        } else {
            vocE.setTextColor(Color.parseColor("#219a95"));
        }
    }

    private void quizResult() {
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        final int rightAnswered = db.vokabelnDao().getAlreadyAnswered(1).size();
        final int wrongAnswered = vocabList.size() - rightAnswered;
        mainCard.setVisibility(View.GONE);
        resultCard.setVisibility(View.VISIBLE);
        if (rightAnswered >= wrongAnswered) {
            sucsess.setText("Gratulation!");
        } else {
            sucsess.setText("Schade!");
        }
        countR.setText(rightAnswered + " Fragen richtig");
        countW.setText(wrongAnswered + " Fragen falsch");
    }*/
}
