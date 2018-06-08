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
		<script type="text/javascript">
            this.errorHandler = null;
			
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			
			q_copy=1;
            q_desc = 1;
            q_tables = 's';
            var q_name = "custprice";
            var q_readonly = ['txtNoa', 'txtDatea','txtWorker'];
            var q_readonlys = ['txtMemo1','txtMemo3','txtDiscount','txtPrice'];
            var bbmNum = [];
            var bbsNum = [['txtOprice', 10, 2, 1],['txtPrice', 10, 2, 1],['txtDiscount', 10, 2, 1],['txtTaxrate', 5, 2, 1],['txtNotaxprice', 10, 2, 1]
            ,['txtCost', 10, 3, 1],['txtTranprice', 10, 3, 1],['txtCommission', 10, 2, 1],['txtProfit', 10, 2, 1],['txtInsurance', 10, 2, 1],['txtPrice2', 10, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
            	//['txtProductno_', 'btnProductno_', 'uca', 'noa,product,unit,engpro', 'txtProductno_,txtProduct_,txtUnit_,txtMemo1_', 'uca_b.aspx'],
            	['txtProductno_', 'btnProductno_', 'uca', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'uca_b.aspx'],
            	['txtMemo2_', '', 'adsec', 'noa,product,price', 'txtMemo2_,txtMemo3_,txtDiscount_', '_b.aspx']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                q_cmbParse("cmbPayterms", q_getPara('sys.payterms'),'s');
                
                document.title='內銷優惠品項主檔';
                
                $('#txtBdate').focusout(function() {
                    q_cd($(this).val(), $(this));
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
                }  /// end switch
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
                var t_err = '';
                //t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')]]);
                //不鎖客戶因為會有統一售價
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['lblBdate', q_getMsg('lblBdate')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custprice') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('custprice_uj_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
                $('#txtBdate').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtBdate').focus();
            }
            function btnPrint() {
                q_box('z_custprice.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }
            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						$('#txtMemo2_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtOprice_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							ssum(b_seq);
						});
                    }
                }
                
                _bbsAssign();
            }
            
            
            function bbsSave(as) {
                t_err = '';
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['custno'] = abbm2['custno'];
                as['bdate'] = abbm2['bdate'];
                return true;
            }
            
            function sum() {
                var t1 = 0, t_unit, t_mount, t_income = 0, t_pay = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                 
                }// j
            }
            
            function ssum(i) {
            	var t_oprice=dec($('#txtOprice_'+i).val());
            	var t_discount=dec($('#txtDiscount_'+i).val())/100;
            	
                $('#txtPrice_'+i).val(round(q_mul(t_oprice,t_discount),0));
            }
            
            function refresh(recno) {
                _refresh(recno);
                
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
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
                if (q_chkClose())
                    return;
                _btnDele();
            }
            function btnCancel() {
                _btnCancel();
            }
            
            function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						ssum(b_seq);
						break;
					case 'txtMemo2_':
						ssum(b_seq);
						break;
				}
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 355px;
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
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 500px;
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 98%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select {
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewBdate'> </a></td>
						<td align="center" style="width:40%"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='bdate'>~bdate</td>
						<td align="center" id='comp'>~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td style="width: 30%"> </td>
						<td style="width: 50%"> </td>
						<td style="width: 19%"> </td>
						<td style="width: 1%"> </td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno" type="text" class="txt c2"/>
							<input id="txtComp" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width: 2%;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:12%;"><a id='lblProductno_uj_s'>物品編號</a></td><!--新編碼-->
					<td align="center" style="width:18%;"><a id='lblProduct_uj_s'>物品名稱</a></td>
					<td align="center" style="width:4%;display: none;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:12%;display: none;"><a id='lblMemo1_uj_s'>舊編號</a></td>
					<td align="center" style="width:8%;"><a id='lblOprice_uj_s'>單價</a></td>
					<td align="center" style="width:8%;"><a id='lblMemo2_uj_s'>優惠類別</a></td>
					<td align="center" style="width:10%;"><a id='lblMemo3_uj_s'>產品分類</a></td>
					<td align="center" style="width:6%;"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:10%;display: none;"><a id='lblNotaxprice_s'> </a></td>
					<td align="center" style="width:7%;display: none;"><a id='lblTaxrate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblPrice_uj_s'>折扣後價格</a></td>
					<td align="center" style="width:10%;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" class="txt c1"/>
						<input id="btnProductno.*" type="button" style="width: 1%;float:left;font-size: medium; font-weight: bold;display: none;" value="."/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td style="display: none;"><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td style="display: none;"><input id="txtMemo1.*" type="text" class="txt c1"/></td>
					<td><input id="txtOprice.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo2.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo3.*" type="text" class="txt c1"/></td>
					<td><input id="txtDiscount.*" type="text" class="txt num c1"/></td>
					<td style="display: none;"><input id="txtNotaxprice.*" type="text" class="txt num c1"/></td>
					<td style="display: none;"><input id="txtTaxrate.*" type="text" class="txt num c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text"   class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>