package controller.document;

import dao.DocumentDAO;
import dao.SubjectDAO;
import model.Document;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import model.Subject;

@MultipartConfig
public class DocumentController extends HttpServlet {

    private DocumentDAO dao = new DocumentDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        List<Document> ds = dao.findBySubject(subjectId);
        
        // thêm đoạn này để lấy tên môn học
        Subject subject = subjectDAO.findById(subjectId);
        req.setAttribute("subject", subject);
        
        req.setAttribute("documents", ds);
        req.setAttribute("subjectId", subjectId);

        req.getRequestDispatcher("/views/document/document-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        int subjectId = Integer.parseInt(req.getParameter("subjectId"));

        // ------- xóa tài liệu
        if ("delete".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));

            Document doc = dao.findById(id);

            if (doc != null) {
                String fullPath = getServletContext().getRealPath("/") + doc.getFilePath();
                File f = new File(fullPath);
                if (f.exists()) f.delete(); // xóa file vật lý
            }

            dao.delete(id);

            resp.sendRedirect("documents?subjectId=" + subjectId);
            return;
        }

        // ---------upload tai lieu
        Part filePart = req.getPart("file");

        String fileName = Paths.get(filePart.getSubmittedFileName())
                               .getFileName().toString();

        // validate file (kieemr tra file upload là loại gì, cho phép pdf, docx, ảnh
        String type = filePart.getContentType();

        boolean isValid =
                type.startsWith("image") ||
                type.equals("application/pdf") ||
                type.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document");

        if (!isValid) {
            resp.sendRedirect("documents?subjectId=" + subjectId + "&msg=invalid");
            return;
        }

        // tạo thư mục uploads
        String uploadPath = getServletContext().getRealPath("/uploads");

        // tạo thư mục theo subject
        String subjectFolder = uploadPath + File.separator + "subject_" + subjectId;

        File dir = new File(subjectFolder);
        if (!dir.exists()) dir.mkdirs();

        // ====== tránh trùng tên file ======
        String newFileName = System.currentTimeMillis() + "_" + fileName;

        String filePath = subjectFolder + File.separator + newFileName;

        // lưu file
        filePart.write(filePath);

        // lưu DB
        Document d = new Document();
        d.setSubjectId(subjectId);
        d.setDocumentName(newFileName);
        d.setFilePath("uploads/subject_" + subjectId + "/" + newFileName);
        d.setFileType(type);
        d.setFileSize(filePart.getSize());

        boolean success = dao.insert(d);

        if (success) {
            resp.sendRedirect("documents?subjectId=" + subjectId + "&msg=success");
        } else {
            resp.sendRedirect("documents?subjectId=" + subjectId + "&msg=error");
        }
    }
}