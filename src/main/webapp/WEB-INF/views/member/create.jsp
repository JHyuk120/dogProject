<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>

<link href="/css/style.css" rel="Stylesheet" type="text/css">  <!-- /static -->

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  


<script type="text/javascript">
    // jQuery ajax 요청
    function checkID() {
      // $('#btn_close').attr("data-focus", "이동할 태그 지정");
      
      let frm = $('#frm'); // id가 frm인 태그 검색
      let id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
      let params = '';
      let msg = '';
      let confirm = 0; // 아이디 중복 확인 누르면 값이 1이됨.
      
      if ($.trim(id).length == 0) { // $.trim(id) : 문자열 좌우의 공백 제거, length : 문자열 길이, id를 입력받지 않은 경우
    	  $('#modal_title').html('ID(이메일) 중복 확인'); // 제목 

        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        msg = '· ID(이메일)를 입력하세요.<br>· ID(이메일) 입력은 필수 입니다.<br>· ID(이메일)는 3자이상 권장합니다.';
        $('#modal_content').html(msg);        // 내용
        
        $('#btn_close').attr("data-focus", "id");  // data-focus : 개발자가 추가한 속성, 닫기 버튼 클릭시 "id" 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력, modal : 메시지 창을 닫아야 다음 동작 진행 가능
        return false;  // 회원 가입 진행 중지
      } else {  // when ID is entered
        params = 'id=' + id;
        confirm = 1;
        // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
        // alert('params: ' + params);
    
        $.ajax({
          url: './checkID.do', // spring execute
          type: 'get',  // post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우: {"cnt":1}
            // alert(rdata);
            let msg = "";
            
            if (rdata.cnt > 0) {
              $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
              msg = "이미 사용중인 ID(이메일) 입니다.<br>";
              msg = msg + "다른 ID(이메일)을 지정해주세요.";
              $('#btn_close').attr("data-focus", "id");  // id 입력으로 focus 이동
            } else {
              $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
              msg = "사용 가능한 ID(이메일) 입니다.";
              $('#btn_close').attr("data-focus", "passwd");  // passwd 입력으로 focus 이동
              // $.cookie('checkId', 'TRUE'); // Cookie 기록
            }
            
            $('#modal_title').html('ID(이메일) 중복 확인'); // 제목 
            $('#modal_content').html(msg);        // 내용
            $('#modal_panel').modal();              // 다이얼로그 출력
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        });
        
        // 처리중 출력
    /*     var gif = '';
        gif +="<div style='margin: 0px auto; text-align: center;'>";
        gif +="  <img src='/member/images/ani04.gif' style='width: 10%;'>";
        gif +="</div>";
        
        $('#panel2').html(gif);
        $('#panel2').show(); // 출력 */
        
      }
    
    }

  
  function setFocus() {  // focus 이동
    // console.log('btn_close click!');
    
    let tag = $('#btn_close').attr('data-focus'); // data-focus 속성에 선언된 값을 읽음 
    // alert('tag: ' + tag);
    
    $('#' + tag).focus(); // data-focus 속성에 선언된 태그를 찾아서 포커스 이동
  }
  
  function send() { // 회원 가입 처리
    let id = $('#id').val(); // 태그의 아이디가 'id'인 태그의 값
    
      if ($.trim(id).length == 0) { // id를 입력받지 않은 경우
        msg = '· ID를 입력하세요.<br>· ID 입력은 필수 입니다.<br>· ID는 3자이상 권장합니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('ID 중복 확인'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "id");  // 닫기 버튼 클릭시 id 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        }
      if (confirm == 0){
    	  $('#modal_title').html('ID(이메일) 중복 확인'); // 제목 

        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        msg = '· ID(이메일) 중복 확인을 눌러주세요.';
        $('#modal_content').html(msg);        // 내용
          
        $('#btn_close').attr("data-focus", "id");  // data-focus : 개발자가 추가한 속성, 닫기 버튼 클릭시 "id" 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력, modal : 메시지 창을 닫아야 다음 동작 진행 가능
        return false;  // 회원 가입 진행 중지
          }
      
   // 패스워드를 정상적으로 2번 입력했는지 확인
      if ($('#passwd').val() != $('#passwd2').val()) {
        msg = '입력된 패스워드가 일치하지 않습니다.<br>';
        msg += "패스워드를 다시 입력해주세요.<br>"; 
        
        $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
        $('#modal_title').html('패스워드 일치 여부 확인'); // 제목 
        $('#modal_content').html(msg);  // 내용
        $('#btn_close').attr('data-focus', 'passwd');
        $('#modal_panel').modal();         // 다이얼로그 출력
        
        return false; // submit 중지
      }

      // 패스워드 유효성 검사
      let passwd = $('#passwd').val();
      let passwordRegex = /^(?=.*?[A-Z].*?[a-z]|.*?[A-Z].*?\d|.*?[A-Z].*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]|.*?[a-z].*?\d|.*?[a-z].*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]|.*?\d.*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]).{10,16}$/;
      if (!passwordRegex.test(passwd)) { 
        msg = '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자<br>';
        msg += "패스워드를 다시 입력해주세요.<br>"; 
        
        $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
        $('#modal_title').html('패스워드 조건 성립 확인'); // 제목 
        $('#modal_content').html(msg);  // 내용
        $('#btn_close').attr('data-focus', 'passwd');
        $('#modal_panel').modal();  
        return false; // submit 중지
      }

    

    let mname = $('#mname').val(); // 태그의 아이디가 'mname'인 태그의 값
      if ($.trim(mname).length == 0) { // id를 입력받지 않은 경우
        msg = '· 이름을 입력하세요.<br>· 이름 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('이름 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "mname");  // 닫기 버튼 클릭시 mname 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 

    let tel = $('#tel').val().trim(); // 태그의 아이디가 'tel'인 태그의 값
      if (tel.length == 0) { // id를 입력받지 않은 경우
        msg = '· 전화번호를 입력하세요.<br>· 전화번호 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('전화번호 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "tel");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 
      
      let zipcode = $('#zipcode').val().trim(); // 태그의 아이디가 'zipcode'인 태그의 값
      if (zipcode.length == 0) { // id를 입력받지 않은 경우
        msg = '· 우편번호를 입력하세요.<br>· 우편번호 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('우편번호 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "zipcode");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 

      let add2 = $('#address2').val().trim(); // 태그의 아이디가 'address2'인 태그의 값
      if (add2.length == 0) { // id를 입력받지 않은 경우
        msg = '· 상세주소를 입력하세요.<br>· 상세주소 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('상세주소 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "address2");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 

    $('#frm').submit(); // required="required" 작동 안됨.
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
    </style>
    
</head> 
<body>
<c:import url="/menu/top.do" />


  <!-- ******************** Modal 알림창 시작 ******************** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id='modal_title'></h4><%-- 제목 --%>
          <button type="button" id='btn_close_modal' class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <%-- 내용 --%>
        </div>
        <div class="modal-footer"> <%-- data-focus="": 캐럿을 보낼 태그의 id --%>
          <button type="button" id="btn_close" data-focus="" onclick="setFocus()" class="btn btn-default" 
                      data-dismiss="modal">닫기</button> <%-- data-focus: 캐럿이 이동할 태그 --%>
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='content_body'>
  <DIV>
    <img src="/menu/images/pheart.svg" class="icon0" style='margin-left:40%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'> 회원 가입</span>
</DIV> 

  
  <ASIDE class="aside_right" style="margin-left:900px;  font-size: 16px;">
   <span style="color: red;  margin-right: 5px;" >*</span>필수입력사항
  </ASIDE>

  <div class='menu_line'></div>
  
  <div style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; margin-top:20px; ">
  <FORM name='frm' id='frm' method='POST' action='./create.do' class="">
  
    <div class="form_input"  style = "margin-bottom:20px;  margin-top:40px; ">
      <label style="font-size: 18px;">아이디</label><span style="color: red;  margin-right:124px;" >*</span>
      <input maxlength="30" type='text' class="form-control " name='id' id='id' value="" required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="아이디" autofocus="autofocus">
      <button type='button' id="btn_checkID" onclick="checkID()" class="btn btn-outline-dark" style=' margin-bottom:2px; margin-left:5px;'>중복확인</button>
    </div>   
                
    <div class="form_input"  style = "margin-bottom:20px; ">
      <label style="font-size: 18px;">패스워드</label><span style="color: red;  margin-right: 107px;" >*</span>
      <input maxlength="60" type='password' class="form-control " name='passwd' id='passwd' value='' required="required" style="font-family:'맑은 고딕'; width: 400px; height:50px; display: inline-block;" placeholder="패스워드">
    </div>
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">패스워드 확인</label><span style="color: red;  margin-right: 63px;" >*</span>
      <input maxlength="60" type='password' class="form-control" name='passwd2' id='passwd2' value='' required="required" style="font-family:'맑은 고딕'; width: 400px; height:50px; display: inline-block;" placeholder="패스워드 확인">
      <div  style="font-size: 13px; color:red; margin-left:190px;" >영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자</div>
    </div>   
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">성명</label><span style="color: red;  margin-right: 143px;" >*</span>
      <input maxlength="30" type='text' class="form-control" name='mname' id='mname' 
                value='' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="성명">
    </div>   
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">휴대폰</label><span style="color: red;  margin-right: 124px;" >*</span>
      <input maxlength="14" type='text' class="form-control " name='tel' id='tel' 
                value='' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="숫자만 입력해주세요."> 
    </div>   
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">우편번호</label><span style="color: red;  margin-right: 107px;" >*</span>
      <input maxlength="5" type='text' class="form-control" name='zipcode' id='zipcode' 
                value='' style='width: 400px; height:50px; display: inline-block;' placeholder="우편번호">
      <button type="button" id="btn_DaumPostcode" onclick="DaumPostcode()" class="btn btn-outline-dark" style="margin-bottom:2px;">우편번호 찾기</button>
    </div>  
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">주소</label><span style="color: red;  margin-right: 143px;" >*</span>
      <input maxlength="100" type='text' class="form-control " name='address1' id='address1' 
                 value='' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="주소">
    </div>   
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="font-size: 18px;">상세주소</label><span style="color: red;  margin-right: 107px;" >*</span>
      <input maxlength="100" type='text' class="form-control" name='address2' id='address2' 
                value='' required="required" style='width: 400px; height:50px; display: inline-block; margin-bottom:30px;' placeholder="상세 주소">
    </div>   

    <div>

<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
  // 우편번호 찾기 화면을 넣을 element
  var element_wrap = document.getElementById('wrap');

  function foldDaumPostcode() {
      // iframe을 넣은 element를 안보이게 한다.
      element_wrap.style.display = 'none';
  }

  function DaumPostcode() {
      // 현재 scroll 위치를 저장해놓는다.
      var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
      new daum.Postcode({
          oncomplete: function(data) {
              // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var fullAddr = data.address; // 최종 주소 변수
              var extraAddr = ''; // 조합형 주소 변수

              // 기본 주소가 도로명 타입일때 조합한다.
              if(data.addressType === 'R'){
                  //법정동명이 있을 경우 추가한다.
                  if(data.bname !== ''){
                      extraAddr += data.bname;
                  }
                  // 건물명이 있을 경우 추가한다.
                  if(data.buildingName !== ''){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                  fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              $('#zipcode').val(data.zonecode); // 5자리 새우편번호 사용 ★
              $('#address1').val(fullAddr);  // 주소 ★

              // iframe을 넣은 element를 안보이게 한다.
              // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
              element_wrap.style.display = 'none';

              // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
              document.body.scrollTop = currentScroll;
              
              $('#address2').focus(); //  ★
          },
          // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
          onresize : function(size) {
              element_wrap.style.height = size.height+'px';
          },
          width : '100%',
          height : '100%'
      }).embed(element_wrap);

      // iframe을 넣은 element를 보이게 한다.
      element_wrap.style.display = 'block';
  }
 
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

    </div>
    
    <div class="form_input">
      <button type="button" onclick="history.back()" class="btn btn-outline-dark"  style="margin-left:43%;"><img src="/member/images/back.png" class="icon"></button>    
      <button type="button" id='btn_send' onclick="send()" class="btn btn-dark" >가입하기</button>
    </div>   
  </FORM>
  </DIV>
  
  </DIV>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

