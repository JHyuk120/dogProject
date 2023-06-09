<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:set var="itemno" value="${itemVO.itemno }" />
 
<c:set var="recipeno" value="${recipeVO.recipeno }" />
<c:set var="itemno" value="${recipeVO.itemno }" />
<c:set var="ingredient" value="${recipeVO.ingredient }" />
<c:set var="title" value="${recipeVO.title }" />        
<c:set var="file1" value="${recipeVO.file1 }" />
<c:set var="file1saved" value="${recipeVO.file1saved }" />
<c:set var="thumb1" value="${recipeVO.thumb1 }" />
<c:set var="gname" value="${recipeVO.gname }" />
<c:set var="ingredient" value="${recipeVO.ingredient }" />
<c:set var="article" value="${recipeVO.article }" />
<c:set var="youtube" value="${recipeVO.youtube }" />
<c:set var="word" value="${recipeVO.word }" />
<c:set var="size1_label" value="${recipeVO.size1_label }" />
<c:set var="rdate" value="${recipeVO.rdate.substring(0,16) }" />
<c:set var="recom" value="${recipeVO.recom }" />
<c:set var="time" value="${recipeVO.time }" />
<c:set var="difficulty" value="${recipeVO.difficulty }" />
 
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
<script>
var count = 1;
function clearFileInput(fileInput) {
    fileInput.value = "";
  }

$(function() {
    $("#addBtn").on("click", function(event) {
        event.preventDefault(); // 전송 방지
        $("#gname").val("");
        // 체크박스 데이터를 textarea에 추가
        var checkedItems = "";
        $("input[type=checkbox]:checked").each(function() {
            checkedItems += $(this).val() + ", ";
        });

        $("#gname").val($("#gname").val() + checkedItems);
    });
});

    
  function addCookingStep() {
       let filecnt = document.getElementsByName("cookfileMF").length;
       if (filecnt >= 8) {
         alert('최대 8개의 파일만 업로드 가능합니다.');
         return;
       }
    var container = document.getElementById("cookingStepsContainer");
    count +=1;
    console.log("Current count:", count);
    
    // Create the new set of elements
    var newDiv = document.createElement("div");
    newDiv.innerHTML = `
      <div><br>
        <div style='display: flex; align-items: center;'>
          <div style="width: 30%;">
            <div class="col-md-12">
              <input type='file' class="form-control" name='cookfileMF' id='fileInput' 
                     value='' placeholder="파일 선택" multiple="multiple">
            </div>
            <div class='content_bottom_menu'>
              <button type="button" onclick="clearFileInput(document.getElementById('fileInput'));"
                   class="btn-sm btn-light" style="font-size: 11px; margin-left: 70%; width: 26%; height: 25px;">첨부파일 초기화</button>
            </div>
          </div>
          <textarea name='cookexp' required="required" class="form-control" 
          rows="3" style="overflow-y: scroll; width: 70%;"></textarea>
        </div>
      </div>
    `;
    // Append the new elements to the container
    container.appendChild(newDiv);
    
  }
</script>
    
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
    
    background-color:#FEFCF0;
  }

  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }  
    </style>
    
</head> 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='content_body'>
  <DIV>
<img src="/menu/images/menu2.png" class="icon1" style='margin-left:34%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>${itemVO.item } > 글 등록</span>
</DIV> 

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemVO.itemno }">목록</A>
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
  
  <FORM name='frm' method='POST' action='./update.do' enctype="multipart/form-data">
    <input type="hidden" name="itemno" value="${itemno }"> 
    <input type="hidden" name="recipeno" value="${recipeno }"> 

    
    <div>
       <label>🤍제목🤍</label>
       <input type='text' name='title' value='${title }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>    <br>
<div>
  <label for="time" style="display: inline-block;">🤍소요시간🤍</label>
  <input type="text" name="time" id="time" value="${time }" required autofocus class="form-control" style="width: 9%; display: inline-block;">
    
  <label for="difficulty" style="display: inline-block; margin-left: 20px;">🤍난이도🤍</label>
  <input type="text" name="difficulty" id="difficulty" value="${difficulty }" required autofocus class="form-control" style="width: 20%; display: inline-block;">
</div><br>
       <label>🤍레시피 요약 설명🤍</label>
    <div>
      <textarea name='article' id='article' required="required" class="form-control" 
      rows="3" style="overflow-y: scroll; width: 100%;">${article }</textarea>
    </div>
            
    <br>
    <div>
       <label>🤍메인 이미지🤍</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="메인이미지 선택">
    </div> 
    <br>
    <div>
       <label>🤍재료 선택🤍</label>
        <div>
          <tbody>
            <c:forEach var="goodsVO" items="${list}">
              <c:set var="gname1" value="${goodsVO.gname}"/>
                <input type="checkbox" id="gname1" name="gname1" value="${gname1 }">
                  <label for='${gname1}'>${gname1 }</label>
            </c:forEach>
          </tbody>
        </div>
        <button id="addBtn" class="btn-sm btn-outline-dark"> ✔ 체크한 항목 아래 재료 박스에 추가</button><br><br>
        
        🤍재료박스🤍 <a style="color: #BBBDB2;">재료박스에 담으면 댕키트에서 구매가 가능합니다</a>
        <!-- gname = recipeVO.gname -->
        <input type='text'  name='gname' id='gname' value="${gname }" required="required" class="form-control" rows="2" style='width: 100%;' readonly>
    </div>
    <br>
    <div>
      <label>🤍추가 재료🤍</label>
      <div>
        <textarea name='ingredient' id='ingredient' required="required" class="form-control" rows="6" style='width: 100%;'>${ingredient }</textarea>
      </div>
    </div>
    <br>
  <div>
  <label>🤍조리순서🤍</label><br>
  <div id="cookingStepsContainer">
    <c:forEach var="cook_multiVO" items="${list2}">
      <c:set var="cookfile" value="${cook_multiVO.cookfile }" />
      <c:set var="cookfilesaved" value="${cook_multiVO.cookfilesaved }" />
      <c:set var="thumb" value="${cook_multiVO.thumb }" />
      <c:set var="exp" value="${cook_multiVO.exp }" />
        <div style='display: flex; align-items: center;'>
          <div style="width: 30%;">
            <div class="col-md-12">
              <input type='file' class="form-control" name='cookfileMF' id='cookfileMF' 
                     value='' placeholder="파일 선택">
            </div>
            <div class='content_bottom_menu'>
              <button type="button" onclick="clearFileInput(document.getElementById('fileInput'));"
                   class="btn-sm btn-light" style="font-size: 11px; margin-left: 70%; width: 26%; height: 25px;">첨부파일 초기화</button>
            </div>
          </div>
          <textarea name='cookexp' required="required" class="form-control" 
          rows="3" style="overflow-y: scroll; width: 70%;">${exp }</textarea>
        </div>
        <br>
      </c:forEach>
  </div>
  <button type="button" onclick="addCookingStep();"
         class="btn-sm btn-outline-dark" style="margin-left: 91%; margin-top: 1%;">조리순서 추가</button>
</div>

    <div>
    <br>
       <label>🤍검색어🤍</label>
       <input type='text' name='word' value='# ' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
  
     <br>
    <div>
       <label>🤍패스워드🤍</label>
       <input type='password' name='passwd' value='' required="required" 
                 class="form-control" style='width: 20%;'>
    </div>   
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark" style="width:7%; height:45px;">등록</button>
      <button type="button" onclick="location.href='./list_by_itemno.do?itemno=${param.itemno}'" class="btn btn-outline-dark" style="width:7%; height:45px;">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>