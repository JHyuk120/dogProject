package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import dev.mvc.recipe.RecipeVO;
import dev.mvc.admin.AdminProcInter;
import dev.mvc.cook_multi.Cook_multiProcInter;
import dev.mvc.cook_multi.Cook_multiVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.reply.ReplyVO;

@Controller
public class ReplyCont {
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    @Autowired
    @Qualifier("dev.mvc.recipe.RecipeProc") 
    private RecipeProcInter recipeProc;
    
    @Autowired
    @Qualifier("dev.mvc.reply.ReplyProc")
    private ReplyProcInter replyProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;
    
    @Autowired
    @Qualifier("dev.mvc.admin.AdminProc")
    private AdminProcInter adminProc;
    
    @Autowired
    @Qualifier("dev.mvc.cook_multi.Cook_multiProc")
    private Cook_multiProcInter cook_multiProc;
    
    
    public ReplyCont() {
        System.out.println("-> ReplyCont created");
    }
    /**
     * 
    * 리뷰 처리
    * @param session
    * @param reviewVO
    * @param contentsVO
    * @return
    */
   @RequestMapping(value="/reply/reply_create.do", method=RequestMethod.POST)
   public ModelAndView reply_create (HttpSession session,ReplyVO replyVO,RecipeVO recipeVO){ 
       
       ModelAndView mav = new ModelAndView();
       int cnt=this.replyProc.reply_create(replyVO);
       
     if(memberProc.isMember(session)) {
         
         if (cnt == 1) {
             mav.addObject("recipe", recipeVO);
             mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());
         } else {
           mav.addObject("code", "reply_create_fail");
         }
     }
      else {
         mav.addObject("url", "/member/login_need"); 
         mav.setViewName("redirect:/reply/msg.do"); 
     }
     return mav;
   }

   
   /**
    * 
   * 리뷰 수정 폼
   * http://localhost:9093/reply/reply_update.do?
   * @param session
   * @param reviewVO
   * @param contentsVO
   * @return
   */
  @RequestMapping(value="/reply/update.do", method=RequestMethod.GET)
  public ModelAndView reply_update (HttpSession session, int replyno, int recipeno, ReplyVO replyVO ){ 
      ModelAndView mav = new ModelAndView();
      //현재 로그인된 id
      String currentUserId = (String) session.getAttribute("id");
      ReplyVO replyVOmid = this.replyProc.reply_read(replyVO.getReplyno());
      
      if (replyVOmid != null) {
          if(replyVOmid.getMid().equals(currentUserId)) {
              RecipeVO recipeVO = this.recipeProc.read(recipeno);
              mav.addObject("recipeVO", recipeVO);
              ReplyVO reply2VO = this.replyProc.reply_read(replyno);
              mav.addObject("replyVO", reply2VO);        
              mav.setViewName("/reply/read_update");
              
              ArrayList<Cook_multiVO> list2 = this.cook_multiProc.read(recipeno);
              mav.addObject("list2", list2);
              
              // 댓글 조회  
              ArrayList<ReplyVO> list = this.replyProc.list_by_reply_paging(replyVO);
              mav.addObject("list", list);
              String paging = replyProc.pagingBox(replyVO.getRecipeno(), replyVO.getNow_page(),"read.do");
              mav.addObject("paging", paging);
          }else {
              mav.addObject("code", "reply_update_fail");
              mav.addObject("url", "/member/msg");
              mav.setViewName("redirect:/member/msg.do");              
          }
      }
      else {
          mav.setViewName("./reply/login_need");
      }


    return mav;
  }
  /**
   * 
  * 리뷰 수정 처리
  * http://localhost:9093/reply/reply_update.do?
  * @param session
  * @param reviewVO
  * @param contentsVO
  * @return
  */
  @RequestMapping(value = "/reply/update.do", method = RequestMethod.POST)
  public ModelAndView reply_update(ReplyVO replyVO,int recipeno) {
      ModelAndView mav = new ModelAndView();
          this.replyProc.reply_update(replyVO);
          mav.addObject("replyno", replyVO.getReplyno());
          mav.addObject("recipeno", recipeno);
          mav.setViewName("redirect:/recipe/read.do");
      return mav;
  }
  
  /**
   * 
  * 리뷰 삭제 처리
  * http://localhost:9093/reply/reply_update.do?
  * @param session
  * @param reviewVO
  * @param contentsVO
  * @return
  */
 @RequestMapping(value = "/reply/delete.do", method = RequestMethod.GET)
 public ModelAndView reply_delete(HttpSession session, ReplyVO replyVO, int replyno,int recipeno) {
     ModelAndView mav = new ModelAndView();

     // 현재 로그인된 id
     String currentUserId = (String) session.getAttribute("id");
     ReplyVO replyVOmid = this.replyProc.reply_read(replyno);

     // 아이디 확인
     if (replyVOmid != null) {
         if(replyVOmid.getMid().equals(currentUserId)) {
             this.replyProc.reply_delete(replyno);
             mav.addObject("replyno", replyVO.getReplyno());
             mav.addObject("recipeno", recipeno);
             mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeno);
         }
         else {
             mav.addObject("code", "reply_delete_fail");
             mav.addObject("url", "/member/msg");
             mav.setViewName("redirect:/member/msg.do");           
         }
     }
     else {
         mav.setViewName("./reply/login_need");
     }
     return mav;
 }  
 
}
