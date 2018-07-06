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
                AJAX ��� �׽�Ʈ ������
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> reply test</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
		
		<!-- ��� �ۼ� content start -->
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">��� �ۼ�</h3>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label for="newReplyDetail">��� ����</label>
                            <input class="form-control" id="newReplyDetail" name="replyDetail" placeholder="��� ������ �Է����ּ���">
                        </div>
                        <div class="form-group">
                            <label for="newReplyId">��� �ۼ���</label>
                            <input class="form-control" id="newReplyId" name="replyId" placeholder="��� �ۼ��ڸ� �Է����ּ���">
                        </div>
                        <div class="pull-right">
                            <button type="button" id="replyAddBtn" class="btn btn-primary"><i class="fa fa-save"></i> ��� ����</button>
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
            <!-- ��� �ۼ� content end -->

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