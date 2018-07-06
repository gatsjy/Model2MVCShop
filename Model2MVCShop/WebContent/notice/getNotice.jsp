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
                ��������
                <small>��ȸ������</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> �Խ���</a></li>
                <li class="active">��ȸ</li>
            </ol>
        </section>

        <%-- Main content --%>
        <section class="content container-fluid">

            <div class="col-lg-12">

                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">���� : ${notice.noticeTitle}</h3>
                        <ul class="list-inline pull-right">
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-share margin-r-5"></i>����</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-bookmark-o margin-r-5"></i>�ϸ�ũ</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-thumbs-o-up margin-r-5"></i>��õ (0)</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-eye margin-r-5"></i>��ȸ�� (${notice.noticeHits})</a></li>
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

                <%--��ư ����--%>
                <div>
                    <button type="submit" class="btn btn-warning modBtn">����</button>
                    <button type="submit" class="btn btn-danger delBtn">����</button>
                    <button type="submit" class="btn btn-primary listBtn pull-right">���</button>
                </div>
                <br/>
				
				<%-- ��� ��� ���� --%>
				<div class="box box-warning">
				    <div class="box-header with-border">
				        <a class="link-black text-lg"><i class="fa fa-pencil"></i> ����ۼ�</a>
				    </div>
				    <div class="box-body">
				        <form class="form-horizontal">
				            <div class="form-group margin">
				                <div class="col-sm-10">
				                    <textarea class="form-control" id="newReplyDetail" rows="3" placeholder="��۳���..." style="resize: none"></textarea>
				                </div>
				                <div class="col-sm-2">
				                    <input class="form-control" id="newReplyId" type="text" placeholder="����ۼ���..."  value="${sessionScope.user.userId }">
				                </div>
				                <hr/>
				                <div class="col-sm-2">
				                    <button type="button" id="replyAddBtn" class="btn btn-primary btn-block replyAddBtn"><i class="fa fa-save"></i> ����</button>
				                </div>
				            </div>
				            <div class="box-footer">
                        		<ul id="replies">

                        		</ul>
                    		</div>
				        </form>
				    </div>
				</div>
				<%--��� �Է� ���� �� --%>
				
				<%--��� ��� ����--%>
				<div class="box box-success collapsed-box">
				    <%--��� ���� / ��� ���� / ��� ��ġ��, ����--%>
				    <div class="box-header with-border">
				        <a href="" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i></a>
				        <div class="box-tools">
				            <button type="button" class="btn btn-box-tool" data-widget="collapse">
				                <i class="fa fa-plus"></i>
				            </button>
				        </div>
				    </div>
				    <%--��� ���--%>
				    <div class="box-body repliesDiv">
				
				    </div>
				    <%--��� ����¡--%>
				    <div class="box-footer">
				        <div class="text-center">
				            <ul class="pagination pagination-sm no-margin">
				
				            </ul>
				        </div>
				    </div>
				</div>
				<%--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --%>
				<!-- ����ۼ� modal â start -->
            <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">��� ����â</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="replyNo">��� ��ȣ</label>
                                <input class="form-control" id="replyNo" name="replyNo" readonly>
                            </div>
                            <div class="form-group">
                                <label for="replyDetail">��� ����</label>
                                <input class="form-control" id="replyDetail" name="replyDetail" placeholder="��� ������ �Է����ּ���">
                            </div>
                            <div class="form-group">
                                <label for="replyId">��� �ۼ���</label>
                                <input class="form-control" id="replyId" name="replyId" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">�ݱ�</button>
                            <button type="button" class="btn btn-success modalModBtn">����</button>
                            <button type="button" class="btn btn-danger modalDelBtn">����</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ��� �ۼ� modal â end -->
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
                    +   "<button type='button' class='btn btn-xs btn-success modifyModal' data-toggle='modal' data-target='#modifyModal'>��� ����</button>"
                    + "</li>"
                    + "<hr/>";
            });
            $("#replies").html(str);
        });
    }
    
    // ����� �߰��ϴ� ajax
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
            	alert("��� ��� �Ϸ�!");
                getReplies();  // ��� ��� ��� �Լ� ȣ��
                replyDetail.val(""); // ��� ���� �ʱ�ȭ
                replyId.val(""); // ��� �ۼ��� �ʱ�ȭ
            }
        });
    });
    
   /* ajax������ ����� ������ ������ �ݴϴ� */
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
                    alert("��� ���� �Ϸ�!");
                    $("#modifyModal").modal("hide");
                    getReplies();
            }
        });
    }); 
    
    $(".modalModBtn").on("click", function () {
    	
    	//��� ������
        var reply = $(this).parent().parent();
    	
    	//��� ��ȣ
        var replyNo = reply.find("#replyNo").val();
    	
    	//������ ��� ����
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
                    alert("��� ���� �Ϸ�!");
                    $("#modifyModal").modal("hide");
                    getReplies();  // ��� ��� ��� �Լ� ȣ��
                }
            }
        });
    });
</script>
</body>
</html>