package net.jtmcgee.project.happybirthday.controllers;

import java.io.IOException;
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
		// look for todays birthdays
			// get oauth token and post it
		PersistenceManager pm = PMF.get().getPersistenceManager();
		List<Birthday> bdays = (List<Birthday>) pm.newQuery(Birthday.class).execute();
		for(Birthday bday: bdays) {
			if(bday.isToday()) {
				FacebookClient fbClient = new DefaultFacebookClient(bday.getToken());
				FacebookType publishMessageResponse = fbClient.publish(bday.getUid() + "/feed", FacebookType.class, Parameter.with("message", bday.getMessage()));
				resp.getWriter().println("Published message ID: " + publishMessageResponse.getId());
			}
		}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// look for todays birthdays
			// get oauth token and post it
		PersistenceManager pm = PMF.get().getPersistenceManager();
		List<Birthday> bdays = (List<Birthday>) pm.newQuery(Birthday.class).execute();
		for(Birthday bday: bdays) {
			if(bday.isToday()) {
				FacebookClient fbClient = new DefaultFacebookClient(bday.getToken());
				FacebookType publishMessageResponse = fbClient.publish(bday.getUid() + "/feed", FacebookType.class, Parameter.with("message", bday.getMessage()));
				resp.getWriter().println("Published message ID: " + publishMessageResponse.getId());
			}
		}
	}
}
