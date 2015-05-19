/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hiber;

import java.util.LinkedList;
import java.util.List;
import net.sf.ehcache.hibernate.*;
import org.hibernate.*;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author БОСС ЗДЕСЬ
 */
public class Person0 {
    public static void createPerson(int id_department,String person_name,String person_position,String person_post,String tl_vn,String tl_gor)
    {
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Department dept=(Department)session.createCriteria(Department.class).add(Restrictions.eq("id_department", id_department)).list().get(0);
        //dept.setIdDepartment(((Department)session.createCriteria(Department.class).add(Restrictions.eq("id_department", id_department)).list().get(0)).getIdDepartment());
        List<Person> list=dept.getPerson();
        Person person=new Person(person_name,person_position,person_post,dept,tl_vn,tl_gor);
        list.add(person);
        dept.setPerson(list);
        session.update(dept);
        session.save(person);
        t.commit();
        session.close();
    }
    public static Person getById(int id){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Person p=(Person)session.createCriteria(Person.class)
    .add(Restrictions.eq("id_person", id)).uniqueResult();
        t.commit();
        session.close();
        return p;
    }
    
    public static void updPerson(int id,int id_depart,String name_new,String p_position,String person_post,String tel_gor,String tel_vn){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Person person = (Person)session.createCriteria(Person.class)
    .add(Restrictions.eq("id_person", id)).uniqueResult();
        Department dept=(Department)session.createCriteria(Department.class).add(Restrictions.eq("id_department", id_depart)).list().get(0);
        person.setPersonName(name_new);
        person.setDepartment(dept);
        person.setPersonPosition(p_position);
        person.setPersonPost(person_post);
        person.setTelGor(tel_gor);
        person.setTelVn(tel_vn);
        session.update(person);
        t.commit();
        session.close();
    }
    public static void deletePerson(int name_for_del){
       Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.delete((Person)session.createCriteria(Person.class)
    .add(Restrictions.eq("id_person", name_for_del)).uniqueResult());
        t.commit();
        session.close();
    }
    public static void createPerson(Session session,Person person)
    {
        session.save(person);
    }
    public static void updPerson(Session session,Person person){
        session.update(person);
    }
    public static void deletePerson(Session session,Person person){
        session.delete(person);
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
    public static List<Person> getPersons(){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        List<Person> persons =  session.createCriteria(Person.class).list();
        //System.out.println("Service n"+ service.size());
        t.commit();
        session.close();
        return persons;
    }
     public static List<Person> GetPersons(Session session){
        //Session session=OpenSession();
        List<Person> persons =  session.createCriteria(Person.class).list();
        //System.out.println("Service n"+ service.size());
        //CloseSession(session);
        return persons;
    }
}
