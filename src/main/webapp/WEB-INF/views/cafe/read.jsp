<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%@ include file="../include/footerjs.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<script>
	$(document).ready(function() {
		// 목록 페이지 제어
		var formObj = $("form[role='form']");
		console.log(formObj);
		//수정
		$(".modBtn").on("click", function() {
			formObj.attr("action", "/cafe/modify");
			formObj.attr("method", "get");
			formObj.submit();
		});
		//삭제
		$(".delBtn").on("click", function() {
			formObj.attr("action", "/cafe/delete");
			formObj.submit();
		});
		$(".listBtn").on("click", function() {
			formObj.attr("action", "/cafe/list");
			formObj.attr("method", "get");
			formObj.submit();
		});
	});
	$(document)
			.ready(
					function() {
						
						//전역 변수
						var cno = ${cafelist.cno}; //현재 게시글 번호
				        var uid = "${login.uid}";
				        var score = 5;
				        
				        var finalscore = ${cafelist.scorecnt} /${cafelist.reviewcnt};
				        
				        $('input[name="score"]').click(function(){
				        	  score = $('input[name="score"]:checked').val();
				        });
				        
				        if(${cafelist.scorecnt} != 0 && ${cafelist.reviewcnt} != 0) {
				        $("#scorecnt").text(parseFloat(finalscore).toFixed(1));
				        }else if(${cafelist.scorecnt} == 0){
				        $("#scorecnt").text("카페에 대한 리뷰와 평점을 남겨주세요!");
				        }

						var reviewPageNum = 1; // 리뷰 페이지 번호 초기화
						//리뷰 내용 : 줄바꿈, 공백처리
						Handlebars.registerHelper("escape",
								function(reviewText) {

									console.log("Handlebars.registerHelper");
									var text = Handlebars.Utils
											.escapeExpression(reviewText);
									text = text.replace(/(\r\n|\n|\r)/gm,
											"<br/>");
									text = text.replace(/( )/gm, "&nbsp;");
									return new Handlebars.SafeString(text);
								});
						// 리뷰 등록일자 : 날짜/시간 2자리로 맞추기
						Handlebars.registerHelper("prettifyDate", function(
								timeValue) {

							console.log("Handlebars.registerHelper - date");
							var dateObj = new Date(timeValue);
							var year = dateObj.getFullYear();
							var month = dateObj.getMonth() + 1;
							var date = dateObj.getDate();
							var hours = dateObj.getHours();
							var minutes = dateObj.getMinutes();
							// 2자리 숫자로 변환
							month < 10 ? month = '0' + month : month;
							date < 10 ? date = '0' + date : date;
							hours < 10 ? hours = '0' + hours : hours;
							minutes < 10 ? minutes = '0' + minutes : minutes;
							return year + "-" + month + "-" + date + "-"
									+ hours + ":" + minutes;
						});
						// 리뷰 목록 함수 호출
						getReviews("/reviews/" + cno + "/" + reviewPageNum);
						// 리뷰 목록 함수
						function getReviews(reviewsUri) {

							$.getJSON(reviewsUri, function(data) {
								printReviewCount(data.pageMaker.totalCount);
								printReviews(data.replies, $(".reviewsDiv"),
										$("#reviewTemplate"));
								printReviewPaging(data.pageMaker,
										$(".pagination"));

							
								
								 // 4. 댓글 추천여부 확인
				                $(".reviewDiv").each(function () {
				                    var reviewLike = $(this).find(".reviewLike");
				                    var rno = $(this).attr("data-rno");
				                    checkReviewLike(rno, reviewLike);
				                })
				                
				            // 5. 추천 갯수 확인
				                $(".reviewDiv").each(function () {
				                    var reviewLike = $(this).find(".reviewLike");
				                    var rno = $(this).attr("data-rno");
	                                totalCountReviewLike(rno, reviewLike);

				                })
				                // 6. 평점 갱신
				            	getScores("/cafe/score/" + cno, data.pageMaker.totalCount);
							});
							
							
						}
						
						//평점 갱신
						function getScores(scoreUri, totalCount){
							$.getJSON(scoreUri, function(data){
								$("#scorecnt").text(parseFloat(data/totalCount).toFixed(1));
							});
						}
						
				
						function printReviewCount(totalCount) {

							//리뷰 없을 시
							if (totalCount === 0) {
								$(".reviewCount").html("리뷰이 없습니다.");
								$(".collapsed-box").find(".btn-box-tool")
										.remove();
								return;
							}
							//리뷰 존재 시
							$(".reviewCount").html("리뷰 목록 (" + totalCount + ")");
							$(".collapsed-box").find(".box-tools").html(
									"<button type='button' class='btn btn-box-tool' data-widget='collapse'>"
											+ "<i class='fa fa-plus'></i>"
											+ "</button>");
						}
						//리뷰 목록 출력 함수
						function printReviews(reviewArr, targetArea, templateObj) {

							var reviewTemplate = Handlebars.compile(templateObj
									.html());
							var html = reviewTemplate(reviewArr);
							$(".reviewDiv").remove();
							targetArea.html(html);
						}
						//리뷰 페이징 출력 함수
						function printReviewPaging(pageMaker, targetArea) {

							var str = "";
							// 이전 버튼
							if (pageMaker.prev) {
								str += "<li><a href='"
										+ (pageMaker.startPage - 1)
										+ "'>이전</a></li>";
							}
							// 페이지 번호
							for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
								var strCalss = pageMaker.criteria.page == i ? "class='active'"
										: "";
								str += "<li " + strCalss +"><a href='"+i+"'>"
										+ i + "</a></li>";
							}
							if (pageMaker.next) {
								str += "<li><a href='"
										+ (pageMaker.endPage + 1)
										+ "'>다음</a></li>";
							}
							targetArea.html(str);
						}
						//리뷰 페이지 번호 클릭 이벤트
						$(".pagination").on("click", "li a", function(event) {
							console.log("click()");
							event.preventDefault();
							reviewPageNum = $(this).attr("href"); // 목록 페이지 번호 추출
							getReviews("/reviews/" + cno + "/" + reviewPageNum);
						});

						//리뷰 저장 버튼 클릭 이벤트
						$(".reviewAddBtn")
								.on(
										"click",
										function() {

											//입력 form 선택자
											var reviewTextObj = $("#newReviewText");
											var reviewerObj = $("#newReviewer");
											var reviewText = reviewTextObj.val();
											var reviewerVal = reviewerObj
													.val();
											
												//AJAX 통신 : POST
											$
													.ajax({
														type : "post",
														url : "/reviews",
														headers : {
															"Content-type" : "application/json",
															"X-HTTP-Method-Override" : "POST"
														},
														dataType : "text",
														data : JSON
																.stringify({
																	cno : cno,
																	reviewtxt : reviewText,
																	reviewer : reviewerVal,
																	score: score
																}),
														success : function(
																result) {
															if (result == "regSuccess") {
																console
																		.log("리뷰 등록 완료");
															}
															getReviews("/reviews/"
																	+ cno
																	+ "/"
																	+ reviewPageNum); //리뷰 목록 출력 함수 호출
															reviewTextObj
																	.val(""); // 리뷰 입력창 공백처리
															// 평점 버튼 초기화
															$('input[name="score"]:checked').removeAttr("checked");
															
														}
													});
											
										});

						$(".reviewDiv").on(
								"click",
								".reviewDiv a",
								function(event) {

									$(".in").css("opacity", ".5");

									var review = $(this).parent().parent()
											.parent();
									var reviewNo = review.attr("data-rno");
									var reviewText = review.find(".oldReviewtext")
											.text();

									$("#reviewText").val(reviewText);
								});

						$(".modalDelBtn")
								.on(
										"click",
										function() {

											// 리뷰 번호
											var reviewNo = $(this).parent()
													.parent().find(
															"#delreviewNo")
													.val();
											
											
											console.log("클릭한 리뷰 번호 :" + reviewNo);
											$
													.ajax({
														type : "delete",
														url : "/reviews/"
																+ reviewNo,
														headers : {
															"Content-type" : "application/json",
															"X-HTTP-Method-Override" : "DELETE"
														},
														dataType : "text",
														success : function(
																result) {
															console
																	.log("result >>> "
																			+ result);
															if (result == "delSuccess") {
																console
																		.log("리뷰 삭제 완료");
																$("#delModal")
																		.modal(
																				"hide");
																getReviews("/reviews/"
																		+ cno
																		+ "/"
																		+ reviewPageNum);//리뷰 목록 출력 함수 호출
															     // 평점 갱신
												            	getScores("/cafe/score/" + cno, data.pageMaker.totalCount);
															}
														}
													});
										});
						$(".modalModBtn")
								.on(
										"click",
										function() {
											// 리뷰 선택자
											var review = $(this).parent().parent();
											// 리뷰 선택 번호
											var reviewNo = review.find("#modreviewNo").val();
											
											
											//수정한 리뷰 내용
											var reviewText = review.find(
													"#reviewText").val();
											
											var newScore = review.find(".newScore").val();
											console.log("평점 수정 : " + newScore);
											
											$
													.ajax({
														type : "put",
														url : "/reviews/"
																+ reviewNo,
														headers : {
															"Content-type" : "application/json",
															"X-HTTP-Method-Override" : "PUT"
														},
														data : JSON
																.stringify({
																	reviewtxt : reviewText,
																	score : newScore
																}),
														dataType : "text",
														success : function(
																result) {
															if (result == "modSuccess") {
																console
																		.log("리뷰 수정  완료");
																$("#modModal")
																		.modal(
																				"hide");
																getReviews("/reviews/"
																		+ cno
																		+ "/"
																		+ reviewPageNum); //리뷰 목록 출력 함수 호출
															}
														}
													});
										});
					     Handlebars.registerHelper("eqReviewer", function (reviewerVal, block) {
					            var accum = "";
					            if (reviewerVal == "${login.uid}") {
					                accum += block.fn();
					            }
					            return accum;
					        });
					     /*================================================리뷰 평점 관련==================================*/

					     
				        /*================================================리뷰 추천 관련==================================*/
				        // 리뷰 추천여부 확인
				        var checkReviewLike = function (rno, reviewLike) {
				            reviewLike.find("i").attr("class", "fa fa-thumbs-o-up");
				            $.getJSON("/likes/check/" + cno + "/" + uid + "/" + rno, function (result) {
				                var likeCheck = result.checkReviewLike;
				                console.log("리뷰 추천 여부 확인");
				                if (likeCheck) {
				                    reviewLike.find("i").attr("class", "fa fa-thumbs-up");
				                }
				            });
				        };
				        // 리뷰 추천하기
				        $(".reviewsDiv").on("click", ".reviewLike", function (event) {
				            event.preventDefault();
				            var reviewLike = $(this);
				            var rno = reviewLike.closest(".reviewDiv").attr("data-rno");
				            var isReviewLike = reviewLike.find("i").hasClass("fa-thumbs-o-up");
				            if (uid == "") {
				                alert("로그인 후에 추천할 수 있습니다.");
				                location.href = "/user/login";
				                return;
				            }
				            if (isReviewLike) {
				                if (confirm("리뷰을 추천하시겠습니까?")) {
				                    $.ajax({
				                        type: "post",
				                        url: "/likes/create/" + cno + "/" + uid + "/"+ rno,
				                        headers: {
				                            "Content-Type" : "application/json",
				                            "X-HTTP-Method-Override" : "POST"
				                        },
				                        dataType: "text",
				                        success: function (result) {
				                            if (result == "REVIEW LIKE CREATED") {
				                                alert("리뷰이 추천되었습니다.");
				                                checkReviewLike(rno, reviewLike);
				                                totalCountReviewLike(rno, reviewLike);
				                            }
				                        }
				                    });
				                }
				                return;
				            }
				            if (confirm("리뷰 추천을 취소하시겠습니까?")) {
				                $.ajax({
				                    type: "delete",
				                    url: "/likes/delete/" + cno + "/" + uid + "/"+ rno,
				                    headers: {
				                        "Content-Type" : "application/json",
				                        "X-HTTP-Method-Override" : "DELETE"
				                    },
				                    dataType: "text",
				                    success: function (result) {
				                        if (result == "REVIEW LIKE DELETED") {
				                            alert("리뷰 추천 이 취소되었습니다.");
				                            checkReviewLike(rno, reviewLike);
				                            totalCountReviewLike(rno, reviewLike);
				                        }
				                    }
				                });
				            }
				        });
				        // 리뷰 추천수 갱신
				        var totalCountReviewLike = function (rno, reviewLike) {
				            $.getJSON("/likes/count/" + cno + "/" + rno, function (result) {
				                reviewLike.find("span").html("(" + result.reviewLikeTotalCount + ")");
				            });
				        };
				        
				        
				        /*================================================게시글 북마크 관련==================================*/
				        var cafeBookmark = $(".cafeBookmark");
				        // 게시글 북마크 여부확인
				        var checkBookmark = function () {
				            cafeBookmark.find("i").attr("class", "fa fa-bookmark-o");
				            $.getJSON("/bookmark/check/" + cno + "/" + uid, function (result) {
				                var bookmarkCheck = result.isBookmarkCheck;
				                if (bookmarkCheck) {
				                    cafeBookmark.find("i").attr("class", "fa fa-bookmark");
				                }
				            });
				        };
				        checkBookmark();
				        // 게시글 북마크 등록 or 취소
				        cafeBookmark.on("click", function () {
				            if (uid == "") {
				                alert("로그인 후에 북마크 등록할 수 있습니다.");
				                location.href = "/user/login";
				                return;
				            }
				            var iscafeBookmark = cafeBookmark.find("i").hasClass("fa-bookmark-o");
				            if (iscafeBookmark) {
				                if (confirm("북마크 등록하시겠습니까?")) {
				                    $.ajax({
				                        type: "post",
				                        url: "/bookmark/create/",
				                        headers: {
				                            "Content-Type" : "application/json",
				                            "X-HTTP-Method-Override" : "POST"
				                        },
				                        data: JSON.stringify({
				                            cno:cno,
				                            uid:uid
				                        }),
				                        dataType: "text",
				                        success: function (result) {
				                            console.log("result : " + result);
				                            if (result == "BOOKMARK INSERTED") {
				                                alert("북마크 등록되었습니다.");
				                                checkBookmark();
				                            }
				                        }
				                    });
				                }
				                return;
				            }
				            if (confirm("북마크를 취소하시겠습니까?")) {
				                $.ajax({
				                    type: "delete",
				                    url: "/bookmark/remove/" + cno + "/" + uid,
				                    headers: {
				                        "Content-Type" : "application/json",
				                        "X-HTTP-Method-Override" : "DELETE"
				                    },
				                    dataType: "text",
				                    success: function (result) {
				                        console.log("result : " + result);
				                        if (result == "BOOKMARK DELETED") {
				                            alert("북마크가 취소되었습니다.");
				                            checkBookmark();
				                        }
				                    }
				                });
				            }
				        });

				        /*================================================게시판 첨부파일 업로드 목록 관련==================================*/
				        var templatePhotoAttach = Handlebars.compile($("#templatePhotoAttach").html()); // 이미지 template
				        var templateFileAttach = Handlebars.compile($("#templateFileAttach").html());   // 일반파일 template
				        $.getJSON("/file/list/" + cno, function (list) {
				            if (list.length == 0) {
				                $(".uploadedList").html("첨부파일이 없습니다.");
				            }
				            $(list).each(function () {
				                // 파일정보 가공
				                var fileInfo = getFileInfo(this);
				                // 이미지 파일일 경우
				                if (fileInfo.fullName.substr(12, 2) == "s_") {
				                    var html = templatePhotoAttach(fileInfo);
				                    // 이미지 파일이 아닐 경우
				                } else {
				                    html = templateFileAttach(fileInfo);
				                }
				                $(".uploadedList").append(html);
				            })
				        });
					});
	
	
</script>
<style>

.star-rating {
  font-family: 'FontAwesome';
  margin: 50px auto;
}
.star-rating > fieldset {
  border: none;
  display: inline-block;
}
.star-rating > fieldset:not(:checked) > input {
  position: absolute;
  /*top: -9999px;*/
  clip: rect(0, 0, 0, 0);
}
.star-rating > fieldset:not(:checked) > label {
  float: right;
  width: 1em;
  padding: 0 0.05em;
  overflow: hidden;
  white-space: nowrap;
  cursor: pointer;
  font-size: 200%;
  color: #f0b111;
}
.star-rating > fieldset:not(:checked) > label:before {
  content: '\f006  ';
}
.star-rating > fieldset:not(:checked) > label:hover,
.star-rating > fieldset:not(:checked) > label:hover ~ label {
  color: #f0b111;
  text-shadow: 0 0 3px #f0b111;
}
.star-rating > fieldset:not(:checked) > label:hover:before,
.star-rating > fieldset:not(:checked) > label:hover ~ label:before {
  content: '\f005  ';
}
.star-rating > fieldset > input:checked ~ label:before {
  content: '\f005  ';
}
.star-rating > fieldset > label:active {
  position: relative;
  top: 2px;
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
							<h3 class="box-title">카페 이름 : ${cafelist.cafename}</h3>
							<ul class="list-inline pull-right">
								<li><a href="#" class="link-black text-lg"><i
										class="fa fa-share"></i>공유</a></li>
								<li><a href="#" class="link-black text-lg cafeBookmark"><i
										class="fa fa-bookmark-o"></i> 북마크</a></li>
								<li><a href="#" class="link-black text-lg boardLike"><i
										class="fa"></i> 추천 <span></span></a></li>
								<li><a href="#" class="link-black text-lg"><i
										class="fa fa-eye"></i>조회수 (${cafelist.viewcnt})</a></li>
							</ul>
						</div>
						<div class="box-header with-border">
							<h3 class="box-title">평점 : <span id="scorecnt"></span></h3>
						</div>
						<div class="box-body" style="height: 700px;">
							${cafelist.content}</div>
						<div class="box-footer">
						위치 : ${cafelist.location}
						<div id="map" style="width:100%;height:350px;"></div>
						</div>
					<%--업로드 파일 정보 영역--%>
                    <div class="box-footer uploadFiles">
                        <ul class="mailbox-attachments clearfix uploadedList"></ul>
                    </div>
						<div class="box-footer">
							<div class="user-block">
								<img class="img-circle img-bordered-sm"
									src="${pagContext.request.contextPath}/dist/img/user1-128x128.jpg"
									alt="user image" /> <span class="username"> <a href="#">${cafelist.writer}</a>
								</span> <span class="description"><fmt:formatDate
										pattern="yyyy-MM-dd a HH:mm" value="${cafelist.updatedate}" /></span>
							</div>
						</div>
						<div class="box-footer">
							<form role="form" method="post">
								<input type="hidden" name="cno" value="${cafelist.cno}">
								<input type="hidden" name="page" value="${searchCriteria.page}">
								<input type="hidden" name="perPageNum"
									value="${searchCriteria.perPageNum}"> <input
									type="hidden" name="searchType"
									value="${searchCriteria.searchType}"> <input
									type="hidden" name="keyword" value="${searchCriteria.keyword}">
							</form>
							<button type="submit" class="btn btn-primary listBtn">
								<i class="fa fa-list"></i>목록
							</button>
 						<c:if test="${login.uid == cafelist.writer}">
                            <div class="pull-right">
                                <button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i> 수정</button>
                                <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                            </div>
                        </c:if>
						</div>
					</div>
  <%--리뷰 입력 영역--%>
                <c:if test="${not empty login}">
                    <div class="box box-warning">
                        <div class="box-header with-border">
                            <a class="link-black text-lg"><i class="fa fa-pencil"></i> 리뷰작성</a>
                        </div>
                        <div class="box-body">
                            <form class="form-horizontal">
                                <div class="form-group margin-bottom-none">
                                    <div class="col-sm-10">
                                        <textarea class="form-control" id="newReviewText" rows="3" placeholder="리뷰을 입력해주세요..." style="resize: none"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control" id="newReviewer" type="text" value="${login.uid}" readonly="readonly">
                                    </div>
                                    <hr/>
                                    <div class="star-rating">
  <fieldset>
    <input type="radio" id="star5" name="score" value="5" checked /><label for="star5" title="Outstanding">5 stars</label>
    <input type="radio" id="star4" name="score" value="4" /><label for="star4" title="Very Good">4 stars</label>
    <input type="radio" id="star3" name="score" value="3" /><label for="star3" title="Good">3 stars</label>
    <input type="radio" id="star2" name="score" value="2" /><label for="star2" title="Poor">2 stars</label>
    <input type="radio" id="star1" name="score" value="1" /><label for="star1" title="Very Poor">1 star</label>
  </fieldset>
</div>
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-primary btn-block reviewAddBtn"><i class="fa fa-save"></i> 저장</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty login}">
                    <div class="box box-warning">
                        <div class="box-header with-border">
                            <p><i class="fa fa-pencil"></i> 리뷰 작성을 위해 <a href="${path}/user/login" class="link-black text-lg">로그인</a>해주세요</p>
                        </div>
                    </div>
                </c:if>
					<div class="box box-success collapsed-box">
						<!-- 리뷰 유무, 리뷰 갯수, 리뷰 펼치기 & 접기 -->
						<div class="box-cheader with-border">
							<a href="" class="link-black text-lg"><i
								class="fa fa-comments-o margin-r-5 reviewCount"
								data-widget="collapse"></i></a>
							<div class="box-tools">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-plus"></i>
								</button>
							</div>
						</div>

						<!-- 리뷰 목록 -->
						<div class="box-body reviewsDiv"></div>

						<!-- 리뷰 수정 Modal 영역 -->
						<div class="modal fade" id="modModal">
							<div class="model-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="mdodal-title">리뷰 수정</h4>
									</div>
									<div class="modal-body">
										<input type="hidden" class="reviewNo" id="modreviewNo" />
										<textarea class="form-control" id="reviewText" rows="3"
											style="resize: none"></textarea>
									  <div class="star-rating Modstar">
  <fieldset>
    <input type="radio" id="star5" name="score" value="5" checked/><label for="star5" title="Outstanding">5 stars</label>
    <input type="radio" id="star4" name="score" value="4" /><label for="star4" title="Very Good">4 stars</label>
    <input type="radio" id="star3" name="score" value="3" /><label for="star3" title="Good">3 stars</label>
    <input type="radio" id="star2" name="score" value="2" /><label for="star2" title="Poor">2 stars</label>
    <input type="radio" id="star1" name="score" value="1" /><label for="star1" title="Very Poor">1 star</label>
  </fieldset>
</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-success modalModBtn">수정</button>
									</div>
								</div>
							</div>
						</div>

						<!-- 리뷰 삭제 Modal 영역 -->
						<div class="modal fade" id="delModal">
							<div class="model-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="mdodal-title">리뷰 삭제</h4>
									</div>
									<div class="modal-body">
										<p>리뷰을 삭제하시겠습니까?</p>
										<input type="hidden" class="reviewNo" id="delreviewNo" />
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">아니요</button>
										<button type="button" class="btn btn-success modalDelBtn">네,
											삭제합니다.</button>
									</div>
								</div>
							</div>
						</div>



						<!-- 리뷰 페이징 -->

						<div class="box-footer">
							<div class="text-center">
								<ul class="pagination pagination-sm no-margin">

								</ul>
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
	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9619937fadbc25cf54f5d5e469cc0c2a&libraries=services"></script>
<%-- 다음 지도 --%>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${cafelist.location}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${cafelist.cafename}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<%--Handlebars JS--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<%--업로드 JS--%>
<script type="text/javascript" src="/resources/dist/js/upload.js"></script>

<%--첨부파일 하나의 영역--%>
<%--이미지--%>
<script id="templatePhotoAttach" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name" data-lightbox="uploadImages"><i class="fa fa-camera"></i> {{fileName}}</a>
        </div>
    </li>
</script>
<%--일반 파일--%>
<script id="templateFileAttach" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> {{fileName}}</a>
        </div>
    </li>
</script>
	<!-- ./wrapper -->
	<script id="reviewTemplate" type="text/x-handlebars-template">
    {{#each.}}
    <div class="post reviewDiv" data-rno={{rno}}>
           <div class="user-block">
            <%--리뷰 작성자 프로필사진 : 추후 이미지 업로드기능 구현 예정--%>
            <img class="img-circle img-bordered-sm" src="${path}/dist/img/profile{{userVO.uimage}}" alt="user image">
            <%--리뷰 작성자--%>
            <span class="username">
                <%--작성자 이름--%>
                <a href="#">{{reviewer}}</a>
                {{#eqReviewer reviewer}}
                <%--리뷰 삭제 버튼--%>
                <a href="#" class="pull-right btn-box-tool reviewDelBtn" data-toggle="modal" data-target="#delModal">
                    <i class="fa fa-times"> 삭제</i>
                </a>
                <%--리뷰 수정 버튼--%>
                <a href="#" class="pull-right btn-box-tool reviewModBtn" data-toggle="modal" data-target="#modModal">
                    <i class="fa fa-edit"> 수정</i>
                </a>
                {{/eqReviewer}}
            </span>
            <%--리뷰 작성일자--%>
            <span class="description">{{prettifyDate regdate}}</span>
        </div>
        <%--리뷰 내용--%>
        <div class="oldReviewtext">{{{escape reviewtxt}}}</div>
        <br/>
        <%--리뷰 추천 버튼--%>
        <ul class="list-inline">
            <li>
                <a href="#" class="link-black text-sm reviewLike">
                    <i class="fa fa-thumbs-o-up"></i> 추천<span>({{rlnocount}})</span>
                </a>
            </li>
			<li>
				<i class="fa fa-star"></i> 평점<span>{{score}}.0 점</span>
			</li>
        </ul>
    </div>
    {{/each}}
</script>


	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>