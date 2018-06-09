package ge.mimino.travel.dto;

import ge.mimino.travel.model.City;
import ge.mimino.travel.model.EmailFolders;

import java.util.ArrayList;
import java.util.List;

public class EmailFolderDTO {

    private Integer id;
    private String name;


    public static EmailFolderDTO parse(EmailFolders record) {
        EmailFolderDTO dto = new EmailFolderDTO();
        dto.setId(record.getId());
        dto.setName(record.getName());
        return dto;
    }


    public static List<EmailFolderDTO> parseToList(List<EmailFolders> records) {
        ArrayList<EmailFolderDTO> list = new ArrayList<EmailFolderDTO>();
        for (EmailFolders record : records) {
            list.add(EmailFolderDTO.parse(record));
        }
        return list;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
