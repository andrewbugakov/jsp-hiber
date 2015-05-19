/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hiber;

import java.util.LinkedList;
import java.util.List;
import org.hibernate.*;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author БОСС ЗДЕСЬ
 */
public class Service0 {
    private static Session session;
    public static Session GetSession(){
        return session;
    }
    public static List<Department> getListById(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Service p=(Service)session.createCriteria(Service.class)
    .add(Restrictions.eq("id_service", id)).uniqueResult();
        System.err.println("bugakov"+p.toString());
        List<Department> d=p.getIdDepartment();
        System.err.println(d.toString());
        t.commit();
        session.close();
        return d;
    }
    public static void createService(Session session,String name_service)
    {
        List<Department> DepartmentList = new LinkedList<Department>();
        Service service = new Service(name_service,DepartmentList);
        session.save(service);
    }
    public static Service getById(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Service p=(Service)session.createCriteria(Service.class)
    .add(Restrictions.eq("id_service", id)).uniqueResult();
        t.commit();
        session.close();
        return p;
    }
    public static void createService(String name_service)
    {
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        List<Department> DepartmentList = new LinkedList<Department>();
        Service service = new Service(name_service,DepartmentList);
        session.save(service);
        t.commit();
        session.close();
    }
    public static void updService(int id,String name_new){
         Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Service service = (Service)session.createCriteria(Service.class)
    .add(Restrictions.eq("id_service", id)).list().get(0);
        service.setNameService(name_new);
        session.update(service);
        t.commit();
        session.close();
    }
    public static void deleteService(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.delete((Service)session.createCriteria(Service.class)
        .add(Restrictions.eq("id_service", id)).list().get(0));
        t.commit();
        session.close();
    }

    /**
     *
     */
    public static Session OpenSession(){
         session = NewHibernateUtil.getSessionFactory().openSession(); 
        session.beginTransaction();
        return session;
    }
    public static void CloseSession(){
        session.getTransaction().commit();
        if (session != null && session.isOpen()) {
                    session.close();
                }
        NewHibernateUtil.getSessionFactory().close();
    }
    public static List<Service> GetServices(){
       Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        List<Service> service =  session.createCriteria(Service.class).list();
        //System.out.println("Service n"+ service.size());
        t.commit();
        session.close();
        return service;
    }
    public static List<Service> GetServices(Session session){
        //Session session=OpenSession();
        List<Service> service =  session.createCriteria(Service.class).list();
        //System.out.println("Service n"+ service.size());
        //CloseSession(session);
        return service;
    }
//DevExtreme
    public static void selectService(){
        Session session=OpenSession();
       List<Service> service =  (List<Service>)session.createCriteria(Service.class).list();//session.createQuery("from hiber.Service").list();
        System.out.println("Services");
        for (Service srv : service) {
            System.out.println("Service "+srv.getNameService()+ " " + srv.getIdService());
        }
        CloseSession();
  }
    
}
