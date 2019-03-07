<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 한글 깨짐 방지 -->
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="include/head.jsp"%>
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
<style>
.swiper-container {
	width: 100%;
	height: 100%;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
	overflow: hidden;
	height: auto;
}

.gallery-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.gallery-item-info {
	display: none;
}

.gallery-item-info li {
	display: block;
	/* 	display: inline-block; */
	font-size: 1.7rem;
	font-weight: 600;
}

.gallery-item:hover .gallery-item-info, .gallery-item:focus .gallery-item-info
	{
	display: flex;
	justify-content: center;
	align-items: center;
	position: absolute;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
	color: #fff;
}

ol, ul {
	padding-inline-start: 0px;
}

.header {
    padding: 150px 0;
}

.header {
    overflow: hidden;
    position: relative;
    text-align: center;
    background-position: center;
    background-size: cover;
}


.header:before {
	content: '';
	display: block;
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 0;
	height: 100%;
	width: 100%;
	background-color: rgba(0, 0, 0, 0.3);
}

#header .info h1{
	color: #fff !important;
}

.navbar {
	position: absolute;
	top: 0;
	margin-top: 5px;
	width: 100%;
}

.skin-blue .main-header .navbar {
	background-color: transparent;
}

.nav>li>a:focus, .nav>li>a:hover{
 background-color: transparent;
}

.skin-blue .main-header .navbar .nav>li>a {
	color: #fff !important;
}

#header .info {
	color: #fff;
}

@media screen and (max-width: 700px) {
	.gallery-item-info {
		padding: 0 15%;
	}
	.gallery-item-info li {
		font-size: 1.3rem;
	}
	
	.content-wrapper{
	min-height: 500px !important;
	}
	
	.content:last-child{
	padding-bottom: 0;
	}
}

</style>
<body class="hold-transition skin-blue sidebar-mini">

<div id="loading">
	<div class="loader">
		<span class="cup">
		<span class="coffee"><span class="ingredient"></span></span>
		</span></div>
</div>
	<div id="main" class="wrapper">
			<%@ include file="include/main_header.jsp"%>
	  <div class="header" style="background-image: url(https://source.unsplash.com/1600x900/?coffee);">
	  	<p class="title">세상 사람들이 알았으면 하는 우리 동네 카페</p>
	<h1 class="title">카페와 나</h1>
	  </div>

		<!--  -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Main content -->
			<section class="content container-fluid">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<h1>실시간 생생 후기</h1>
				</section>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${cafelists}" var="cafelist">
							<div class="swiper-slide gallery-item">
								<img class="gallery-image"
									src="${path}/dist/img/upload_files${cafelist.cimage}" />
								<div class="gallery-item-info">
									<ul>
										<li>${cafelist.cafename}</li>
										<c:if test="${cafelist.reviewcnt eq 0}">
											<li><i class="fa fa-star"></i>0.0</li>
										</c:if>
										<c:if test="${cafelist.reviewcnt ne 0}">
											<li><i class="fa fa-star"></i>${cafelist.scorecnt/cafelist.reviewcnt}</li>
										</c:if>

									</ul>
								</div>
								<%-- ${cafelist.cafename} --%>
							</div>
						</c:forEach>
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</section>
						<section class="content container-fluid">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<h1>평점 순</h1>
				</section>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${ratelists}" var="ratelist">
							<div class="swiper-slide gallery-item">
								<img class="gallery-image"
									src="${path}/dist/img/upload_files${ratelist.cimage}" />
								<div class="gallery-item-info">
									<ul>
										<li>${ratelist.cafename}</li>
										<c:if test="${ratelist.reviewcnt eq 0}">
											<li><i class="fa fa-star"></i>0.0</li>
										</c:if>
										<c:if test="${ratelist.reviewcnt ne 0}">
											<li><i class="fa fa-star"></i>${ratelist.scorecnt/ratelist.reviewcnt}</li>
										</c:if>

									</ul>
								</div>
								<%-- ${cafelist.cafename} --%>
							</div>
						</c:forEach>
					</div>
					<div class="swiper-pagination"></div>
				</div>

			</section>
		</div>
		<!-- /.content-wrapper -->

	<%@ include file="include/main_footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@ include file="include/footerjs.jsp"%>
	<!-- Swiper JS -->
	<script src="${pagContext.request.contextPath}/dist/js/swiper.min.js"></script>
	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper('.swiper-container', {
			slidesPerView : 3,
			spaceBetween : 20,
			pagination : {
				el : '.swiper-pagination',
				clickable : true,
			},
		});
	</script>
	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->

</body>
</html>