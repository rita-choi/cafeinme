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
<%@ include file="../include/footerjs.jsp"%>
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
<style>
body {
position: relative;
}

#app {
	display: flex;
	align-items: center;
	justify-content: center;
	height: initial;
	padding-top: 5px;
	overflow: hidden;
}

#app .col-lg-12 {
    background-color: white;
    height: 620px;
    width: 375px;
    overflow: hidden;
    padding: 0;
    }

#app .box-primary {
	height: 100%;
	overflow-y: scroll;
	overflow-x: hidden;
	margin-right: -15px;
	padding: 0;
}

#app .box-body{
	padding: 0;
}

.box-body .header {
	height: 30px;
	border-bottom: 1px solid #fff;
	margin: 15px 10px;
}

.level-left {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
}

.level-left {
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	-webkit-box-pack: start;
	-ms-flex-pack: start;
	justify-content: flex-start;
}

.box-body .header .image {
	display: inline-block;
}

.image.is-32x32 {
	height: 32px;
	width: 32px;
}

.box-body .header .username {
	font-size: 1.2rem;
	color: #262626;
    font-weight: 600;
    position: relative;
    margin: 0 auto;

}

.box-body .header .location {
    position: relative;
    margin: 0 auto;
    font-size: 12px;
    font-weight: normal;
}

.image {
	display: block;
	position: relative;
}

.image img {
	display: block;
	height: auto;
	width: 100%;
}

.box-body .header img {
	border-radius: 99px;
}

.box-body .img-wrapper {
	height: 330px;
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	margin-bottom: 12px;
}

.perpetual:before {
	z-index: 2;
}

.perpetual:before, .perpetual:after {
	content: '';
	display: block;
	height: 100%;
	width: 100%;
	top: 0;
	left: 0;
	position: absolute;
	pointer-events: none;
}

.user-contents{
margin-left: 12px;
}

.details-wrapper {
    padding: 0 16px;
    }

.details-wrapper .cafe-detail {
	display: inline-block;
}

.details-wrapper .cafe-detail h2 {
	font-weight: 600;
	font-size: 14px;
	margin: 0 auto;
	display: inline-flex;
	margin-right: 5px;
}

.content-wrapper{
	padding: 0 18%;
}

.device {
    right: 2rem;
    height: 816px;
    width: 396px;
    padding: 90px 10px;
    border: 5px solid white;
    border-radius: 60px;
    background-color: #dcdfe6;
    box-shadow: 0 0 50px 10px rgba(0, 0, 0, 0.1);
}

.device:before {
    width: 20%;
    height: 10px;
    top: 40px;
    left: 40%;
    border-radius: 10px;
    background-color: #a1a5b3;
}

.device:after {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    border: solid 5px #bdc0ca;
    left: calc(50% - 25px);
    bottom: 15px;
}

.pagination {
margin-bottom: 50px;
}

html {
    overflow: scroll;
    overflow-x: hidden;
}
::-webkit-scrollbar {
    width: 0px;  /* remove scrollbar space */
    background: transparent;  /* optional: just make scrollbar invisible */
}
/* optional: show position indicator in red */
::-webkit-scrollbar-thumb {
    background: #FF0000;
}

.mb-btn{
    position: absolute;
    bottom: 19%;
    right: 38.7%;
    z-index: 1;
}

#app .btn-success{
background-color: #c0c0c063;
    color: #242424;
    border-color: #c0c0c063;
    width: 338px;
}

.device, .device * {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

</style>
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

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">

			</section>
		<div class="device">
			<!-- Main content -->
			<section class="content container-fluid " id="app">
											<div class="pull-right mb-btn">
								<button type="button" class="btn btn-success btn-flat"
									id="writeBtn">
									<i class="fa fa-pencil"></i> 글쓰기
								</button>
							</div>
				<!--------------------------
        | Your Page Content Here |
        -------------------------->
        
        		<div class="col-lg-12">
					<div class="box box-primary">
			<c:forEach items="${cafelists}" var="cafelist">

						<div class="box-body">
				
								<div class="header level">
									<div class="level-left">
										<figure class="image is-32x32">
											<img
												src="${path}/dist/img/profile${cafelist.userVO.uimage}">
										</figure>
										<div class="user-contents">
										<div class="username">${cafelist.writer}</div>
										<div class="location">${cafelist.location}</div>
										</div>
									</div>
								</div>
								<div class="img-wrapper perpetual"
									style="background-image:url('${path}/dist/img/upload_files${cafelist.cimage}');">
								</div>
								<div class="details-wrapper">
								<div class="cafe-detail">
									<h2><a
										href="${path}/cafe/read${pageMaker.makeSearch(pageMaker.criteria.page)}&cno=${cafelist.cno}">#${cafelist.cafename}</a>
								</h2><span>${cafelist.content}</span></div>
								<div class="badge-wrapper">
									<span class="badge bg-teal"><i class="fa fa-comment-o"></i>
										+${cafelist.reviewcnt} </span> <span class="badge bg-aqua"><i
										class="fa fa-image"></i> ${cafelist.attachcnt}</span>
								</div>
</div></div>
							</c:forEach>
</div></div>


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
											<a href="${path}/cafe/list${pageMaker.makeSearch(idx)}">${idx}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="${path}/cafe/list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
									</c:if>
								</ul>
							</div>
							<!-- <div class="form-group col-sm-2">
								<select class="form-control" name="searchType" id="searchType">
									<option value="n"
										<c:out value="${searchCriteria.searchType == null ? 'selected' : ''}" />>::::선택::::</option>
									<option value="t"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>카페 이름</option>
									<option value="c"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>내용</option>
									<option value="w"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>작성자</option>
									<option value="tc"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>카페 이름+내용</option>
									<option value="cw"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>내용+작성자</option>
									<option value="tcw"
										<c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}" />>카페 이름+내용+작성자</option>

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
							</div> -->


						</div>
					</div>
				</div>
			</section>
			</div>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
     
		<%@ include file="../include/main_footer.jsp"%>
</body>
</html>