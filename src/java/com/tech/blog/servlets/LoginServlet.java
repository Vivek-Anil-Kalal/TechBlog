package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vivek
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            // Login 
            // fetch user email and password ....
            
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password");

            // this userDao has functionalities to store and get data from database so this has a method which returns 
            // the information of user of who's email and password given to it 
            UserDao userDao = new UserDao(ConnectionProvider.getDbConnection());
            
            User user =  userDao.getUserByEmailAndPassword(userEmail, userPassword);
            
            if( user == null ){
                // user doesn't exist 
                
//                out.println("<h1>Invalid Details.... Try again</h1>");
                
                // jab login page par koi bhi submit click karega toh login servlet chalega aur yha msg store hogya but hume msg login.jsp
                // me hi dikhana h so hum redirect kar denge aur msg object ko session me rakh denge taki use hum login.jsp par access kar ske
                // isme msg ko humne pass krdiya ab hume 
                Message msg = new Message("Invalid Details.... ! Try again" , "error" , "alert-danger");
                HttpSession s = request.getSession();
                
                s.setAttribute("msg", msg); // key , value
                response.sendRedirect("login_page.jsp");
                
            }else{
                // login successfully ....
                // Now jab user site open karta h toh ek session ka object banta h aur vo object tab tak rehta h jab tk user browser close 
                // nhi karta ya window band nhi hoti toh hum is user k object ko vo session k object me store kar lenge jis se jab tak
                // window open hogi user login rahega badme window band hote hi logout ho jyga
                // for permanent login we can use cookies ....
                
                                
                // first get that session object using request object 
/*                HttpSession s = request.getSession();
                s.setAttribute("currentUser ", user);
                System.out.println("Session object : " + s.getAttribute("currentUser"));
                response.sendRedirect("profile_page.jsp");
*/

                // first get that session object using request object 
                HttpSession s = request.getSession();
                s.setAttribute("currentUser", user);
                response.sendRedirect("profile_page.jsp");
                // this means ek bar user login hogaya to use hum profile page par redirect kardenge...
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
