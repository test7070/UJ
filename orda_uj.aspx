
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
			var q_name = "orda";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtSafemount', 10, 0, 1],['txtNetmount', 10, 0, 1],['txtSchmount', 10, 0, 1],['txtMount', 10, 0, 1],['txtGmount', 10, 0, 1]];
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
				    case 'modfixc':
                        as = _q_appendData("modfixcs", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,textM6,textM14,txtNetmount,textM10,textM11,textM15'
                        , as.length, as, 'productno,product,bottom,mount,brepair,erepair,weight,etime', 'txtProductno,txtProduct','');
                        for ( i = 0; i < q_bbsCount; i++) {
                            if (i < as.length) {
                            }else{
                                _btnMinus("btnMinus_" + i);
                            }
                        }
                        sum();
                        $('#txtNoa').focus();
                        break;
                    case 'ucc':
                        as = _q_appendData("ucc", "", true);
                        for ( i = 0; i < q_bbsCount; i++) {
                            if($('#txtProductno_'+i).val()==as[0].noa){
                                $('#txtGmount_'+i).val(q_mul($('#txtMount_'+i).val(),as[0].uweight));
                            }
                        }
                        break;				
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
				
				for (var i=0; i<q_bbsCount; i++){
    				var ts1=$('#textM1_'+i).val()==''?'':round(dec($('#textM1_'+i).val()),0);
                    var ts2=$('#textM2_'+i).val()==''?'':round(dec($('#textM2_'+i).val()),0);
                    var ts3=$('#textM3_'+i).val()==''?'':round(dec($('#textM3_'+i).val()),0);
                    var ts4=$('#textM4_'+i).val()==''?'':round(dec($('#textM4_'+i).val()),0);
                    var ts5=$('#textM5_'+i).val()==''?'':round(dec($('#textM5_'+i).val()),0);
                    var ts6=$('#textM6_'+i).val()==''?'':round(dec($('#textM6_'+i).val()),0);
                    var ts7=$('#textM9_'+i).val()==''?'':round(dec($('#textM9_'+i).val()),0);
                    var ts8=$('#textM10_'+i).val()==''?'':round(dec($('#textM10_'+i).val()),0);
                    var ts9=$('#textM11_'+i).val()==''?'':round(dec($('#textM11_'+i).val()),0);
                    var ts10=$('#textM12_'+i).val()==''?'':round(dec($('#textM12_'+i).val()),0);
                    var ts11=$('#textM13_'+i).val()==''?'':round(dec($('#textM13_'+i).val()),0);
                    var ts12=$('#textU1_'+i).val()==''?'':round(dec($('#textU1_'+i).val()),0);
                    var ts13=$('#textU2_'+i).val()==''?'':round(dec($('#textU2_'+i).val()),0);
                    var ts14=$('#textU3_'+i).val()==''?'':round(dec($('#textU3_'+i).val()),0);
                    var ts15=$('#textU4_'+i).val()==''?'':round(dec($('#textU4_'+i).val()),0);
                    var ts16=$('#textU5_'+i).val()==''?'':round(dec($('#textU5_'+i).val()),0);
                    var ts17=$('#textU6_'+i).val()==''?'':round(dec($('#textU6_'+i).val()),0);
                    var ts18=$('#textM14_'+i).val()==''?'':round(dec($('#textM14_'+i).val()),0);
                    var ts19=$('#textM15_'+i).val()==''?'':round(dec($('#textM15_'+i).val()),0);
                    $('#txtApvmemo_'+i).val(ts1+"#^#"+ts2+"#^#"+ts3+"#^#"+ts4+"#^#"+ts5+"#^#"+ts6
                    +"#^#"+ts7+"#^#"+ts8+"#^#"+ts9+"#^#"+ts10+"#^#"+ts11+"#^#"+ts12+"#^#"+ts13+"#^#"+ts14+"#^#"+ts15+"#^#"+ts16+"#^#"+ts17+"#^#"+ts18+"#^#"+ts19);
                }
    				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);	

				var t_noa = trim($('#txtNoa').val());
			    var t_date = trim($('#txtDatea').val());
			    if (t_noa.length == 0 || t_noa == "AUTO")
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orda') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}
			
			function showS19() {
			    for (var i=0; i<q_bbsCount; i++){
                    var t_style=$('#txtApvmemo_'+i).val().split('#^#');
                    
                    var ts1=t_style[0]==undefined?'':t_style[0];
                    var ts2=t_style[1]==undefined?'':t_style[1];
                    var ts3=t_style[2]==undefined?'':t_style[2];
                    var ts4=t_style[3]==undefined?'':t_style[3];
                    var ts5=t_style[4]==undefined?'':t_style[4];
                    var ts6=t_style[5]==undefined?'':t_style[5];
                    var ts7=t_style[6]==undefined?'':t_style[6];
                    var ts8=t_style[7]==undefined?'':t_style[7];
                    var ts9=t_style[8]==undefined?'':t_style[8];
                    var ts10=t_style[9]==undefined?'':t_style[9];
                    var ts11=t_style[10]==undefined?'':t_style[10];
                    var ts12=t_style[11]==undefined?'':t_style[11];
                    var ts13=t_style[12]==undefined?'':t_style[12];
                    var ts14=t_style[13]==undefined?'':t_style[13];
                    var ts15=t_style[14]==undefined?'':t_style[14];
                    var ts16=t_style[15]==undefined?'':t_style[15];
                    var ts17=t_style[16]==undefined?'':t_style[16];
                    var ts18=t_style[17]==undefined?'':t_style[17];
                    var ts19=t_style[18]==undefined?'':t_style[18];
                    
                    $('#textM1_'+i).val(ts1);
                    $('#textM2_'+i).val(ts2);
                    $('#textM3_'+i).val(ts3);
                    $('#textM4_'+i).val(ts4);
                    $('#textM5_'+i).val(ts5);
                    $('#textM6_'+i).val(ts6);
                    $('#textM9_'+i).val(ts7);
                    $('#textM10_'+i).val(ts8);
                    $('#textM11_'+i).val(ts9);
                    $('#textM12_'+i).val(ts10);
                    $('#textM13_'+i).val(ts11);
                    $('#textU1_'+i).val(ts12);
                    $('#textU2_'+i).val(ts13);
                    $('#textU3_'+i).val(ts14);
                    $('#textU4_'+i).val(ts15);
                    $('#textU5_'+i).val(ts16);
                    $('#textU6_'+i).val(ts17);
                    $('#textM14_'+i).val(ts18);
                    $('#textM15_'+i).val(ts19);
                }
            }
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('orda_uj_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function sum() {		
				for (var i=0; i<q_bbsCount; i++){
				    //總庫存賣(天)
				    $('#textM1_' + i).val(q_sub(q_add(q_add(q_add(q_add(dec($('#textU1_' + i).val()),dec($('#textU2_' + i).val())),dec($('#textU3_' + i).val())),dec($('#textU4_' + i).val())),dec($('#textU5_' + i).val())),dec($('#textU6_' + i).val())));
				    //總庫小計(M)
				    $('#textM2_' + i).val(q_div(q_mul(dec($('#textM1_' + i).val()),dec($('#textM14_' + i).val())),30));
				    //已採未交(天)
                    $('#textM3_' + i).val(q_div(dec($('#textM4_' + i).val()),q_div(dec($('#textM14_' + i).val()),30)));
                    //總庫存(天)
                    $('#txtSafemount_' + i).val(round(q_add(dec($('#textM1_' + i).val()),dec($('#textM3_' + i).val())),0));
                    //總庫存(M)
                    $('#textM5_' + i).val(q_div(q_mul(dec($('#txtSafemount_' + i).val()),dec($('#textM14_' + i).val())),30));
                    //距離必採倒數(天)
                    if(dec($('#txtSafemount_' + i).val())>dec($('#txtNetmount_' + i).val()) || (q_sub(dec($('#txtSafemount_' + i).val()),dec($('#textM6_' + i).val()))<0)){
                        $('#txtSchmount_' + i).val('0');
                    }else{
                        $('#txtSchmount_' + i).val(q_sub(dec($('#txtSafemount_' + i).val()),dec($('#textM6_' + i).val())));
                    }
                    //應採購量(天)
                    if(dec($('#txtSafemount_' + i).val())<dec($('#textM6_' + i).val()) || (dec($('#textM10_' + i).val())==1 && dec($('#txtSafemount_' + i).val())<dec($('#txtNetmount_' + i).val()))){
                        $('#textM9_' + i).val(q_sub(dec($('#txtNetmount_' + i).val()),dec($('#textM6_' + i).val())));
                    }else{
                        $('#textM9_' + i).val('0');
                    }
                    //採購
                    tmount();
                    //採購量(M)
                    fmount();
                    //採購量(KG)
                    if($('#txtProductno_'+i).val().length!=0){
                        t_where = "where=^^ noa='"+$('#txtProductno_'+i).val()+"' ^^";
                        q_gt('ucc', t_where, 0, 0, 0, "", r_accy);
                    }
				}		
			}
			
			//採購
			function tmount() {
			    for (var i=0; i<q_bbsCount; i++){
			        var t_t1,t_t2;
			        if(dec($('#txtSafemount_' + i).val())<dec($('#textM6_' + i).val())){
                        t_t1='急';
                    }else if(dec($('#textM4_' + i).val())>0 && dec($('#textM9_' + i).val())>0){
                        t_t1='再';
                    }else if(dec($('#textM10_' + i).val())==1 && dec($('#txtSafemount_' + i).val())<dec($('#txtNetmount_' + i).val())){
                        t_t1='可';
                    }else if(dec($('#txtSchmount_' + i).val())>0){
                        t_t1='@';
                    }else{
                        t_t1='';
                    }
                    if(dec($('#textM13_' + i).val())>0 && dec($('#textM12_' + i).val())<dec($('#textM13_' + i).val())){
                        t_t2='少';
                    }else if($('#textM13_' + i).val()=='' && (q_div(dec($('#textM12_' + i).val()),dec($('#textM11_' + i).val()))<q_div(dec($('#textM15_' + 0).val().replace('%','')),100))){
                        t_t2='少';
                    }else{
                        t_t2='';
                    }
                    $('#txtFdate_' + i).val(t_t1+t_t2);
			    }
			}

            function fmount() {
                for (var i=0; i<q_bbsCount; i++){
                    var t_mount1=q_div(q_mul(dec($('#textM9_' + i).val()),dec($('#textM11_' + i).val())),30);
                    var t_mount2=0;
                    if($('#textM13_' + i).val()!='' && dec($('#textM12_' + i).val())<dec($('#textM13_' + i).val())){
                        t_mount2=q_sub(dec($('#textM13_' + i).val()),dec($('#textM12_' + i).val()));
                    }else{
                        t_mount2=0;
                    }
                    $('#txtMount_' + i).val(q_add(t_mount1,t_mount2));
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
                    $('#textM1_' + j).change(function() {
                            sum();
                    });
                    $('#textM14_' + j).change(function() {
                            sum();
                    });
                    $('#textM3_' + j).change(function() {
                            sum();
                    });
                    $('#textM4_' + j).change(function() {
                            sum();
                    });
                    $('#textM6_' + j).change(function() {
                            sum();
                    });
                    $('#txtSafemount_' + j).change(function() {
                            sum();
                    });
                    $('#txtNetmount_' + j).change(function() {
                            sum();
                    });
                    $('#textM9_' + j).change(function() {
                            sum();
                    });
                    $('#txtSchmount_' + j).change(function() {
                            sum();
                    });
                    $('#textM10_' + j).change(function() {
                            sum();
                    });
                    $('#textM11_' + j).change(function() {
                            sum();
                    });
                    $('#textM12_' + j).change(function() {
                            sum();
                    });
                    $('#textM13_' + j).change(function() {
                            sum();
                    });
                    $('#textM15_' + j).change(function() {
                            sum();
                    });
                    $('#textU1_' + j).change(function() {
                            sum();
                    });
                    $('#textU2_' + j).change(function() {
                            sum();
                    });
                    $('#textU3_' + j).change(function() {
                            sum();
                    });
                    $('#textU4_' + j).change(function() {
                            sum();
                    });
                    $('#textU5_' + j).change(function() {
                            sum();
                    });
                    $('#textU6_' + j).change(function() {
                            sum();
                    });
				}				
				_bbsAssign();

			}			
			
			function btnIns() {
				_btnIns();
				$('#txtWorkgno').change(function() {
                    if($('#txtWorkgno').val().length!=0){
                        t_where = "where=^^ noa='"+$('#txtWorkgno').val()+"' ^^";
                        q_gt('modfixc', t_where, 0, 0, 0, "", r_accy);
                    }
                });
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				refreshBbs();
				
				
			}
			function btnModi() {			
				_btnModi();
				refreshBbs();
				showS19();
			}
			function btnPrint() {
				//q_box('z_orda_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
			    if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
				q_nowf();
				return true;
			}
			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				showS19();
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
				width: 500px;
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
                        <td><span> </span><a id='lblSignno_uj' class="lbl">採購參數單號</a></td>
                        <td><input id="txtWorkgno"  type="text"  class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker"  type="text"  class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="3" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="4"> </textarea></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2250px;">
				<tr style='color:white; background:#003366;' >
					    <td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					    <td align="center" style="width:180px;"><a id='lblProductno' >品名</a></td>
                        <td align="center" style="width:80px;"><a id='lblM1_uj'>總庫存賣(天)</a></td>
                        <td align="center" style="width:80px;display: none;"><a id='lblM14_uj'>本月月均(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM2_uj'>總庫小計(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM3_uj'>已採未交(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM4_uj'>已採未交(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM5_uj'>總庫存(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM6_uj'>採購點(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM7_uj'>總庫存(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM8_uj'>滿足點(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblSchmount_uj'>距離必採倒數(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM9_uj'>應採購量(天)</a></td>
                        <td align="center" style="width:60px;"><a id='lblFdate_uj'>採購</a></td>
                        <td align="center" style="width:80px;"><a id='lblMount_uj'>採購量(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblGmount_uj'>採購量(KG)</a></td>
                        <td align="center" style="width:40px;"><a id='lblM10_uj'>可採</a></td>
                        <td align="center" style="width:80px;"><a id='lblM11_uj'>未來月均(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM12_uj'>可動用皮料庫存(M)</a></td>
                        <td align="center" style="width:80px;"><a id='lblM13_uj'>可動用皮料提醒量(M)</a></td>
                        <td align="center" style="width:80px;display: none;"><a id='lblM15_uj'>安全庫存</a></td>
                        <td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
                        <td align="center" style="width:80px;"><a id='lblU1_uj'>成品(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblU2_uj'>再製品(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblU3_uj'>半成品(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblU4_uj'>可備料(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblU5_uj'>皮庫存(天)</a></td>
                        <td align="center" style="width:80px;"><a id='lblU6_uj'>訂單式耗用(天)</a></td>
				</tr>
				<tr style='background:#cad3ff;' class="ishide.*">
    					<td align="center">
    						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
    						<input id="txtNoq.*" type="text" style="display: none;" />
    					</td>
					    <td><input id="txtProductno.*" type="text" class="txt c1" style="width:97%;"/>
                            <input id="txtProduct.*" type="text" class="txt c1" style="width:80%;"/>
                            <input id="txtApvmemo.*" type="text" class="txt c1" style="display: none;"/>
                            <input class="btn" id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" />
                        </td>
                        <td><input id="textM1.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td style="display: none"><input id="textM14.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM2.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM3.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM4.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM5.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM6.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtSafemount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtNetmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtSchmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM9.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtFdate.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="txtMount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtGmount.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM10.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM11.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM12.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textM13.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td style="display: none"><input id="textM15.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="txtMemo.*" type="text" class="txt c1" style="width:97%;"/></td>
                        <td><input id="textU1.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textU2.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textU3.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textU4.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textU5.*" type="text" class="num c1" style="width:97%;"/></td>
                        <td><input id="textU6.*" type="text" class="num c1" style="width:97%;"/></td>	
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
