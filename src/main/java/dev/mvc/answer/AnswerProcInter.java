package dev.mvc.answer;

import java.util.ArrayList;

import dev.mvc.qna.QnaVO;

public interface AnswerProcInter {
  
  /**
   * 답글 작성
   * @param answerVO
   * @return
   */
  public int create(AnswerVO answerVO);
  
  /**
   * 읽기
   * @param answer_no
   * @return
   */
    public AnswerVO read(int answer_no);

}