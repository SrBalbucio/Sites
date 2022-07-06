package balbucio.site.auth.servlets.auths;

import balbucio.utils.Account;
import com.github.scribejava.apis.GitHubApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.httpclient.okhttp.OkHttpHttpClientConfig;
import org.json.JSONObject;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

public class GitAuth {

    private static final String NETWORK_NAME = "GitHub";
    private static final String PROTECTED_RESOURCE_URL = "https://api.github.com/user";

    static OAuth20Service service = new ServiceBuilder("66d5527ac086e97e7484")
            .apiSecret("b5c0e144697c1cb24445099c219c5af779f8279e")
            .callback("https://user.balbucio.xyz/oauth/git")
            .httpClientConfig(OkHttpHttpClientConfig.defaultConfig())
            .build(GitHubApi.instance());

    public static String getURL(){
        return service.getAuthorizationUrl();
    }

    public static JSONObject getJSON(String code) throws IOException, ExecutionException, InterruptedException {
        OAuth2AccessToken accessToken = service.getAccessToken(code);
        final OAuthRequest request = new OAuthRequest(Verb.POST, PROTECTED_RESOURCE_URL);
        service.signRequest(accessToken, request);
        Response response = service.execute(request);
        JSONObject json = new JSONObject(response.getBody());
        return json;
    }
}
