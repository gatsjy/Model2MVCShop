<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<%@ include file="../include/plugin_js.jsp"%>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/notice/listNotice").submit();
	}

	$(function() {

		$("button").on("click", function() {
			fncGetList(1);
		});

		$(".ct_list_pop td:nth-child(3)").on("click", function() {
					self.location = "/notice/getNotice?noticeNo=" + $(this).text().trim();
				});

		$(".ct_list_pop td:nth-child(2)").tooltip();

	});
</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="detailForm">
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
						공지사항 <small></small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 공지사항</a></li>
						<li class="active">전체목록</li>
					</ol>
				</section>

				<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">공지사항 목록</h3>
							</div>
							<div class="col-lg-12 text-left">
								<br />
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->

								<div class="row">

									<div class="col-lg-12 text-left">
										<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지</p>
									</div>

									<div class="col-lg-12 text-right">
										<form class="form-inline" name="detailForm">

											<div class="form-group">
												<select class="form-control" name="searchCondition">
													<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
													<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
												</select>
											</div>

											<div class="form-group">
												<label class="sr-only" for="searchKeyword">검색어</label> 
													<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어"
													value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
											</div>

											<button type="button" class="btn btn-default">검색</button>

											<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
											<input type="hidden" id="currentPage" name="currentPage" value="" />

										</form>
									</div>

								</div>
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->
							</div>
							<div class="box-body">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th class="text-center">NO</th>
											<th class="text-center">제목</th>
											<th class="text-center">작성자</th>
											<th class="text-center">작성시간</th>
											<th class="text-center">조회</th>
										</tr>
										<c:forEach var="notice" varStatus="i" items="${list}">
											<tr class="ct_list_pop">
												<td align="center">${notice.noticeNo}</td>
												<td align="center" id="age" title="${notice.noticeDetail}" ><a href="/notice/getNotice?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a></td>
												<td align="center">${notice.noticeId}</td>
												<td align="center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${notice.regDate}" /></td>
												<td align="center"><span class="badge bg-aqua">${notice.noticeHits}</span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="box-footer">
								<!-- PageNavigation Start... -->
								<jsp:include page="../common/pageNavigator_new.jsp" />
								<!-- PageNavigation End... -->
						</div>
				</section>
				<%-- / content --%>
			</div>
			<%-- /.content-wrapper --%>

			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>


		</div>
	</form>
</body>
</html>