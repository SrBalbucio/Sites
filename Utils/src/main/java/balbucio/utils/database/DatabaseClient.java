package balbucio.utils.database;

import balbucio.datacrack.client.Datacrack;
import balbucio.datacrack.client.data.RootDataPack;
import balbucio.datacrack.client.user.User;

public class DatabaseClient {

    public static void createIfNotExists(){
        if(instance == null){
            instance = new DatabaseClient();
        }
    }

    private static DatabaseClient instance = null;

    private Datacrack datacrack;

    public DatabaseClient(){
        this.datacrack = new Datacrack(new User("Admin", "Ademiro"));
        datacrack.getManager().addSocket("painel.ec2.balbucio.xyz", 25565);
    }

    public static DatabaseClient getInstance() {
        return instance;
    }

    public RootDataPack getUser(String user) throws Exception {
        createIfNotExists();
        return datacrack.getManager().getRootPack(user);
    }
    public RootDataPack getContent() throws Exception {
        createIfNotExists();
        return datacrack.getManager().getRootPack("Content");
    }

    public RootDataPack getLicenses() throws Exception {
        createIfNotExists();
        return datacrack.getManager().getRootPack("Licenses");
    }
    public RootDataPack getTempIds() throws Exception {
        createIfNotExists();
        return datacrack.getManager().getRootPack("TempIds");
    }

}
