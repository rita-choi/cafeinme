<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="../include/head.jsp"%>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@ include file="../include/main_header.jsp"%>
		<%@ include file="../include/left_column.jsp"%>
		<%@ include file="../include/footerjs.jsp"%>
		<script>
			$(document).ready(function() {
				$(".listBtn").on("click", function() {
					self.location = "/cafe/list";
				});
			});
		</script>
		<!--
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Page Header <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
        | Your Page Content Here |
        -------------------------->

				<div class="col-lg-12">
					<form id="writeForm" method="POST" action="${path}/cafe/write">
						<div class="box box-primary">
							<div class="box-body">
								<div class="form-group">
									<label for="cafe_name">카페명</label> <input class="form-control"
										id="cafename" name="cafename" placeholder="카페명을 입력 해 주세요">
								</div>
								<div class="form-group">
									<label for="content">카페 소개</label>
									<textarea class="form-control" id="content" name="content"
										placeholder="내용을 입력해 주세요" style="resize: none;"></textarea>
								</div>
								<div class="form-group">
									<label for="writer">작성자</label> <input class="form-control"
										id="writer" name="writer" value="${login.uid}" readonly>
								</div>
								<div class="form-group">
									<label for="location">위치</label> <input class="form-control"
										id="location" name="location">
								</div>
							</div>
							<div class="box-footer">
								<button type="button" class="btn btn-primary listBtn"">
									<i class="fa fa-list"></i>목록
								</button>
							</div>
							<button type="reset" class="btn btn-warning">
								<i class="fa fa-reply"></i>초기화
							</button>
							<button type="submit" class="btn btn-success">
								<i class="fa fa-save"></i>저장
							</button>
						</div>
					</form>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<%@ include file="../include/main_footer.jsp"%>
	</div>
	<!-- ./wrapper -->
	<!-- REQUIRED JS SCRIPTS -->
	<%@ include file="../include/footerjs.jsp"%>
	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>