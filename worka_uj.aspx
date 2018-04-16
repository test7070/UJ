<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_desc = 1;
			q_tables = 's';
			var q_name = "worka";
			var decbbs = ['mount', 'weight'];
			var decbbm = ['mount'];
			var q_readonly = ['txtNoa','txtWorker','txtWorker2', 'txtStore', 'txtStation', 'txtProcess', 'txtMech'];
			var q_readonlys = ['txtWorkno', 'txtOrdeno', 'txtNo2','txtProductno','txtProduct','txtSpec','txtStore'];
			var bbmNum = [];
			var bbsNum = [
				['txtMount', 10, 0, 1], ['txtWeight', 15, 2, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
				$('#txtDatea').focus();
			}
			
			var q_box_aspx='';
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('worka.typea'));
				
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
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//如果表身倉庫沒填，表頭倉庫帶入
				for (var i = 0; i < q_bbsCount; i++) {
					if (emp($('#txtStoreno_' + i).val())) {
						if (!emp($('#txtProductno_' + i).val())) {
							$('#txtStoreno_' + i).val($('#txtStoreno').val());
							$('#txtStore_' + i).val($('#txtStore').val());
						}
					}
				}

				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}
				
				var t_date = $('#txtDatea').val();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_worka') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}
			

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('worka_uj_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtUno_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_datea=emp($('#txtDatea').val())?q_date():$('#txtDatea').val();
							if(!emp($('#txtUno_'+b_seq).val())){
								q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(t_datea)+';'+encodeURI($('#txtUno_'+b_seq).val())+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI($('#txtNoa').val())+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								if (as[0] != undefined) {
									if((as[0].mount<=0 || as[0].weight<=0) && $('#cmbTypea').val()=='1'){
										alert('【'+$('#txtUno_'+b_seq).val()+'】已無庫存量!!');
										$('#txtUno_'+b_seq).val('');
									}else{
										$('#txtProductno_'+b_seq).val(as[0].productno);
										$('#txtProduct_'+b_seq).val(as[0].product);
										$('#txtSpec_'+b_seq).val(as[0].spec);
										$('#txtStyle_'+b_seq).val(as[0].style);
										$('#txtStoreno_'+b_seq).val(as[0].storeno);
										$('#txtStore_'+b_seq).val(as[0].store);
										
										if($('#cmbTypea').val()=='1'){									
											$('#txtMount_'+b_seq).val(as[0].mount);
											$('#txtWeight_'+b_seq).val(as[0].weight);
										}
									}
								}else{
									alert('【'+$('#txtUno_'+b_seq).val()+'】批號不存在!!');
								}
							}
							
						});
					}
				}
				_bbsAssign();
				
			}
			
			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				
			}

			function btnPrint() {
				//q_box('z_workap.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];

				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {

				}
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					
				} else {
					
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
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
				switch (s1) {
					
				}
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
				width: 100%;
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
				/*margin: -1px;
				 border: 1px black solid;*/
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
				width: 35%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
				font-size: medium;
			}
			.tbbm textarea {
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
		</style>
	</head>
	<body>
		<div id="dmain" style="width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:23%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:40%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:55%"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 77%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr style="height: 1px;">
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
						<td width="203px"> </td>
						<td width="120px"> </td>
						<td width="203px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMechno' class="lbl"> </a></td>
						<td><input id="txtMechno" type="text" class="txt c2"/></td>
						<td><span> </span><a id='lblWorkno_uj' class="lbl">派工單號</a></td>
						<td><input id="txtWorkno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStore' class="lbl"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt c2"/>
							<input id="txtStore" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo_uj' class="lbl">備註</a></td>
						<td colspan='3'><input id="txtMemo" type="text" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:45px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px;"><a id='lblUno_uj_s'>批號</a></td>
					<td align="center" style="width:180px;"><a id='lblProductno_uj_s'>料號</a></td>
					<td align="center" style="width:180px;"><a id='lblProduct_uj_s'>品名/參照</a></td>
					<td align="center" style="width:110px;">
						<a id='lblSpec_uj_s'>列管備註</a><BR>
						<a id='lblStyle_uj_s'>製造備註</a>
					</td>
					<td align="center" style="width:80px;"><a id='lblMount_uj_s'>領料數量</a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_uj_s'>領料長度</a></td>
					<td align="center" style="width:150px;"><a id='lblStore_uj_s'>倉庫</a></td>
					<td align="center"><a id='lblMemo_uj_s'>備註</a></td>
					<td align="center" style="display: none;"><a id='lblWorkno_uj_s'>日報表</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt c1" id="txtUno.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtProductno.*" type="text" />
						<!--<input class="btn" id="btnProductno.*" type="button" value='.' style="width:10%;" />-->
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtSpec.*" type="text" class="txt c1"/>
						<input id="txtStyle.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td>
						<!--<input class="btn" id="btnStore.*" type="button" value='.' style="width:1%;float: left;" />-->
						<input id="txtStoreno.*" type="text" class="txt c2" style="width: 34%;"/>
						<input id="txtStore.*" type="text" class="txt c3"  style="width: 59%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtOrdeno.*" type="text" class="txt c3"/>
						<input id="txtNo2.*" type="text" class="txt c2"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td style="display: none;"><input id="txtWorkno.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>