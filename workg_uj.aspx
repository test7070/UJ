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
			var q_readonly = ['txtNoa','txtFact', 'txtDatea', 'txtWorker', 'txtWorker2', 'txtOrdbno'];//105/03/30 開放 'txtWadate' 
			var q_readonlys = ['txtWorkno','txtWorkhno', 'txtIndate', 'txtInmount', 'txtWmount', 'txtOrdeno','txtNoq','txtUindate'];
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
				['txtProductno', 'lblProduct', 'uca', 'noa,product', 'txtProductno,txtProduct', 'uca_b.aspx'],
				['txtProductno_', 'btnProduct_', 'uca', 'noa,product,style', 'txtProductno_,txtProduct_,txtStyle_', 'uca_b.aspx'],
				['txtStationno_', 'btnStation_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx'],
				['txtProductno__', 'btnProduct__', 'uca', 'noa,product,style', 'txtProductno__,txtProduct__,txtStyle__', 'uca_b.aspx']
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
				bbsMask = [['txtRworkdate', r_picd], ['txtCuadate', r_picd], ['txtIndate', r_picd], ['txtUindate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", '製造,加工');	
				
				 $('#btnWorkgg').click(function() {
                	q_box("z_workgg.aspx", 'z_workgg', "95%", "95%", q_getMsg("btnWorkgg"));
				});
				
				$('#btnOrde').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (emp($('#txtBdate').val()) && emp($('#txtEdate').val())) {
							alert(q_getMsg('lblBdate') + '請先填寫。');
							return;
						}
						if ((!emp($('#txtBdate').val()) && emp($('#txtEdate').val())) || (emp($('#txtBdate').val()) && !emp($('#txtEdate').val()))) {
							alert(q_getMsg('lblBdate') + '錯誤!!。');
							return;
						}
						
						if(emp($('#txtWbdate').val()))
							$('#txtWbdate').val(q_cdn($('#txtBdate').val(),-dec(q_getPara('orde.preborn'))));
						if(emp($('#txtWedate').val()))
							$('#txtWedate').val(q_cdn($('#txtEdate').val(),-dec(q_getPara('orde.preborn'))));
							
						
						
					}
				});
				
				$('#btnWork').click(function() {
					if(q_cur != 1 && q_cur != 2) {
						if(!emp($('#txtOrdbno').val())){
							alert('製令單已請購-禁止重新產生製令單!!');
							return;
						}
						
						var worked = false;
						for (var i = 0; i < q_bbsCount; i++) {
							if (!emp($('#txtWorkno_' + i).val()))
								worked = true;
						}
						if (worked && t_gmount > 0)
							alert('製令單已領料-禁止重新產生製令單!!');
						else {
							//q_func('workg.genWork', r_accy + ',' + $('#txtNoa').val() + ',' + r_name);
							//$('#btnWork').val('產生中...').attr('disabled', 'disabled');
						}
					}
				});
				
				//針對workg的物料需求
				$('#btnWorkg2ordb').click(function() {
					q_box('z_workg2ordb.aspx' + "?;;;;" + r_accy + ";", 'workg2ordb', "95%", "95%", q_getMsg("popPrint"));
				});
				
				$('#btnWorkPrint').click(function() {
					q_box('z_workp.aspx' + "?;;;noa='" + $('#txtNoa').val() + "';" + r_accy + ";", '', "95%", "95%", q_getMsg("popPrint"));
				});
				
				$('#lblOrdbno').click(function() {
					q_box('ordb.aspx' + "?;;;charindex(noa,'" + $('#txtOrdbno').val() + "')>0;" + r_accy + ";", '', "95%", "95%", q_getMsg("lblOrdbno"));
				});
				
				$('#cmbStype').change(function() {
					change_field();
				});
				
			}
			
			var ordedate=false;
			var t_works, t_gmount = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'view_works':
						t_gmount = 0;
						t_works = _q_appendData("view_works", "", true);
						for (var i = 0; i < t_works.length; i++) {
							t_gmount = t_gmount + dec(t_works[i].gmount);
						}
						break;
					case 'check_view':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							for (var i = 0; i < brwCount; i++) {
								if($('#vtnoa_'+i).text()!=''){
									for (var j = 0; j < as.length; j++) {
										if($('#vtnoa_'+i).text()==as[j].noa){
											if(as[j].ordbno!=''){
												$('#vtunordb_'+i).text('');
											}else{
												$('#vtunordb_'+i).text('v');
											}
											if(as[j].ordano!='' && as[j].ordano.substr(0,2)=='OA'){
												$('#vtunorda_'+i).text('');
											}else{
												$('#vtunorda_'+i).text('v');
											}
											$('#vtunwork_'+i).text(as[j].unwork);
										}
									}
								}
							}
							
							for (var j = 0; j < as.length; j++) {
								if($('#txtNoa').val()==as[j].noa){
									$('#txtOrdbno').val(as[j].ordbno);
									$('#txtOrdano').val(as[j].ordano);
								}
							}
						}
					break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if (t_name.substr(0, 9) == 'modiwork_') {
					var s_works = _q_appendData("works", "", true);
					var s_gmount = 0;
					for (var i = 0; i < s_works.length; i++) {
						s_gmount = s_gmount + dec(s_works[i].gmount);
					}
					if (s_gmount > 0) {
						t_noq = t_name.substr(t_name.indexOf('_') + 1, t_name.length)
						for (var j = 0; j < fbbs.length; j++) {
							$('#' + fbbs[j] + '_' + t_noq).attr('disabled', 'disabled');

						}
						$('#btnMinus_' + t_noq).attr('disabled', 'disabled');
					}
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				q_func('qtxt.query', 'workg.txt,freeze,' +encodeURI($('#txtNoa').val()));
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'workg2ordb':
						//檢查是否有簽核和請購
						var endnoa=''
						for (var i = 0; i < brwCount; i++) {
							if($('#vtnoa_'+i).text()!='')
								endnoa=$('#vtnoa_'+i).text();
						}
						q_gt('workg', "where=^^ noa between '"+endnoa+"' and '"+$('#vtnoa_0').text()+"' ^^" , 0, 0, 0, "check_view", r_accy);
						break;
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
				$('#txtUnorda').val('v');
				$('#txtBdate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProductno').focus();
			}

			function btnPrint() {
				q_box('z_workgp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
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
				if(q_cur==1){
					//預設vew的未展排未請購未送簽
					$('#vtunwork_0').text('v');
					$('#vtunordb_0').text('v');
					$('#vtunorda_0').text('v');					
				}
				
				var endnoa=''
				for (var i = 0; i < brwCount; i++) {
					if($('#vtnoa_'+i).text()!='')
						endnoa=$('#vtnoa_'+i).text();
				}
				q_gt('workg', "where=^^ noa between '"+endnoa+"' and '"+$('#vtnoa_0').text()+"' ^^" , 0, 0, 0, "check_view", r_accy);
				
				var t_where = "where=^^ noa in (select noa from view_work where cuano='" + $('#txtNoa').val() + "') and isnull(gmount,0)>0 ^^";
				q_gt('view_works', t_where, 0, 0, 0, "", r_accy);
				change_field();
			}
			
			function change_field () {
				if($('#cmbStype').val()=='製造'){
					$('.semi').show();
					$('.finished').hide();
				}else{
					$('.finished').show();
					$('.semi').hide();
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

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						
					}
				}
				_bbsAssign();
				change_field();
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
				if (t_gmount > 0)
					alert('製令單已領料不能刪除!!');
				else
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
					case 'txtProductno_':
						$('#txtClass_' + b_seq).focus();
						break;
					default:
						break;
				}
			}
			function q_funcPost(t_func, result) {
				/*後面調整產生製令單*/
				/*if (t_func == 'workg.genWork') {
					var workno = result.split(';')
					for (var j = 0; j < q_bbsCount; j++) {
						abbsNow[j]['workno'] = workno[(j * 3) + 1];
						$('#txtWorkno_' + j).val(workno[(j * 3) + 1]);
						abbsNow[j]['rworkdate'] = workno[(j * 3) + 2];
						$('#txtRworkdate_' + j).val(workno[(j * 3) + 2]);
						abbsNow[j]['workhno'] = workno[(j * 3) + 3];
						$('#txtWorkhno_' + j).val(workno[(j * 3) + 3]);
					}
					alert('製令產出執行完畢!!');
					$('#vtunwork_'+q_recno).text('');
					$('#btnWork').val('製令產出').removeAttr('disabled');
					var obj = $('#tview').find('#noa');
					var t_noa=$.trim($('#txtNoa').val());
					for(var i=0;i<obj.length;i++){
						if(obj.eq(i).html()==t_noa){
							$('#tview').find('#unordb').eq(i).html('v');
							break;                                      
						}
					}
				}*/
			}

		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 575px;
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
				width: 695px;
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
				width: 3300px;
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
						<td style="width:170px; color:black;"><a id='vewRang'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnwork'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnordb'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnorda'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td align="center" id='stype=workg.stype'>~stype=workg.stype</td>
						<td id='bdate edate' style="text-align: center;">~bdate - ~edate</td>
						<td id='unwork' style="text-align: center;">~unwork</td>
						<td id='unordb' style="text-align: center;">~unordb</td>
						<td id='unorda' style="text-align: center;">~unorda</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td style="width: 116px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 126px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 210px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea" type="text" class="txt c1"/>
							<input id="txtWadate" type="hidden"/>
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
						<td><input id="btnOrde" type="button"/></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblWbdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtWbdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtWedate" type="text" class="txt c2"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" class="txt c3"/>
							<input id="txtComp" type="text" class="txt c4"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUcc1_uj" class="lbl btn">面材</a></td>
						<td colspan="2">
							<input id="txtUcc1no" type="text" class="txt c1" style="width: 155px;"/>
							<span> </span><a id="lblUcc2_uj" class="lbl btn">底材</a>
						</td>
						<td colspan="2"><input id="txtUcc2no" type="text" class="txt c1" style="width: 155px;"/></td>
						<td><input id="btnWorkgg" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><input id="btnWorkg2ordb" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdbno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtOrdbno" type="text" class="txt c1"/>
							<input id="txtOrdano" type="text" class="txt c1" style="display: none;"/>
						</td>
						<td>
							<input id="btnWorkPrint" type="button" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input id="btnWork" type="button"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;display: none;"> </td>
						<td style="width:60px;"><a id='lblNoq_s'> </a></td>
						<td style="width:120px;"><a id="lblOdatea_uj_s">交期</a></td>
						<td style="width:150px;"><a id='lblOrdeno_uj_s'>訂單號碼</a></td>
						<td style="width:140px;">
							<a id='lblProductno_uj_s' class="finished">成品料號</a>
							<a id='lblProductno2_uj_s' class="semi">半成品料號</a>
						</td>
						<td style="width:210px;">
							<a id='lblProduct_uj_s' class="finished">成品名稱</a>
							<a id='lblProduct2_uj_s' class="semi">半成品名稱</a>
						</td>
						<td style="width:100px;" class="finished"><a id='lblMount_uj_s'>加工成品(支)</a></td>
						<td style="width:100px;" class="finished"><a id='lblWidth_uj_s'>寬幅(mm)</a></td>
						<td style="width:100px;">
							<a id='lblLengthb_uj_s' class="finished">長(M)</a>
							<a id='lblLengthb2_uj_s' class="semi">長度(M)</a>
						</td>
						<td style="width:60px;"><a id='lblIsprearranged_uj_s'>預排</a></td>
						<td style="width:100px;">
							<a id='lblRworkdate_uj_s' class="finished">加工日</a>
							<a id='lblRworkdate2_uj_s' class="semi">上膠日</a>
						</td>
						<td style="width:100px;"><a id='lblStyle_uj_s'>膠號</a></td>
						<td style="width:100px;" class="semi"><a id='lblDime_uj_s'>膠厚</a></td>
						<td style="width:100px;"><a id='lblLatedate_uj_s'>最遲到料日</a></td>
						<td style="width:150px;"><a id='lblMech_uj_s'>指定機台別</a></td>
						<td style="width:100px;"><a id='lblTypea_uj_s'>生產屬性</a></td>
						<td style="width:100px;"><a id='lblC5_uj_s'>筆數</a></td>
						<td style="width:60px;"><a id='lblIsunschedule_uj_s'>未排程</a></td>
						<td style="width:100px;">
							<a id='lblM1_uj_s' class="finished">(未排程)<BR>同紙箱</a>
							<a id='lblM12_uj_s' class="semi">(未排程)<BR>同紙</a>
						</td>
						<td style="width:100px;"><a id='lblC1_uj_s'>(未排程)<BR>筆數</a></td>
						<td style="width:100px;"><a id='lblM2_uj_s'>(未排程)<BR>同半成品</a></td>
						<td style="width:100px;"><a id='lblC2_uj_s'>(未排程)<BR>筆數</a></td>
						<td style="width:100px;">
							<a id='lblM3_uj_s' class="finished">(已排程)<BR>同紙箱</a>
							<a id='lblM32_uj_s' class="semi">(已排程)<BR>同紙</a>
						</td>
						<td style="width:100px;"><a id='lblC3_uj_s'>(已排程)<BR>筆數</a></td>
						<td style="width:100px;"><a id='lblM4_uj_s'>(已排程)<BR>同半成品</a></td>
						<td style="width:100px;"><a id='lblC4_uj_s'>(已排程)<BR>筆數</a></td>
						<td style="width:120px;"><a id='lblUcano_uj_s'>半成品料號</a></td>
						<td style="width:120px;"><a id='lblUcc1no_uj_s'>面材</a></td>
						<td style="width:120px;"><a id='lblUcc2no_uj_s'>底材</a></td>
						<td style="width:120px;"><a id='lblUcc3no_uj_s'>材料</a></td>
						<td style="width:120px;" class="finished"><a id='lblUcc4no_uj_s'>紙箱</a></td>
						<td style="width:120px;" class="finished"><a id='lblUcc5no_uj_s'>紙管</a></td>
						<td style="width:120px;" class="finished"><a id='lblUcc6no_uj_s'>塞頭</a></td>
						<td style="width:100px;">
							<a id='lblGen_uj_s' class="finished">生產時間(Hr)</a>
							<a id='lblGen2_uj_s' class="semi">製造速度(M/min)</a>
						</td>
						<td style="width:200px;"><a id='lblMemo_uj_s'>備註</a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
						<td style="display: none;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center"><input id="txtNoq.*" type="text" class="txt c1"/></td>
						<td><input id="txtOdatea.*" type="text" class="txt c1"/></td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
						<td class="finished"><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td class="finished"><input id="txtWidth.*" type="text" class="txt num c1"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
						<td><input id="chkIsprearranged.*" type="checkbox" class="txt c1"/></td>
						<td><input id="txtRworkdate.*" type="text" class="txt c1"/></td>
						<td><input id="txtStyle.*" type="text" class="txt c1"/></td>
						<td class="semi"><input id="txtDime.*" type="text" class="txt num c1"/></td>
						<td><input id="txtLatedate.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtMechno.*" type="text" class="txt c1"/>
							<input id="txtMech.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtTypea.*" type="text" class="txt c1"/></td>
						<td><input id="textC5.*" type="text" class="txt num c1"/></td>
						<td><input id="chkIsunschedule.*" type="checkbox" class="txt c1"/></td>
						<td><input id="textM1.*" type="text" class="txt num c1"/></td>
						<td><input id="textC1.*" type="text" class="txt num c1"/></td>
						<td><input id="textM2.*" type="text" class="txt num c1"/></td>
						<td><input id="textC2.*" type="text" class="txt num c1"/></td>
						<td><input id="textM3.*" type="text" class="txt num c1"/></td>
						<td><input id="textC3.*" type="text" class="txt num c1"/></td>
						<td><input id="textM4.*" type="text" class="txt num c1"/></td>
						<td><input id="textC4.*" type="text" class="txt num c1"/></td>
						<td><input id="txtUcano.*" type="text" class="txt c1"/></td>
						<td><input id="txtUcc1no.*" type="text" class="txt c1"/></td>
						<td><input id="txtUcc2no.*" type="text" class="txt c1"/></td>
						<td><input id="txtUcc3no.*" type="text" class="txt c1"/></td>
						<td class="finished"><input id="txtUcc4no.*" type="text" class="txt c1"/></td>
						<td class="finished"><input id="txtUcc5no.*" type="text" class="txt c1"/></td>
						<td class="finished"><input id="txtUcc6no.*" type="text" class="txt c1"/></td>
						<td><input id="txtGen.*" type="text" class="txt num c1"/></td>
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