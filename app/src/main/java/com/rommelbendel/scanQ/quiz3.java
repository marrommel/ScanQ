package com.rommelbendel.firstapp;

import androidx.appcompat.app.AppCompatActivity;

public class quiz3 extends AppCompatActivity {
   /* private TextView points3, vocD;
    private EditText loesung;
    private TextInputLayout layoutloesung;
    private Button check;
    private ImageButton previous, next;
    private CardView richtig, falsch;
    private final List<Vokabel> vocabList = new ArrayList<>();

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz3);

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        List<Vokabel> list = db.vokabelnDao().getAlle();
        this.vocabList.addAll(list);

        points3 = findViewById(R.id.points3);

        SharedPreferences mSPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mSPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();

        String currPoints = mSPR.getString("myKey1","");
        assert currPoints != null;
        final int currentPoints = Integer.parseInt(currPoints);

        layoutloesung = findViewById(R.id.loesungEBox);
        loesung = findViewById(R.id.loesungE);
        check = findViewById(R.id.check);
        richtig = findViewById(R.id.richtig);
        falsch = findViewById(R.id.falsch);
        previous = findViewById(R.id.quiz3left);
        next = findViewById(R.id.quiz3right);
        vocD = findViewById(R.id.vocD);

        richtig.setVisibility(View.GONE);
        falsch.setVisibility(View.GONE);

        previous.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                    vocD.setText(vocabList.get(1).getVokabelDE());
            }
        });

        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int newPoint = currentPoints+1;
                if(loesung.getText().toString().toLowerCase().trim().equals(vocabList.get(1).getVokabelENG())){
                    layoutloesung.setVisibility(View.GONE);
                    check.setVisibility(View.GONE);
                    richtig.setVisibility(View.VISIBLE);
                    points3.setText(String.valueOf(newPoint));
                    editor.putString("myKey1", String.valueOf(newPoint));
                    editor.apply();
                }else{
                    layoutloesung.setVisibility(View.GONE);
                    check.setVisibility(View.GONE);
                    falsch.setVisibility(View.VISIBLE);
                }
            }
        });
    }
    @Override
    public void onDestroy() {
        super.onDestroy();
        SharedPreferences mySPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }

    @Override
    protected void onStop() {
        super.onStop();
        SharedPreferences mySPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }*/
}

