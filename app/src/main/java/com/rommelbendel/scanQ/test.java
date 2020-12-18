package com.rommelbendel.firstapp;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.SparseArray;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.palette.graphics.Palette;

import com.google.android.gms.vision.Frame;
import com.google.android.gms.vision.text.Text;
import com.google.android.gms.vision.text.TextBlock;
import com.google.android.gms.vision.text.TextRecognizer;
import com.theartofdev.edmodo.cropper.CropImage;
import com.theartofdev.edmodo.cropper.CropImageView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;

public class test extends AppCompatActivity {

    class RectEdit extends View {
        private Canvas canvas;
        private ArrayList<int[]> dims;
        private List<Integer> pos;
        private int[] dim;
        private Paint paint;
        private int color = Color.BLACK;

        public RectEdit(Context context, Canvas canvas, ArrayList<int[]> dims, Paint paint, List<Integer> pos) {
            super(context);
            this.canvas = canvas;
            this.dims = dims;
            this.pos = pos;
            this.paint = paint;
        }

        public RectEdit(Context context, Canvas canvas, int[] dim, Paint paint) {
            super(context);
            this.canvas = canvas;
            this.dim = dim;
            this.paint = paint;
        }

        @RequiresApi(api = Build.VERSION_CODES.Q)
        public RectF draw() {
            //invalidate();
            RectF rect = new RectF(dim[0], dim[1], dim[2], dim[3]);
            paint.setColor(Color.WHITE);
            canvas.drawRect(rect, paint);

            return rect;
        }

        public void add(int color) {
            for(int d = 0; d < pos.size(); d++) {


                RectF rect = new RectF(dims.get(pos.get(d))[0], dims.get(pos.get(d))[1], dims.get(pos.get(d))[2], dims.get(pos.get(d))[3]);
                paint.setColor(color);
                canvas.drawRect(rect, paint);
            }
        }
    }

    ImageView bildVorschau;
    Button speichern;
    ArrayList<RectF> rectFS;

    private static final int CAMERA_REQUEST_CODE = 200;
    private static final int STORAGE_REQUEST_CODE = 400;
    private static final int IMAGE_PICK_GALLERY_CODE = 1000;

    private static final int FIRST_CROP = 101;

    String[] storagePermission;

    @SuppressLint("ClickableViewAccessibility")
    @Override
    protected void onCreate(Bundle savedInstaceState) {
        super.onCreate(savedInstaceState);
        setContentView(R.layout.activity_haupt);

        bildVorschau = findViewById(R.id.bildVorschau);
        speichern = findViewById(R.id.speichern);

        storagePermission = new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE};

        Intent getintent = getIntent();
        int gal_id = getintent.getIntExtra("gal_key", 0);

        if (gal_id == 110011) {
            pickGallery();
        }

        speichern.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pickGallery();
            }
        });
    }

    private void pickGallery() {
        Intent intent = new Intent(Intent.ACTION_PICK);
        intent.setType("image/*");
        startActivityForResult(intent, IMAGE_PICK_GALLERY_CODE);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        switch (requestCode) {
            case CAMERA_REQUEST_CODE:
                break;

            case STORAGE_REQUEST_CODE:
                if (grantResults.length > 0) {
                    boolean writeStorageAccepted = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;
                    if (writeStorageAccepted) {
                        pickGallery();
                    } else {
                        Toast.makeText(this, "Berechtigung fehlt!", Toast.LENGTH_SHORT).show();
                    }
                }
                break;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.Q)
    @SuppressLint("ClickableViewAccessibility")
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (resultCode == RESULT_OK) {
            if (requestCode == IMAGE_PICK_GALLERY_CODE) {
                assert data != null;
                intentForCropResult(data.getData(), FIRST_CROP);
            }
        }
        if (requestCode == FIRST_CROP) {
            CropImage.ActivityResult ergebnis = CropImage.getActivityResult(data);

            if (resultCode == RESULT_OK) {
                assert ergebnis != null;
                Uri ergebnisUri = ergebnis.getUri();
                Rect size = ergebnis.getCropRect();
                //bildVorschau.getLayoutParams().height = size.height();
                //bildVorschau.getLayoutParams().width = size.width();
                bildVorschau.setImageURI(ergebnisUri);

                BitmapDrawable bd = (BitmapDrawable) bildVorschau.getDrawable();
                final Bitmap newBit = bd.getBitmap();

                DisplayMetrics displayMetrics = new DisplayMetrics();
                getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
                float width = displayMetrics.widthPixels;


                float factor = (float) (width*0.87) / newBit.getWidth();

                final Bitmap bitmap = Bitmap.createScaledBitmap(newBit, (int) ((int) width*0.87), (int) (newBit.getHeight() * factor), true);
                Logger log = Logger.getLogger(test.class.getName());
                log.warning(" + + + + +  + : " + bd.getBounds().width() + " & " + newBit.getHeight());

                //bitmap.setWidth(bildVorschau.getWidth());
                //bitmap.setHeight(bildVorschau.getHeight());
                //Canvas can = new Canvas(bitmap);
                //can.drawBitmap(newBit, 0, 0, null);
                rectFS = detect_words(bitmap);
                //bildVorschau.setImageBitmap(bitmap);

                final List<Integer> pos = new ArrayList<>();

                bildVorschau.setOnTouchListener(new View.OnTouchListener() {
                    @Override
                    public boolean onTouch(View view, MotionEvent motionEvent) {
                        if (motionEvent.getAction() == MotionEvent.ACTION_DOWN) {
                            Bitmap tempBitmap = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), Bitmap.Config.RGB_565);
                            Canvas canvas = new Canvas(tempBitmap);
                            canvas.drawBitmap(bitmap, 0, 0, null);

                            Palette pal = Palette.from(bitmap).generate();
                            int color = pal.getDominantColor(Color.BLUE);
                            Paint paint = new Paint();
                            Paint recPaint = new Paint();
                            paint.setColor(color);

                            ArrayList<int[]> dimList = new ArrayList<>();
                            for (int i = 0; i < rectFS.size(); i++) {

                                int[] dims = {
                                        (int) rectFS.get(i).left,
                                        (int) rectFS.get(i).top,
                                        (int) rectFS.get(i).right,
                                        (int) rectFS.get(i).bottom
                                };
                                dimList.add(dims);
                            }

                            for (int i = 0; i < rectFS.size(); i++) {
                                if (rectFS.get(i).contains(motionEvent.getX(), motionEvent.getY())) {
                                    Logger log = Logger.getLogger(test.class.getName());
                                    log.warning("rectangle : " + rectFS.get(i).toShortString());
                                    if (!pos.contains(i)) {
                                        pos.add(i);
                                        RectEdit rectEdit = new RectEdit(getApplicationContext(),
                                                canvas, dimList, recPaint, pos);

                                        rectEdit.add(color);
                                    } else {
                                        pos.removeAll(Collections.singletonList(i));
                                        RectEdit rectEdit = new RectEdit(getApplicationContext(),
                                                canvas, dimList, recPaint, pos);

                                        rectEdit.add(color);

                                    }
                                    bildVorschau.setImageBitmap(tempBitmap);
                                }
                            }
                        }
                        Logger log = Logger.getLogger(test.class.getName());
                        log.warning("pos touch : " + motionEvent.getX() +  " & " + motionEvent.getY());
                        return false;
                    }
                });

            }
            else if (resultCode == CropImage.CROP_IMAGE_ACTIVITY_RESULT_ERROR_CODE) {
                assert ergebnis != null;
                Exception error = ergebnis.getError();
                Toast.makeText(this, "" + error, Toast.LENGTH_SHORT).show();
            }
        }
    }

    public void intentForCropResult(Uri uri, int crop_code) {
        Intent intent = CropImage.activity(uri)
                .setGuidelines(CropImageView.Guidelines.ON_TOUCH)
                .getIntent(getApplicationContext());
        test.this.startActivityForResult(intent, crop_code);
    }

    @RequiresApi(api = Build.VERSION_CODES.Q)
    public ArrayList<RectF> detect_words(Bitmap bitmap) {

        TextRecognizer recognizer = new TextRecognizer.Builder(this).build();
        ArrayList<RectF> rects = new ArrayList<>();
        TextBlock myItem;

        Frame frame = new Frame.Builder().setBitmap(bitmap).build();
        SparseArray<TextBlock> items = recognizer.detect(frame);
        List<TextBlock> blocks = new ArrayList<>();

        Paint rectPaint = new Paint();
        rectPaint.setStyle(Paint.Style.STROKE);
        rectPaint.setStrokeWidth(4);

        Bitmap tempBitmap = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), Bitmap.Config.RGB_565);
        Canvas canvas = new Canvas(tempBitmap);
        canvas.drawBitmap(bitmap, 0, 0, null);


        for (int i = 0; i < items.size(); i++) {
            myItem = items.valueAt(i);
            blocks.add(myItem);
        }

        for (int i = 0; i < blocks.size(); i++) {
            List<? extends Text> textLines = blocks.get(i).getComponents();

            for (int z = 0; z < textLines.size(); z++) {
                List<? extends Text> words = textLines.get(z).getComponents();

                for (int u = 0; u < words.size(); u++) {
                    int[] dims = {
                            words.get(u).getBoundingBox().left,
                            words.get(u).getBoundingBox().top,
                            words.get(u).getBoundingBox().right,
                            words.get(u).getBoundingBox().bottom
                    };

                            RectEdit rectEdit = new RectEdit(getApplicationContext(),
                            canvas, dims, rectPaint);
                    RectF rect = rectEdit.draw();
                    rects.add(rect);

                    bildVorschau.setImageBitmap(tempBitmap);
                }
            }
        }
        return rects;
    }
}
