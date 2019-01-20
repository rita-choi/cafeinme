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

<!-- REQUIRED JS SCRIPTS -->

<%@ include file="../include/footerjs.jsp"%>

<script>
	$(document)
			.ready(
					function() {
						// 목록 페이지 제어
						var formObj = $("form[role='form']");
						console.log(formObj);
						//수정
						$(".modBtn").on("click", function() {
							formObj.submit();
						});
						$(".cancelBtn").on("click", function() {
							history.go(-1);
						});
						$(".listBtn")
								.on(
										"click",
										function() {
											self.location = "/cafe/list?page=${searchCriteria.page}"
													+ "&perPageNum=${searchCriteria.perPageNum}"
													+ "&searchType=${searchCriteria.searchType}"
													+ "&keyword=${searchCriteria.keyword}";
										});
					});
</script>


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
					<form role="form" id="writeForm" method="POST"
						action="${path}/cafe/modify">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">게시글 작성</h3>
							</div>
							<div class="box-body">
								<input type="hidden" name="cno" value="${cafelist.cno}">
								<input type="hidden" name="page" value="${searchCriteria.page}">
								<input type="hidden" name="perPageNum"
									value="${searchCriteria.perPageNum}"> <input
									type="hidden" name="searchType"
									value="${searchCriteria.searchType}"> <input
									type="hidden" name="keyword" value="${searchCriteria.keyword}">
								<div class="form-group">
									<label for="cafe_name">카페명</label> <input class="form-control"
										id="cafename" name="cafename" placeholder="카페명을 입력 해 주세요"
										value="${cafelist.cafename}">
								</div>
								<div class="form-group">
									<label for="content">카페 소개</label>
									<textarea class="form-control" id="content" name="content"
										placeholder="내용을 입력해 주세요" style="resize: none;">${cafelist.content}</textarea>
								</div>
								<div class="form-group">
									<label for="writer">작성자</label> <br /> ${cafelist.writer}
								</div>
								<div class="form-group">
									<label for="location">위치</label> <input class="form-control"
										id="location" name="location" value="${cafelist.location}">
								</div>
							</div>
							<div class="box-footer">
								<button type="button" class="btn btn-primary listBtn">
									<i class="fa fa-list"></i>목록
								</button>
							</div>
							<button type="button" class="btn btn-warning cancelBtn">
								<i class="fa fa-trash"></i>취소
							</button>
							<button type="submit" class="btn btn-success modBtn">
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



	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>