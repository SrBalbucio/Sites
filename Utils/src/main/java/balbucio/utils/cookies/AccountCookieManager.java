package balbucio.utils.cookies;

import balbucio.datacrack.client.data.DataPack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.utils.Account;
import balbucio.utils.database.DatabaseClient;

import javax.servlet.http.Cookie;
import java.util.*;

public class AccountCookieManager {

    public static List<AccountTempID> tempIDS = new ArrayList<>();
    private static boolean started = false;

    public static void removeOld() {
        try {
            for (AccountTempID id : tempIDS) {
                Calendar a = Calendar.getInstance();
                Calendar b = Calendar.getInstance();
                b.setTime(new Date(id.getTime()));
                b.add(Calendar.DATE, 5);
                if (b.before(a)) {
                    RootDataPack tempID = DatabaseClient.getInstance().getTempIds();
                    tempID.set(id.getUniqueID() + "_datapack", null);
                    id.destroy();
                    tempIDS.remove(id);
                }
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    public static Cookie createTempID(Account acc) {
        String uniqueID = UUID.randomUUID().toString()+"-"+acc.getDiscordID()+"-"+new Random().nextInt(999_999);
        Cookie cookie = null;
        AccountTempID tid = new AccountTempID(uniqueID, acc.getEmail());
        tempIDS.add(tid);
        cookie = new Cookie("balbUniqueID", uniqueID.toString());
        cookie.setMaxAge(60 * 60 * 24 * 5);
        cookie.setPath("/");
        cookie.setComment("Este cookie registra sua conta, não compartilhe com ninguém! Esse ID durará por 5 dias.");
        try {
            RootDataPack tempID = DatabaseClient.getInstance().getTempIds();
            DataPack t = tempID.createDataPack(uniqueID);
            t.set("time", tid.getTime());
            t.set("account", acc.getEmail());
        } catch(Exception e){
            e.printStackTrace();
        }
        return cookie;
    }

    public static boolean checkTempID(Cookie[] cookies){
        removeOld();
        if(cookies == null){ return false; }
        Cookie cok = CookieUtils.getCookie("balbUniqueID", cookies);
        if(cok != null){
            if(checkIfExists(cok.getValue())){
                return true;
            } else{
                return false;
            }
        }
        return false;
    }

    public static Account getAccount(Cookie[] cookies){
        Cookie cok = CookieUtils.getCookie("balbUniqueID", cookies);
        if(cok != null){
            if(checkIfExists(cok.getValue())){
                return getTempID(cok.getValue()).getAccount();
            } else{
                return null;
            }
        }
        return null;
    }

    private static boolean checkIfExists(String uid){
        for(AccountTempID id : tempIDS){
            if(id.getUniqueID().equals(uid)){
                return true;
            }
        }
        return false;
    }

    private static AccountTempID getTempID(String uid){
        for(AccountTempID id : tempIDS){
            if(id.getUniqueID().equals(uid)){
                return id;
            }
        }
        return null;
    }

    public static void start(){
        try {
            if (!started) {
                RootDataPack tempID = DatabaseClient.getInstance().getTempIds();
                for (DataPack d : tempID.getAllDataPacks()) {
                    tempIDS.add(new AccountTempID(d.getName(), d.getString("account"), d.getLong("time")));
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
