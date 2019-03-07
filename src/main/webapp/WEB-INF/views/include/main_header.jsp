<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<style>
#app {
	display: inline;
	align-items: center;
	justify-content: center;
	height: initial;
	padding-top: 5px;
	overflow: hidden;
}

#header {
    margin: 0 auto;
    width: 100%;
    border-bottom: 1px solid #c0c0c0;
    padding: 0 20%;
}

.checkbox, .radio{
    margin-left: 20px;
}

#header .gnb {
	height: 50px;
}

#header .gnb ul {
	overflow: hidden;
	text-align: center;
}

#header .gnb ul li {
	display: inline-block;
}

#header .gnb ul li a {
	display: block;
	height: 51px;
	line-height: 51px;
	font-size: 1.3em;
	padding: 0 84px;
	letter-spacing: -.50px;
}

a {
	color: #222;
	text-decoration: none;
}

.cup {
    top: 8.5px;
    position: absolute;
    margin: 0 auto;
    width: 37px;
    height: 32px;
    border-radius: .05em .05em 3em 3em;
    box-shadow: 0 0 0 0.2em #242424;
}

.coffee {
     position: absolute;
    z-index: 10;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    background: #FFF;
    border-radius: .05em .05em 3em 3em;
}

.coffee:before {
    content: '';
    display: block;
    width: 200%;
    height: 1em;
    position: absolute;
    left: -50%;
    top: -.5em;
    background: #FFF;
    animation: coffee-wave .8s ease-in-out infinite;
    border-radius: 50%;
}
.cup:after {
    content: '';
    display: block;
    position: absolute;
    left: 85%;
    top: 0.3em;
    width: 5px;
    height: 10px;
    box-shadow: 0 0 0 0.3em #242424;
    margin-left: .5em;
    border-radius: 0 50% 50% 0;
}
.ingredient {
    position: absolute;
    left: 0;
    top: 5%;
    width: 100%;
    height: 100%;
    background: linear-gradient(to bottom, #252C32 5%, #F4E8DA 5%, #F4E8DA 30%, #DAB7A3 30%, #DAB7A3 70%, #87624F 70%);
    animation: coffee-load 5s infinite;
}


@keyframes coffee-load {
	0% {
		transform: translateY(100%);
	}
	70% {
		transform: translateY(30%);
	}
	90% {
		transform: translateY(0);
	}
	95% {
		transform: translateY(0);
	}
	100% {
		transform: translateY(100%);
	}
}

@keyframes coffee-wave {
	0% {
		transform: rotate(2deg);
	}
	50% {
		transform: rotate(-2deg);
  }
	100% {
		transform: rotate(2deg);
	}
}

#header .info {
    padding: 8px 0;
    display: inline-block;
    height: 50px;
    width: 230px;
}

#header .info h1 {
font-size: 20px;
    font-weight: 800;
    color: #252C32;
    margin: 0 auto;
}

#header .info p {
    font-family: 'Noto Serif KR', serif;
    font-size: 10px;
    font-weight: 600;
}
@media screen and (max-width:700px) { 
/*모바일*/

 
#header {
padding: 0;
} 

#app .col-lg-12 {
		width: 375px;
	}
	.content-wrapper {
		padding: 0;
	}
	.mb-btn {
		bottom: 10%;
		right: 5%;
	}
	.main-header .logo {
		float: left;
		width: 25vw;
		padding: 0;
		display: inline-block;
	}
	.navbar-custom-menu>.navbar-nav>li {
		display: inline-block;
	}
	#header .info {
		display: none !important;
	}
	
	.navbar-nav>li>a{
	padding: 15px 10px; 
	}
	
	.navbar 	.cup {
		left: 10px;
	}
	
#loading .cup {
    left: -20px;
    top: -2vh;
}
}

.header .title {
    position: relative;
    z-index: 1;
    margin: 0 auto;
    width: 300px;
    font-size: 1.625rem;
    color: #ffffff;
    line-height: 32px;
}

#loading {
 width: 100%;  
 height: 100%;  
 top: 0px;
 left: 0px;
 position: fixed;  
 display: block;  
 opacity: 1;  
 background-color: #fff;  
 z-index: 9999;  
 text-align: center; } 

.loader {
    position: absolute;
    top: 50%;
    left: 50%;
}

</style>
<!-- Header -->
<header id="header" class="main-header">

	<%-- Header Navbar --%>
	<nav class="navbar navbar-static-top" role="navigation">
		<%-- Logo --%>
		<a href="/" class="logo"> 
		<span class="logo-lg cup">
		<span class="coffee"><span class="ingredient"></span></span>
		</span>
		</a>
		<div class="info">
			<h1>카페와 나</h1>
			<p>우리 동네 카페 소개소</p>
		</div>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
			<li class="false"><a href="/cafe/write"><span
					data-reactid="42">우리 동네 카페 등록</span></a></li>
			<li class="false"><a href="/cafe/list"><span>카페 탐방</span></a></li>
				<c:if test="${not empty login}">
					<li class="dropdown user user-menu"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <img
							src="${path}/dist/img/profile${login.uimage}" class="user-image"
							alt="User Image"> <span class="hidden-xs">${login.uname}</span>
					</a>
						<ul class="dropdown-menu">
							<li class="user-body">
								<div class="row">
									<div class="col-xs-4 text-center">
										<a href="#">게시글</a>
									</div>
									<div class="col-xs-4 text-center">
										<a href="#">추천글</a>
									</div>
									<div class="col-xs-4 text-center">
										<a href="#">북마크</a>
									</div>
								</div>
							</li>
							<li class="user-footer">
								<div class="pull-left">
									<a href="${path}/user/profile" class="btn btn-default btn-flat"><i
										class="fa fa-info-circle"></i><b> 내 프로필</b></a>
								</div>
								<div class="pull-right">
									<a href="${path}/user/logout" class="btn btn-default btn-flat"><i
										class="glyphicon glyphicon-log-out"></i><b> 로그아웃</b></a>
								</div>
							</li>
						</ul></li>
				</c:if>
				<c:if test="${empty login}">
					<li class="dropdown user user-menu"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <img
							src="${path}/dist/img/default-user-image.png" class="user-image"
							alt="User Image"> <span class="hidden-xs">회원가입 또는
								로그인</span>
					</a>
						<ul class="dropdown-menu">
							<li class="user-footer">
								<div class="pull-left">
									<a href="${path}/user/register"
										class="btn btn-default btn-flat"><i
										class="fa fa-user-plus"></i><b> 회원가입</b></a>
								</div>
								<div class="pull-right">
									<a href="${path}/user/login" class="btn btn-default btn-flat"><i
										class="glyphicon glyphicon-log-in"></i><b> 로그인</b></a>
								</div>
							</li>
						</ul></li>
				</c:if>
			</ul>
		</div>
	</nav>

</header>
