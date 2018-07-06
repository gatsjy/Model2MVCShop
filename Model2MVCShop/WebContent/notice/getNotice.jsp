<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

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
                <small>조회페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 게시판</a></li>
                <li class="active">조회</li>
            </ol>
        </section>

        <%-- Main content --%>
        <section class="content container-fluid">

            <div class="col-lg-12">

                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">제목 : ${notice.noticeTitle}</h3>
                        <ul class="list-inline pull-right">
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-share margin-r-5"></i>공유</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-bookmark-o margin-r-5"></i>북마크</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-thumbs-o-up margin-r-5"></i>추천 (0)</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-eye margin-r-5"></i>조회수 (${notice.noticeHits})</a></li>
                        </ul>
                    </div>
                    <form role="form" method="post">
                        <input type="hidden" id="noticeNo" name="noticeNo" value="${notice.noticeNo}">
                    </form>
                    <div class="box-body" style="height: 600px">
                        <p>
                            ${notice.noticeDetail}
                        </p>
                    </div>
                    <div class="box-footer">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="/dist/img/user1-128x128.jpg" alt="user image">
                            <span class="username">
                                <a href="#">${notice.noticeId}</a>
                            </span>
                            <span class="description"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${notice.regDate}"/></span>
                        </div>
                    </div>
                </div>

                <%--버튼 영역--%>
                <div>
                    <button type="submit" class="btn btn-warning modBtn">수정</button>
                    <button type="submit" class="btn btn-danger delBtn">삭제</button>
                    <button type="submit" class="btn btn-primary listBtn pull-right">목록</button>
                </div>
                <br/>
				
				<%-- 댓글 등록 영역 --%>
				<div class="box box-warning">
				    <div class="box-header with-border">
				        <a class="link-black text-lg"><i class="fa fa-pencil"></i> 댓글작성</a>
				    </div>
				    <div class="box-body">
				        <form class="form-horizontal">
				            <div class="form-group margin">
				                <div class="col-sm-10">
				                    <textarea class="form-control" id="newReplyDetail" rows="3" placeholder="댓글내용..." style="resize: none"></textarea>
				                </div>
				                <div class="col-sm-2">
				                    <input class="form-control" id="newReplyId" type="text" placeholder="댓글작성자..."  value="${sessionScope.user.userId }">
				                </div>
				                <hr/>
				                <div class="col-sm-2">
				                    <button type="button" id="replyAddBtn" class="btn btn-primary btn-block replyAddBtn"><i class="fa fa-save"></i> 저장</button>
				                </div>
				            </div>
				            <div class="box-footer">
                        		<ul id="replies">

                        		</ul>
                    		</div>
				        </form>
				    </div>
				</div>
				<%--댓글 입력 영역 끝 --%>
				
				<%--댓글 목록 영역--%>
				<div class="box box-success collapsed-box">
				    <%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%>
				    <div class="box-header with-border">
				        <a href="" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i></a>
				        <div class="box-tools">
				            <button type="button" class="btn btn-box-tool" data-widget="collapse">
				                <i class="fa fa-plus"></i>
				            </button>
				        </div>
				    </div>
				    <%--댓글 목록--%>
				    <div class="box-body repliesDiv">
				
				    </div>
				    <%--댓글 페이징--%>
				    <div class="box-footer">
				        <div class="text-center">
				            <ul class="pagination pagination-sm no-margin">
				
				            </ul>
				        </div>
				    </div>
				</div>
				<%--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --%>
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
            </div>
            
        </section>
        <%-- /.content --%>
    </div>
    <%-- /.content-wrapper --%>

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>

</div>
<!-- ./wrapper -->
<%@ include file="../include/plugin_js.jsp"%>
<script>
    var noticeNo = $("#noticeNo").val();
    
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