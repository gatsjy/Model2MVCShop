<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>


<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<html>
<script type="text/javascript">
	function updateUser() {
		self.location = "/user/updateUser?userId=${user.userId}";
	}

	$(function() {
		$("button.btn.btn-warning").on("click", function() {
			updateUser();
		});
		
		$( "button.btn.btn-primary").on("click", function() {
			history.go(-1);
		});
	});
</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<div class="wrapper">

		<%--main_header.jsp--%>
		<%-- Main Header --%>
		<%@ include file="../include/main_header.jsp"%>

		<%--left_column.jsp--%>
		<%-- Left side column. contains the logo and sidebar --%>
		<%@ include file="../include/left_column.jsp"%>

		<%-- Content Wrapper. Contains page content --%>
		<div class="content-wrapper">
			<%-- Content Header (Page header) --%>
			<section class="content-header">
				<h1>
					<small></small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> ȸ������</a></li>
					<li class="active">ȸ������</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form name= "form">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">ȸ��������ȸ</h3>
								<h5 class="text-muted">
									�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.
								</h5>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>�� �� ��</strong>
									</div>
									<div class="col-xs-8 col-md-4">${user.userId}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>�ּ�</strong>
									</div>
									<div class="col-xs-8 col-md-4">${user.addr}</div>
								</div>
							</div>
							
							<hr />
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>�޴���ȭ��ȣ</strong>
									</div>
									<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}
									</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>�� �� ��</strong>
									</div>
									<div class="col-xs-8 col-md-4">${user.email}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>��������</strong>
									</div>
									<div class="col-xs-8 col-md-4">${user.regDate}</div>
								</div>
							</div>

							<hr />

						</div>
						<div class="box-footer">
							<button type="button" class="btn btn-primary">
								<i class="fa fa-list"></i> ���
							</button>
							<div class="pull-right">
								<button type="reset" class="btn btn-warning">
									<i class="fa fa-reply"></i> ����
								</button>
							</div>
						</div>
					</form>
				</div>

			</section>
			<%-- /.content --%>
		</div>
		<%-- /.content-wrapper --%>

		<%--main_footer.jsp--%>
		<%-- Main Footer --%>
		<%@ include file="../include/main_footer.jsp"%>

	</div>
	<%-- ./wrapper --%>

	<%--plugin_js.jsp--%>
	<%@ include file="../include/plugin_js.jsp"%>

</body>
</html>