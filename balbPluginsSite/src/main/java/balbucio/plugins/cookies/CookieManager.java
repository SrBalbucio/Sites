package balbucio.plugins.cookies;

import javax.servlet.http.Cookie;
import java.util.Arrays;

public class CookieManager {
    public static boolean isAdmin(Cookie[] cookies){
        if(cookies == null){ return false; }
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("balbAdmin")){
                return true;
            }
        }
        return false;
    }

    public static Cookie getCookie(Cookie[] cookies){
        return Arrays.stream(cookies).filter(c -> c.getName().equals("balbPluginsAcc")).findFirst().get();
    }

    public static Cookie createAdminCookie(){
        Cookie cookie = new Cookie("balbAdmin", "papadorDeBuceta");
        cookie.setMaxAge(60*60*1);
        cookie.setVersion(1);
        return cookie;
    }
}
