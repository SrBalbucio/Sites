package balbucio.plugins.site;

import balbucio.datacrack.client.data.DataPack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.utils.database.DatabaseClient;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Plugin {

    private String name;
    private String description;
    private String documentation = "Este plugin ainda não tem documentação :/";
    private String paymentUrl = "nada";
    private String spigotUrl;
    private String content;
    private double price;
    private double version = 1.0;
    private boolean free = false;
    private boolean inspigot = false;
    private Map<Double, String> versions = new HashMap<>();

    private static List<Plugin> plugins = new ArrayList<>();
    private static HashMap<String, Plugin> pluginByName = new HashMap<>();
    private static boolean started = false;

    public Plugin(String name, String description, String paymentUrl, String spigotUrl, double price, boolean free, boolean inspigot, String content) {
        this.name = name;
        this.description = description;
        this.paymentUrl = paymentUrl;
        this.spigotUrl = spigotUrl;
        this.price = price;
        this.free = free;
        this.inspigot = inspigot;
        this.content = content;
        plugins.add(this);
        pluginByName.put(name, this);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getVersion() {
        return version;
    }

    public Map<Double, String> getVersions() {
        return versions;
    }

    public String getDocumentation() {
        return documentation;
    }

    public void setDocumentation(String documentation) {
        this.documentation = documentation;
    }

    public String getPaymentUrl() {
        return paymentUrl;
    }

    public void setPaymentUrl(String paymentUrl) {
        this.paymentUrl = paymentUrl;
    }

    public String getSpigotUrl() {
        return spigotUrl;
    }

    public void setSpigotUrl(String spigotUrl) {
        this.spigotUrl = spigotUrl;
    }

    public boolean isFree() {
        return free;
    }

    public void setFree(boolean free) {
        this.free = free;
    }

    public boolean isInspigot() {
        return inspigot;
    }

    public void setInspigot(boolean inspigot) {
        this.inspigot = inspigot;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getNextVersion(){
        return version + 1;
    }

    public double getPreviousVersion(){
        return version > 0 ? (version - 1) == 0 ? 1.0 : (version - 1) : 1.0;
    }

    public void addVersion(double version, String changelog){
        if (versions.containsKey(version)) {
            versions.replace(version, changelog);
            return;
        }
        versions.put(version, changelog);
        double defversion = 0.0;
        for(double vs : versions.keySet()){
            if(vs > defversion){
                defversion = vs;
            }
        }
        this.version = defversion;
    }

    public File getDownloadFile(String context) {
        File file = new File(context + File.separator + "plugin" + File.separator + this.name, this.name + "-" + this.getVersion());
        return file;
    }

    public File getDownloadFile(String context, Double version) {
        File file = new File(context + File.separator + "plugin" + File.separator + this.name, this.name + "-" + version);
        return file;
    }

    public static List<Plugin> getPlugins() {
        return plugins;
    }

    public static HashMap<String, Plugin> getPluginByName() {
        return pluginByName;
    }

    public static void update(){
        try{
            RootDataPack content = DatabaseClient.getInstance().getContent();
            for (Plugin plugin : plugins) {
                DataPack pack = content.createDataPack(plugin.getName());
                pack.setString("name", plugin.getName());
                pack.setString("description", plugin.getDescription());
                pack.set("documentation", plugin.getDocumentation());
                pack.setString("paymentUrl", plugin.getPaymentUrl());
                pack.setString("spigotUrl", plugin.getSpigotUrl());
                pack.setDouble("price", plugin.getPrice());
                pack.setBoolean("free", plugin.isFree());
                pack.setBoolean("inspigot", plugin.isInspigot());
                pack.set("content", plugin.getContent());
                DataPack vers = pack.createDataPack("versions");
                for (Double v : plugin.versions.keySet()) {
                    vers.set(v.toString(), plugin.versions.get(v));
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void reload() {
        if(started){ return; }
        try {
            RootDataPack content = DatabaseClient.getInstance().getContent();
            for (DataPack dataPack : content.getAllDataPacks()) {
                if(!pluginByName.containsKey(dataPack.getString("name"))) {
                    Plugin npl = new Plugin(dataPack.getString("name"), dataPack.getString("description"), dataPack.getString("paymentUrl"), dataPack.getString("spigotUrl"), dataPack.getDouble("price"), dataPack.getBoolean("free"), dataPack.getBoolean("inspigot"), dataPack.getString("content"));
                    npl.setDocumentation(dataPack.getString("documentation"));
                    DataPack vers = dataPack.createDataPack("versions");
                    for (String k : vers.getSource().keySet()) {
                        if (!k.contains("datacrack_updateDate") && !k.contains("datacrack_path") && !k.contains("datacrack_name")) {
                            npl.addVersion(Double.parseDouble(k), vers.getString(k));
                        }
                    }
                }
            }
            started = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static boolean has(String pluginName){
        return pluginByName.containsKey(pluginName);
    }

    public static void createPlugin(JSONObject obj){
        new Plugin(obj.getString("name"), obj.getString("description"),obj.getString("paymentUrl"), obj.getString("spigotUrl"), Double.parseDouble(obj.getString("price")), Boolean.parseBoolean(obj.getString("free")), Boolean.parseBoolean(obj.getString("inspigot")), ""+obj.get("content"));
    }

    public static void deletePlugin(JSONObject obj){
        try{
            RootDataPack content = DatabaseClient.getInstance().getContent();
            content.set(obj.getString("name")+"_datapack", null);
            Plugin plugin = pluginByName.get(obj.getString("name"));
            plugins.remove(plugin);
            pluginByName.remove(obj.getString("name"));
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void deletePlugin(String name){
        if(!has(name)){ return; }
        try{
            Plugin plugin = pluginByName.get(name);
            plugins.remove(plugin);
            pluginByName.remove(name);
            RootDataPack content = DatabaseClient.getInstance().getContent();
            content.set(name+"_datapack", null);
            content.update();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
