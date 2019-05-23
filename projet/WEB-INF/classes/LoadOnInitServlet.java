


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet (urlPatterns = "/seulement-on-init",
		loadOnStartup = 1
)

public class LoadOnInitServlet extends HttpServlet {



    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init(ServletConfig arg0) throws ServletException {
		super.init(arg0);
		try {
			System.out.println("--------------------------------------------------------------------------------------");
			Class.forName("persistentdata.MediathequeData");
			System.out.println("--------------------------------------------------------------------------------------");
			
			} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
