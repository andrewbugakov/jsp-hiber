/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hiber;

import javax.persistence.*;


/**
 *
 * @author БОСС ЗДЕСЬ
 */
//@javax.persistence.SequenceGenerator(name="SEQ_ID",sequenceName="SEQ_ID")
@Entity
@Table (name = "person")
public class Person {
    @Id 
    @Column(name = "id_person")
    @GeneratedValue (strategy=GenerationType.AUTO)//(generator = "SEQ_ID")
    private int id_person;
    @Column (name = "person_name", length = 30)
    private String person_name;
    @Column (name = "person_position", length = 100)
    private String person_position;
    @Column (name = "person_post", length = 100)
    private String person_post;
    @ManyToOne (cascade = CascadeType.ALL,fetch=FetchType.LAZY)
    @JoinColumn(name="id_department",insertable = true, updatable = true)
    private Department department;
    @Column (name = "tel_vn", length = 30)
    private String tel_vn;    
    @Column (name = "tel_gor", length = 30)
    private String tel_gor;
    public Person(){
        super();
    }
    public Person(String person_name,String person_position,String person_post,Department department,String tel_vn,String tel_gor){
        this.person_name=person_name;
        this.person_post=person_post;
        this.person_position=person_position;
        this.department=department;
        this.tel_gor=tel_gor;
        this.tel_vn=tel_vn;
    }
    public String getTelVn(){
        return tel_vn;
    }
     public String getTelGor(){
        return tel_gor;
    }
      public void setTelVn(String tel_vn){
        this.tel_vn=tel_vn;
    }
      public void setTelGor(String tel_gor){
        this.tel_gor=tel_gor;
    }
    public Department getDepartment(){
        return department;
    }
    public void setDepartment(Department department){
        this.department=department;
    }
    public void setIdPerson(Integer id_person){
        this.id_person=id_person;
    }
    public Integer getIdPerson(){
        return id_person;
    }
    public void setPersonPosition(String person_position){
        this.person_position=person_position;
    }
    public String getPersonPosition(){
        return person_position;
    }
    public void setPersonName(String person_name){
        this.person_name=person_name;
    }
    public String getPersonName(){
        return person_name;
    }
    public void setPersonPost(String person_post){
        this.person_post=person_post;
    }
    public String getPersonPost(){
        return person_post;
    }
}
