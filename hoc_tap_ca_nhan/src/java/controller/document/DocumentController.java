package controller.document;
import dao.DocumentDAO;
import model.Document;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig
public class DocumentController extends HttpServlet {
    private DocumentDAO dao = new DocumentDAO();
    
    // hien thi cac tai lieu (cua mon dau tien trong danh sach mon hoc)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // mon hoc co id=1 do lay dau danh sach
        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        
        List<Document> ds = dao.findBySubject(subjectId);
        
        req.setAttribute("documents", ds);
        req.setAttribute("subjectId", subjectId);
        
        req.getRequestDispatcher("/views/document/list.jsp").forward(req, resp);
    }
    // upload + delete tai lieu
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        //1. upload tai lieu
        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        
        Part filePart = req.getPart("file");
        
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // thu muc luu file
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        
        File uploadDir = new File(uploadPath);
        if(!uploadDir.exists())
            uploadDir.mkdir();// chua co thi tao ra
        
        String filePath = uploadPath + File.separator + fileName;
        
        filePart.write(fileName);
        
        // luu DB
        Document d = new Document();
        d.setSubjectId(subjectId);
        d.setDocumentName(fileName);
        d.setFilePath("uploads/"+fileName);
        d.setFileType(filePart.getContentType());
        d.setFileSize(filePart.getSize());
        
        boolean success = dao.insert(d);

        if (success) {
            resp.sendRedirect("documents?subjectId=" + subjectId + "&msg=success");
        } else {
            resp.sendRedirect("documents?subjectId=" + subjectId + "&msg=error");
        }
        
        //2.delete
        String action = req.getParameter("action");
        if("delete".equals(action)){
            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            resp.sendRedirect("documents?subjectId="+req.getParameter("subjectId"));
            return;
        }
    }
}