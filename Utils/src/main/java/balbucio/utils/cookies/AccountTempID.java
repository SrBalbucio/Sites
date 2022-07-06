package balbucio.utils.cookies;

import balbucio.utils.Account;

import java.util.Date;
import java.util.UUID;

public class AccountTempID {

    private String uniqueID;
    private String email;
    private long time;

    public AccountTempID(String uniqueID, String email) {
        this.uniqueID = uniqueID;
        this.email = email;
        this.time = new Date().getTime();
    }
    public AccountTempID(String uniqueID, String email, long time) {
        this.uniqueID = uniqueID;
        this.email = email;
        this.time = time;
    }

    public String getUniqueID() {
        return uniqueID;
    }

    public Account getAccount() {
        return Account.getAccountByEmail(this.email);
    }

    public long getTime() {
        return time;
    }

    public void destroy(){
        this.uniqueID = null;
        this.email = null;
        this.time = 0;
    }
}
