package dev.mvc.review;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.goods.Goods;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.recipe.RecipeVO;
import dev.mvc.reply.ReplyVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ReviewCont {

    @Autowired
    @Qualifier("dev.mvc.review.ReviewProc")
    private ReviewProcInter reviewProc;
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;
    @Autowired
    @Qualifier("dev.mvc.goods.GoodsProc")
    private GoodsProcInter goodsProc;
    
    public ReviewCont() {
        System.out.println("-> ReviewCont created");
    }
        /**
         * 리뷰 처리
         * @param session
         * @param reviewVO
         * @param goodsVO
         * @return
         */
       @RequestMapping(value="/review/create.do", method=RequestMethod.POST)
       public ModelAndView review_create (HttpSession session,ReviewVO reviewVO, GoodsVO goodsVO){ 
           ModelAndView mav = new ModelAndView();
           
           
         if(memberProc.isMember(session)) {
            // if (cnt == 1) {

                 // 별점 평균 계산 
                 this.reviewProc.ratingAVG_cal(reviewVO.getGoodsno());
                 // 업데이트된 별점 평균 조회
                 float ratingAVG = this.reviewProc.ratingAVG(goodsVO.getGoodsno());
                 
                 mav.addObject("ratingAVG", ratingAVG);
                 mav.addObject("goods", goodsVO);
                 mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno());

                 // ------------------------------------------------------------------------------
                 // 파일 전송 코드 시작
                 // ------------------------------------------------------------------------------
                 String file2 = "";          // 원본 파일명 image
                 String file2saved = "";   // 저장된 파일명, image
                 String thumb2 = "";     // preview image
                 String upDir =  Review.getUploadDir();
                 System.out.println("-> upDir: " + upDir);
                 
                 // 전송 파일이 없어도 file1MF 객체가 생성됨.
                 // <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 //           value='' placeholder="파일 선택">
                 MultipartFile mf = reviewVO.getFile2MF();
                 

                 file2 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
                 System.out.println("-> file2: " + file2);
                 
                 long size2 = mf.getSize();  // 파일 크기
                 
                 if (size2 > 0) { // 파일 크기 체크
                   // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
                   file2saved = Upload.saveFileSpring(mf, upDir); 
                   
                   if (Tool.isImage(file2saved)) { // 이미지인지 검사
                     // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                     thumb2 = Tool.preview(upDir, file2saved, 200, 150); 
                   }
                   
                 }    

                 reviewVO.setFile2(file2);   // 순수 원본 파일명
                 reviewVO.setFile2saved(file2saved); // 저장된 파일명(파일명 중복 처리)
                 reviewVO.setThumb2(thumb2);      // 원본이미지 축소판
                 reviewVO.setSize2(size2);  // 파일 크기
                 
                 // ------------------------------------------------------------------------------
                 // 파일 전송 코드 종료
                 // ------------------------------------------------------------------------------
                 
                 // Call By Reference: 메모리 공유, Hashcode 전달
                 int memberno = (int)(session.getAttribute("memberno"));
                 reviewVO.setMemberno(memberno); 

                 this.reviewProc.review_create(reviewVO);
                 // ------------------------------------------------------------------------------
                 // PK의 return
                 // ------------------------------------------------------------------------------
                 // System.out.println("--> goodsno: " + goodsVO.getGoodsno());
                 // mav.addObject("goodsno", goodsVO.getGoodsno()); // redirect parameter 적용



//-----------------------------------------------------------------------------------------------------------------------------------------------
           /**  } else {
               mav.addObject("code", "review_create_fail");
             }*/
         }else {
             mav.addObject("url", "/member/login_need"); 
             mav.setViewName("redirect:/review/msg.do"); 
         }
         return mav;
       }
       /**
        * 
       * 리뷰 수정 폼
       * http://localhost:9093/review/update.do?
       * @param session
       * @param reviewVO
       * @param contentsVO
       * @return
       */
      @RequestMapping(value="/review/update.do", method=RequestMethod.GET)
      public ModelAndView review_update (int reviewno, int goodsno, ReviewVO reviewVO ){ 
          ModelAndView mav = new ModelAndView();
          
          GoodsVO goodsVO = this.goodsProc.read(goodsno);
          mav.addObject("goodsVO", goodsVO);
          
          ReviewVO review2VO = this.reviewProc.review_read(reviewno);
          mav.addObject("reviewVO", review2VO);
          
          
          // 댓글 조회
          ArrayList<ReviewVO> list = this.reviewProc.list_by_review_paging(reviewVO);
          mav.addObject("list", list);
          String paging = reviewProc.pagingBox(reviewVO.getGoodsno(), reviewVO.getNow_page(),"read.do");
          mav.addObject("paging", paging);

          
        mav.setViewName("/review/review_update");
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
      @RequestMapping(value = "/review/update.do", method = RequestMethod.POST)
      public ModelAndView review_update(HttpSession session, ReviewVO reviewVO, int goodsno) {
          ModelAndView mav = new ModelAndView();
          //현재 로그인된 id
          String currentUserId = (String) session.getAttribute("id");
          ReviewVO reviewVOmid = this.reviewProc.review_read(reviewVO.getReviewno());
          
           // 아이디 확인
          if (reviewVOmid != null && reviewVOmid.getMid().equals(currentUserId)) {
              this.reviewProc.review_update(reviewVO);
              mav.addObject("reviewno", reviewVO.getReviewno());
              mav.addObject("goodsno", goodsno);
              mav.setViewName("redirect:/goods/read.do");
          } else {
              mav.setViewName("./reply/login_need");
          }
          return mav;
      }
      /**
       * 리뷰 삭제
       * @param session
       * @param reviewVO
       * @param goodsno
       * @param reviewno
       * @return
       */
      @RequestMapping(value = "/review/delete.do", method = RequestMethod.GET)
      public ModelAndView review_delete(HttpSession session, ReviewVO reviewVO, int goodsno, int reviewno) {
          ModelAndView mav = new ModelAndView();
          //현재 로그인된 id
          String currentUserId = (String) session.getAttribute("id");
          ReviewVO reviewVOmid = this.reviewProc.review_read(reviewVO.getReviewno());
          
           // 아이디 확인
          if (reviewVOmid != null && reviewVOmid.getMid().equals(currentUserId)) {
              this.reviewProc.review_delete(reviewno);
              mav.addObject("reviewno", reviewVO.getReviewno());
              mav.addObject("goodsno", goodsno);
              mav.setViewName("redirect:/goods/read.do?goodno="+goodsno);
          } else {
              mav.setViewName("./reply/login_need");
          }
          return mav;
      }
      
             
       
        
    }

