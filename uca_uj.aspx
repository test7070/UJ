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
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 't';
			var q_name = "uca";
			var decbbs = [];
			var decbbm = [];
			var decbbt = [];
			var q_readonly = ['txtKdate','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 12;
			q_copy=1;
			aPop = new Array(
				['txtProcessno', 'lblProcessno_uj', 'mech', 'noa,mech', 'txtProcessno,txtProcess', 'mech_b.aspx'],
				['txtModelno', 'lblModelno_uj', 'mech', 'noa,mech', 'txtModelno,txtModel', 'mech_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			}).mousedown(function(e) {
				if(!$('#div_row').is(':hidden')){
					$('#div_row').hide();
				}
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(0);
				$('#txtNoa').focus();
			}
			function mainPost() {
				q_getFormat();
				bbmMask = [];
				q_mask(bbmMask);
				//q_cmbParse("cmbTypea", q_getPara('uca.typea'));
				q_cmbParse("cmbTypea", "2@製成品,3@半成品,8@再製品");//固定避免有問題
				q_cmbParse("cmbGroupdno", '訂單,成-計,半-計,半-訂,計畫');
				
				$('#txtNoa').change(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa='" + thisVal + "' ^^";
						Lock();
						q_gt('ucaucc', t_where, 0, 0, 0, "checkNoa", r_accy);
					}
				});
				
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
				});
				
				$('#cmbTypea').change(function() {
					TypeaChange();
				});
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'uploadimg':
						var t_where = "where=^^noa='" + $('#txtNoa').val() + "'^^";
						q_gt('uca', t_where, 0, 0, 0, "uploadimg_noa", r_accy);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkNoa':
						var as = _q_appendData("ucaucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').val('').focus();
						}
						Unlock();
						break;
					case 'uploadimg_noa':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							abbm[q_recno]['images'] = as[0].images;
							$('#txtImages').val(as[0].images);
						}
						$('.images').html('');
						if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
							imagename=$('#txtImages').val().split(';');
							imagename.sort();
							var imagehtml="<table width='1260px'><tr>";
							for (var i=0 ;i<imagename.length;i++){
								if(imagename[i]!='')
									imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
							}
							imagehtml+="</tr></table>";
							$('.images').html(imagehtml);
							
							for (var i=0 ;i<imagename.length;i++){
								$('#images_'+i).click(function() {
									var n = $(this).attr('id').split('_')[1];
									t_where = "noa='" + $('#txtNoa').val() + "'";
									q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
								});
							}
						}
						break;
					case q_name:
						if (q_cur == 4){
							q_Seek_gtPost();
						}
						break;
				}
			}
			
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtProduct', q_getMsg('lblProduct')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				var ts1=$('#textS1').val();
				var ts2=$('#textS2').val();
				var ts3=$('#textS3').val();
				var ts4=$('#textS4').val();
				var ts5=$('#textS5').val();
				var ts6=$('#textS6').val();
				var ts7=$('#textS7').val();
				var ts8=$('#textS8').val();
				
				$('#txtStyle').val(ts1+"#^#"+ts2+"#^#"+ts3+"#^#"+ts4+"#^#"+ts5+"#^#"+ts6+"#^#"+ts7+"#^#"+ts8);
				
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				//重新設定noq
				for (var i = 0; i < q_bbsCount; i++) {
					if (!emp($('#txtProductno_' + i).val()))
						$('#txtNoq_' + i).val(('000' + (i + 1)).slice(-3));
				}
				for (var i = 0; i < q_bbtCount; i++) {
					if (!emp($('#txtProcessno__' + i).val()))
						$('#txtNoq__' + i).val(('000' + (i + 1)).slice(-3));
				}
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll('Q' + $('#txtKdate').val(), '/', ''));
				else
					wrServer(s1);
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('uca_uj_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
							}
							if (!emp($('#txtProductno_' + b_seq).val()) && !emp($('#txtNoa').val()))
								q_func('qtxt.query.bom', 'bom.txt,bom,' + encodeURI($('#txtProductno_' + b_seq).val()) + ';' + encodeURI($('#txtNoa').val()));
						});
						
						$('#btnMinus_'+j).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
						
					}
				}
				_bbsAssign();
			}
			var assm_row = 0;
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#btnMinut__' + i).bind('contextmenu',function(e) {
							e.preventDefault();
							if (e.button == 2) {
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								row_b_seq = b_seq;
								row_bbsbbt = 'bbt';
							}
						});
					}
				}
				_bbtAssign();
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.bom':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] == undefined) {
							if (t_td.length > 0) {
								alert('替代品會造成BOM錯誤!!請重新填入!!');
								$('#txtTd_' + b_seq).val('');
							} else {
								alert('BOM錯誤!!該品號不能填入!!');
								$('#btnMinus_' + b_seq).click();
							}
						}
						t_td = '';
						break;
				}
			};
			
			function btnIns() {
				_btnIns();
				
				$('#txtKdate').val(q_date());
				$('#txtKdate').focus();
			}
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				showS19();
			}
			
			function btnPrint() {
				q_box("z_ucap_uj.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "' and product='" + $('#txtProduct').val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
				t_err = '';
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				as['rev'] = abbm2['rev'];
				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}
			
			function bbtSave(as) {
                if (!as['processno'] && !as['process'] && !as['tggno'] && !as['stationno'] && !as['productno'] && !as['assm']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
			function sum() {
			}
			
			function refresh(recno) {
				_refresh(recno);
				showS19();
				$('.images').html('');
				if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
					imagename=$('#txtImages').val().split(';');
					imagename.sort();
					var imagehtml="<table width='1260px'><tr>";
					for (var i=0 ;i<imagename.length;i++){
						if(imagename[i]!='')
							imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
					}
					imagehtml+="</tr></table>";
					$('.images').html(imagehtml);
					
					for (var i=0 ;i<imagename.length;i++){
						$('#images_'+i).click(function() {
							var n = $(this).attr('id').split('_')[1];
							t_where = "noa='" + $('#txtNoa').val() + "'";
							q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
						});
					}
				}
				
				TypeaChange();
			}
			
			function showS19() {
				var t_style=$('#txtStyle').val().split('#^#');
				
				var ts1=t_style[0]==undefined?'':t_style[0];
				var ts2=t_style[1]==undefined?'':t_style[1];
				var ts3=t_style[2]==undefined?'':t_style[2];
				var ts4=t_style[3]==undefined?'':t_style[3];
				var ts5=t_style[4]==undefined?'':t_style[4];
				var ts6=t_style[5]==undefined?'':t_style[5];
				var ts7=t_style[6]==undefined?'':t_style[6];
				var ts8=t_style[7]==undefined?'':t_style[7];
				
				$('#textS1').val(ts1);
				$('#textS2').val(ts2);
				$('#textS3').val(ts3);
				$('#textS4').val(ts4);
				$('#textS5').val(ts5);
				$('#textS6').val(ts6);
				$('#textS7').val(ts7);
				$('#textS8').val(ts8);
			}
			
			function TypeaChange() {
				if($('#cmbTypea').val()=='3'){//半成品
					$('#lblSec_uj').text('生產速度(M/min)');
					$('#lblWages_uj').text('製造人工');
					$('.type2').hide();
					$('#lblPreday_uj').text('熟成(天)');
					$('.type8').hide();
					$('.type3').show();
				}else if($('#cmbTypea').val()=='8'){//再製品
					$('#lblSec_uj').text('分條工時(Sec/M)');
					$('#lblWages_uj').text('分條人工');
					$('.type2').hide();
					$('#lblPreday_uj').text('訂單交期');
					$('.type3').hide();
					$('.type8').show();
				}else{//成品
					$('#lblSec_uj').text('分條工時(Sec/M)');
					$('#lblWages_uj').text('分條人工');
					$('#lblPreday_uj').text('訂單交期');
					$('.type3').hide();
					$('.type8').hide();
					$('.type2').show();
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#div_row').hide();
				}
			}
			
			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}
			
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
			
			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
			
			var mouse_div = true;
			//控制滑鼠消失div
			var row_bbsbbt = '';
			//判斷是bbs或bbt增加欄位
			var row_b_seq = '';
			//判斷第幾個row
			//插入欄位
			function q_bbs_addrow(bbsbbt, row, topdown) {
				//取得目前行
				var rows_b_seq = dec(row) + dec(topdown);
				if (bbsbbt == 'bbs') {
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
					//目前行的資料往下移動
					for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbs.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
							else
								$('#' + fbbs[j] + '_' + i).val('');
						}
					}
				}
				if (bbsbbt == 'bbt') {
					q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
					//目前行的資料往下移動
					for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbt.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
							else
								$('#' + fbbt[j] + '__' + i).val('');
						}
					}
				}
				$('#div_row').hide();
				row_bbsbbt = '';
				row_b_seq = '';
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
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
			.tview td {
				padding: 2px;
				/*text-align: center;*/
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 68%;
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
				/*width: 9%;*/
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
				text-align: right;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				text-align: right;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c5 {
				width: 75%;
				float: left;
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
			.tbbm td input[type="button"] {
				/*float: left;*/
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"],select {
				font-size: medium;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 1755px;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
			
			#div_row {
				display: none;
				width: 750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
				color: #000000;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			.table_row tr td .lbl.btn:hover {
				color: #FF8F19;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden; width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:410px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;word-break:break-all;">
					<tr>
						<td align="center" style="width:20px"><a id='vewChk'> </a></td>
						<td align="center" style="width:180px"><a id='vewNoa'> </a></td>
						<td align="center" style="width:210px"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa'>~noa</td>
						<td id='product spec'>~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0' >
					<tr style="height:1px;">
						<td style="width:130px;"> </td>
						<td style="width:150px;"> </td>
						<td style="width:130px;"> </td>
						<td style="width:150px;"> </td>
						<td style="width:130px;"> </td>
						<td style="width:150px;"> </td>
						<td style="width:5px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEngpro_uj" class="lbl">舊成品編碼</a></td>
						<td colspan="2"><input id="txtEngpro" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan='3'><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblKdate" class="lbl"> </a></td>
						<td><input id="txtKdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblType" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblGroupdno_uj" class="lbl">銷售政策</a></td>
						<td><select id="cmbGroupdno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
                        <td><input id="txtUnit" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblUweight_uj" class="lbl">單位重</a></td>
						<td><input id="txtUweight" type="text" class="txt num c1"/></td>
						<td> </td>
						<td style="text-align: center;"><input id="btnUploadimg" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblRev_uj" class="lbl">系列</a></td>
						<td><input id="txtRev" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblStationgno_uj" class="lbl">客戶編號</a></td>
                        <td><input id="txtStationgno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblStationg_uj" class="lbl">客戶名稱</a></td>
                        <td><input id="txtStationg" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechs_uj" class="lbl">寬(mm)</a></td>
						<td><input id="txtMechs" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblTrans_uj" class="lbl">長(M)</a></td>
						<td><input id="txtTrans" type="text" class="txt num c1"/></td>
						<td class="type2 type8"><span> </span><a id="lblMolds_uj" class="lbl">裁切</a></td>
						<td class="type2 type8"><input id="txtMolds" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="type2 type3">
						<td class="type2 type3"><span> </span><a id="lblPreday_uj" class="lbl">訂單交期</a></td>
						<td class="type2 type3"><input id="txtPreday" type="text" class="txt num c1"/></td>
						<td class="type2"><span> </span><a id="lblMakes_uj" class="lbl">半-計 交期</a></td>
						<td class="type2"><input id="txtMakes" type="text" class="txt num c1"/></td>
						<td class="type2"><span> </span><a id="lblPretime_uj" class="lbl">半-訂 交期</a></td>
						<td class="type2"><input id="txtPretime" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblModelno_uj" class="lbl">機台</a></td>
						<td>
							<input id="txtModelno" type="text" class="txt c1"/>
							<input id="txtModel" type="text" class="txt c1" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblSec_uj" class="lbl">分條工時(Sec/M)</a></td>
						<td><input id="txtSec" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWages_uj" class="lbl">分條人工</a></td>
						<td><input id="txtWages" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="type2"><!--成品才顯示-->
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblMinutes_uj" class="lbl">覆捲工時(Sec/M)</a></td>
						<td><input id="txtMinutes" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblHours_uj" class="lbl">覆捲人工</a></td>
						<td><input id="txtHours" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="type2 type8">
						<td><span> </span><a id="lblGroupbno_uj" class="lbl">半成品</a></td>
						<td><input id="txtGroupbno" type="text" class="txt c1"/></td>
						<td class="type2"><span> </span><a id="lblGroupcno_uj" class="lbl">再製品</a></td>
						<td class="type2"><input id="txtGroupcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type2 type8">
						<td><span> </span><a id="lblGroupkno_uj" class="lbl">半成品轉零碼</a></td>
						<td><input id="txtGroupkno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGrouplno_uj" class="lbl">再製品轉零碼</a></td>
						<td><input id="txtGrouplno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type2">
						<td><span> </span><a id="lblGroupeno_uj" class="lbl">紙管</a></td>
						<td><input id="txtGroupeno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroupfno_uj" class="lbl">紙箱</a></td>
						<td><input id="txtGroupfno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroupgno_uj" class="lbl">塞頭</a></td>
						<td><input id="txtGroupgno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type3">
						<td><span> </span><a id="lblGrouphno_uj" class="lbl">上皮(投入)</a></td>
						<td><input id="txtGrouphno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroupino_uj" class="lbl">上紙(投入)</a></td>
						<td><input id="txtGroupino" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroupjno_uj" class="lbl">膠號/膠水</a></td>
						<td>
							<input id="txtGroupjno" type="text" class="txt c1" style="width: 48%;"/>
							<input id="txtIssuedate" type="text" class="txt c1" style="width: 48%;"/>
						</td>
					</tr>
					<tr class="type3">
						<td><span> </span><a id="lblS1_uj" class="lbl">膠厚</a></td>
						<td><input id="textS1" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblS2_uj" class="lbl">換線屬性</a></td>
						<td><input id="textS2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblS3_uj" class="lbl">補水</a></td>
						<td><input id="textS3" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type3">
						<td><span> </span><a id="lblS4_uj" class="lbl">上膠面</a></td>
						<td><input id="textS4" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblS5_uj" class="lbl">懸空放</a></td>
						<td><input id="textS5" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type2">
						<td><span> </span><a id="lblS6_uj" class="lbl">外箱長(mm)</a></td>
						<td><input id="textS6" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblS7_uj" class="lbl">外箱寬(mm)</a></td>
						<td><input id="textS7" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblS8_uj" class="lbl">外箱高(mm)</a></td>
						<td><input id="textS8" type="text" class="txt c1"/></td>
					</tr>
					<tr class="type3">
						<td><span> </span><a id="lblHsec_uj" class="lbl">標準長小值(M)</a></td>
						<td><input id="txtHsec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblHminutes_uj" class="lbl">標準長大值(M)</a></td>
						<td><input id="txtHminutes" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBadperc_uj" class="lbl">良率%</a></td>
						<td><input id="txtBadperc" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblStdmount_uj" class="lbl">MOQ(M)</a></td>
						<td><input id="txtStdmount" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
                        <td><span> </span><a id="lblMemo_uj" class="lbl">注意事項</a></td>
                        <td colspan='5'>
                        	<input id="txtMemo" type="text" class="txt c1"/>
                        	<input id="txtStyle" type="hidden" class="txt c1"/>
                        </td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 760px;display: none;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblProductno_s_uj'>半成品/材料編號</a></td>
					<td align="center" style="width:260px;"><a id='lblProduct_s_uj'>半成品/材料名稱</a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s_uj'>數量</a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s_uj'>加工/製造說明</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td>
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 85%;"/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<div id="dbbt" style="display: none;" >
			<table id="tbbt" class='tbbt' border="1" cellpadding='2' cellspacing='1'>
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:40px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:145px;"><a id='lblProcess_t'> </a></td>
					<td align="center" style="width:145px;"><a id='lblTgg_t'> </a></td>
					<td align="center" style="width:145px;"><a id='lblStation_t'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_t'> </a></td>
					<td align="center" style="width:75px; display: none;"><a id='lblHours_t'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMinutes_t'> </a></td>
					<td align="center" style="width:120px;"><a id='lblHminutes_t'> </a></td>
					<td align="center" style="width:175px;"><a id='lblProductno_t'> </a></td>
					<td align="center" style="width:190px;"><a id='lblAssm_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblMount_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblLoss_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblWages_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblMakes_t'> </a></td>
					<td align="center" style="width:103px;"><a id='lblWages_fee_t'> </a></td>
					<td align="center" style="width:103px;"><a id='lblMakes_fee_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcessno..*" type="text" class="txt c5"/>
						<input id="btnProcessno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtProcess..*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtTggno..*" type="text" class="txt c5"/>
						<input id="btnTggno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtNick..*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtStationno..*" type="text" class="txt c5"/>
						<input id="btnStation..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtStation..*" type="text" class="txt c1"/>
					</td>
					
					<td><input id="txtPrice..*" type="text" class="txt c1 num"/></td>
					
					<td style="display: none;"><input id="txtHours..*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtMinutes..*" type="text" class="txt c1 num" style="width: 45%;"/>
						<input id="txtSec..*" type="text" class="txt c1 num" style="width: 45%;"/>
					</td>
					<td>
						<input id="txtHminutes..*" type="text" class="txt c1 num" style="width: 45%;"/>
						<input id="txtHsec..*" type="text" class="txt c1 num" style="width: 45%;"/>
					</td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td>
						<input id="btnAssm..*" type="button" value='.' style=" font-weight: bold;width:1%; float: left;" />
						<input id="txtAssm..*" type="text" class="txt" style="width: 80%"/>
					</td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLoss..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWages..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMakes..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWages_fee..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMakes_fee..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<div class='images' style="float: left;"> </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>