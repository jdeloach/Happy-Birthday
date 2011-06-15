package net.jtmcgee.project.happybirthday.controllers;

import java.io.IOException;
import java.text.ParseException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

import net.jtmcgee.project.happybirthday.model.Birthday;
import net.jtmcgee.project.happybirthday.model.PMF;
import net.jtmcgee.project.happybirthday.utils.Config;

@SuppressWarnings("serial")
public class AddBirthday extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		long id = Long.parseLong(req.getParameter("id"));
		String message = req.getParameter("message");
		
		FacebookClient fbClient = new DefaultFacebookClient(Config.ACCESS_TOKEN(req));
		User user = fbClient.fetchObject(Long.toString(id), User.class);
		
		Birthday bday = null;
        HttpSession session = req.getSession(true);

		try {
			bday = new Birthday(user.getBirthday(), user, message, (String) session.getAttribute("access_token"), req);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			pm.makePersistent(bday);
		} finally {
			pm.close();
		}
		resp.getWriter().println("Added Birthday!");
		resp.sendRedirect("/scheduled.jsp");
	}
}
