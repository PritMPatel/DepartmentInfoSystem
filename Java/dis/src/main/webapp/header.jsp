<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script src="js/jquery-3.2.1.min.js"></script>
<link rel="icon" type="image/ico" href="images/download.jpg" />
<%-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.3.7/dist/css/uikit.min.css" /> --%>
<%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	 --%>

<style type="text/javascript">
	.body {
		height: 100%;
		margin: 0;
		font: 400 10px/1.8 "Lato", sans-serif;
		margin-bottom: 60px; /* Margin bottom by footer height */
		color: #777;
	}
</style>

</head>

<style type="text/css">
	@media print {@page { size: landscape !important;}}
	table{
		border-collapse: collapse;
	}
	th,td{
		width: max-content;
		border: 1px solid black;
		text-align: center;
		vertical-align: center;
		padding: 2px 5px;
	}
	.uk-table{
		width: auto !important;
	}
	input[type=number] {	
		-moz-appearance: textfield;
		/* padding:0px;
		border: 0px;
		text-align: center; */
	}
</style>
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> --%>

<body style="user-select: none;">

	<script src="js/uikit.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/DIS.css">
	<link rel="stylesheet" type="text/css" href="css/nav-style.css">
	<%-- <link rel="stylesheet" type="text/css" href="css/uikit.css"> --%>
	<link rel="stylesheet" type="text/css" href="css/uikit.min.css">
	<link rel="stylesheet" type="text/javascript" href="JScript/passtest.js">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"	crossorigin="anonymous">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script type="text/javascript">
		$(document).on("click",".approveAdmin",function () {
			var id2 = this.id;
			$.ajax({
				url: "update-approve-admin-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
		$(document).on("click",".rejectAdmin",function () {
			var id2 = this.id;
			$.ajax({
				url: "update-reject-admin-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
		$(document).on("click",".approveFaculty",function () {
			var id2 = this.id;
			$.ajax({
				url: "update-approve-faculty-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
		$(document).on("click",".rejectFaculty",function () {
			var id2 = this.id;
			$.ajax({
				url: "update-reject-faculty-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
		$(document).on("click",".removeFaculty",function () {
			var id2 = this.id;
			$.ajax({
				url: "update-remove-faculty-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
</script>
	<div class="container-fluid "
		style="padding-left: 0px; padding-right: 0px;">
		<div class="row" style="margin-left: 5px;">
			<img src="images/download.jpg"
				class="img-responsive my-img mt-3 mr-3 ml-3 mb-3"
				style="height: 60px; width: 60px; margin-left: 15px;">
			<!-- <div class="col-sm"> -->
			<p class="h4" style="margin-top: 20px; padding-top: 10px; color: #031424;">DEPARTMENT INFORMATION SYSTEM</p>
		</div>