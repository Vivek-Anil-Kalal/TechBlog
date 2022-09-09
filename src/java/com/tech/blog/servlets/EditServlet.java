package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

// this is to define ki data jo arh h sender se usme image aur files bhi h not only text 
@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            fetch all data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");

            // this part is used to get details of the image files 
            Part part = request.getPart("image");
            // this will return file name with extention
            String imageName = part.getSubmittedFileName();

            // Ab User ko update krne k liye login k time jo user object humne session object me rkha tha use fetch karke usko update karenge
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser"); // ye sare changes usi user object me honge jo abhi login k time banaya h 

            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile = user.getProfile();     // this is to delete the file from our device after removing or updating 
            user.setProfile(imageName);

            // Update user data in database now this we have to do in UserDao as it's the class to access and update database
            UserDao userDao = new UserDao(ConnectionProvider.getDbConnection());
            boolean ans = userDao.updateUser(user);

            
            if (ans) {    
                //  here RealPath will return path till WebPages uske andar pics me aur file seperator se / aayaga aur fir image name 
                String newFilePath = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

                String oldFilePath = request.getRealPath("/") + "pics" + File.separator + oldFile;

//                System.out.println("Old File :- " + oldFile);
                if (!oldFile.equals("default.png")) {
                    Helper.deleteFile(oldFilePath);
                }

                if (Helper.saveFile(part.getInputStream(), newFilePath)) {
//                    out.println("Profile Updated");

                    Message msg = new Message("Profile Updated", "success", "alert-success");
                    session.setAttribute("msg", msg); // key , value
//                    response.sendRedirect("login_page.jsp");

                } else {
                    Message msg = new Message("Details not updated ! Something went Wrong..", "error", "alert-danger");
                    session.setAttribute("msg", msg); // key , value
                }

            } else {
                Message msg = new Message("Details not updated ! Something went Wrong..", "error", "alert-danger");
                session.setAttribute("msg", msg); // key , value
            }

            response.sendRedirect("profile_page.jsp");
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
