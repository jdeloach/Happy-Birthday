package net.jtmcgee.project.happybirthday;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.jtmcgee.project.happybirthday.model.Birthday;
import net.jtmcgee.project.happybirthday.utils.Config;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

@SuppressWarnings("serial")
public class HappyBirthdayServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
		FacebookClient fbClient = new DefaultFacebookClient(Config.ACCESS_TOKEN(req));
		Birthday bday = null;
	}
}
