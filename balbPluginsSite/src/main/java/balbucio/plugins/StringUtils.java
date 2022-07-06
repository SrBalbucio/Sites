package balbucio.plugins;

import java.util.HashMap;
import java.util.Map;

public class StringUtils {

    static Map<String, String> replacement = new HashMap<>();

    public static String acentos(String s){
        String finnaly = s;
        finnaly = finnaly.replace("+atio+", "ã");
        finnaly = finnaly.replace("+otio+", "õ");
        finnaly = finnaly.replace("+asu+", "á");
        finnaly = finnaly.replace("+esu+", "é");
        finnaly = finnaly.replace("+osu+", "ó");
        finnaly = finnaly.replace("+acha+", "â");
        finnaly = finnaly.replace("+echa+", "ê");
        finnaly = finnaly.replace("+ocha+", "ô");
        finnaly = finnaly.replace("+cidilha+", "ç");
        return finnaly;
    }
}
