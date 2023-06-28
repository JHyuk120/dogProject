<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }
 </style>

    
<script>
    $(function() {
        $("#addBtn").on("click", function(event) {
            event.preventDefault(); // 전송 방지

            // 체크박스 데이터를 textarea에 추가
            var checkedItems = "";
            $("input[type=checkbox]:checked").each(function() {
                checkedItems += $(this).val() + ", ";
            });

            $("#ingredient").val($("#ingredient").val() + checkedItems);
        });
    });
</script>
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>${itemVO.item } > 글 등록</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?itemno=${itemVO.itemno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${itemVO.itemno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemVO.itemno }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit'class='btn btn-custom btn-sm'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button'   class='btn btn-custom btn-sm' 
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data">
    <input type="hidden" name="itemno" value="${param.itemno }">
    
    
    <div>
       <label>제목</label>
       <input type='text' name='title' value='▸레시피 이름을 입력해주세요◂' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <br>
    <div>
       <label>재료선택</label>
        <div>
          <tbody>
            <c:forEach var="goodsVO" items="${list}">
              <c:set var="gname" value="${goodsVO.gname}"/>
                <input type="checkbox" id="gname" name="gname" value="${gname }">
                  <label>${gname }</label>
            </c:forEach>
          </tbody>
        </div>
        <button id="addBtn">선택된 항목 추가</button><br><br>
        🍚재료🍚
        <textarea name='ingredient' id='ingredient' required="required" class="form-control" rows="6" style='width: 100%;'></textarea>
    </div>
    <br>
  
    <div>
       <label>🍚조리순서🍚</label>
       <textarea name='article' required="required" class="form-control" rows="12" style="overflow-y: scroll"; 'width: 100%;'>

</textarea>
    </div>  
      
    <div>
    <br>
       <label>검색어</label>
       <input type='text' name='word' value='# ' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
     <br>
    <div>
       <label>이미지</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="파일 선택">
    </div>   
     <br>
    <div>
       <label>패스워드</label>
       <input type='password' name='passwd' value='1234' required="required" 
                 class="form-control" style='width: 50%;'>
    </div>   
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark" style="width:5%; height:45px;">등록</button>
      <button type="button" onclick="location.href='./list_by_itemno.do?itemno=${param.itemno}'" class="btn btn-dark" style="width:5%; height:45px;">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>