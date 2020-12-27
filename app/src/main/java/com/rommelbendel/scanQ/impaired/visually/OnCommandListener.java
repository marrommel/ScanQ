package com.rommelbendel.scanQ.impaired.visually;

import java.util.List;

public interface OnCommandListener {
    boolean onCommand(String command);
    void onCommandNotFound(String mostLikelyCommand, List<String> possibleCommands);
}
