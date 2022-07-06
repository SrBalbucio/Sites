package balbucio.plugins.site;

import balbucio.datacrack.client.data.DataPack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.utils.database.DatabaseClient;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class License {

    private static List<License> allLicenses = new ArrayList<>();

    private String owner;
    private Plugin plugin;
    private UUID key;
    private boolean activate;

    public License(String owner, Plugin plugin, UUID key, boolean activate){
        this.owner = owner;
        this.plugin = plugin;
        this.key = key;
        this.activate = activate;
    }

    public License(String owner, Plugin plugin){
        this.owner = owner;
        this.plugin = plugin;
        this.key = UUID.randomUUID();
        this.activate = true;
    }

    public String getOwner() {
        return owner;
    }

    public Plugin getPlugin() {
        return plugin;
    }

    public UUID getKey() {
        return key;
    }

    public void setKey(UUID key) {
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

    public static void reload(){
        try{
            RootDataPack licenses = DatabaseClient.getInstance().getLicenses();
            for(DataPack data : licenses.getAllDataPacks()){
                if(data.contains("key")) {
                    new License(data.getString("owner"), Plugin.getPluginByName().get(data.getString("plugin")), UUID.fromString(data.getString("key")), data.getBoolean("activate"));
                } else{
                    new License(data.getString("owner"), Plugin.getPluginByName().get(data.getString("plugin")));
                }
            }
            for(License license : allLicenses){
                DataPack data = licenses.createDataPack(license.owner+"*"+license.getKey().toString());
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
