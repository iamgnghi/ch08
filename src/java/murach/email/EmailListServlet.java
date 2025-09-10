package murach.email;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import murach.business.User;
import murach.data.UserDB;
import murach.data.UserIO;

// ➕ import cho kiểm tra ngày sinh
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class EmailListServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "join";

        String url = "/index.jsp";

        if (action.equals("join")) {
            url = "/index.jsp";
        }
        else if (action.equals("add")) {
            // --- Lấy tham số từ form ---
            String firstName = request.getParameter("firstName");
            String lastName  = request.getParameter("lastName");
            String email     = request.getParameter("email");
            String dob       = request.getParameter("dob");   // ➕ NGÀY SINH

            // --- Kiểm tra server-side: tất cả bắt buộc & dob không ở tương lai ---
            String error = null;
            if (isBlank(firstName) || isBlank(lastName) || isBlank(email) || isBlank(dob)) {
                error = "Please fill out all required fields.";
            } else {
                try {
                    LocalDate parsed = LocalDate.parse(dob); // yêu cầu dạng yyyy-MM-dd
                    if (parsed.isAfter(LocalDate.now())) {
                        error = "Date of birth cannot be in the future.";
                    }
                } catch (DateTimeParseException ex) {
                    error = "Invalid date of birth.";
                }
            }

            if (error != null) {
                // Giữ lại dữ liệu người dùng đã nhập
                User u = new User(firstName, lastName, email);
                u.setDob(dob); // giữ lại dob để hiển thị lại trên form
                request.setAttribute("user", u);
                request.setAttribute("error", error);
                url = "/index.jsp"; // quay lại form
            } else {
                // --- Tạo User & lưu ---
                User user = new User(firstName, lastName, email);
                user.setDob(dob);                  // ➕ GÁN DOB VÀO USER

                UserDB.insert(user);               // nếu DB chưa có cột DOB có thể bỏ qua
                // (tuỳ chọn) UserIO.appendUser(...) nếu bạn lưu file

                // --- Đưa user sang trang thanks ---
                request.setAttribute("user", user);
                url = "/thanks.jsp";
            }
        }

        // Ngày hiện tại cho thanks.jsp
        Date currentDate = new Date();
        request.setAttribute("currentDate", currentDate);

        // Danh sách users demo trong session (đọc từ file)
        String path = getServletContext().getRealPath("/WEB-INF/EmailList.txt");
        ArrayList<User> users = UserIO.getUsers(path);
        HttpSession session = request.getSession();
        session.setAttribute("users", users);

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    // Helper nhỏ
    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
