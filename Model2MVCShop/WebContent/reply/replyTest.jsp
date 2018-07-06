<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<html>

<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">

<div class="wrapper">

    <!-- Main Header -->
    <%@ include file="../include/main_header.jsp"%>

    <!-- Left side column. contains the logo and sidebar -->
    <%@ include file="../include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                AJAX 댓글 테스트 페이지
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> reply test</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
		
		<!-- 댓글 작성 content start -->
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">댓글 작성</h3>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label for="newReplyDetail">댓글 내용</label>
                            <input class="form-control" id="newReplyDetail" name="replyDetail" placeholder="댓글 내용을 입력해주세요">
                        </div>
                        <div class="form-group">
                            <label for="newReplyId">댓글 작성자</label>
                            <input class="form-control" id="newReplyId" name="replyId" placeholder="댓글 작성자를 입력해주세요">
                        </div>
                        <div class="pull-right">
                            <button type="button" id="replyAddBtn" class="btn btn-primary"><i class="fa fa-save"></i> 댓글 저장</button>
                        </div>
                    </div>
                    <div class="box-footer">
                        <ul id="replies">

                        </ul>
                    </div>
                    <div class="box-footer">
                        <div class="text-center">
                            <ul class="pagination pagination-sm no-margin">

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
			
			<!-- 댓글작성 modal 창 start -->
            <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">댓글 수정창</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="replyNo">댓글 번호</label>
                                <input class="form-control" id="replyNo" name="replyNo" readonly>
                            </div>
                            <div class="form-group">
                                <label for="replyDetail">댓글 내용</label>
                                <input class="form-control" id="replyDetail" name="replyDetail" placeholder="댓글 내용을 입력해주세요">
                            </div>
                            <div class="form-group">
                                <label for="replyId">댓글 작성자</label>
                                <input class="form-control" id="replyId" name="replyId" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                            <button type="button" class="btn btn-success modalModBtn">수정</button>
                            <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 댓글 작성 modal 창 end -->
            <!-- 댓글 작성 content end -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <%@ include file="../include/main_footer.jsp"%>

</div>
<!-- ./wrapper -->
<%@ include file="../include/plugin_js.jsp"%>
<script>
    var noticeNo = 10000;
	
    getReplies();
    
    function getReplies() {
        $.getJSON("/reply/json/getReplyList/" + noticeNo, function (data) {
            console.log(data);
            var str = "";
            $(data).each(function () {
                str += "<li data-replyNo='" + this.replyNo + "' class='replyLi'>"
                    +   "<p class='replyDetail'>" + this.replyDetail + "</p>"
                    +   "<p class='replyId'>" + this.replyId + "</p>"
                    +   "<button type='button' class='btn btn-xs btn-success modifyModal' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
                    + "</li>"
                    + "<hr/>";
            });
            $("#replies").html(str);
        });
    }
    
    // 댓글을 추가하는 ajax
    $("#replyAddBtn").on("click", function () {
    	
        var replyDetail = $("#newReplyDetail");
        var replyId = $("#newReplyId");
        var replyDetailVal = replyDetail.val();
        var replyIdVal = replyId.val();
        $.ajax({
            type : "post",
            url : "/reply/json/addReply",
            headers : {
                "Content-type" : "application/json",
                "X-HTTP-Method-Override" : "POST"
            },
            dataType : "text",
            data : JSON.stringify({
            	noticeNo : noticeNo,
            	replyDetail : replyDetailVal,
            	replyId : replyIdVal
            }),
            success : function (result) {
            	alert("댓글 등록 완료!");
                getReplies();  // 댓글 목록 출력 함수 호출
                replyDetail.val(""); // 댓글 내용 초기화
                replyId.val(""); // 댓글 작성자 초기화
            }
        });
    });
    
   /* ajax이전에 댓글의 값들을 세팅해 줍니다 */
    $("#replies").on("click", ".replyLi button", function () {
        var reply = $(this).parent();

        var replyNo = reply.attr("data-replyNo");
        var replyDetail = reply.find(".replyDetail").text();
        var replyId = reply.find(".replyId").text();

        $("#replyNo").val(replyNo);
        $("#replyDetail").val(replyDetail);
        $("#replyId").val(replyId);

    });
    
    $(".modalDelBtn").on("click", function () {
        var replyNo = $(this).parent().parent().find("#replyNo").val();
        $.ajax({
            type : "delete",
            url : "/reply/json/deleteReply/" + replyNo,
            headers : {
                "Content-type" : "application/json",
                "X-HTTP-Method-Override" : "DELETE"
            },
            dataType : "text",
            success : function (result) {
                    alert("댓글 삭제 완료!");
                    $("#modifyModal").modal("hide");
                    getReplies();
            }
        });
    }); 
    
    $(".modalModBtn").on("click", function () {
    	
    	//댓글 선택자
        var reply = $(this).parent().parent();
    	
    	//댓글 번호
        var replyNo = reply.find("#replyNo").val();
    	
    	//수정한 댓글 내용
        var replyDetail = reply.find("#replyDetail").val();
        $.ajax({
            type : "put",
            url : "/reply/json/updateReply/" + replyNo,
            headers : {
                "Content-type" : "application/json",
                "X-HTTP-Method-Override" : "PUT"
            },
            data : JSON.stringify(
                {replyDetail : replyDetail}
            ),
            dataType : "text",
            success : function (result) {
                console.log("result : " + result);
                if (result == "modSuccess") {
                    alert("댓글 수정 완료!");
                    $("#modifyModal").modal("hide");
                    getReplies();  // 댓글 목록 출력 함수 호출
                }
            }
        });
    });
</script>
</body>
</html>