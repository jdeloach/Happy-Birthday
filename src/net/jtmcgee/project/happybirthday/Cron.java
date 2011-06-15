package net.jtmcgee.project.happybirthday;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class Cron extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws IOException {
		// go to DB, look up bdays added
			// for each user, get OAuth
				//publish to wall
	}
}
