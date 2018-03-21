
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
			var q_name = "ordr";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
					
			aPop = new Array(
			    ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
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
				q_cmbParse("cmbUccgano", '一般@一般,希得@希得');
				
				$('#btnImport').click(function(e){
                    var t_noa = $('#txtWorkgno').val();
                    q_func('qtxt.query.ordr_orda', 'ordr_uj.txt,orda2ordrCD,'+ encodeURI(t_noa)); 
                });
							
			} 
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.ordr_orda':
                        var as = _q_appendData("tmp0", "", true, true); 
                            q_gridAddRow(bbtHtm, 'tbbs', 'txtOrdano,txtOrdanoq,txtApvmemo,txtApvmount,txtProductno,txtProduct,txtSpec,txtUnit,txtWorkdate,txtStkmount,txtSchmount,txtSafemount,txtNetmount,txtFdate,txtFmount,txtMemo,txtWmount,chkApv,txtSmount,txtGweight,txtWeight,txtMount,txtTggno,txtComp,txtTypea'
                            , as.length, as, 'noa,noq,apvmemo,apvmount,productno,product,spec,unit,workdate,stkmount,schmount,safemount,netmount,fdate,fmount,memo,wmount,apv,smount,gweight,weight,mount,tggno,tgg,stype', 'txtOrdano,txtOrdanoq');
                        for (var i = 0; i < as.length; i++) {
                                if(as[i].apv=='1' && as[i].apv!='undefined')
                                    $('#chkApv_' + i).prop('checked', true);
                        }
                        break;  
                    default:
                        break;
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
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}
		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordr_uj_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function sum() {		
				for (var i=0; i<q_bbsCount; i++){
				  
				}		
			}
			
			//採購
			function tmount() {
			    for (var i=0; i<q_bbsCount; i++){
			        
			    }
			}

            function fmount() {
                for (var i=0; i<q_bbsCount; i++){
                    
                }
                
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
                    
				}				
				_bbsAssign();

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
				//q_box('z_ordr_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
                        <td><span> </span><a id='lblNoa_uj' class="lbl " >電腦編號</a></td>
                        <td><input id="txtNoa" type="text" class="txt c1" /></td>                       
                        <td><span> </span><a id='lblDatea_uj' class="lbl">日期</a></td>
                        <td><input id="txtDatea"  type="text"  class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblUccga_uj" class="lbl">類別</a></td>
                        <td><select id="cmbUccgano" class="txt c1"> </select></td>
                        <td> </td>
                        <td style="text-align: center;"><input id="btnImport" type="button" value="匯入" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorkgnouj' class="lbl">採購需求單號</a></td>
                        <td><input id="txtWorkgno"  type="text"  class="txt c1" /></td>
                        <td> </td>
                        <td><input id="btnOrdb" type="button" value="轉請購單" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker"  type="text"  class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="3" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"> </textarea></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2260px;">
				<tr style='color:white; background:#003366;' >
					    <td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					    <td align="center" style="width:160px;"><a id='lblProductno' >品名</a></td>
					    <td align="center" style="width:35px;"><a id='lblapv_uj' >1色</a></td>
                        <td align="center" style="width:90px;"><a id='lblSpec_uj' >採購優惠</a></td>
                        <td align="center" style="width:70px;"><a id='lblSmount' >距離必採倒數(天)</a></td>
                        <td align="center" style="width:60px;"><a id='lblWorkdate_uj' >採購</a></td>
                        <td align="center" style="width:80px;"><a id='lblApvmount' >原採購量(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblFdate' >採購條件</a></td>
                        <td align="center" style="width:80px;"><a id='lblFmount' >原採購量(Kg)</a></td>
                        <td align="center" style="width:44px;"><a id='lblUnit' >採購單位</a></td>
                        <td align="center" style="width:80px;"><a id='lblTtype' >手調採購量(Kg)</a></td>
                        <td align="center" style="width:80px;"><a id='lblGWeight' >採購量(Kg)</a></td>
                        <td align="center" style="width:80px;"><a id='lblWeight' >採購量(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblMount' >採購量(支)</a></td>
                        <td align="center" style="width:70px;"><a id='lblTggno1' >購買廠商</a></td>
                        <td align="center" style="width:80px;"><a id='lblNetmount' >採購限定MOQ(Kg)</a></td>
                        <td align="center" style="width:60px;"><a id='lblTypea' >庫存水位(%)</a></td>
                        <td align="center" style="width:80px;"><a id='lblStkmount' >原月均(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblSchmount' >月均(Kg)</a></td>
                        <td align="center" style="width:70px;"><a id='lblApvmemo' >希德簡碼</a></td>
                        <td align="center" style="width:70px;"><a id='lblLdate' >同色短尺寸採購</a></td>
                        <td align="center" style="width:100px;"><a id='lblMemo' >注意事項</a></td>
				</tr>
				<tr style='background:#cad3ff;' class="ishide.*">
    					<td align="center">
    						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
    						<input id="txtNoq.*" type="text" style="display: none;" />
    						<input id="txtOrdano.*" type="text" style="display: none;" />
    						<input id="txtOrdanoq.*" type="text" style="display: none;" />
    					</td>
					    <td><input id="txtProductno.*" type="text" class="txt c1" style="width:97%;"/>
                            <input id="txtProduct.*" type="text" class="txt c1" style="width:80%;"/>
                            <input class="btn" id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" />
                        </td>
                        <td align="center"><input id="chkApv.*" type="checkbox"/></td>
                        <td><input id="txtSpec.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtSmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtWorkdate.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtApvmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtFdate.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtFmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtUnit.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtTtype.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtGweight.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtWeight.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtMount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtTggno.*" type="text" class="txt c1" style="width:97%;"/>
                            <input id="txtComp.*" type="text" class="txt c1" style="width:97%;"/>
                        </td>
                        <td><input id="txtNetmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtTypea.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtStkmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtSchmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtApvmemo.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtLdate.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtMemo.*" type="text" class="txt c1" style="width:97%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
