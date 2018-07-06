<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

<%--plugin_js.jsp--%>
<%@ include file="../include/plugin_js.jsp" %>


<script type="text/javascript">

function fncAddNotice() {
	document.detailForm.action = '/notice/addNotice';
	document.detailForm.submit();
}

function resetData(){
	document.detailForm.reset();
}

$( function() {
	$(".box-footer").on("click" , function() {
		fncAddNotice();
	});	
	
	$("detailForm").attr("method","POST").attr("action","/notice/addNotice").submit();		
});	

</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp" %>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="../include/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="../include/left_column.jsp" %>
    
    <%-- Content Wrapper. Contains page content --%>
    <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        <section class="content-header">
            <h1>
                공지사항
                <small>공지사항 내용</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 게시판</a></li>
                <li class="active">입력</li>
            </ol>
        </section>

        <%-- Main content --%>
        <section class="content container-fluid">

            <div class="col-lg-12">
                <form role="form" id="writeForm" method="post" action="/notice/addNotice" enctype="multipart/form-data">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">게시글 입력</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group">
                                <label>제목</label>
                                <input type="text" id="noticeTitle" name="noticeTitle" class="form-control" placeholder="제목을 입력해주세요 ...">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" id="noticeDetail" name="noticeDetail" rows="10" placeholder="전하고 싶은말을 입력해주세요 ..." style="resize: none;"></textarea>
                            </div>

                            <div class="form-group">
                                <label>작성자</label>
                                <input type="text" class="form-control" id="noticeId" name="noticeId" placeholder="작성자를 입력해주세요 ..." value="${sessionScope.user.userId}">
                            </div>
                            
                            <!-- 파일업로드 부분입니다. -->
                             <div class="form-group">
    							<label for="InputFile">파일 업로드</label>
  							    <input type="file"  name="file" id="InputFile" >
 							 </div>

                        </div>
                        <div class="box-footer">
                           <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
              			 <div class="pull-right">
                    		<button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 초기화</button>
                    		<button type="submit" class="btn btn-success"><i class="fa fa-save"></i> 저장</button>
                        </div>
                    </div>
                </form>
            </div>

        </section>
        <%-- /.content --%>
    </div>
    <%-- /.content-wrapper --%>
<%-- ./wrapper --%>
    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>
</div>


</body>
</html>