package net.jtmcgee.project.happybirthday.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.types.FacebookType;

import net.jtmcgee.project.happybirthday.model.Birthday;
import net.jtmcgee.project.happybirthday.model.PMF;

public class Cron extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doPost(req, resp);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// look for todays birthdays
			// get oauth token and post it
		PersistenceManager pm = PMF.get().getPersistenceManager();
		List<Birthday> bdays = (List<Birthday>) pm.newQuery(Birthday.class).execute();
		List list = new ArrayList();
		
		for(Birthday bday: bdays) {
			if(bday.isToday()) {
				FacebookClient fbClient = new DefaultFacebookClient(bday.getToken());
				FacebookType publishMessageResponse = fbClient.publish(bday.getUid() + "/feed", FacebookType.class, Parameter.with("message", bday.getMessage()));
				resp.getWriter().println("Published message ID: " + publishMessageResponse.getId());
				list.add("Result ID: " + publishMessageResponse.getId() + "\n" +
						"Birthday wish to: " + bday.getUid() + ", From: " + bday.getWisher() + "\n" +
						"Message: " + bday.getMessage());
				// TODO rm birthday if it succeded (sp?)
			}
		}
		
		// MAIL
        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);

        String msgBody = "";
        try {
	        for(int i = 0; i < list.size(); i++) {
	        	msgBody = msgBody + "\n " + list.get(i);
	        }
        } catch(Exception e) {
        	// this blows
        }

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("jordan@jtmcgee.net", "Jtmcgee.net Webmaster"));
            msg.addRecipient(Message.RecipientType.TO,
                             new InternetAddress("jordan@jtmcgee.net", "Jordan DeLoach"));
            msg.setSubject("Results from the Birthday Wishes");
            msg.setText(msgBody);
            Transport.send(msg);

        } catch (AddressException e) {
            // ...
        } catch (MessagingException e) {
            // ...
        }
	}
}
