<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
<link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>   
    
    
<style>
  body {
    background-color: #FEFCE6;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .content_body {
    width: 100%;
    max-width: 1200px;
    text-align: center;
  }

  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
      /* 스크롤 막대의 색상 설정 */
    ::-webkit-scrollbar {
        width: 8px; /* 스크롤 막대의 너비 */
    }
    
    /* 스크롤 막대의 바탕색 */
    ::-webkit-scrollbar-track {
        background-color: white;
    }
    
    /* 스크롤 막대의 색상 */
    ::-webkit-scrollbar-thumb {
        background-color: #FFDAD5;
    }
    
    /* 스크롤 막대의 색상 및 모서리 둥글게 */
::-webkit-scrollbar-thumb {
    background-color: #FFDAD5;
    border-radius: 4px;
}
    
    /* 마우스 호버 시 스크롤 막대의 색상 */
    ::-webkit-scrollbar-thumb:hover {
        background-color: #DAF5E0;
    }
  
</style>
</head> 
 
<body>
<c:import url="/menu/top.do" />
 

<DIV class='content_body' style='background-color:#FEFCF0;'>

  <DIV>
    <div style='display: flex; align-items: flex-start;'>
        <img src="/menu/images/save.png" class="icon0"  style='margin-left:5px; width: 2%; margin-bottom: 7px; margin-right: 1%;'>저장된 레시피 목록
        <img src="/goods/images/arrow.png" class="icon"  style='margin-left:5px; width: 2%; margin-bottom: 5px;'>총 ${myrecom }건
    </div>

  
  <div style='width: 100%; display: flex; flex-wrap: wrap; margin-top: 2%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="recipeVO" items="${list_m }" varStatus="status">
      <c:set var="title" value="${recipeVO.title }" />
      <c:set var="ingredient" value="${recipeVO.article }" />
      <c:set var="itemno" value="${recipeVO.itemno }" />
      <c:set var="recipeno" value="${recipeVO.recipeno }" />
      <c:set var="thumb1" value="${recipeVO.thumb1 }" />
      <c:set var="size1" value="${recipeVO.size1 }" />
      <c:set var="cnt" value="${recipeVO.cnt }" />
      <c:set var="recom" value="${recipeVO.recom }" />
      <c:set var="mname" value="${recipeVO.mname }" />
      
      <!-- 나머지 연산자를 사용하여 홀수와 짝수를 판별하여 배경색 설정 -->
      <div onclick="location.href='../recipe/read.do?recipeno=${recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'"
                class="gallery_item" style="background-color: ${recipeno % 2 == 0 ? '#FEFCD6' : '#F5FEDE'};">
        <c:choose> 
          <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
            <%-- registry.addResourceHandler("/recipe/storage/**").addResourceLocations("file:///" +  Recipe.getUploadDir()); --%>
            <img src="/dogproject/recipe/storage/${thumb1 }" style="width: 80%; height: 180px;">
          </c:when>
          <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/recipe/images/none1.png -->
            <IMG src="/recipe/images/ee.png" style="width: 80%; height: 180px; margin-bottom:20px; margin-top:8px; "><br>
          </c:otherwise>
        </c:choose>
        <strong>
          <div style='height: 25px; word-break: break-all;'>
            <c:choose> 
              <c:when test="${title.length() > 45 }"> <%-- 160자 이상이면 160자만 출력 --%>
                ${title.substring(0, 45)}.....
              </c:when>
              <c:when test="${title.length() <= 45 }">
                ${title}
              </c:when>
            </c:choose>
          </div>
        </strong>
          
        <div style='font-size:0.8em; word-break: break-all;'>
          <img src="/menu/images/pcircle.svg" class="icon" style="margin-bottom:8px; margin-top:4px;"> ${mname } <br>
          조회수: ${cnt }  | 좋아요: ${recom } 
        </div>

      </div>
      
    </c:forEach>
  </div>
       </DIV>
   </body>

  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
     <!-- 플로팅 메뉴 -->
<style>
    .float {
        position: fixed;
        bottom: 30px;
        right: 20px;
        z-index: 999;
    }
</style>

<div class="float">
    <div class="btn-group-vertical">
      <c:choose>
        <c:when test="${sessionScope.id != null }">
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../cart/list_by_memberno.do'">장바구니</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../recom/memberList.do?memberno=${memberno}'">저장한 레시피</button>
          <button type="button"class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"  onclick="location.href='../pay/pay_list.do'">주문내역</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../qna/list_by_search.do'">고객상담</button>
        </c:when>
        <c:otherwise>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../member/create.do'">회원가입</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../qna/list_by_search.do'">고객상담</button>
        </c:otherwise>
      </c:choose>
    </div>
</div>

<jsp:include page="../menu/bottom.jsp" />
</body>

 
</html>