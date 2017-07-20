package com.mmong.controller;

import java.util.Properties;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.auth.util.SMTPAuthenticator;

@Controller
public class MailController {
	@RequestMapping("/sendMail/auth")
    public ModelAndView emailAuth(HttpServletResponse response, HttpServletRequest request) throws Exception{
		String memberEmail = request.getParameter("memberEmail");
    	//난수 만들기
    	StringBuffer buffer = new StringBuffer();
    	for(int i=0; i<=6; i++){
    		int n = (int)(Math.random()*10);
    		buffer.append(n);
    	}
    	String authNo = buffer.toString();
    	
    	sendEmail(memberEmail.toString(), authNo);
    	
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("/WEB-INF/view/content/member/register_emailAuth.jsp");
    	mv.addObject("memberEmail", memberEmail);
    	mv.addObject("authNo", authNo);
    	return mv;
    }
    
    public void sendEmail(String memberEmail, String authNo){
    	String host = "smtp.gmail.com"; //smtp서버
    	String subject = "MMONG 회원가입 인증메일입니다.";
    	String fromName = "MMONG 관리자";
    	String from = "mmong_admin@mmong.com";
    	String to = memberEmail;
    	String content = "인증번호는 [ "+authNo+" ] 입니다. 올바르게 입력해주세요.";
    	
    	try{
    		//Session 클래스 
    		Properties props = new Properties();
    		//G-mail SMTP 사용시
    		props.put("mail.smtp.starttls.enable", "true");
    		props.put("mail.transport.protocol", "smtp");
    		props.put("mail.smtp.host", host);
    		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    		props.put("mail.smtp.port", "587");
    		props.put("mail.smtp.user", from);
    		props.put("mail.smtp.auth", "true");
    		
    		/**
    		  * SMTP 인증이 필요한 경우 반드시 Properties 에 SMTP 인증을 사용한다고 설정하여야 한다.
    		  * 그렇지 않으면 인증을 시도조차 하지 않는다.
    		  * 그리고 Authenticator 클래스를 상속받은 SMTPAuthenticator 클래스를 생성한다.
    		  * getPasswordAuthentication() 메소드만 override 하면 된다.
    		  */
    		 
    		Authenticator auth = new SMTPAuthenticator();    		 
    		Session mailSession = Session.getDefaultInstance(props, auth);
    			
    		//메시지 설정
    		Message msg = new MimeMessage(mailSession);
    		msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B"))); //보내는 사람 설정
    		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); //받는사람 설정
    		msg.setSubject(subject); //제목 설정
    		msg.setSentDate(new java.util.Date()); //보내는날짜 설정
    		msg.setContent(content, "text/html;charset=euc-kr"); //내용설정 (HTML형식)
    		
    		//메시지 보내기
    		Transport.send(msg); //메일 보내기
    		
    	}catch (MessagingException e){
    		e.printStackTrace();
    	}catch (Exception e){
    		e.printStackTrace();   		
    	}
    	
    }
}
