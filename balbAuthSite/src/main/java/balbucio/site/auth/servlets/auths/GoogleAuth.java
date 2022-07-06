package balbucio.site.auth.servlets.auths;

import balbucio.utils.Account;
import com.github.scribejava.apis.GitHubApi;
import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.httpclient.HttpClientConfig;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.httpclient.ahc.AhcHttpClientConfig;
import com.github.scribejava.httpclient.okhttp.OkHttpHttpClientConfig;
import org.asynchttpclient.DefaultAsyncHttpClientConfig;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutionException;

public class GoogleAuth {
    private static final String NETWORK_NAME = "Google";
    private static final String PROTECTED_RESOURCE_URL = "https://www.googleapis.com/oauth2/v3/userinfo";
    private static List<String> states = new ArrayList<>();

    static final HttpClientConfig clientConfig = new AhcHttpClientConfig(new DefaultAsyncHttpClientConfig.Builder()
            .setMaxConnections(5)
            .setRequestTimeout(10_000)
            .setPooledConnectionIdleTimeout(1_000)
            .setReadTimeout(1_000)
            .build());

    static OAuth20Service service = new ServiceBuilder("270965088150-d3itlqmn57lenvm8r41sk55m4drmogsd.apps.googleusercontent.com")
            .apiSecret("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")
            .callback("https://user.balbucio.xyz/oauth/google")
            .defaultScope("profile")
            .httpClientConfig(clientConfig)
            .build(GoogleApi20.instance());

    public static String getURL() {
        final Map<String, String> additionalParams = new HashMap<>();
        additionalParams.put("access_type", "offline");
        additionalParams.put("prompt", "consent");
        String state = "secret" + new Random().nextInt(999_999);
        states.add(state);
        return service.createAuthorizationUrlBuilder()
                .state(state)
                .additionalParams(additionalParams)
                .build();
    }

    public static Account getAccount(String code, String state) throws IOException, ExecutionException, InterruptedException {
        states.remove(state);
        OAuth2AccessToken accessToken = service.getAccessToken(code);
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken());
        final OAuthRequest request = new OAuthRequest(Verb.GET,PROTECTED_RESOURCE_URL);
        service.signRequest(accessToken, request);
        Response response = service.execute(request);
        System.out.println(response.getCode());
        System.out.println(response.getBody());
        return null;
    }
}
