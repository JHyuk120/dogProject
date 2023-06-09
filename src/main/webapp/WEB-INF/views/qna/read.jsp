<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="qnano" value="${qnaVO.qnano }" />
<c:set var="memberno" value="${qnaVO.memberno }"/>
<c:set var="title" value="${qnaVO.title }" />        
<c:set var="content" value="${qnaVO.content }" />
<c:set var="word" value="${qnaVO.word }" />
<c:set var="rdate" value="${qnaVO.rdate.substring(0,10) }" />
<c:set var="mname" value="${qnaVO.mname }"/>


 
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
    
</head> 
 
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
    background-color: #FEFCF0;
  }

  .fieldset_basic {
    width: 100%;
    height: 100%;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
  

</style>
</head>
 
<body>
<c:import url="/menu/top.do" />
 
<DIV style='background-color:#FEFCF0; margin-right: 60%; font-size: 30px;'><img src="/menu/images/qna1.png" class="icon1"> Q&A</DIV>


<DIV class='content_body'>
  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>

      <c:if test="${sessionScope.memberno == memberno }">

    	    <A href="./update_text.do?qnano=${qnano}&now_page=${param.now_page}&word=${param.word}">글 수정</A>
    	    <span class='menu_divide' >│</span>
    	    <A href="./delete.do?qnano=${qnano}&now_page=${param.now_page}">삭제</A>  
      </c:if>

    <c:choose>
     <c:when test="${sessionScope.admin_id != null }">
       <A href="../answer/create.do?qnano=${qnano }"> ✒️관리자 답변 등록</A>
      </c:when>
    </c:choose>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
   
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">         
          <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
          <div style="font-size: 0.7em;">${mname} ${rdate }</div><br>
        <div style="float: center; margin-top: 3%;">${content }</div>
      </li>
     <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
        <br>
          <img src="/menu/images/words.png" class="icon0"> :  ${word }
        </DIV>
      </li>
      
      <li class="li_none">
        <DIV>
            <c:forEach var="attachfileVO" items="${list}">
              <c:set var="fname" value="${attachfileVO.fname }"/>
              <c:set var="fupname" value="${attachfileVO.fupname }"/>
              <c:set var="fsize" value="${attachfileVO.fsize }"/>
                <li>
                  <c:if test="${fname.trim().length() > 0 }">
                    첨부 파일: <A href='/download?dir=/attachfile/storage&filename=${fupname}&downname=${fname}'>${fname}</A> (${fsize})  
                  </c:if> 
              </li>
            </c:forEach>
        </DIV>
      </li>   
      
    </ul>
  </fieldset>

</DIV>
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
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>