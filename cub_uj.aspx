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
            var q_name = "cub";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtOrdeno', 'txtNo2'];
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
            q_desc = 1;
            brwCount2 = 5;
            aPop = new Array(
            	['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
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

            function sum() {
                for (var j = 0; j < q_bbsCount; j++) {
                    
                }
            }

            function mainPost() {
            	bbsNum = [ ['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 9, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1], ['txtLengthc', 15, 2, 1]];//['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1],
            	bbtNum = [['txtGmount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtGweight', 9, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1], ['txtLengthc', 15, 2, 1]];
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                document.title='訂單彙總表';
                
                $('#btnOrde').click(function() {
                	var t_where="1=1";
                	var t_custno=$('#txtCustno').val();
                	var t_ordeno=$('#txtOrdeno').val();
                	var t_datea=$('#txtBdate').val();
                	if(t_custno.length==0){t_custno='#non';}
                	if(t_ordeno.length==0){t_ordeno='#non';}
                	if(t_datea.length==0){t_datea='#non';}
                	
                });
            }

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
            
           
            function q_funcPost(t_func, result) {
				switch(t_func) {
					
				}
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
				q_box('cub_uj_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                //q_box('z_cubp_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
			
            function btnOk() {
            	t_err = q_chkEmpField([['txtDatea', '加工日']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                
                sum();
                
                if(q_cur==1){
                	$('#txtWorker').val(r_name);
                }else{
                	$('#txtWorker2').val(r_name);
                }
                
                                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function bbtSave(as) {
                if (!as['product'] && !as['uno']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
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
            }

            

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	
                    }
                }
                _bbtAssign();
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
                    case 'txtProductno_':
                        $('#txtClass_' + b_seq).focus();
                        break;
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
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
                width: 75%;
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
            .tbbm tr td {
                width: 9%;
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
                color: black;
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
                width: 95%;
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
            input[type="text"], input[type="button"] ,select{
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
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
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 100%;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea_uj" class="lbl">日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa_uj" class="lbl">單據編號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno_uj" class="lbl" >客戶</a></td>
						<td><input id="txtCustno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtComp" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="btnOrde" type="button" value="訂單匯入" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno_uj" class="lbl" >訂單編號</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><span> </span><a id="lblBdate_uj" class="lbl" >客戶交期</a></td>
						<td><input id="txtBdate" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' style="min-width: 3400px;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:50px;">項次</td>
						<td style="width:150px;"><a id='lblOrdeno_uj_s'>訂單號碼</a></td>
						<td style="width:100px;"><a id='lblProductno_uj_s'>成品料號</a></td>
						<td style="width:100px;"><a id='lblMount_uj_s'>數量<br>(毛需求-支)</a></td>
						<td style="width:60px;"><a id='lblUnit_uj_s'>單位</a></td>
						<td style="width:80px;"><a id='lblWidth_uj_s'>寬(mm)</a></td>
						<td style="width:80px;"><a id='lblLengthb_uj_s'>長(M)</a></td>
						<td style="width:60px;"><a id='lblDime_uj_s'>裁切</a></td>
						<td style="width:100px;"><a id='lblW01_uj_s'>成品庫存(支)</a></td>
						<td style="width:120px;"><a id='lblW02_uj_s'>半成品+再製品<br>可變成成品(支)</a></td>
						<td style="width:120px;"><a id='lblW03_uj_s'>半成品+再製品<br>庫存(M)</a></td>
						<td style="width:100px;"><a id='lblProductno2_uj_s'>半成品料號</a></td>
						<td style="width:100px;"><a id='lblX01_uj_s'>製造<br>成品<br>(淨需求-支)</a></td>
						<td style="width:100px;"><a id='lblX02_uj_s'>製造<br>(M)</a></td>
						<td style="width:100px;"><a id='lblOth_uj_s'>製造<br>MOQ限定</a></td>
						<td style="width:100px;"><a id='lblX03_uj_s'>製造<br>MOQ</a></td>
						<td style="width:100px;"><a id='lblX04_uj_s'>製造<br>低於MOQ</a></td>
						<td style="width:120px;"><a id='lblX05_uj_s'>加工<br>原生產成品(支)</a></td>
						<td style="width:100px;"><a id='lblX06_uj_s'>加工<br>增減成品(支)</a></td>
						<td style="width:100px;"><a id='lblX07_uj_s'>加工<br>成品(支)</a></td>
						<td style="width:100px;"><a id='lblOrdcno_uj_s'>底材<br>料號</a></td>
						<td style="width:100px;"><a id='lblW04_uj_s'>底材<br>指定廠內庫存</a></td>
						<td style="width:100px;"><a id='lblW05_uj_s'>底材<br>合計</a></td>
						<td style="width:100px;"><a id='lblY01_uj_s'>同紙<br>(未排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY02_uj_s'>同半成品<br>(未排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY03_uj_s'>同紙<br>(已排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY04_uj_s'>同半成品<br>(已排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblX08_uj_s'>物料需求(支)<br>紙管(根)</a></td>
						<td style="width:100px;"><a id='lblX09_uj_s'>物料需求(支)<br>紙箱(箱)</a></td>
						<td style="width:100px;"><a id='lblX10_uj_s'>物料需求(支)<br>塞頭(個)</a></td>
						<td style="width:100px;"><a id='lblMakeno_uj_s'>面材<br>料號</a></td>
						<td style="width:100px;"><a id='lblW06_uj_s'>面材<br>指定廠內庫存</a></td>
						<td style="width:100px;"><a id='lblOrdcno2_uj_s'>材料<br>料號</a></td>
						<td style="width:100px;"><a id='lblW07_uj_s'>材料<br>指定廠內庫存</a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtOrdeno.*" type="text" class="txt c1" style="width: 68%;"/>
							<input id="txtNo2.*" type="text" class="txt c1" style="width: 25%;"/>
						</td>
						<td>
							<input id="txtProductno.*" type="text" class="txt c1"/>
							<input id="txtProduct.*" type="text" class="txt c1" style="display: none;"/>
						</td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtWidth.*" type="text" class="txt num c1"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
						<td><input id="txtDime.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtProductno2.*" type="text" class="txt c1"/></td>
						<td><input id="txtX01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOth.*" type="text" class="txt c1"/></td>
						<td><input id="txtX03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX05.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX06.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX07.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno.*" type="text" class="txt c1"/></td>
						<td><input id="txtW04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW05.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX08.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX09.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX10.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMakeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtW06.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno2.*" type="text" class="txt c1"/></td>
						<td><input id="txtW07.*" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="width: 750px;display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:40px;"> </td>
					<td style="width:80px;"><a id='lblNor_uj_t'>表身項次</a></td>
					<td style="width:180px;"><a id='lblUno_uj_t'>指定批號</a></td>
					<td style="width:120px;"><a id='lblProductno_uj_t'>對應品項</a></td>
					<td style="width:80px;"><a id='lblSource_uj_t'>對應來源</a></td>
					<td style="width:80px;"><a id='lblGmount_uj_t'>領料數量</a></td>
					<td style="width:80px;"><a id='lblLengthb_uj_t'>長度</a></td>
					<td style="width:60px;"><a id='lblKind_uj_t'>指定</a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtNor..*" type="text" class="txt c1"/></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtSource..*" type="text" class="txt c1"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtKind..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>