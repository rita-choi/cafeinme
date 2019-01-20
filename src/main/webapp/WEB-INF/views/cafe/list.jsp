<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

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
						$("#writeBtn").on("click", function() {
							self.location = "/cafe/write";
						});
						$("#searchBtn")
								.on(
										"click",
										function(event) {
											self.location = "/cafe/list${pageMaker.makeQuery(1)}"
													+ "&searchType="
													+ $(
															"select option:selected")
															.val()
													+ "&keyword="
													+ encodeURIComponent($(
															"#keywordInput")
															.val());
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
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">게시글 목록</h3>
						</div>
						<div class="box-body">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th style="width: 30px">#</th>
										<th>제목</th>
										<th style="width: 100px;">작성자</th>
										<th style="width: 150px;">조회시간</th>
										<th style="width: 60px;">조회</th>
									</tr>
									<c:forEach items="${cafelists}" var="cafelist">
										<tr>
											<td>${cafelist.cno}</td>
											<td><a
												href="${path}/cafe/read${pageMaker.makeSearch(pageMaker.criteria.page)}&cno=${cafelist.cno}">${cafelist.cafename}</a>
												<span class="badge bg-teal"><i class="fa fa-comment-o"></i> +${cafelist.reviewcnt} </span></td>
											<td>${cafelist.writer}</td>

											<td><fmt:formatDate value="${cafelist.updatedate}"
													pattern="yyyy-MM-dd a HH:mm" /></td>
											<td><span class="badge bg-red">${cafelist.viewcnt}</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="box-footer">
							<div class="text-center">
								<ul class="pagination">
									<c:if test="${pageMaker.prev}">
										<li><a
											href="${path}/cafe/list${pageMaker.makeSearch(pageMaker.startPage - 1)}">
												이전 </a></li>
									</c:if>
									<c:forEach begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}" var="idx">
										<li
											<c:out value="${pageMaker.criteria.page == idx ? 'class=active' : ''}" />>
											<a
											href="${path}/cafe/list${pageMaker.makeSearch(idx)}">${idx}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="${path}/cafe/list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
									</c:if>
								</ul>
							</div>
							<div class="form-group col-sm-2">
								<select class="form-control" name="searchType" id="searchType">
									<option value="n"
										<c:out value="${searchCriteria.searchType == null ? 'selected' : ''}" />>::::선택::::</option>
									<option value="t"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>제목</option>
									<option value="c"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>내용</option>
									<option value="w"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>작성자</option>
									<option value="tc"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>제목+내용</option>
									<option value="cw"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>내용+작성자</option>
									<option value="tcw"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>제목+내용+작성자</option>

								</select>
							</div>
							<div class="form-group col-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="keyword"
										id="keywordInput" value="${searchCriteria.keyword}"
										placeholder="검색어"> <span class="input-group-btn">
										<button type="button" class="btn btn-primary btn-flat"
											id="searchBtn">
											<i class="fa fa-search"></i>검색
										</button>
									</span>
								</div>
							</div>

							<div class="pull-right">
								<button type="button" class="btn btn-success btn-flat"
									id="writeBtn">
									<i class="fa fa-pencil"></i> 글쓰기
								</button>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<%@ include file="../include/main_footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>