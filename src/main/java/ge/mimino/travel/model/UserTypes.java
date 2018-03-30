package ge.mimino.travel.model;

import javax.persistence.*;

@Entity
@Table(name = "user_types")
public class UserTypes {
    private Integer userTypeId;
    private String userTypeName;

    @Id
    @Column(name = "user_type_id")
    public Integer getUserTypeId() {
        return userTypeId;
    }

    public void setUserTypeId(Integer userTypeId) {
        this.userTypeId = userTypeId;
    }

    @Basic
    @Column(name = "user_type_name")
    public String getUserTypeName() {
        return userTypeName;
    }

    public void setUserTypeName(String userTypeName) {
        this.userTypeName = userTypeName;
    }
}
