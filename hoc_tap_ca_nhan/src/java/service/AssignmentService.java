package service;

import dao.AssignmentDAO;
import model.Assignment;

import java.util.List;

public class AssignmentService {

    private AssignmentDAO dao = new AssignmentDAO();

    public List<Assignment> getBySubject(int subjectId) {
        return dao.findBySubject(subjectId);
    }

    public boolean create(Assignment a) {

        if (a.getTitle() == null || a.getTitle().isEmpty()) {
            return false;
        }

        return dao.insert(a);
    }

    public boolean updateStatus(int id, String status) {

        if (!status.equals("pending") && !status.equals("done") && !status.equals("overdue")) {
            return false;
        }

        return dao.updateStatus(id, status);
    }
}