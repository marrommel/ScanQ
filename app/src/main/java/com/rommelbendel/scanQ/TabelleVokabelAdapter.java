package com.rommelbendel.firstapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class TabelleVokabelAdapter extends RecyclerView.Adapter<TabelleVokabelAdapter.VokabelViewHolder> {

    class VokabelViewHolder extends RecyclerView.ViewHolder {
        private final EditText vokabelEnItemView;
        private final EditText vokabelDeItemView;

        private VokabelViewHolder(View itemView) {
            super(itemView);
            vokabelEnItemView = itemView.findViewById(R.id.zeile);
            vokabelDeItemView = itemView.findViewById(R.id.zeile2);
        }
    }

    private final LayoutInflater layoutInflater;
    private List<Vokabel> vokabelCache;

    TabelleVokabelAdapter(Context context) {
        layoutInflater = LayoutInflater.from(context);
    }

    @Override
    public VokabelViewHolder onCreateViewHolder(ViewGroup viewGroup, int art) {
        View zeilenView = layoutInflater.inflate(R.layout.dataset, viewGroup, false);
        return new VokabelViewHolder(zeilenView);
    }

    @Override
    public void onBindViewHolder(VokabelViewHolder vokabelViewHolder, int position) {
        if (vokabelCache != null) {
            Vokabel nextVokabel = vokabelCache.get(position);
            String engl = nextVokabel.getVokabelENG();
            String de = nextVokabel.getVokabelDE();
            vokabelViewHolder.vokabelEnItemView.setText(engl);
            vokabelViewHolder.vokabelDeItemView.setText(de);
        }
        else {
            vokabelViewHolder.vokabelEnItemView.setText(R.string.leere_datenbank_fehlermeldung);
        }
    }

    @Override
    public int getItemCount() {
        if (vokabelCache != null) {
            return vokabelCache.size();
        }
        else {
            return 0;
        }
    }

    public void setVokabelCache(List<Vokabel> vokabelCache) {
        this.vokabelCache = vokabelCache;
        notifyDataSetChanged();
    }
}
