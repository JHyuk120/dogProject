package dev.mvc.detail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.pay.PayProcInter;

@Controller
public class DetailCont {
  @Autowired 
  @Qualifier("dev.mvc.detail.DetailProc")
  private DetailProcInter detailProc;
  
  @Autowired 
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;

  @Autowired 
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc;

  @Autowired 
  @Qualifier("dev.mvc.pay.PayProc")
  private PayProcInter payProc;
  
  public DetailCont() {
    System.out.println("-> DetailCont created.");
  }
  
  /**
   * 주문 결재/회원별 목록
   * http://localhost:9093/detail/detail_list.do 
   * @return
   */
  @RequestMapping(value="/detail/detail_list.do", method=RequestMethod.GET )
  public ModelAndView detail_list(HttpSession session,
                                                        int payno) {
    ModelAndView mav = new ModelAndView();
    
    int baesong_tot = 0;   // 배송비 합계
    int tot_sum = 0;        // 할인 금액 총 합계(금액)
    int total_order = 0;     // 전체 주문 금액
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("payno", payno);
      map.put("memberno", memberno);
      
      List<DetailVO> list = this.detailProc.detail_list(map);
      
      for (DetailVO detailVO: list) {
        tot_sum += detailVO.getTot();
      }
      
      if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
        baesong_tot = 3000;
      }
      
      total_order = tot_sum + baesong_tot; // 전체 주문 금액
      
      mav.addObject("baesong_tot", baesong_tot); // 배송비
      mav.addObject("total_order", total_order);     // 할인 금액 총 합계(금액)
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/detail/detail_list"); // /views/detail/detail_list.jsp
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/detail/detail_list.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
  
  /**
   * 관리자가 보는 주문 사항
   * http://localhost:9093/detail/order_list.do 
   * @return
   */
  @RequestMapping(value = "/detail/order_list.do", method = RequestMethod.GET)
  public ModelAndView order_list(HttpSession session) {
    
    ModelAndView mav = new ModelAndView();
        
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/detail/order_list");
    
      ArrayList<DetailVO> list_a = this.detailProc.order_list();
      mav.addObject("list", list_a);
          
    } else {
      mav.setViewName("/admin/login_need");
    }
    
    return mav;
  }
  
  
  /**
   * stateno 증가 (배송 상태)
   */
  @RequestMapping(value="/detail/update_stateno.do", method = RequestMethod.GET)
  public ModelAndView update_stateno(int detailno) {
    ModelAndView mav = new ModelAndView();
    
    int stateno = this.detailProc.update_stateno(detailno);
    if (stateno == 1) {
      mav.setViewName("redirect:/detail/order_list.do");
    }
    mav.addObject("stateno", stateno);
    
    return mav;
  }
  

  /**
   * 회원 주문 취소
   */
  @RequestMapping(value="/detail/cancel.do", method = RequestMethod.GET)
  public ModelAndView cancel(int detailno) {
    ModelAndView mav = new ModelAndView();
    
    int cencel = this.detailProc.cancel(detailno);
    if (cencel == 1) {
      DetailVO detailVO = this.detailProc.read(detailno);
      int payno = detailVO.getPayno();
      int goodsno = detailVO.getGoodsno();
      int cnt = detailVO.getCnt();
      
      for (int i = 1; i <= cnt; i++) {
        int cnt_add = this.goodsProc.cnt_add(goodsno);
      }
      
      mav.setViewName("redirect:/detail/detail_list.do?payno=" + detailVO.getPayno());
    }
    
    return mav;
  }

  /**
   * 관리자 주문 삭제
   */
  @RequestMapping(value="/detail/d_delete.do", method = RequestMethod.GET)
  public ModelAndView d_delete(HttpSession session, int detailno) {
    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("adminno") != null) {
      DetailVO detailVO = this.detailProc.read(detailno);  
      int payno = detailVO.getPayno();
      
      this.detailProc.d_delete(detailno);
      
      DetailVO deVO = this.detailProc.d_read(payno);

      if (deVO == null) {
        this.payProc.p_delete(payno);

      }

      mav.setViewName("redirect:/detail/order_list.do?");
      
    }
    return mav;
  }
  
  
  
  
  
}