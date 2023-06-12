package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.notice.NoticeVO;

public interface QnaProcInter {
  
  /**
   * 등록
   * @param qnaVO
   * @return
   */
  public int create(QnaVO qnaVO);
  
  /**
   * 전체보기
   * @return
   */
  
  public ArrayList<QnaVO> list_all();
  
  
  /**
   * 조회
   * @param qnano
   * @return
   */
  public QnaVO read(int qnano);
  

  /**
   * 패스워드 확인
   * @param qnaVO
   * @return 처리된 레코드 갯수
   */
  public int password_check(QnaVO qnaVO);
  
  /**
   * 글 정보 수정
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(QnaVO qnaVO);
 
  /**
   * 삭제
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int noticeno);
  


}