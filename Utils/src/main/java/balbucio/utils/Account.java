package balbucio.utils;
import balbucio.datacrack.client.data.DataPack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.utils.database.DatabaseClient;
import balbucio.utils.modules.AccountModule;
import io.mokulu.discord.oauth.model.User;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class Account {

    private String username = "<null-not>";
    private boolean usernameChanged = false;
    private String discriminator = "0000";
    private String email = "<null-not>";
    private String avatar = "null-not";
    private String discordID = "<null-not>";
    private UUID uniqueID = UUID.randomUUID();
    private String password = "<null-not>";
    private boolean hasGitHub = false;
    private String gitUsername = "<null-not>";
    private String gitLink = "<null-not>";
    private String name = "Não informado";
    private String endereco = "Não informado";
    private String telefone = "Não informado";
    private String site = "Não informado";
    private String bio = "Sou uma pessoa incrível e gosto dos projetos do balb :)";
    private List<AccountModule> modules = new ArrayList<>();
    private boolean isNewAccount = false;
    public Account(User user){
        try {
            RootDataPack pack = DatabaseClient.getInstance().getUser(user.getEmail());
            if(pack.contains("usernameChanged") && pack.getBoolean("usernameChanged")){
                this.username = pack.getString("username");
            } else{
                this.username = user.getUsername();
            }
            this.email = user.getEmail();
            this.avatar = "https://cdn.discordapp.com/avatars/"+user.getId()+"/"+user.getAvatar()+".png";
            this.discriminator = user.getDiscriminator();
            this.discordID = user.getId();
            pack.set("username", username);
            pack.set("discriminator", discriminator);
            pack.set("email", email);
            pack.set("avatar", avatar);
            pack.set("discordID", discordID);
            if(pack.contains("password")){
                this.password = pack.getString("password");
            }
            if(pack.contains("gitUsername")){
                this.hasGitHub = true;
                this.gitUsername = pack.getString("gitUsername");
            }
            if(pack.contains("gitLink")){
                this.hasGitHub = true;
                this.gitLink = pack.getString("gitLink");
            }
            if(pack.contains("name")){
                this.name = pack.getString("name");
                this.endereco = pack.getString("endereco");
                this.telefone = pack.getString("telefone");
            }
            if(pack.contains("site")){
                this.site = pack.getString("site");
                this.bio = pack.getString("bio");
            }
            DataPack mods = pack.createDataPack("modules");
            for(DataPack PM : mods.getAllDataPacks()){
                modules.add(new AccountModule(PM));
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        save();
    }

    public Account(String email){
        if(email.equalsIgnoreCase("<null-not>")){ return; }
        try {
            RootDataPack pack = DatabaseClient.getInstance().getUser(email);
            if(pack.contains("username")) {
                this.username = pack.getString("username");
            }
            this.email = email;
            if(pack.contains("avatar")) {
                this.avatar = pack.getString("avatar");
            }
            if(pack.contains("discriminator")) {
                this.discriminator = pack.getString("discriminator");
            }
            if(pack.contains("discordID")) {
                this.discordID = pack.getString("discordID");
            }
            if(pack.contains("password")){
                this.password = pack.getString("password");
            }
            if(pack.contains("gitUsername")){
                this.hasGitHub = !pack.getString("gitLink").equalsIgnoreCase("<null-not>");
                this.gitUsername = pack.getString("gitUsername");
            }
            if(pack.contains("gitLink")){
                this.hasGitHub = !pack.getString("gitLink").equalsIgnoreCase("<null-not>");
                this.gitLink = pack.getString("gitLink");
            }
            if(pack.contains("name")){
                this.name = pack.getString("name");
                this.endereco = pack.getString("endereco");
                this.telefone = pack.getString("telefone");
            }
            if(pack.contains("site")){
                this.site = pack.getString("site");
                this.bio = pack.getString("bio");
            }
            DataPack mods = pack.createDataPack("modules");
            for(DataPack PM : mods.getAllDataPacks()){
                modules.add(new AccountModule(PM));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Account(){

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.usernameChanged = true;
        this.username = username;
        save();
    }

    public String getDiscriminator() {
        return discriminator;
    }

    public void setDiscriminator(String discriminator) {
        this.discriminator = discriminator;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getDiscordID() {
        return discordID;
    }

    public void setDiscordID(String discordID) {
        this.discordID = discordID;
    }

    public UUID getUniqueID() {
        return uniqueID;
    }

    public void setUniqueID(UUID uniqueID) {
        this.uniqueID = uniqueID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
        save();
    }

    public String getGitUsername() {
        return gitUsername;
    }

    public void setGitUsername(String gitUsername) {
        this.gitUsername = gitUsername;
    }

    public String getGitLink() {
        return gitLink;
    }

    public void setGitLink(String gitLink) {
        this.gitLink = gitLink;
    }

    public void setGitHub(JSONObject json){
        hasGitHub = true;
        this.gitUsername = json.getString("login");
        this.gitLink = json.getString("html_url");
        save();
    }

    public boolean hasGitHub() {
        return hasGitHub;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        save();
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
        save();
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
        save();
    }

    public boolean isUsernameChanged() {
        return usernameChanged;
    }

    public void setUsernameChanged(boolean usernameChanged) {
        this.usernameChanged = usernameChanged;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
        save();
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
        save();
    }

    public void createModule(AccountModule module){
        try {
            RootDataPack pack = DatabaseClient.getInstance().getUser(email);
            module.setDataPack(pack.createDataPack("modules").createDataPack(module.getName()));
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    public void save(){
        try {
            RootDataPack pack = DatabaseClient.getInstance().getUser(email);
            pack.set("username", username);
            pack.set("discriminator", discriminator);
            pack.set("email", email);
            pack.set("avatar", avatar);
            pack.set("discordID", discordID);
            pack.set("password", password);
            pack.set("gitUsername", gitUsername);
            pack.set("gitLink", gitLink);
            pack.set("name", name);
            pack.set("endereco", endereco);
            pack.set("telefone", telefone);
            pack.set("site", site);
            pack.set("bio", bio);
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public static Account getAccountByEmail(String email){
        return new Account(email);
    }

    public static boolean contains(String email)  {
        RootDataPack pack = null;
        try {
            pack = DatabaseClient.getInstance().getUser(email);
            return pack.contains("email");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isNewAccount() {
        return isNewAccount;
    }

    public void setNewAccount(boolean newAccount) {
        isNewAccount = newAccount;
    }
}
