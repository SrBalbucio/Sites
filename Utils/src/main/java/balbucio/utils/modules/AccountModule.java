package balbucio.utils.modules;

import balbucio.datacrack.client.data.DataPack;

public class AccountModule {

    private String name;
    private DataPack pack;

    public AccountModule(DataPack pack){
        this.pack = pack;
    }

    public AccountModule(String name){
        this.name = name;
    }

    public void setDataPack(DataPack pack){
        this.pack = pack;
    }

    public String getName() {
        return name;
    }

    public DataPack getPack() {
        return pack;
    }
}
