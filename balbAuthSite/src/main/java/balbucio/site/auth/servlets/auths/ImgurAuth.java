package balbucio.site.auth.servlets.auths;

import balbucio.utils.Account;
import com.github.scribejava.apis.GitHubApi;
import com.github.scribejava.apis.ImgurApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.AccessTokenRequestParams;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.httpclient.okhttp.OkHttpHttpClientConfig;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

public class ImgurAuth {

    private static final String NETWORK_NAME = "Imgur";
    private static final String PROTECTED_RESOURCE_URL = "https://api.imgur.com/3/account/me";

    static OAuth20Service service = new ServiceBuilder("1dfda563c016817")
            .apiSecret("3e41206830c51da388c146d4776c201ef4f04aa6")
            .callback("https://user.balbucio.xyz/oauth/imgur")
            .httpClientConfig(OkHttpHttpClientConfig.defaultConfig())
            .build(ImgurApi.instance());

    public static String getURL(){
        return service.getAuthorizationUrl();
    }

    public static Account getAccount(String code) throws IOException, ExecutionException, InterruptedException {
        OAuth2AccessToken accessToken = service.getAccessToken(new AccessTokenRequestParams(code).addExtraParameter("grant_type", "refresh_token"));
        final OAuthRequest request = new OAuthRequest(Verb.POST, PROTECTED_RESOURCE_URL);
        request.addParameter("client_id", "1dfda563c016817");
        request.addParameter("client_secret", "3e41206830c51da388c146d4776c201ef4f04aa6");
        request.addHeader("acess_token", code);
        service.signRequest(accessToken, request);
        Response response = service.execute(request);
        System.out.println(response.getCode());
        System.out.println(response.getBody());
        System.out.println(response.getHeaders());
        System.out.println(response.getMessage());
        return null;
    }
}

