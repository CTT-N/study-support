package service;

import dao.SubjectDAO;
import model.Subject;

import java.util.List;

public class SubjectService {

    private SubjectDAO dao = new SubjectDAO();

    public List<Subject> getSubjectsByUser(int userId) {
        return dao.findByUser(userId);
    }

    public boolean createSubject(Subject s) {

        if (s.getSubjectName() == null || s.getSubjectName().isEmpty()) {
            return false;
        }

        return dao.insert(s);
    }

    public boolean deleteSubject(int id) {
        return dao.delete(id);
    }
}