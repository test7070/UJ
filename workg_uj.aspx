<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			q_tables = 't';
			var q_name = "workg";
			var q_readonly = ['txtNoa','txtFact', 'txtDatea', 'txtWorker', 'txtWorker2', 'txtOrdbno'];
			var q_readonlys = ['txtNoq','txtOdatea','txtOrdeno','txtProductno','txtLengthb','txtMount','txtWidth'
			,'txtStyle','txtStyle','txtDime'
			,'txtMech','txtTypea','txtUcano','txtUcc1no','txtUcc2no','txtUcc3no','txtUcc4no','txtUcc5no','txtUcc6no'
			,'txtGen','txtMemo2'
			,'textM1','textC1','textM2','textC2','textM3','textC3','textM4','textC4','textC5'
			];
			var q_readonlyt = [];
			var bbmNum = [];
			var bbsNum = [
				['txtOrdemount', 15, 0, 1], ['txtPlanmount', 15, 0, 1], ['txtStkmount', 15, 0, 1],
				['txtIntmount', 15, 0, 1], ['txtPurmount', 15, 0, 1], ['txtAvailmount', 15, 0, 1],
				['txtBornmount', 15, 0, 1], ['txtSalemount', 15, 0, 1], ['txtMount', 15, 0, 1],
				['txtInmount', 15, 0, 1], ['txtWmount', 15, 0, 1], ['txtSaleforecast', 15, 0, 1],
				['txtForecastprepare', 15, 0, 1], ['txtUnprepare', 15, 0, 1], ['txtPrepare', 15, 0, 1], ['txtDayborn', 15, 0, 1]
			];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			//brwCount2 = 6;//03/28自動
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtUcc1no', 'lblUcc1_uj', 'ucc', 'noa,product', 'txtUcc1no', 'ucc_b.aspx'],
				['txtUcc2no', 'lblUcc2_uj', 'ucc', 'noa,product', 'txtUcc2no', 'ucc_b.aspx'],
				['txtMechno_', '', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx']
				
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtSfbdate', r_picd], ['txtSfedate', r_picd], ['txtWadate', r_picd], ['txtWbdate', r_picd], ['txtWedate', r_picd]];
				bbsMask = [['txtOdatea', r_picd],['txtLatedate', r_picd],['txtRworkdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", '製造,加工');	
				
				document.title='製造/加工排程表';
				
				 $('#btnWorkgg_uj').click(function() {
                	q_box("z_workgg.aspx", 'z_workgg', "95%", "95%", q_getMsg("btnWorkgg"));
				});
				
				$('#btnOrde_uj').click(function() {
					
				});
				
				$('#btnWork_uj').click(function() {
					//寫txt 產生work
					if(q_cur==1 || q_cur==2){
						if($('#cmbStype').val()=='製造'){
							
						}
						
						if($('#cmbStype').val()=='加工'){
							
						}
					}
				});
				
				
				
				$('#cmbStype').change(function() {
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_'+i).click();
					}
					change_field();
				});
				
			}
			
			
			
			var ordedate=false;
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
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

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workg_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtBdate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProductno').focus();
			}

			function btnPrint() {
				//q_box('z_workgp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if ((dec(as['lengthb'])+dec(as['mount']))==0) { ///0424 改成數量為0 就不儲存  !as['productno']
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				
				change_field();
			}
			
			function change_field () {
				if($('#cmbStype').val()=='製造'){
					$('.M1').hide();
					$('.M2').hide();
					$('.M3').show();
					$('#lblWadate_uj').text('指定排程日期');
					$('.dbbs').css('width','3100px');
				}else{
					$('.M3').hide();
					$('.M1').show();
					$('.M2').show();
					$('#lblWadate_uj').text('建議加工日');
					$('.dbbs').css('width','4500px');
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					
				} else {
					
				}
				change_field();
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
			
			var t_desc=0;
			function bbssort(tField) {
				if(q_cur==1 || q_cur==2){
					var t_bbs=new Array();
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) || !emp($('#txtOdatea_'+i).val())){
		               		var t_bbss=new Array();
		               		for (var j = 0; j < fbbs.length; j++) {
		               			t_bbss[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
		               		}
		               		t_bbs.push(t_bbss);
		               	}
						$('#btnMinus_'+i).click();
					}
					
					if(t_bbs.length!=0){
						if(t_desc==0){
							t_bbs.sort(function compare(a,b) {
								if (eval('a.'+tField)< eval('b.'+tField)) return -1;
								if (eval('a.'+tField)> eval('b.'+tField)) return 1;
								return 0;
							});
							t_desc=1;
						}else{
							t_bbs.sort(function compare(a,b) {
								if (eval('a.'+tField)> eval('b.'+tField)) return -1;
								if (eval('a.'+tField)< eval('b.'+tField)) return 1;
								return 0;
							});
							t_desc=0;
						}
						for (var i = 0; i < t_bbs.length; i++) {
			              		for (var j = 0; j < fbbs.length; j++) {
			              			if(fbbs[j]!='txtNoq')
			              				$('#'+fbbs[j]+'_'+i).val(t_bbs[i][fbbs[j]]);
			              		}
						}
					}
					//清除NOQ 以避免重新排序
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtNoq_'+i).val('');
					}
				}
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtRworkdate_'+i).focusout(function() {
							if(q_cur==1 || q_cur==2)
								bbsretotal();
						});
					}
				}
				_bbsAssign();
				change_field();
				
				if(q_cur==1 || q_cur==2){
					$('#btnOrderUcc1no').removeAttr('disabled');
					$('#btnOrderUcc2no').removeAttr('disabled');
				}else{
					$('#btnOrderUcc1no').attr('disabled', 'disabled');
					$('#btnOrderUcc2no').attr('disabled', 'disabled');
				}
				
				//面材排序
				$('#btnOrderUcc1no').unbind('click');
				$('#btnOrderUcc1no').click(function() {
					if(q_cur==1 || q_cur==2){
						bbssort('txtUcc1no');
					}
				});
				
				//底材排序
				$('#btnOrderUcc2no').unbind('click');
				$('#btnOrderUcc2no').click(function() {
					if(q_cur==1 || q_cur==2){
						bbssort('txtUcc2no');
					}
				});
				
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
			}

			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {

				}
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

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					default:
						break;
				}
			}
			function q_funcPost(t_func, result) {
				
			}

		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 420px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 840px;
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
				/*width: 15%;*/
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 46%;
				float: left;
			}
			.txt.c3 {
				width: 35%;
				float: left;
			}
			.txt.c4 {
				width: 63%;
				float: left;
			}
			.num {
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 3100px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#dbbt {
				width: 900px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1270px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:24px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:110px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:50px; color:black;"><a id='vewStype'> </a></td>
						<td style="width:170px; color:black;"><a id='vewRang_uj'>訂單預交日</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td align="center" id='stype=workg.stype'>~stype=workg.stype</td>
						<td id='bdate edate' style="text-align: center;">~bdate - ~edate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 135px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea" type="text" class="txt c1"/>
							<input id="txtSfbdate" type="hidden"/>
							<input id="txtSfedate" type="hidden"/>
						</td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c2"/>
						</td>
						<td><input id="btnCub_uj" type="button" value="生產指令匯入"/></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" class="txt c3"/>
							<input id="txtComp" type="text" class="txt c4"/>
						</td>
					</tr>
					<tr class="M3">
						<td><span> </span><a id="lblUcc1_uj" class="lbl btn">製造"上皮"投入</a></td>
						<td><input id="txtUcc1no" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUcc2_uj" class="lbl btn">製造"上紙"投入</a></td>
						<td><input id="txtUcc2no" type="text" class="txt c1"/></td>
					</tr>
					<tr class="M1 M2 M3">
						<td><span> </span><a id="lblWadate_uj" class="lbl">建議加工日</a></td>
						<td><input id="txtWadate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMount_uj" class="lbl">排程量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="M2">
						<td><span> </span><a id="lblWbdate_uj" class="lbl">決定分條日</a></td>
						<td><input id="txtWbdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWedate_uj" class="lbl">決定覆捲日</a></td>
						<td><input id="txtWedate" type="text" class="txt c1"/></td>
					</tr>
					<tr class="M2">
						<td><span> </span><a id="lblOrdano_uj" class="lbl">加工產出回報</a></td>
						<td><input id="txtOrdano" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo_uj" class="lbl" >備註</a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;display: none;"> </td>
						<td style="width:60px;"><a id='lblNoq_s'>項次</a></td>
						<!--原生產指令需求-->
						<td class="M1 M2" style="width:100px;"><a id="lblA01_uj_s">指令流水號</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA02_uj_s">指令名稱</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA03_uj_s">料號(原成品名)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA04_uj_s">新成品編碼</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA05_uj_s">交期</a></td>
						<td class="M1" style="width:100px;"><a id="lblA06_uj_s">成品指令</a></td>
						<td class="M1" style="width:100px;"><a id="lblA07_uj_s">銷售政策</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA08_uj_s">寬(mm)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA09_uj_s">長(M)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA10_uj_s">原需求數量</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblA11_uj_s">單位</a></td>
						<!---->
						<td class="M1" style="width:100px;"><a id="lblB01_uj_s">手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblB02_uj_s">數量</a></td>
						<!--Booking或指定-->
						<td class="M1" style="width:100px;"><a id="lblC01_uj_s">可動用</a></td>
						<td class="M1" style="width:100px;"><a id="lblC02_uj_s">Booking手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblC03_uj_s">Booking</a></td>
						<td class="M1" style="width:100px;"><a id="lblC04_uj_s">指定</a></td>
						<td class="M1" style="width:100px;"><a id="lblC05_uj_s">調撥單</a></td>
						<td class="M1" style="width:100px;"><a id="lblC06_uj_s">Booking到期日</a></td>
						<td class="M1" style="width:100px;"><a id="lblC07_uj_s">確定</a></td>
						<!--中繼產品"指定"前預估生產量-->
						<td class="M1" style="width:100px;"><a id="lblD01_uj_s">應生產量成品</a></td>
						<td class="M1" style="width:100px;"><a id="lblD02_uj_s">應生產(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblD03_uj_s">上膠(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblD04_uj_s">手調(M)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblD05_uj_s">生產(M)</a></td>
						<!---->
						<td class="M1 M2" style="width:100px;"><a id="lblE01_uj_s">場內可用庫存供貨</a></td>
						<!--中繼產品-->
						<td class="M1" style="width:100px;"><a id="lblF01_uj_s">中繼產品料號</a></td>
						<td class="M1" style="width:100px;"><a id="lblF02_uj_s">場內可用庫存</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblF03_uj_s">中繼指定(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblF04_uj_s">連接</a></td>
						<!--再製品-->
						<td class="M1" style="width:100px;"><a id="lblG01_uj_s">再製品</a></td>
						<td class="M1" style="width:100px;"><a id="lblG02_uj_s">場內可用庫存</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblG03_uj_s">再製品指定(M)</a></td>
						<td class="M1" style="width:100px;"><a id="lblG04_uj_s">連接</a></td>
						<!--指定後產出量-->
						<td class="M1" style="width:100px;"><a id="lblH01_uj_s">指定(%)</a></td>
						<td class="M1" style="width:100px;"><a id="lblH02_uj_s">指定可產出量</a></td>
						<td class="M1" style="width:100px;"><a id="lblH03_uj_s">生產成品</a></td>
						<!---->
						<td class="M1" style="width:100px;"><a id="lblI01_uj_s">物料需求手調</a></td>
						<td class="M1" style="width:100px;"><a id="lblI02_uj_s">物料需求(套)</a></td>
						<td class="M1" style="width:100px;"><a id="lblI03_uj_s">業務成品需求</a></td>
						<td class="M1" style="width:100px;"><a id="lblI04_uj_s">業務餘料需求</a></td>
						<td class="M1" style="width:100px;"><a id="lblI05_uj_s">紙管</a></td>
						<td class="M1" style="width:100px;"><a id="lblI06_uj_s">採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI07_uj_s">貨齊日</a></td>
						<td class="M1" style="width:100px;"><a id="lblI08_uj_s">紙箱</a></td>
						<td class="M1" style="width:100px;"><a id="lblI09_uj_s">採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI10_uj_s">貨齊日</a></td>
						<td class="M1" style="width:100px;"><a id="lblI11_uj_s">塞頭</a></td>
						<td class="M1" style="width:100px;"><a id="lblI12_uj_s">採購量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI13_uj_s">貨齊日</a></td>
						<td class="M1" style="width:100px;"><a id="lblI14_uj_s">物料指定確認</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI15_uj_s">上膠日</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI16_uj_s">熟成(天)</a></td>
						<td class="M1 M2" style="width:100px;"><a id="lblI17_uj_s">料最快備齊日期</a></td>
						<td class="M1" style="width:100px;"><a id="lblI18_uj_s">完工狀態(加工)</a></td>
						<td class="M1" style="width:100px;"><a id="lblI19_uj_s">訂單總量</a></td>
						<td class="M1" style="width:100px;"><a id="lblI20_uj_s">限定餘數</a></td>
						
						<!--加工B-->
						<td class="M2" style="width:100px;"><a id="lblJ01_uj_s">加工日</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ02_uj_s">分條機台別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ03_uj_s">可分條機台</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ04_uj_s">不可分條機台</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ05_uj_s">分條工時(Hr)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ06_uj_s">分1</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ07_uj_s">分2</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ08_uj_s">分3</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ09_uj_s">分4</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ10_uj_s">覆捲日</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ11_uj_s">覆捲機台別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ12_uj_s">覆捲工時(Hr)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ13_uj_s">覆1</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ14_uj_s">覆2</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ15_uj_s">覆3</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ16_uj_s">其他</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ17_uj_s">需求急別</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ18_uj_s">備註</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ19_uj_s">產出</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ20_uj_s">產出率(%)</a></td>
						<td class="M2" style="width:100px;"><a id="lblJ21_uj_s">完工狀態</a></td>
						
						<!--製造-->
						<td class="M3" style="width:100px;"><a id="lblK01_uj_s">產品別</a></td>
						<td class="M3" style="width:100px;"><a id="lblK02_uj_s">客戶</a></td>
						<td class="M3" style="width:100px;"><a id="lblK03_uj_s">半成品</a></td>
						<td class="M3" style="width:100px;"><a id="lblK04_uj_s">計畫性</a></td>
						<td class="M3" style="width:100px;"><a id="lblK05_uj_s">需求</a></td>
						<td class="M3" style="width:100px;"><a id="lblK06_uj_s">原生產量(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblK07_uj_s">手調</a></td>
						<td class="M3" style="width:100px;"><a id="lblK08_uj_s">生產量</a></td>
						<td class="M3" style="width:100px;"><a id="lblK09_uj_s">下料指令</a></td>
						<td class="M3" style="width:100px;"><a id="lblK10_uj_s">列管備註</a></td>
						<td class="M3" style="width:100px;"><a id="lblK11_uj_s">指定進度</a></td>
						<td class="M3" style="width:100px;"><a id="lblK12_uj_s">指定(紙)%</a></td>
						<td class="M3" style="width:100px;"><a id="lblK13_uj_s">指定(皮)%</a></td>
						<td class="M3" style="width:100px;"><a id="lblK14_uj_s">原料最快備齊日期</a></td>
						<!--決定"上膠日"-->
						<td class="M3" style="width:100px;"><a id="lblL01_uj_s">換線屬性</a></td>
						<td class="M3" style="width:100px;"><a id="lblL02_uj_s">補水</a></td>
						<td class="M3" style="width:100px;"><a id="lblL03_uj_s">上膠日</a></td>
						<td class="M3" style="width:100px;"><a id="lblL04_uj_s">製造機台別</a></td>
						<td class="M3" style="width:100px;"><a id="lblL05_uj_s">限定機台別</a></td>
						<td class="M3" style="width:100px;"><a id="lblL06_uj_s">備料板位</a></td>
						<!--排程量-->
						<td class="M3" style="width:100px;"><a id="lblM01_uj_s">A</a></td>
						<td class="M3" style="width:100px;"><a id="lblM02_uj_s">A工時(小時)</a></td>
						<td class="M3" style="width:100px;"><a id="lblM03_uj_s">B</a></td>
						<td class="M3" style="width:100px;"><a id="lblM04_uj_s">B工時(小時)</a></td>
						<!--製造產出回報-->
						<td class="M3" style="width:100px;"><a id="lblN01_uj_s">產出(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblN02_uj_s">產出率(%)</a></td>
						<td class="M3" style="width:100px;"><a id="lblN03_uj_s">完工狀態</a></td>
						<!---->
						<td class="M3" style="width:100px;"><a id="lblO01_uj_s">完工確認</a></td>
						<td class="M3" style="width:100px;"><a id="lblO02_uj_s">備註</a></td>
						<!--上紙段(投入)-->
						<td class="M3" style="width:100px;"><a id="lblP01_uj_s">上紙(投入)</a></td>
						<td class="M3" style="width:100px;"><a id="lblP02_uj_s">上紙替代</a></td>
						<td class="M3" style="width:100px;"><a id="lblP03_uj_s">上紙場內可動用庫存</a></td>
						<td class="M3" style="width:100px;"><a id="lblP04_uj_s">上紙已採未交</a></td>
						<td class="M3" style="width:100px;"><a id="lblP05_uj_s">上紙指定(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblP06_uj_s">上紙連接</a></td>
						<!--上皮段(投入)-->
						<td class="M3" style="width:100px;"><a id="lblQ01_uj_s">上皮(投入)</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ02_uj_s">上皮替代</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ03_uj_s">上皮場內可動用庫存</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ04_uj_s">上皮已採未交</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ05_uj_s">上皮指定(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblQ06_uj_s">上皮連接</a></td>
						<!---->
						<td class="M3" style="width:100px;"><a id="lblR01_uj_s">計畫性需求(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR02_uj_s">訂單性需求(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR03_uj_s">成品庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR04_uj_s">半成品庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR05_uj_s">再製品庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR06_uj_s">已排未產(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR07_uj_s">總庫存(M)</a></td>
						<td class="M3" style="width:100px;"><a id="lblR08_uj_s">工時(Hr)</a></td>
						<!---->
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
						<td style="display: none;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center"><input id="txtNoq.*" type="text" class="txt c1"/></td>
						<!--原生產指令需求-->
						<td class="M1 M2"><input id="textA01.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textA02.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textA03.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textA04.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textA05.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textA06.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textA07.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textA08.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textA09.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textA10.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textA11.*" type="text" class="txt c1"/></td>
						<!---->
						<td class="M1"><input id="textB01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textB02.*" type="text" class="txt num c1"/></td>
						<!--Booking或指定-->
						<td class="M1"><input id="textC01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textC02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textC03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnC04.*" type="button" value="."/></td>
						<td class="M1"><input id="btnC05.*" type="button" value="."/></td>
						<td class="M1"><input id="textC06.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="checkC07.*" type="checkbox"/></td>
						<!--中繼產品"指定"前預估生產量-->
						<td class="M1"><input id="textD01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textD04.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textD05.*" type="text" class="txt num c1"/></td>
						<!---->
						<td class="M1 M2"><input id="textE01.*" type="text" class="txt c1"/></td>
						<!--中繼產品-->
						<td class="M1"><input id="textF01.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textF02.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textF03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnF04.*" type="button" value="."/></td>
						<!--再製品-->
						<td class="M1"><input id="textG01.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textG02.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textG03.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="btnG04.*" type="button" value="."/></td>
						<!--指定後產出量-->
						<td class="M1"><input id="textH01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textH02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textH03.*" type="text" class="txt num c1"/></td>
						<!---->
						<td class="M1"><input id="textI01.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI02.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI03.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI04.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI05.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI06.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI07.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI08.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI09.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI10.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI11.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI12.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI13.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI14.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textI15.*" type="text" class="txt c1"/></td>
						<td class="M1 M2"><input id="textI16.*" type="text" class="txt num c1"/></td>
						<td class="M1 M2"><input id="textI17.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI18.*" type="text" class="txt c1"/></td>
						<td class="M1"><input id="textI19.*" type="text" class="txt num c1"/></td>
						<td class="M1"><input id="textI20.*" type="text" class="txt num c1"/></td>
						
						<!--加工B-->
						<td class="M2"><input id="textJ01.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ02.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ03.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ04.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ05.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ06.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ07.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ08.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ09.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ10.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ11.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ12.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ13.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ14.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ15.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ16.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ17.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ18.*" type="text" class="txt c1"/></td>
						<td class="M2"><input id="textJ19.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ20.*" type="text" class="txt num c1"/></td>
						<td class="M2"><input id="textJ21.*" type="text" class="txt c1"/></td>
						
						<!--製造-->
						<td class="M3"><input id="textK01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK03.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK04.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK05.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK06.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK07.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK08.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK09.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK10.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK11.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textK12.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK13.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textK14.*" type="text" class="txt c1"/></td>
						
						<!--決定"上膠日"-->
						<td class="M3"><input id="textL01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL03.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL04.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL05.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textL06.*" type="text" class="txt c1"/></td>
						<!--排程量-->
						<td class="M3"><input id="textM01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textM04.*" type="text" class="txt num c1"/></td>
						<!--製造產出回報-->
						<td class="M3"><input id="textN01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textN02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textN03.*" type="text" class="txt c1"/></td>
						<!---->
						<td class="M3"><input id="btnO01.*" type="button" value="."/></td>
						<td class="M3"><input id="textO02.*" type="text" class="txt c1"/></td>
						<!--上紙段(投入)-->
						<td class="M3"><input id="textP01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textP02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textP03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textP04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textP05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="btnP06.*" type="button" value="+"/></td>
						<!--上皮段(投入)-->
						<td class="M3"><input id="textQ01.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textQ02.*" type="text" class="txt c1"/></td>
						<td class="M3"><input id="textQ03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textQ04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textQ05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="btnQ06.*" type="button" value="+"/></td>
						
						<!---->
						<td class="M3"><input id="textR01.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR02.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR03.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR04.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR05.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR06.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR07.*" type="text" class="txt num c1"/></td>
						<td class="M3"><input id="textR08.*" type="text" class="txt num c1"/></td>
						<!---->
						
						
						
						
						
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:160px; text-align: center;"><a id='lblOrdeno_t'> </a></td>
					<td style="width:40px; text-align: center;"><a id='lblNo2_t'> </a></td>
					<td style="width:120px; text-align: center;"><a id='lblProductno_t'> </a></td>
					<td style="width:180px; text-align: center;"><a id='lblProduct_t'> </a></td>
					<td style="width:95px; text-align: center;"><a id='lblStyle_t'> </a></td>
					<td style="width:100px; text-align: center;"><a id='lblSalemount_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtOrdeno..*" type="text" class="txt c1"/></td>
					<td><input id="txtNo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td><input id="txtStyle..*" type="text" class="txt c1"/></td>
					<td><input id="txtSalemount..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>