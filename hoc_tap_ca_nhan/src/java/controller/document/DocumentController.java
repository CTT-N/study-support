package controller.document;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;

import dao.DocumentDAO;
import model.Document;

import java.io.File;
import java.io.IOException;

@MultipartConfig
public class DocumentController extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private DocumentDAO dao = new DocumentDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int subjectId = Integer.parseInt(req.getParameter("subjectId"));

        Part filePart = req.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // LƯU DB
        Document d = new Document();
        d.setSubjectId(subjectId);
        d.setDocumentName(fileName);
        d.setFilePath(filePath);
        d.setFileType(filePart.getContentType());
        d.setFileSize(filePart.getSize());

        dao.insert(d);

        resp.sendRedirect("documents?subjectId=" + subjectId);
    }
}