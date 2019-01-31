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
					<form role="form" id="modForm" method="POST" action="${path}/cafe/modify">
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
							  <div class="form-group">
                                <div class="fileDrop">
                                    <br/>
                                    <br/>
                                    <br/>
                                    <br/>
                                    <p class="text-center"><i class="fa fa-paperclip"></i> 첨부파일을 드래그해주세요.</p>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <ul class="mailbox-attachments clearfix uploadedList"></ul>
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
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn"><i class="fa fa-fw fa-remove"></i></a>
        </div>
    </li>
</script>
<%--일반 파일--%>
<script id="templateFileAttach" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> {{fileName}}</a>
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn"><i class="fa fa-fw fa-remove"></i></a>
        </div>
    </li>
</script>
<script>
    $(document).ready(function () {
        // 전역 변수 선언
        var cno = ${cafelist.cno}; // 현재 게시글 번호
        var templatePhotoAttach = Handlebars.compile($("#templatePhotoAttach").html()); // 이미지 Template
        var templateFileAttach = Handlebars.compile($("#templateFileAttach").html());   // 일반파일 Template
        /*================================================게시판 업로드 첨부파일 추가관련===================================*/
        // 전체 페이지 파일 끌어 놓기 기본 이벤트 방지 : 지정된 영역외에 파일 드래그 드랍시 페이지 이동방지
        $(".content-wrapper").on("dragenter dragover drop", function (event) {
            event.preventDefault();
        });
        // 파일 끌어 놓기 기본 이벤트 방지
        $(".fileDrop").on("dragenter dragover", function (event) {
            event.preventDefault();
        });
        // 파일 드랍 이벤트 : 파일 전송 처리
        $(".fileDrop").on("drop", function (event) {
            event.preventDefault();
            var files = event.originalEvent.dataTransfer.files;
            var file = files[0];
            console.log("file: " + file);
            var formData = new FormData();
            formData.append("file", file);
            $.ajax({
                url: "/file/upload",
                data: formData,
                dataType: "text",
                processData: false,
                contentType: false,
                type: "POST",
                success: function (data) {
                    // 파일정보 가공
                    var fileInfo = getFileInfo(data);
                    // 이미지 파일일 경우
                    if (fileInfo.fullName.substr(12, 2) == "s_") {
                        var html = templatePhotoAttach(fileInfo);
                        // 이미지 파일이 아닐경우
                    } else {
                        html = templateFileAttach(fileInfo);
                    }
                    // 목록에 출력
                    $(".uploadedList").append(html);
                }
            });
        });
        // 수정 처리시 파일 정보도 함께 처리
        $("#modForm").submit(function (event) {
            event.preventDefault();
            var that = $(this);
            var str = "";
            $(".uploadedList .delBtn").each(function (index) {
                str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'>"
            });
            that.append(str)
            console.log(">>>>"+that.get(0));
            that.get(0).submit();
        });
        // 파일 삭제 버튼 클릭 이벤트
        $(document).on("click", ".delBtn", function (event) {
            event.preventDefault();
            if (confirm("삭제하시겠습니까? 삭제된 파일은 복구할 수 없습니다.")) {
                var that = $(this);
                $.ajax({
                    url: "/file/delete/" + cno,
                    type: "post",
                    data: {fileName:$(this).attr("href")},
                    dataType: "text",
                    success: function (result) {
                        if (result == "DELETED") {
                            alert("삭제되었습니다.");
                            that.parents("li").remove();
                        }
                    }
                });
            }
        });
        /*================================================게시판 업로드 첨부파일 목록관련===================================*/
        $.getJSON("/file/list/" + cno, function (list) {
            $(list).each(function () {
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
        /*================================================게시판 페이지 이동관련===========================================*/
        // 페이지 이동 form 선택자
        var formObj = $("form[role='form']");
        console.log(formObj);
        // 수정버튼 클릭 이벤트
        // $(".modBtn").on("click", function () {
        //     formObj.submit();
        // });
        // 취소버튼 클릭 이벤트
        $(".cancelBtn").on("click", function () {
            history.go(-1);
        });
        // 목록버튼 클릭 이벤트
        $(".listBtn").on("click", function () {
            self.location =  "/cafe/list?page=${searchCriteria.page}"
				+ "&perPageNum=${searchCriteria.perPageNum}"
				+ "&searchType=${searchCriteria.searchType}"
				+ "&keyword=${searchCriteria.keyword}";
        });
    });
</script>


	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>