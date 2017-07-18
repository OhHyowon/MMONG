package com.mmong.auth.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
public class SMTPAuthenticator extends Authenticator {
    protected PasswordAuthentication getPasswordAuthentication() {
        String username = "www.mmong.com@gmail.com"; // gmail 사용자;
        String password = "ahdahd123";  // 패스워드;
        return new PasswordAuthentication(username, password);
   }
}
