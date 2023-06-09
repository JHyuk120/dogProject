package dev.mvc.answer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.admin.AdminVO;
import dev.mvc.attachfile.AttachfileVO;
import dev.mvc.goods.Goods;
import dev.mvc.goods.GoodsVO;
import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.member.MemberVO;
import dev.mvc.qna.Qna;
import dev.mvc.qna.QnaProcInter;
import dev.mvc.qna.QnaVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class AnswerCont {
  @Autowired
  @Qualifier("dev.mvc.answer.AnswerProc")
  private AnswerProcInter answerProc;
  
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc") 
  private QnaProcInter qnaProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") 
  private AdminProcInter adminProc;
  
  public AnswerCont(){
    System.out.println("--> AnswerCont created.");
  }
  
  // 등록 폼
  // http://localhost:9093/answer/create.do?qnano=1
  @RequestMapping(value="/answer/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpServletRequest request, HttpSession session, int qnano) {
//  public ModelAndView create(HttpServletRequest request,  int itemno) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) { 
      int adminno = (int) (session.getAttribute("adminno"));
      AdminVO adminVO = this.adminProc.read(adminno);
      mav.addObject("adminVO", adminVO);
      String aname = adminVO.getMname();
      
    QnaVO qnaVO = this.qnaProc.read(qnano);
    mav.addObject("qnaVO", qnaVO);
    
    mav.setViewName("/answer/create"); // /webapp/WEB-INF/views/goods/create.jsp
    
    }else {
      mav.addObject("url", "/admin/login_need");
      mav.setViewName("redirect:/answer/msg.do"); 
    }
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9093/answer/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) { // 관리자로 로그인한경우

      int cnt = this.answerProc.create(answerVO); 

      if (cnt == 1) {
        mav.addObject("code", "create_success");
      } else {
          mav.addObject("code", "create_fail");
      }
      mav.addObject("url", "/answer/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/answer/msg.do"); 
      
    } else {
      mav.addObject("url", "/admin/login_need");
    
    }
   
    return mav; // forward
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * @return
   */
  @RequestMapping(value="/answer/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  


/** 
 * http://localhost:9093/answer/read.do?answer_no=1
 * 조회
 * @return
 */
  @RequestMapping(value="/answer/read.do", method=RequestMethod.GET )
  public ModelAndView read(HttpServletRequest request, HttpSession session, int answer_no) {
    ModelAndView mav = new ModelAndView();
      
      AnswerVO answerVO = this.answerProc.read(answer_no);
      System.out.println("answerVO: " + answerVO);
      
      String title = answerVO.getTitle();
      String text = answerVO.getText();
      
      title = Tool.convertChar(title);  // 특수 문자 처리
      text = Tool.convertChar(text); 
      
      answerVO.setTitle(title);
      answerVO.setText(text);  
      
      mav.addObject("answerVO", answerVO); 
      mav.setViewName("/answer/read"); 

    return mav;
  }
  
  
  /**
   * 삭제 폼
   * @param answer_no
   * @return
   */
  @RequestMapping(value="/answer/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int answer_no) { 
    ModelAndView mav = new  ModelAndView();
    
    // 삭제할 정보를 조회하여 확인
    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO);

    
    mav.setViewName("/answer/delete");  // /webapp/WEB-INF/views/answer/delete.jsp
    
    return mav; 
  }
  
  /**
   * 삭제 처리 http://localhost:9091/answer/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    

    this.answerProc.delete(answerVO.getAnswer_no()); // DBMS 삭제

    mav.setViewName("redirect:/qna/list_all.do"); 
  
    return mav;
  }  
  
  // 수정폼
  @RequestMapping(value = "/answer/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(int answer_no) {
    ModelAndView mav = new ModelAndView();
    
    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO);

    
    mav.setViewName("/answer/update_text");

    return mav; // forward
  }
  
  //수정처리
  @RequestMapping(value = "/answer/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(HttpSession session, AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    
    
    if(this.adminProc.isAdmin(session)) {
      this.answerProc.update_text(answerVO);

      mav.addObject("answer_no", answerVO.getAnswer_no());
      mav.setViewName("redirect:/answer/read.do");
    }else {
      if(this.answerProc.password_check(answerVO) == 1) {
        this.answerProc.update_text(answerVO);

      // mav 객체 이용
      mav.addObject("answer_no", answerVO.getAnswer_no());
      mav.setViewName("redirect:/answer/read.do?");
      } else {
        mav.addObject("url", "answer/passwd_check"); 
        mav.setViewName("redirect:/answer/msg.do"); 
      }
    }

    return mav; // forward
  }
    
    // 패스워드 확인
    @RequestMapping(value="/answer/password_check.do", method=RequestMethod.GET )
    public ModelAndView password_check(AnswerVO answerVO) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.answerProc.password_check(answerVO);
      System.out.println("-> cnt:" + cnt);
      
      if(cnt == 0) {
      mav.setViewName("answer/passwd_check"); // /WEB-INF/views/answer/read.jsp
          
      }
      return mav;
    }
    


  
  
}