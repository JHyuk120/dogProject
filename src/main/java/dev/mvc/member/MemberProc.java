package dev.mvc.member;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
  @Autowired
  private MemberDAOInter memberDAO;
  
  public MemberProc(){
    System.out.println("-> MemberProc created.");
  }

  @Override
  public int checkID(String id) {
    int cnt = this.memberDAO.checkID(id);
    return cnt;
  }
  

  @Override
  public int create(MemberVO memberVO) {
    int cnt = this.memberDAO.create(memberVO);
    return cnt;
  }

  @Override
  public ArrayList<MemberVO> list() {
    ArrayList<MemberVO> list = this.memberDAO.list();
    return list;
  }

  @Override
  public MemberVO read(int memberno) {
    MemberVO memberVO = this.memberDAO.read(memberno);
    return memberVO;
  }

  @Override
  public MemberVO readById(String id) {
    MemberVO memberVO = this.memberDAO.readById(id);
    return memberVO;
  }

  @Override
  public boolean isMember(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    
    if (session != null) {
      String id = (String) session.getAttribute("id");
      
      if(id != null) {
        sw = true;
        
      }
    }
    
    return sw;
  }

  @Override
  public int update(MemberVO memberVO) {
    int cnt = this.memberDAO.update(memberVO);
    return cnt;
  }
  
  @Override
  public MemberVO idFind(MemberVO memberVO) {
    MemberVO vo = this.memberDAO.idFind(memberVO);
    return vo;
  }
  
  @Override
  public MemberVO pwFind(MemberVO memberVO) {
    MemberVO vo = this.memberDAO.pwFind(memberVO);
    return vo;
  }


 

  @Override
  public int delete(int memberno) {
    int cnt = this.memberDAO.delete(memberno);
    return cnt;
  }

  @Override
  public int passwd_check(HashMap<Object, Object> map) {
    int cnt = this.memberDAO.passwd_check(map);
    return cnt;
  }

  @Override
  public int passwd_update(HashMap<Object, Object> map) {
    int cnt = this.memberDAO.passwd_update(map);
    return cnt;
  }

  @Override
  public int login(HashMap<String, Object> map) {
    int cnt = this.memberDAO.login(map);
    return cnt;
  }

@Override
public int recommend_memberno(MemberVO memberVO) {
    int memberno = this.memberDAO.recommend_memberno(memberVO);
    return memberno;
}

@Override
public int mpoint_update(MemberVO memberVO) {
  int cnt = this.memberDAO.mpoint_update(memberVO);
  return cnt;
}





 
  

}
 