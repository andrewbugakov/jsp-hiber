/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hiber;

import java.util.List;
import javax.persistence.*;
import org.hibernate.annotations.GenericGenerator;
//@javax.persistence.SequenceGenerator(name="SEQ1_ID",sequenceName="SEQ1_ID")
@Entity
@Table (name = "department")
public class Department {
    @Id 
    @GeneratedValue(strategy=GenerationType.AUTO)
    //@GenericGenerator(name="kaugen" , strategy="increment")
    //@GeneratedValue(generator="kaugen")
    @Column(name = "id_department")
    ////(generator = "SEQ1_ID")   
    private int id_department;
    @Column (name = "name_department", length = 100)
    private String name_department;
    @ManyToOne
    @JoinColumn(name = "id_service")
    //@ManyToOne (cascade=CascadeType.ALL,fetch=FetchType.LAZY)//cascade=CascadeType.ALL,
    //@JoinColumn(name="id_service",insertable = true, updatable = true)//nullable=false)
    private Service service;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "department")
    //@OneToMany (cascade=CascadeType.ALL,fetch=FetchType.LAZY)
    //@JoinColumn(name="id_person",insertable = true, updatable = true)
    private List<Person> persons;
    public Department(){
        super();
    }
    public Department(String name_department,Service service,List<Person> persons){
        this.name_department=name_department;
        this.service=service;
        List<Department> d=service.getIdDepartment();
        d.add(this);
        service.setDepartment(d);
        this.persons=persons;
    }
    public void setPerson(List<Person> person){
        this.persons=person;
    }
    public  List<Person> getPerson(){
        return persons;
    }
    public void setService(Service service){
        this.service=service;
    }
    public Service getService(){
        return service;
    }
    public void setIdDepartment(Integer id_department){
        this.id_department=id_department;
    }
    public Integer getIdDepartment(){
        return id_department;
    }
    public void setNameDepartment(String name_department){
        this.name_department=name_department;
    }
    public String getNameDepartment(){
        return name_department;
    }
}
