﻿
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message)
			}
			q_tables = 's';
			var q_name = "ordp";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtSmount', 10, 0, 1],['txtApvmount', 10, 0, 1],['txtFmount', 10, 0, 1],['txtGweight', 10, 0, 1],['txtMount', 10, 0, 1],['txtWeight', 10, 0, 1],['txtTmount', 10, 0, 1],['txtSafemount', 10, 0, 1],['txtSchmount', 10, 0, 1],['txtStkmount', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
					
			aPop = new Array(
			    ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
			    ['textTggno_', '', 'tgg', 'noa,noa,comp', 'textTggno_,txtTggno_,txtComp_', 'tgg_b.aspx'],
			    ['txtTggno_', 'btnTgg_', 'tgg', 'noa,noa,comp', 'textTggno_,txtTggno_,txtComp_', 'tgg_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				document.title='計畫性採購需求作業'
			}
			
			var t_focusout='',t_focusout2='',t_fc=0,t_fbeq='';
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				$('#txtDatea').datepicker();
				if(r_len==4){           
                    $.datepicker.r_len=4;
                }
				q_mask(bbmMask);
				
				$('#btnImport_uj').click(function(e){
				        var t_where = "where=^^ odate='" + $('#txtDatea').val() + "' ^^";
                        q_gt('view_ordcs', t_where, 0, 0, 0, "");
                });
							
			}     	 
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                   		 break;  	
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);	

				var t_noa = trim($('#txtNoa').val());
			    var t_date = trim($('#txtDatea').val());
			    if (t_noa.length == 0 || t_noa == "AUTO")
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordp') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}
		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordp_uj_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function sum() {		
				
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if ($('#btnMinus_' + j).hasClass('isAssign'))
		                continue;  
		            $('#txtProductno_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            sum();
                    });
                    $('#txtLdate_' + j).change(function() {
                            sum();
                    });
                   
				}				
				_bbsAssign();
                refreshBbs();
			}			
			
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				refreshBbs();
				
				
			}
			function btnModi() {			
				_btnModi();
				refreshBbs();
			}
			function btnPrint() {
				//q_box('z_ordp_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
			    if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
				q_nowf();
				return true;
			}
			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				$('#btndiv_detail_close').click();
			}
			
			function refreshBbs(){
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				
			}
			function btnMinus(id) {
				_btnMinus(id);
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
			
			function q_popPost(s1) {
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				border-width: 0px;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 5px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 600px;
				/*margin: -1px;
				/*border: 1px black solid;*/
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
				height: 43px;
			}
			.tbbm tr td {
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 95%;
				float: left;
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
			}
			.dbbs {
				width: 1260px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"]{
				font-size: medium;
			}
			select {
				font-size: medium;
				height: 24px;
			}
			.num {
				text-align: right;
			}
			#bbs_detail a{
				float:right;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewNoa_uj'>日期</a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewDatea_uj'>電腦編號</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" /></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="noa" style="text-align: center;">~noa</td>
                        
                    </tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblLdate_uj' class="lbl">採購日期</a></td>
                        <td><input id="txtBldate" type="text" class="txt" style="float:left;width:100%;"/></td>
                        <td> </td>
                        <td><input id="btnImport_uj" type="button" class="txt c1" value="採購單匯入"/>  </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo' class='lbl'> </a></td>
                        <td colspan='3'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2000px;">
				<tr style='color:white; background:#003366;' >
				        <td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					    <td align="center" style="width:165px;"><a id='lblNoa_s'>採購單號</a></td>
					    <td align="center" style="width:100px;"><a id='lblTgg_s'> </a></td>
					    <td align="center" style="width:50px;"><a id='lblKind_s'>類別名稱</a></td>
					    <td align="center" style="width:165px;"><a id='lblProductno_s'> </a></td>
                        <td align="center" style="width:40px;"><a id='lblSpec_UJ'> </a>採購屬性</td>
                        <td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
                        <td align="center" style="width:50px;"><a id='lblUnit_s'> </a></td>  
                        <td align="center" style="width:80px;"><a id=''>交貨日期</a></td>
                        <td align="center" style="width:80px;"><a id=''>廠商回覆交期</a></td>
                        <td align="center" style="width:40px;"><a id=''>週</a></td>
                        <td align="center" style="width:80px;"><a id=''>廠商未回交期</a></td>
                        <td align="center" style="width:60px;"><a id=''>交期異動天數</a></td>
                        <td align="center" style="width:80px;"><a id=''>交期異常</a></td>
                        <td align="center" style="width:80px;"><a id=''>交期異動不準時</a></td>
                        <td align="center" style="width:80px;"><a id=''>備註</a></td>
                        <td align="center" style="width:60px;"><a id=''>倒數進貨(天)</a></td>
                        <td align="center" style="width:60px;"><a id=''>提醒週期</a></td>
                        <td align="center" style="width:50px;"><a id=''>追蹤</a></td>
                        <td align="center" style="width:50px;"><a id=''>到貨前提醒</a></td>
                        <td align="center" style="width:80px;"><a id=''>貨到確認</a></td>
                        <td align="center" style="width:80px;"><a id=''>實際交貨日</a></td>
                        <td align="center" style="width:60px;"><a id=''>交期差異天數</a></td>
                        <td align="center" style="width:80px;"><a id=''>交期不準時原因 </a></td>
                        <td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;' class="ishide.*">
    					<td align="center">
    						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
    						<input id="txtNoq.*" type="text" style="display: none;" />
    					</td>
    					<td align="center">
    					    <input id="txtOrdbno.*" type="text" class="txt c1" style="width:65%;"/>
                            <input id="txtNo2.*" type="text" class="txt c1" style="width:30%;"/>
                        </td>
                        <td><input id="txtTggno.*" type="text" class="txt c1" style="width:97%;"/>
                            <input id="txtTgg.*" type="text" class="txt c1" style="width:97%;"/>    
                        </td>
                        <td><input id="txtKind.*" type="text" class="txt c1" style="width:97%;"/></td>
					    <td><input id="txtProductno.*" type="text" class="txt c1" style="width:97%;"/>
                            <input id="txtProduct.*" type="text" class="txt c1" style="width:80%;"/>
                            <input class="btn" id="btnProduct.*" type="button" value='..' style=" font-weight: bold;" />
                        </td>
                        <td><input id="txtSpec.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtMount.*" type="text" class="txt c1 num" style="width:97%;"/></td>
                        <td><input id="textM1.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM2.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM3.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM4.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM5.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtOmount.*" type="text" class="txt c1 num" style="width:97%;"/></td>
                        <td><input id="textM6.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM7.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM8.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtPrice.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txttotal.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM9.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM10.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM11.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM12.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM13.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textM14.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtMemo.*" type="text" class="txt c1" style="width:97%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>