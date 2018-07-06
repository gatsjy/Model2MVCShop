<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--left_column.jsp--%>
<%-- Left side column. contains the logo and sidebar --%>
<aside class="main-sidebar">

    <%-- sidebar: style can be found in sidebar.less --%>
    <section class="sidebar">

        <%-- Sidebar user panel (optional) --%>
        <div class="user-panel">
            <div class="pull-left image">
                <img src="/dist/img/user1-128x128.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${sessionScope.user.userId }</p>
                <%-- Status --%>
                <a href="#"><i class="fa fa-circle text-success"></i> offline</a>
            </div>
        </div>

        <%-- Sidebar Menu --%>
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">�޴�</li>
            <%-- Optionally, you can add icons to the links --%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-clipboard"></i>
                    <span>��������</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/notice/addNoticeView.jsp"><i class="fa fa-edit"></i> <span>�������� �ۼ�</span></a></li>
                    <li><a href="/notice/listNotice"><i class="fa fa-list"></i> <span>�������� ���</span></a></li>
                </ul>
            </li>
        </ul>
        
        <c:if test="${user.role == 'admin'}">
        <%-- /.sidebar-menu --%>
         <ul class="sidebar-menu" data-widget="tree">
            <%-- Optionally, you can add icons to the links --%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-child"></i>
                    <span>ȸ������</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/user/getUser?userId=${user.userId}""><i class="fa fa-user"></i> <span>�������� ��ȸ</span></a></li>
                    <li><a href="/user/listUser"><i class="fa fa-users"></i> <span>ȸ������ ��ȸ</span></a></li>
                </ul>
            </li>
        </ul>
       </c:if>
    <%-- /.sidebar-menu --%>
    <c:if test="${user.role == 'admin'}">
         <ul class="sidebar-menu" data-widget="tree">
            <%-- Optionally, you can add icons to the links --%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-truck"></i>
                    <span>�ǸŰ���</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/product/addProductView.jsp"><i class=" fa-check-circle-o"></i> <span>&nbsp;�ǸŻ�ǰ���</span></a></li>
                    <li><a href="/product/listProduct?menu=manage"><i class="fa fa-edit"></i> <span>�ǸŻ�ǰ����</span></a></li>
                    <li><a href="/purchase/listSale"><i class="fa fa-check"></i> <span>&nbsp;�ǸŸ��</span></a></li>
                    <li><a href="/purchase/listMap"><i class="fa fa-check"></i> <span>&nbsp;�Ǹ�����</span></a></li>
                </ul>
            </li>
        </ul>
      </c:if>
    <%-- /.sidebar-menu --%>
         <ul class="sidebar-menu" data-widget="tree">
            <%-- Optionally, you can add icons to the links --%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-gift"></i>
                    <span>��ǰ�˻�</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                	<li><a href="/product/listProduct?menu=search"><i class="fa fa-search"></i> <span>��ǰ�˻�</span></a></li>
                    <li><a href="/purchase/listPurchase"><i class="fa fa-balance-scale"></i> <span>�����̷���ȸ</span></a></li>
                    <li><a href="/purchase/listCancelPurchase"><i class="fa fa-cart-arrow-down"></i> <span>����̷���ȸ</span></a></li>
                    <li><a href="/cart/listCart"><i class="fa fa-cart-plus"></i> <span>��ٱ���</span></a></li>
                    <li><a href="/cart/listCart"><i class="fa-camera-retro"></i> <span>&nbsp;�ֱ� �� ��ǰ</span></a></li>
                </ul>
            </li>
        </ul>
    </section>
    <%-- /.sidebar --%>
</aside>
