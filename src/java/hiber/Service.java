/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author БОСС ЗДЕСЬ
 */
//@javax.persistence.SequenceGenerator(name="SEQ2_ID",sequenceName="SEQ2_ID")
package hiber;

import java.util.List;
import javax.persistence.*;


@Entity
@Table (name = "service")
public class Service {
    @Id 
    @Column(name = "id_service")
    @GeneratedValue (strategy=GenerationType.AUTO)//(generator = "SEQ2_ID")
    private int id_service;
    @Column (name = "name_service", length = 100)
    private String name_service;
    
    //@OneToMany (cascade = CascadeType.ALL,fetch=FetchType.LAZY)
    //@JoinColumn(name="id_department") 
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "service")
    private List<Department> departments;
    public Service(){super();}
    public Service(String name_service,List<Department> departments){
        this.name_service=name_service;
        this.departments=departments;
    }
    public void setDepartment(List<Department> departments){
        this.departments=departments;
    }
    public List<Department> getIdDepartment(){
        return departments;
    }
    public void setIdService(Integer id_service){
        this.id_service=id_service;
    }
    public Integer getIdService(){
        return id_service;
    }
    public void setNameService(String name_service){
        this.name_service=name_service;
    }
    public String getNameService(){
        return name_service;
    }
    
}
