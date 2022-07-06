package balbucio.utils;

import balbucio.utils.cookies.AccountCookieManager;
import balbucio.utils.database.DatabaseClient;

public class Start {

    public static void i(){
        DatabaseClient.createIfNotExists();
        AccountCookieManager.start();
    }
}
