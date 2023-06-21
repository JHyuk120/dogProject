package dev.mvc.recipe;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class RecipeVO {
    /** 컨텐츠 번호 */
    private int recipeno;
    /** 회원 번호 */
    private int memberno;
    /** 품목 번호 */
    private int itemno;
    /** 제목 */
    private String title = "";
    /** 글 내용 */
    private String article = "";
    /** 추천수 */
    private int recom = 0;
    /** 조회수 */
    private int cnt = 0;
    /** 댓글수 */
    private int replycnt = 0;
    /** 패스워드 */
    private String passwd = "";
    /** 검색어 */
    private String word = "";
    /** 등록 날짜 */
    private String rdate = "";

    /** 메인 이미지 */
    private String file1 = "";
    /** 실제 저장된 메인 이미지 */
    private String file1saved = "";
    
    /** 메인 이미지 preview */
    private String thumb1 = "";
    /** 메인 이미지 크기 */
    private long size1;

    /**유튜브*/
    private String youtube;
    
    /** 재료 */
    private String ingredient = "";
    
    /** 리뷰 */
    private String review = "";
    
    /** 별점 */
    private int star;
    
    /**
     이미지 파일
     <input type='file' class="form-control" name='file1MF' id='file1MF' 
                value='' placeholder="파일 선택">
     */
    private MultipartFile file1MF;
    
    /** 메인 이미지 크기 단위, 파일 크기 */
    private String size1_label = "";
    
    /** 시작 rownum */
    private int start_num;
    
    /** 종료 rownum */
    private int end_num;    
    
    /** 현재 페이지 */
    private int now_page=1;



}