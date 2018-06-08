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
			var q_readonlys = ['txtNoq','textF09','textF12','textF13','textF14','textF15','textF16'
			,'txtMount','txtUnit','textF18','textF19','textF20','textF21','textF22','textF23','textF24','textF25'
			];
			var bbmNum = [];
			var bbsNum = [
				['textF02', 15, 0, 1],['textF03', 15, 2, 1],['textF04', 15, 2, 1],['textF05', 15, 2, 1],
				['textF06', 15, 2, 1],['textF08', 15, 0, 1],['textF09', 15, 2, 1],['textF10', 15, 0, 1],
				['textF11', 15, 0, 1],['textF12', 15, 0, 1],['textF13', 15, 0, 1],['textF14', 15, 0, 1],
				['textF15', 15, 2, 1],['textF16', 15, 2, 1],['textF17', 15, 2, 1],['textF18', 15, 2, 1],
				['textF19', 15, 2, 1],['textF20', 15, 0, 1],['textF22', 15, 2, 1],['textF23', 15, 2, 1],
				['textF24', 15, 2, 1],['textF25', 15, 2, 1],['txtMount', 15, 2, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			aPop = new Array(
				['txtProductno_', '', 'uca', 'noa', '0txtProductno_,', 'uca_b.aspx'],
				['textF21_', '', 'ucc', 'noa', '0textF21_,', 'ucc_b.aspx']
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
				
				document.title='計畫性半成品製令單';
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
			   //q_box('saleforecast_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#textF02_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F12(b_seq);
						});
						
						$('#textF03_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F12(b_seq);
							F15(b_seq);
							F16(b_seq);
							Fmount(b_seq);
						});
						
						$('#textF04_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F16(b_seq);
						});
						
						$('#textF05_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F09(b_seq);
						});
						
						$('#textF06_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F09(b_seq);
						});
						
						$('#textF08_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F24(b_seq);
						});
						
						$('#textF10_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F13(b_seq);
						});
						
						$('#textF11_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F12(b_seq);
							Funit(b_seq);
						});
						
						$('#textF17_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F14(b_seq);
							Fmount(b_seq);
							F20(b_seq);
						});
						
						$('#textF18_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fmount(b_seq);
						});
						
						$('#textF19_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							F14(b_seq);
						});
						
						$('#textF21_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//F22(b_seq);
							//F23(b_seq);
						});
						
						//每個欄位變動都去變動合併儲存格
						for (var i = 0; i < fbbs.length; i++) {
							if(fbbs[i].substr(0,4)=='text'){
								$('#'+fbbs[i]+'_'+j).change(function() {
									t_IdSeq = -1;
				                    q_bodyId($(this).attr('id'));
				                    b_seq = t_IdSeq;
				                    
				                    var tstr='';
									for (var k = 0; k < fbbs.length; k++) {
										if(fbbs[k].substr(0,4)=='text'){
											tstr+="@,#"+$('#'+fbbs[k]+'_'+b_seq).val();
										}
									}
									
									$('#txtSpec_'+b_seq).val(tstr);
								});
							}
						}
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
				//q_box('z_saleforecast.aspx','', "95%", "95%", q_getMsg("popPrint"));
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
			
			function q_popPost(id) {
				switch (id) {
					case 'txtProductno_':
                   		var t_pno=$('#txtProductno_'+b_seq).val();
						if(t_pno.length>0){
							q_gt('uca',"where=^^noa='"+t_pno+"'^^", 0, 0, 0, "getuca", r_accy,1);
							var tuca = _q_appendData("uca", "", true);
							if (tuca[0] != undefined) {
								$('#textF01_'+b_seq).val(tuca[0].rev);
								$('#textF02_'+b_seq).val(tuca[0].preday);
								$('#textF18_'+b_seq).val(tuca[0].trans);
								$('#textF21_'+b_seq).val(tuca[0].groupino);
								$('#textF25_'+b_seq).val(tuca[0].stdmount);
								
								Fmount(b_seq);
								F22(b_seq);
								F23(b_seq);
								
								//後面等確定 製造產出 流程和欄位 再寫txt 抓取數量
								//$('#textF19_'+b_seq).val();
							}
						}
						break;
					case 'textF21_':
						F22(b_seq);
						F23(b_seq);
						break;
				}
			}
			
			function F09(i) { //月目標(M)
				if(dec($('#textF06_'+i).val())>0){
					$('#textF09_'+i).val(dec($('#textF06_'+i).val()));
				}else{
					$('#textF09_'+i).val(dec($('#textF05_'+i).val()));
				}
				F14(i);
				F15(i);
				F16(i);
				F20(i);
				F24(i);
			}
			
			function F12(i) { //生產點(天)
				if(dec($('#textF03_'+i).val())>0){
					$('#textF12_'+i).val('');
				}else{
					$('#textF12_'+i).val(q_add(dec($('#textF02_'+i).val()),dec($('#textF11_'+i).val())));
				}
				
				F13(i);
				F15(i);
			}
			
			function F13(i) { //最大生產量(天)
				if(dec($('#textF03_'+i).val())>0){
					$('#textF13_'+i).val('');
				}else{
					$('#textF13_'+i).val(q_add(dec($('#textF10_'+i).val()),dec($('#textF12_'+i).val())));
				}
				
				F16(i);
				F24(i);
			}
			
			function F14(i) { //總庫存(天)
				var t_f17=dec($('#textF17_'+i).val());
				var t_f19=dec($('#textF19_'+i).val());
				var t_f09=dec($('#textF09_'+i).val());
				if(t_f09>0){
					$('#textF14_'+i).val(round(q_div((t_f17-t_f19),q_div(t_f09,30)),0));
				}else{
					$('#textF14_'+i).val(0);
				}
				Funit(i);
			}
			
			function F15(i) { //生產點(M)
				if(dec($('#textF03_'+i).val())>0){
					$('#textF15_'+i).val(round($('#textF03_'+i).val(),0));
				}else{
					var t_f12=dec($('#textF12_'+i).val());
					var t_f09=dec($('#textF09_'+i).val());
					
					$('#textF15_'+i).val(round(q_mul(t_f12,q_div(t_f09,30)),0));
				}
				Fmount(b_seq);
			}
			
			function F16(i) { //最大生產量(M)
				if(dec($('#textF03_'+i).val())>0){
					$('#textF16_'+i).val(round($('#textF04_'+i).val(),0));
				}else{
					var t_f13=dec($('#textF13_'+i).val());
					var t_f09=dec($('#textF09_'+i).val());
					
					$('#textF16_'+i).val(round(q_mul(t_f13,q_div(t_f09,30)),0));
				}
				Fmount(b_seq);
			}
			
			function Fmount(i) { //生產量(M)
				var t_f03=dec($('#textF03_'+i).val());
				var t_f17=dec($('#textF17_'+i).val());
				var t_f15=dec($('#textF15_'+i).val());
				var t_f16=dec($('#textF16_'+i).val());
				var t_f18=dec($('#textF18_'+i).val());
				
				if(t_f03>0 && t_f17<t_f15){
					$('#txtMount_'+i).val(t_f16);
				}else{
					if(t_f17>=t_f16 || (t_f03>0 && t_f17>t_f15)){
						$('#txtMount_'+i).val(0);
					}else{
						if(t_f18>0){
							$('#txtMount_'+i).val(round(q_div(q_sub(t_f16,t_f17),t_f18),0)*t_f18);
						}else{
							$('#txtMount_'+i).val(0);
						}
					}
				}
				Funit(i);
				F22(i);
				F24(i);
			}
			
			function Funit(i) { //需求
				var t_mount=dec($('#txtMount_'+i).val());
				var t_f24=dec($('#textF24_'+i).val());
				var t_f14=dec($('#textF14_'+i).val());
				var t_f20=dec($('#textF20_'+i).val());
				var t_f11=dec($('#textF11_'+i).val());
				var t_f17=dec($('#textF17_'+i).val());
				var t_f15=dec($('#textF15_'+i).val());
				var t_f16=dec($('#textF16_'+i).val());
				
				if(t_mount==0 && t_f24>0){
					$('#txtUnit_'+i).val('@');
				}else if(t_f14==t_f20 && t_f14<=t_f11){
					$('#txtUnit_'+i).val('緊');
				}else if(t_f17<t_f15){
					$('#txtUnit_'+i).val('急');
				}else if(t_mount>0 && t_f17<t_f16){
					$('#txtUnit_'+i).val('可');
				}else{
					$('#txtUnit_'+i).val('');
				}
			}
			
			function F20(i) { //排程後庫存(天)
				var t_f17=dec($('#textF17_'+i).val());
				var t_f09=dec($('#textF09_'+i).val());
				if(t_f09>0){
					$('#textF20_'+i).val(round(q_div(t_f17,q_div(t_f09,30)),0));
				}else{
					$('#textF20_'+i).val(0);
				}
				Funit(i);
				F24(i);
			}
			
			function F22(i) { //累積量(M)
				var t_count=0,t_mount=0;
				var t_f21=$('#textF21_'+i).val();
				for(var j = 0; j < q_bbsCount; j++) {
					if($('#textF21_'+j).val()==t_f21){
						if(j<=i){
							t_count++;
						}
						t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
					}
				}
				if(t_count>1){
					$('#textF22_'+i).val(0);
				}else{
					$('#textF22_'+i).val(t_mount);
				}
			}
			
			function F23(i) { //大色彈性累積量(M)
				var t_count=0,t_f24=0;
				var t_f21=$('#textF21_'+i).val();
				for(var j = 0; j < q_bbsCount; j++) {
					if($('#textF21_'+j).val()==t_f21){
						if(j<=i){
							t_count++;
						}
						t_f24=q_add(t_f24,dec($('#textF24_'+j).val()));
					}
				}
				if(t_count>1){
					$('#textF23_'+i).val(0);
				}else{
					$('#textF23_'+i).val(t_f24);
				}
			}
			
			function F24(i) { //彈性(M)
				var t_f08=dec($('#textF08_'+i).val());
				var t_mount=dec($('#txtMount_'+i).val());
				var t_f13=dec($('#textF13_'+i).val());
				var t_f20=dec($('#textF20_'+i).val());
				var t_f09=dec($('#textF09_'+i).val());
				var t_f18=dec($('#textF18_'+i).val());
				if(t_f08==0 && t_mount>0){
					$('#textF24_'+i).val(t_mount);
				}else{
					if(q_add(t_f08,t_f13)>t_f20 && t_f18>0){
						$('#textF24_'+i).val(q_mul(round(q_div(q_div(q_mul(q_sub(q_add(t_f08,t_f13),t_f20),t_f09),30),t_f18),0),t_f18));
					}else{
						$('#textF24_'+i).val(0);
					}
				}
				Funit(i);
				F23(i);
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
				<td class="td5"><span> </span><a id="lblMon_uj" class="lbl">計畫月份</a></td>
				<td class="td6"><input id="txtMon" type="text" class="txt c1"/></td>
			</tr>
			<tr>
				<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
				<td class="td2" colspan='5'><input id="txtMemo" type="text" class="txt c1"/></td>
			</tr>
		</table>
	</div>
	<div class='dbbs' style="width:3200px;"> 
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
				<td align="center" style="width:100px;"><a id='lblF07_uj_s'>小色</a></td>
				<td align="center" style="width:100px;"><a id='lblF08_uj_s'>大色彈性(天)</a></td>
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
				<td align="center" style="width:100px;"><a id='lblF19_uj_s'>已排未產</a></td>
				<td align="center" style="width:100px;"><a id='lblF20_uj_s'>排程後庫存(天)</a></td>
				<td align="center" style="width:200px;"><a id='lblF21_uj_s'>上紙投入料號</a></td>
				<td align="center" style="width:100px;"><a id='lblF22_uj_s'>累積量(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF23_uj_s'>大色彈性<BR>累積量(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF24_uj_s'>彈性(M)</a></td>
				<td align="center" style="width:100px;"><a id='lblF25_uj_s'>MOQ</a></td>
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
				<td><input id="textF02.*" type="text" class="txt num c1" /></td>
				<td><input id="textF03.*" type="text" class="txt num c1" /></td>
				<td><input id="textF04.*" type="text" class="txt num c1" /></td>
				<td><input id="textF05.*" type="text" class="txt num c1" /></td>
				<td><input id="textF06.*" type="text" class="txt num c1" /></td>
				<td><input id="textF07.*" type="text" class="txt c1" /></td>
				<td><input id="textF08.*" type="text" class="txt num c1" /></td>
				<td><input id="textF09.*" type="text" class="txt num c1" /></td>
				<td><input id="textF10.*" type="text" class="txt num c1" /></td>
				<td><input id="textF11.*" type="text" class="txt num c1" /></td>
				<td><input id="textF12.*" type="text" class="txt num c1" /></td>
				<td><input id="textF13.*" type="text" class="txt num c1" /></td>
				<td><input id="textF14.*" type="text" class="txt num c1" /></td>
				<td><input id="textF15.*" type="text" class="txt num c1" /></td>
				<td><input id="textF16.*" type="text" class="txt num c1" /></td>
				<td><input id="textF17.*" type="text" class="txt num c1" /></td>
				<td ><input id="txtMount.*" type="text" class="txt c1 num"/></td>
				<td ><input id="txtUnit.*" type="text" class="txt c1"/></td>
				<td><input id="textF18.*" type="text" class="txt num c1" /></td>
				<td><input id="textF19.*" type="text" class="txt num c1" /></td>
				<td><input id="textF20.*" type="text" class="txt num c1" /></td>
				<td><input id="textF21.*" type="text" class="txt c1" /></td>
				<td><input id="textF22.*" type="text" class="txt num c1" /></td>
				<td><input id="textF23.*" type="text" class="txt num c1" /></td>
				<td><input id="textF24.*" type="text" class="txt num c1" /></td>
				<td><input id="textF25.*" type="text" class="txt num c1" /></td>
				<td ><input id="txtMemo.*" type="text" class="txt c1"/></td>
			</tr>
		</table>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>