<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>DOG#</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
  전체 글 목록
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 
  

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <c:choose>
        <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
        <c:when test="${sessionScope.admin_id != null }">
          <col style="width: 10%;"></col>
          <col style="width: 80%;"></col>
          <col style="width: 10%;"></col>
        </c:when>
        <c:otherwise>
          <col style="width: 10%;"></col>
          <col style="width: 90%;"></col>
        </c:otherwise>
      </c:choose>
      
    </colgroup>

<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <tbody>
      <c:forEach var="goodsVO" items="${list}">
        <c:set var="title" value="${goodsVO.title }" />
        <c:set var="content" value="${goodsVO.content }" />
        <c:set var="itemno" value="${goodsVO.itemno }" />
        <c:set var="goodsno" value="${goodsVO.goodsno }" />
        <c:set var="thumb1" value="${goodsVO.thumb1 }" />
        
        <tr style="height: 112px;" onclick="location.href='./read.do?goodsno=${goodsno }&now_page=${param.now_page == null?1:now_page }' " class='hover'>
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
                <img src="/contents/storage/${thumb1 }" style="width: 130px; height: 90px;">
              </c:when>
              <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                <IMG src="/contents/images/none1.png" style="width: 130px; height: 90px;">
              </c:otherwise>
            </c:choose>
           </td>  
           <td style='vertical-align: middle;'>
              <div style='font-weight: bold;'>${title }</div>
              <c:choose> 
                <c:when test="${content.length() > 160 }"> <%-- 160자 이상이면 160자만 출력 --%>
                    ${content.substring(0, 160)}.....
                </c:when>
                <c:when test="${content.length() <= 160 }">
                    ${content}
                </c:when>
              </c:choose>
          </td> 
          <c:choose>
            <c:when test="${sessionScope.admin_id != null }">
              <td style='vertical-align: middle; text-align: center;'>
                <A href="/contents/delete.do?itemno=${itemno }&goodsno=${goodsno}&now_page=${param.now_page == null? 1: param.now_page}" title="삭제"><IMG src="/contents/images/delete.png" class="icon"></A>
              </td>
            </c:when>
          </c:choose>
        </tr>
        
      </c:forEach>

    </tbody>
  </table>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>