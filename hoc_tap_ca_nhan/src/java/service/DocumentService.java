package service;

import dao.DocumentDAO;
import model.Document;

public class DocumentService {

    private DocumentDAO dao = new DocumentDAO();

    public boolean uploadDocument(Document d) {

        // validate cơ bản
        if (d.getDocumentName() == null || d.getDocumentName().isEmpty()) {
            return false;
        }

        if (d.getFileSize() <= 0) {
            return false;
        }

        return dao.insert(d);
    }
}