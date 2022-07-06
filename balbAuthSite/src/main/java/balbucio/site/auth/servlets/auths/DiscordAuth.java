package balbucio.site.auth.servlets.auths;

import balbucio.utils.Account;
import io.mokulu.discord.oauth.DiscordAPI;
import io.mokulu.discord.oauth.DiscordOAuth;
import io.mokulu.discord.oauth.model.TokensResponse;
import io.mokulu.discord.oauth.model.User;

import java.io.IOException;

public class DiscordAuth {

    static DiscordOAuth oauthHandler = new DiscordOAuth("990678140995112970", "-645B358G8kPG9M47Bhg-Wa4bxG1po7L", "https://user.balbucio.xyz/oauth/dc", "email//identify".split("//"));

    public static String getURL(){
        return oauthHandler.getAuthorizationURL(null);
    }

    public static Account getAccount(String code) throws IOException {
        TokensResponse tokens = oauthHandler.getTokens(code);
        DiscordAPI api = new DiscordAPI(tokens.getAccessToken());
        User user = api.fetchUser();
        return new Account(user);
    }
}
