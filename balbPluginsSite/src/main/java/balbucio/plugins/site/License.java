package balbucio.plugins.site;

import balbucio.datacrack.client.data.DataPack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.utils.database.DatabaseClient;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

public class License {

    private static List<License> allLicenses = new ArrayList<>();

    private String owner;
    private Plugin plugin;
    private String key = "<null-not>";
    private boolean activate = false;

    public License(String owner, Plugin plugin, String key, boolean activate){
        this.owner = owner;
        this.plugin = plugin;
        this.key = key;
        this.activate = activate;
        allLicenses.add(this);
    }

    public License(String owner, Plugin plugin){
        this.owner = owner;
        this.plugin = plugin;
        this.key = UUID.randomUUID().toString()+new Random().nextInt(999_999);
        allLicenses.add(this);
    }

    public String getOwner() {
        return owner;
    }

    public Plugin getPlugin() {
        return plugin;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public boolean isActivate() {
        return activate;
    }

    public static List<License> getLicensesFromAccount(String owner){
        List<License> ls = new ArrayList<>();
        for(License l : allLicenses){
            if(l.getOwner().equals(owner)){
                ls.add(l);
            }
        }
        return ls;
    }

    public static boolean hasLicense(String owner, Plugin plugin){
        List<License> ls = getLicensesFromAccount(owner);
        for(License l : ls){
            if(l.getPlugin() == plugin){
                return true;
            }
        }
        return false;
    }

    public static License getLicense(String owner, Plugin plugin){
        List<License> ls = getLicensesFromAccount(owner);
        for(License l : ls){
            if(l.getPlugin() == plugin){
                return l;
            }
        }
        return null;
    }

    public static void removeLicense(String owner, Plugin plugin){
        try {
            RootDataPack licenses = DatabaseClient.getInstance().getLicenses();
            if (hasLicense(owner, plugin)) {
                License l = getLicense(owner, plugin);
                allLicenses.remove(l);
                licenses.remove(l.owner + "*" + l.getKey().toString()+"_datapack");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void reload(){
        try{
            RootDataPack licenses = DatabaseClient.getInstance().getLicenses();
            for(DataPack data : licenses.getAllDataPacks()){
                if(data.contains("key")) {
                    new License(data.getString("owner"), Plugin.getPluginByName().get(data.getString("plugin")), data.getString("key"), data.getBoolean("activate"));
                } else{
                    new License(data.getString("owner"), Plugin.getPluginByName().get(data.getString("plugin")));
                }
            }
            for(License license : allLicenses){
                DataPack data = licenses.createDataPack(license.getKey().toString());
                data.setString("owner", license.getOwner());
                data.setString("plugin", license.getPlugin().getName());
                data.setString("key", license.getKey().toString());
                data.setBoolean("activate", license.activate);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
