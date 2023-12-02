package balbucio.site.auth.servlets.auths;

import balbucio.utils.Account;
import com.github.scribejava.apis.FacebookApi;
import com.github.scribejava.apis.GitHubApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.httpclient.okhttp.OkHttpHttpClientConfig;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

public class FaceAuth {

    private static final String NETWORK_NAME = "Facebook";
    private static final String PROTECTED_RESOURCE_URL = "https://graph.facebook.com/v3.2/me";

    static OAuth20Service service = new ServiceBuilder("*")
            .apiSecret("*")
            .callback("https://user.balbucio.xyz/oauth/face")
            .httpClientConfig(OkHttpHttpClientConfig.defaultConfig())
            .build(FacebookApi.instance());

    public static String getURL(){
        return service.getAuthorizationUrl();
    }

    public static Account getAccount(String code) throws IOException, ExecutionException, InterruptedException {
        OAuth2AccessToken accessToken = service.getAccessToken(code);
        final OAuthRequest request = new OAuthRequest(Verb.POST, PROTECTED_RESOURCE_URL);
        service.signRequest(accessToken, request);
        Response response = service.execute(request);
        System.out.println(response.getCode());
        System.out.println(response.getBody());
        return null;
    }
}
