/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hiber;


import java.util.LinkedList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author БОСС ЗДЕСЬ
 */
public class Department0 {
    public static List<Person> getListById(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Department p=(Department)session.createCriteria(Department.class)
    .add(Restrictions.eq("id_department", id)).uniqueResult();
        System.err.println("bugakov"+p.toString());
        List<Person> d=p.getPerson();
        System.err.println(d.toString());
        t.commit();
        session.close();
        return d;
    }
   
    public static void createDepartment(String name_department,int id_service)
    {
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Service service=(Service)session.createCriteria(Service.class)
    .add(Restrictions.eq("id_service", id_service)).list().get(0);
        List<Person> persons = new LinkedList<Person>();
        Department dept = new Department(name_department,service,persons);
        List<Department> s=service.getIdDepartment();
        s.add(dept);
        service.setDepartment(s);
        session.update(service);
        session.save(dept);
        t.commit();
        session.close();
        
    }
    public static void updDepartment(int id,String name_d,String name){
         Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Department dept = (Department)session.createCriteria(Department.class)
    .add(Restrictions.eq("id_department", id)).uniqueResult();
        dept.setNameDepartment(name_d);
        dept.setNameDepartment(name);
        session.update(dept);
        t.commit();
        session.close();
    }
    //не работает удаление
    public static void deleteDepartment(int name_for_del){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Department d=(Department)session.createCriteria(Department.class)
                .add(Restrictions.eq("id_department", name_for_del)).uniqueResult();
        Service c=d.getService();
        c.getIdDepartment().remove(d);
        session.delete(d);
        session.save(c);
         t.commit();
        session.close();
        /*String hql = "delete from department where name_department= :name_department";
        session.createQuery(hql).setString("name_department", name_for_del).executeUpdate();*/
        
    }
    public static void createDepartment(Session session,Department dept)
    {
        session.save(dept);
    }
    public static void updDepartment(Session session,Department dept){
        session.update(dept);
    }
    //не работает удаление
    public static void deleteDepartment(Session session,Department dept){
        Service c=dept.getService();
        c.getIdDepartment().remove(dept);
        session.delete(dept);
        session.save(c);
        
        /*String hql = "delete from department where name_department= :name_department";
        session.createQuery(hql).setString("name_department", name_for_del).executeUpdate();*/
        
    }
    public static Department getById(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Department p=(Department)session.createCriteria(Department.class)
    .add(Restrictions.eq("id_department", id)).uniqueResult();
        t.commit();
        session.close();
        return p;
    }
    public static Session OpenSession(){
        Session session = NewHibernateUtil.getSessionFactory().openSession(); 
        session.beginTransaction();
        return session;
    }
    public static void CloseSession(Session session){
        session.getTransaction().commit();
        if (session != null && session.isOpen()) {
                    session.close();
                }
        NewHibernateUtil.getSessionFactory().close();
    }
    public static List<Department> GetDepartments(){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        List<Department> depart =  session.createCriteria(Department.class).list();
        //System.out.println("Service n"+ service.size());
        t.commit();
        session.close();
        return depart;
    }
    public static List<Department> GetDepartments(Session session){
        //Session session=OpenSession();
        List<Department> depart =  session.createCriteria(Department.class).list();
        //System.out.println("Service n"+ service.size());
        //CloseSession(session);
        return depart;
    }
}
