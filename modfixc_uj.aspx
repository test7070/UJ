
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
			var q_name = "modfixc";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtBebottom', 10, 0, 1],['txtMount', 10, 0, 1],['txtWeight', 10, 0, 1],['txtFixmount', 10, 0, 1],['txtBottom', 10, 0, 1],['txtLoss', 10, 0, 1],['txtBebottom', 10, 0, 1],['txtBrepair', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
					
			aPop = new Array(
			    ['txtProductno_', 'btnProduct_', 'ucc', 'noa,days,product', 'txtProductno_,txtFixmount_,txtProduct_', 'ucc_b.aspx']
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
				document.title='採購參數作業'
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
				
				$('#txtMech2').change(function() {
                    sum();
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
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modfixc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modfixc_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function sum() {		
				for (var i=0; i<q_bbsCount; i++){
				    //別
				    $('#txtFrame_'+i).val($('#txtProductno_'+i).val().substr(2,1));
				    //本月月均
				    if($('#textBtime3_'+i).val().length>0){
				        $('#txtMount_'+i).val(dec($('#textBtime3_'+i).val()));
				    }else{
				        tmount();
				    }
				    //未來月均
				    if($('#textEtime2_'+i).val().length>0){
                        $('#txtWeight_'+i).val(dec($('#textEtime2_'+i).val()));
                    }else{
                        fmount();
                    }
                    //採購點(天)=採購交期天數*安全存量+採購交期天數
                    $('#txtBottom_' + i).val(round(q_add(q_mul(dec($('#txtFixmount_' + i).val()),q_div(dec($('#txtEtime_' +i).val().replace('%','')),100)),dec($('#txtFixmount_' + i).val())),0));
                    //滿足點=若採購週期>0，採購週期(天)+可採，不然採購交期天數+採購點(天)
                    if(dec($('#txtLoss_'+i).val())>0){
                         $('#txtBrepair_'+i).val(round(q_add($('#txtLoss_'+i).val(),$('#txtBottom_'+i).val())));
                    }else{
                         $('#txtBrepair_'+i).val(round(q_add($('#txtFixmount_'+i).val(),$('#txtBottom_'+i).val()),0));
                    }
				}		
			}
			
			//本月月均
			function tmount() {
			    var t_mon=($('#txtMech2').val());
                for (var i=0; i<q_bbsCount; i++){
                    if($('#textBtime3_'+i).val().length==0){
                        if($('#txtBtime2_'+i).val()=='B'){
                            if(t_mon=='2'){
                                $('#txtMount_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else if(t_mon=='9'){
                                $('#txtMount_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),1.2),0));
                            }else{
                                $('#txtMount_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            }  
                        }else if($('#txtBtime2_'+i).val()=='C'){
                            if(t_mon=='2'){
                                $('#txtMount_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else if(t_mon=='10' || t_mon=='11' || t_mon=='12'){
                                $('#txtMount_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),1.2),0));
                            }else{
                                $('#txtMount_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            } 
                        }else{
                            if(t_mon=='2'){
                                $('#txtMount_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else{
                                $('#txtMount_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            }
                        }
                    }else{
                        $('#txtMount_'+i).val($('#txtMount_'+i).val());
                    }
                }
			}
			
			//未來月均
            function fmount() {
                for (var i=0; i<q_bbsCount; i++){
                    var t_mon=($('#txtBtime_'+i).val());
                    if($('#textEtime2_'+i).val().length==0){
                        if($('#txtBtime2_'+i).val()=='B'){
                            if(t_mon=='2'){
                                $('#txtWeight_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else if(t_mon=='9'){
                                $('#txtWeight_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),1.2),0));
                            }else{
                                $('#txtWeight_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            }  
                        }else if($('#txtBtime2_'+i).val()=='C'){
                            if(t_mon=='2'){
                                $('#txtWeight_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else if(t_mon=='10' || t_mon=='11' || t_mon=='12'){
                                $('#txtWeight_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),1.2),0));
                            }else{
                                $('#txtWeight_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            } 
                        }else if($('#txtBtime2_'+i).val()=='-' || $('#txtBtime2_'+i).val()=='X'){
                            $('#txtWeight_'+i).val($('#txtBebottom_'+i).val());
                        }else{
                            if(t_mon=='2'){
                                $('#txtWeight_'+i).val(round(q_mul(dec($('#txtBebottom_'+i).val()),0.8),0));
                            }else{
                                $('#txtWeight_'+i).val(q_mul(dec($('#txtBebottom_'+i).val()),1));
                            }
                        }
                    }else{
                        $('#txtWeight_'+i).val($('#txtWeight_'+i).val());
                    }
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
                    
                    $('#txtBebottom_' + j).change(function() {
                            sum();
                    });
                    
                    $('#textBtime3_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtBtime2_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtBtime_' + j).change(function() {
                            sum();
                    });
                    
                    $('#textEtime2_' + j).change(function() {
                            sum();
                    });
					
					$('#txtEtime_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtFixmount_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtErepair_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtLoss_' + j).change(function() {
                            sum();
                    });
                    
                    $('#txtMount_' + j).change(function() {
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
				//q_box('z_modfixc_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
				as['datea'] = abbm2['datea'];
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
				width: 700px;
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
						<td align="center" style="width:80px; color:black;"><a id='vewNoa_uj'>電腦編號</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea_uj'>月份</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="datea" style="text-align: center;">~datea</td>
						
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>	
						<td><span> </span><a id='lblNoa_uj' class="lbl " >電腦編號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>						
						<td><span> </span><a id='lblDatea_uj' class="lbl">日期</a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1" /></td>
						<td><span> </span><a id='lblMech2_uj' class="lbl">月份</a></td>
                        <td><input id="txtMech2"  type="text"  class="txt c1" /></td>
					</tr>
					<tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker"  type="text"  class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:1300px;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:30px;"><a id='lblFrame_uj' >別</a></td>
					<td align="center" style="width:170px;"><a id='lblProductno' >料號</a></td>
					<td align="center" style="width:90px;"><a id='lblBebottom' >原月均(M)</a></td>
					<td align="center" style="width:90px;"><a id='lblEnbottom' >手調月均(M)</a></td>
					<td align="center" style="width:90px;"><a id='lblMount_uj' >本月月均(M)</a></td>
					<td align="center" style="width:40px;"><a id='lblBtime' >購買月份</a></td>
					<td align="center" style="width:90px;"><a id='lblEtime2' >手調未來月均(M)</a></td>
					<td align="center" style="width:90px;"><a id='lblWeight_uj' >未來月均(M)</a></td>
					<td align="center" style="width:65px;"><a id='lblEtime' >安全庫存</a></td>
					<td align="center" style="width:60px;"><a id='lblFixmount' >採購交期天數</a></td>
					<td align="center" style="width:60px;"><a id='lblBottom' >採購點(天)</a></td>
					<td align="center" style="width:40px;"><a id='lblBtime2' >管理類別</a></td>
					<td align="center" style="width:40px;"><a id='lblErepair' >可採</a></td>
					<td align="center" style="width:60px;"><a id='lblLoss' >採購週期(天)</a></td>
					<td align="center" style="width:60px;"><a id='lblBrepair' >滿足點</a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;' class="ishide.*">
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtFrame.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1" style="width:80%;"/>
					    <input id="txtProduct.*" type="text" class="txt c1" style="display: none"/>
					    <input class="btn" id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" />
					</td>
					<td><input id="txtBebottom.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="textBtime3.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtMount.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtBtime.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="textEtime2.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtWeight.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtEtime.*" type="text" class="num txt c1" style="width:97%;"/></td>
					<td><input id="txtFixmount.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtBottom.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtBtime2.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtErepair.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtLoss.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtBrepair.*" type="text" class="num c1" style="width:97%;"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1" style="width:97%;"/></td>	
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
