package dev.mvc.recom;

import java.util.ArrayList;

public interface RecomProcInter {

  /**
   * 좋아요 생성
   * @param recomVO
   * @return
   */
  public int create(RecomVO recomVO);

    /**
   * 좋아요 확인
   * @param recomVO
   * @return
   */
  public int check(RecomVO recomVO);

  /**
   * 좋아요 삭제
   * @param memberno
   * @return
   */
  public int delete(RecomVO recomVO);
  
  /**
   * 저장한 레시피 수
   * @param memberno
   * @return
   */
  public int myrecom(int memberno);

}
