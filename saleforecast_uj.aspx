<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc=1;
			q_tables = 's';
			var q_name = "saleforecast";
			var q_readonly = ['txtNoa','txtDatea'];
			var q_readonlys = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [['txtMount', 15, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			aPop = new Array(
				['txtProductno_', '', 'uca', 'noa', '0txtProductno_,', 'uca_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			//////////////////   end Ready
			function main() {
				if(dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtMon', r_picm],['txtDatea', r_picd]];
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				
			}
		
			function q_boxClose(s2) {///   q_boxClose 2/4
				var	ret;
				b_ret = getb_ret();
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					
					case q_name:
						if(q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')]]);
				if(t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr='';
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
						}
					}
					$('#txtSpec_'+i).val(tstr);
				}
							
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if(s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_saleforecast')+ $('#txtMon').val(), '/', ''));
				else
					wrServer(s1);
			}
			
			function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtSpec_'+i).val().split('@,#');
					var tstc=1;
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							$('#'+fbbs[j]+'_'+i).val(tstr[tstc]);
							tstc++;
						}
					}
				}
			}

			function _btnSeek() {
				if(q_cur > 0 && q_cur < 4)// 1-3
					return;
			   q_box('saleforecast_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					  }
				}
				_bbsAssign();
				splitbbsf();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substr(0,r_lenm));
				$('#txtMon').focus();
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
					return;
				_btnModi();
				
			}

			function btnPrint() {
				q_box('z_saleforecast.aspx','', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if(!as['productno'] && !as['mount']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['mon'] = abbm2['mon'];
				return true;
			}


			function refresh(recno) {
				_refresh(recno);
				
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			
			function sum() {
				var t_gwelght=0,t_twelght = 0, t_welght = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					
				} // j
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
			
		</script> 
	<style type="text/css">
				  #dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c5 {
				width: 80%;
				float: left;
			}
			.txt.c6 {
				width: 50%;
				float: left;
			}
			.txt.c7 {
				float:left;
				width: 22%;
				
			}
			.txt.c8 {
				float:left;
				width: 65px;
				
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
			}
			.tbbm textarea {
				font-size: medium;
			}
			
			 input[type="text"],input[type="button"] {	 
				font-size: medium;
			}
		 .dbbs .tbbs{
		 	margin:0;
		 	padding:2px;
		 	border:2px lightgrey double;
		 	border-spacing:1px;
		 	border-collapse:collapse;
		 	font-size:medium;
		 	color:blue;
		 	background:#cad3ff;
		 	width: 100%;
		 }
		 .dbbs .tbbs tr{
		 	height:35px;
		 }
		 .dbbs .tbbs tr td{
		 	text-align:center;
		 	border:2px lightgrey double;
		 }
	</style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
	<div class="dview" id="dview" style="float: left;  width:150px;"  >
		<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'> </a></td>
				<td align="center" style="width:95%"><a id='vewMon'> </a></td>
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
				   <td align="center" id='mon'>~mon</td>
			</tr>
		</table>
	</div>
	<div class='dbbm' style="width: 68%;float:left">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			<tr>
				<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
				<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
				<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
				<td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
				<td class="td5"><span> </span><a id="lblMon" class="lbl"> </a></td>
				<td class="td6"><input id="txtMon" type="text" class="txt c1"/></td>
			</tr>
			<tr>
				<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
				<td class="td2" colspan='5'><input id="txtMemo" type="text" class="txt c1"/></td>
			</tr>
		</table>
	</div>
	<div class='dbbs' style="width:2400px;"> 
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			<tr style='color:White; background:#003366;' >
				<td align="center" style="width:40px;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td style="width:60px;"><a id='lblNoq_uj_s'>項次</a></td>
				<td align="center" style="width:100px;"><a id='lblF01_uj_s'>產品別</a></td>
				<td align="center" style="width:225px;"><a id='lblProductno_uj_s'>半成品料號</a></td>
				<td align="center" style="width:100px;"><a id='lblF02_uj_s'>製程天數(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF03_uj_s'>MOQ生產點(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF04_uj_s'>MOQ生產量(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF05_uj_s'>月均(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF06_uj_s'>手動月均(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF07_uj_s'>手調安全庫存(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF08_uj_s'>一次生產</a></td>
				<td align="center" style="width:100px;"><a id='lblF09_uj_s'>月目標(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF10_uj_s'>生產週期(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF11_uj_s'>安全庫存(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF12_uj_s'>生產點(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF13_uj_s'>最大生產量(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF14_uj_s'>總庫存(天)</a></td>
				<td align="center" style="width:100px;"><a id='lblF15_uj_s'>生產點(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF16_uj_s'>最大生產量(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF17_uj_s'>總庫存(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblMount_uj_s'>生產量(M)</a></td>
				<td align="center" style="width:70px;"><a id='lblUnit_uj_s'>需求</a></td>
				<td align="center" style="width:100px;"><a id='lblF18_uj_s'>一顆料長(M)</a></td>
				<td align="center" style="width:200px;"><a id='lblMemo_uj_s'>備註</a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td><input id="txtNoq.*" type="text" class="txt c1" /></td>
				<td>
					<input id="textF01.*" type="text" class="txt c1" />
					<input id="txtSpec.*" type="hidden" class="txt c1" />
				</td>
				<td align="center"><input id="txtProductno.*" type="text" class="txt c1" /></td>
				<td><input id="textF02.*" type="text" class="txt c1" /></td>
				<td><input id="textF03.*" type="text" class="txt c1" /></td>
				<td><input id="textF04.*" type="text" class="txt c1" /></td>
				<td><input id="textF05.*" type="text" class="txt c1" /></td>
				<td><input id="textF06.*" type="text" class="txt c1" /></td>
				<td><input id="textF07.*" type="text" class="txt c1" /></td>
				<td><input id="textF08.*" type="text" class="txt c1" /></td>
				<td><input id="textF09.*" type="text" class="txt c1" /></td>
				<td><input id="textF10.*" type="text" class="txt c1" /></td>
				<td><input id="textF11.*" type="text" class="txt c1" /></td>
				<td><input id="textF12.*" type="text" class="txt c1" /></td>
				<td><input id="textF13.*" type="text" class="txt c1" /></td>
				<td><input id="textF14.*" type="text" class="txt c1" /></td>
				<td><input id="textF15.*" type="text" class="txt c1" /></td>
				<td><input id="textF16.*" type="text" class="txt c1" /></td>
				<td><input id="textF17.*" type="text" class="txt c1" /></td>
				<td ><input id="txtMount.*" type="text" class="txt c1 num"/></td>
				<td ><input id="txtUnit.*" type="text" class="txt c1"/></td>
				<td><input id="textF18.*" type="text" class="txt c1" /></td>
				<td ><input id="txtMemo.*" type="text" class="txt c1"/></td>
			</tr>
		</table>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>