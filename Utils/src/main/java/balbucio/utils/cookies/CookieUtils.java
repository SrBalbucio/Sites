package balbucio.utils.cookies;

import javax.servlet.http.Cookie;

public class CookieUtils {


    public static Cookie getCookie(String name, Cookie[] coks) {
        if (coks == null) {
            return null;
        }
        for (Cookie cookie : coks) {
            if (cookie.getName().equals(name)) {
                return cookie;
            }
        }
        return null;
    }

    public static boolean hasCookie(String name, Cookie[] coks) {
        if (coks == null) {
            return false;
        }
        for (Cookie cookie : coks) {
            if (cookie.getName().equals(name)) {
                return true;
            }
        }
        return false;
    }
}
