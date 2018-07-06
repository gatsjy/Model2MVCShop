<%@ page contentType="text/html; charset=EUC-KR" %>

<!DOCTYPE html>



<html>

<%--head.jsp--%>
<%@ include file="include/head.jsp" %>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="include/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="include/left_column.jsp" %>
    
    <%-- Content Wrapper. Contains page content --%>
    <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        <section class="content-header">
            <h1>
                메인페이지
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Main</a></li>
                <li class="active">Home</li>
            </ol>
        </section>

        <%-- Main content --%>
        <section class="content container-fluid">
           <c:if test="${favoriteStarFile==null}">
				<a href="#"><img src="/images/uploadFiles/macbookair.jpg" width="800px" height="800px"></a>
			</c:if> <c:if test="${favoriteStarFile!=null}">
				<a href="#"><img src="/images/uploadFiles/${favoriteStarFile}" width="800px" height="800px"></a>
			</c:if>
        </section>
        <%-- /.content --%>
    </div>
    <%-- /.content-wrapper --%>

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="include/main_footer.jsp" %>

</div>
<%-- ./wrapper --%>

<%--plugin_js.jsp--%>
<%@ include file="include/plugin_js.jsp" %>

</body>
</html>