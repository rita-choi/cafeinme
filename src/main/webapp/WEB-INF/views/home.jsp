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
	max-width: 97.5rem;
	margin: 0 auto;
	padding: 0 2rem;
	width: 100%;
	height: 100%;
}

.swiper-wrapper {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(22rem, 1fr));
	grid-gap: 2rem;
	flex-wrap: wrap;
	padding-bottom: 3rem;
}

.swiper-slide {
	position: relative;
	flex: 1 0 22rem;
	cursor: pointer;
	height: auto;
	text-align: center;
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


</style>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@ include file="include/main_header.jsp"%>
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
									src="${path}/dist/img/cafe/${cafelist.cimage}" />
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
				<!--------------------------
        | Your Page Content Here |
        -------------------------->

			</section>
			<!-- /.content -->
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
			spaceBetween : 30,
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