package ge.mimino.travel.model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import java.sql.Timestamp;

@Entity
public class Users {
    private int userId;
    private String userDesc;
    private String userName;
    private String userPassword;
    private int typeId;
    private int deleted;
    private String email;
    private String emailPass;
    private Timestamp createDate;

    @Basic
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "user_desc")
    public String getUserDesc() {
        return userDesc;
    }

    public void setUserDesc(String userDesc) {
        this.userDesc = userDesc;
    }

    @Basic
    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "user_password")
    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    @Basic
    @Column(name = "type_id")
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    @Basic
    @Column(name = "deleted")
    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    @Basic
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "email_pass")
    public String getEmailPass() {
        return emailPass;
    }

    public void setEmailPass(String emailPass) {
        this.emailPass = emailPass;
    }

    @Basic
    @Column(name = "create_date")
    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Users users = (Users) o;

        if (userId != users.userId) return false;
        if (typeId != users.typeId) return false;
        if (deleted != users.deleted) return false;
        if (userDesc != null ? !userDesc.equals(users.userDesc) : users.userDesc != null) return false;
        if (userName != null ? !userName.equals(users.userName) : users.userName != null) return false;
        if (userPassword != null ? !userPassword.equals(users.userPassword) : users.userPassword != null) return false;
        if (email != null ? !email.equals(users.email) : users.email != null) return false;
        if (emailPass != null ? !emailPass.equals(users.emailPass) : users.emailPass != null) return false;
        if (createDate != null ? !createDate.equals(users.createDate) : users.createDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId;
        result = 31 * result + (userDesc != null ? userDesc.hashCode() : 0);
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (userPassword != null ? userPassword.hashCode() : 0);
        result = 31 * result + typeId;
        result = 31 * result + deleted;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (emailPass != null ? emailPass.hashCode() : 0);
        result = 31 * result + (createDate != null ? createDate.hashCode() : 0);
        return result;
    }
}
