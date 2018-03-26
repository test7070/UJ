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

            q_desc = 1;
            q_tables = 's';
            var q_name = "cud";
            var q_readonly = ['txtNoa','txtDatea','txtCust','txtCustno','txtWorker','txtWorker2'];
            var q_readonlys = ['txtOrdeno','txtProductno','txtSpec'];
            var bbmNum = [];
            var bbsNum = [['txtMount1', 1, 0, 1],['txtMount2', 1, 0, 1]
            ,['txtMount3', 1, 0, 1],['txtMount4', 1, 0, 1],['txtMount5', 1, 0, 1],['txtMount6', 1, 0, 1]
            ,['txtMount7', 1, 0, 1],['txtMount8', 1, 0, 1],['txtMount9', 1, 0, 1],['txtMount10', 1, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 3; 
                       
            aPop = new Array(
            	
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
            	if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [];
                q_getFormat();
                q_mask(bbmMask);
                
                document.title='上皮/上紙/製造生產日報表'; 
                
                $('#btnIns').hide();
                $('#btnDele').hide();
                
                $('#btnEnda').click(function() {
                	//完工後"鎖住"：不能"修改""不能"印標籤"
                	//產出入庫單和領料單
                	//回寫製造排程單的產出,產出率%,完成狀態
                	if($('#txtEdime').val()!='1'){
	                	var t_noa=$('#txtNoa').val();
	                	var t_ordeno=$('#txtOrdeno').val();
	                	if(t_noa.length>0 && t_ordeno.length>0){
	                		q_func('qtxt.query.cudenda', 'orde_uj.txt,cudenda,' + encodeURI(t_ordeno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								for(var i=0;i<as.length;i++){
									if(as[i].noa==t_noa){
										$('#txtEdime').val(as[i].edime);
										abbm[q_recno]["edime"]=as[i].edime;
										alert('完工成功!!');
										break;
									}
								}
							}else{
								alert('完工失敗，找不到相關派工單的日報表!!');
							}
	                	}
                	}else{
                		alert('已完工過，禁止重覆完工!!');
                	}
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
                t_err = q_chkEmpField([['txtNoa', '單據編號'],['txtDatea', '日期']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                for (var i = 0; i < q_bbsCount; i++) {
					var ts1=$('#textF01_'+i).val();
					var ts2=$('#textF02_'+i).val();
					var ts3=$('#textF03_'+i).val();
					var ts4=$('#textF04_'+i).val();
					var ts5=$('#textF05_'+i).val();
					var ts6=$('#textF06_'+i).val();
					var ts7=$('#textF07_'+i).val();
					var ts8=$('#textF08_'+i).val();
					var ts9=$('#textF09_'+i).val();
					//合併儲存
					var tstr="@,#"+ts1+"@,#"+ts2+"@,#"+ts3+"@,#"+ts4+"@,#"+ts5+"@,#"+ts6+"@,#"+ts7+"@,#"+ts8+"@,#"+ts9;
					
					$('#txtMemo_'+i).val(tstr);
				}
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
								
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cug') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            
            function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtMemo_'+i).val().split('@,#');
					$('#textF01_'+i).val(tstr[1]);
					$('#textF02_'+i).val(tstr[2]);
					$('#textF03_'+i).val(tstr[3]);
					$('#textF04_'+i).val(tstr[4]);
					$('#textF05_'+i).val(tstr[5]);
					$('#textF06_'+i).val(tstr[6]);
					$('#textF07_'+i).val(tstr[7]);
					$('#textF08_'+i).val(tstr[8]);
					$('#textF09_'+i).val(tstr[9]);
				}
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cud_uj_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                change_field();
            }

            function btnModi() {
            	if($('#txtEdime').val()=='1'){
            		alert('已完工,禁止修改!!');
            		return;
            	}
            	
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                change_field();
            }

            function btnPrint() {
                q_box('z_cudp_uj.aspx' + "?;;;noa=" + trim($('#txtOrdeno').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
                	$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
		                $('#txtNos_' + i).blur(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						for (var j = 1; j < 10; j++) {
							$('#txtMount'+j+'_'+i).change(function() {
								if(dec($(this).val())==0){
									$(this).val('');
								}else{
									$(this).val(1);
								}
							});
						}
						
						$('btnPrint_'+i).click(function() {
							if($('#txtEdime').val()=='1'){
			            		alert('已完工,禁止列印!!');
			            		return;
			            	}
						});
					}
                }
                _bbsAssign();
                change_field ();
                splitbbsf();
            }

            function bbsSave(as) {
                if (!as['productno']) {//不存檔條件
                    as[bbsKey[1]] = '';
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
            	$('#btnEnda').hide();
				if($('#txtStyle').val()=='5'){ //皮
					$('.M3').hide();
					$('.M4').hide();
					$('.M5').show();
					$('#lblProduct2_uj_s').html('投入<BR>身分證號碼');
					$('#lblProductno2_uj_s').text('投入');
					$('#lblLengthb_uj_s').text('投入(M)');
					$('#lblWeight_uj_s').text('產出(M)');
					$('#lblWeight1_uj_s').text('產出(%)');
					$('#lblWeight2_uj_s').text('退料(M)');
					$('#lblF01_uj_s').text('退料別');
					$('#lblF02_uj_s').text('備註');
					$('#lblPrint_uj_s').text('印標籤');
					$('#lblMount1_uj_s').text('外觀');
					$('#lblMount2_uj_s').text('色差');
					$('#lblMount3_uj_s').text('寬幅');
					$('#lblMount4_uj_s').text('出油');
					$('#lblMount5_uj_s').text('變形');
					$('#lblMount6_uj_s').text('管底');
					$('#lblMount7_uj_s').text('異常單');
					$('#lblMount8_uj_s').text('留樣');
					$('.dbbs').css('width','1320px');
				} else if($('#txtStyle').val()=='4'){ //紙
					$('.M3').hide();
					$('.M5').hide();
					$('.M4').show();
					$('#lblProduct2_uj_s').text('身分證號碼');
					$('#lblProductno2_uj_s').text('上紙段投入');
					$('#lblLengthb_uj_s').text('投入(M)');
					$('#lblWeight_uj_s').text('產出(M)');
					$('#lblWeight1_uj_s').text('產出(%)');
					$('#lblWeight2_uj_s').text('餘料(M)');
					$('#lblF01_uj_s').text('餘料判定');
					$('#lblF02_uj_s').text('備註');
					$('#lblF03_uj_s').text('長度落差');
					$('#lblPrint_uj_s').text('印標籤');
					$('#lblMount1_uj_s').text('寬幅');
					$('#lblMount2_uj_s').text('印刷');
					$('#lblMount3_uj_s').text('跑捲');
					$('#lblMount4_uj_s').text('外觀破');
					$('#lblMount5_uj_s').text('荷葉邊');
					$('#lblMount6_uj_s').text('管變形');
					$('#lblMount7_uj_s').text('異常單');
					$('#lblMount8_uj_s').text('留樣');
					$('.dbbs').css('width','1400px');
				}else{ //下料
					$('.M4').hide();
					$('.M5').hide();
					$('.M3').show();
					
					$('#lblOrdeno_uj_s').text('派工單');
					$('#lblUno_uj_s').text('產出身分證號碼');
					$('#lblProductno_uj_s').text('產出料號');
					$('#lblWeight_uj_s').text('產出(M)');
					$('#lblWeight2_uj_s').text('讓長(M)');
					$('#lblF04_uj_s').text('上皮段料號');
					$('#lblF05_uj_s').text('上皮段身分證號');
					$('#lblF06_uj_s').text('上紙段料號');
					$('#lblF07_uj_s').text('上紙段身分證號');
					$('#lblF08_uj_s').text('膠號');
					$('#lblF09_uj_s').text('膠身分證號');
					$('#lblSpec_uj_s').text('列管備註');
					$('#lblF01_uj_s').text('製造列管');
					$('#lblF02_uj_s').text('備註');
					$('#lblF03_uj_s').text('印標籤');
					
					$('#lblMount1_uj_s').html('皮面<BR>出油');
					$('#lblMount2_uj_s').text('離不開');
					$('#lblMount3_uj_s').text('離型卡');
					$('#lblMount4_uj_s').html('膠面<BR>顆粒');
					$('#lblMount5_uj_s').text('膠線');
					$('#lblMount6_uj_s').html('膠面<BR>無膠');
					$('#lblMount7_uj_s').text('含水率');
					$('#lblMount8_uj_s').text('膠寬/動');
					$('#lblMount9_uj_s').text('膠線/動');
					$('#lblMount10_uj_s').text('異常單');
					
					$('.dbbs').css('width','2360px');
					
					$('#btnEnda').show();
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					if($('#chkEnda_'+i).prop('checked')){
						$('#trSel_'+i).show();
					}else{
						$('#trSel_'+i).hide();
					}
					
				}
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
            	if($('#txtEdime').val()=='1'){
            		alert('已完工,禁止刪除!!');
            		return;
            	}
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
		   function q_funcPost(t_func, result) {
                switch(t_func) {
                	
                }
			}
			
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1260px;
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
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 685px;
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
                width: 48%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 100%;
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
                width: 1700px;
                background:#cad3ff;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs tr.chkIssel { background:bisque;} 
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
						<td align="center" style="width:30%"><a id='vewDatea_uj'>日期</a></td>
						<td align="center" style="width:30%"><a id='vewCust_uj'>製程</a></td>
						<td align="center" style="width:30%"><a id='vewCustno_uj'>機台</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='cust'>~cust</td>
						<td align="center" id='custno'>~custno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td style="width: 105px;"><span> </span><a id='lblDatea_uj' class="lbl">日期</a></td>
						<td style="width: 175px;"><input id="txtDatea" type="text" class="txt c1"/>
							<input id="txtNoa" type="text" class="txt c1" style="display: none;"/>
							<input id="txtEdime" type="text" class="txt c1" style="display: none;"/>
							<input id="txtOrdeno" type="hidden"/>
						</td>
						<td style="width: 105px;"><span> </span><a id='lblStyle_uj' class="lbl">製程</a></td>
						<td style="width: 175px;">
							<input id="txtStyle" type="text" class="txt c1" style="display: none;"/>
							<input id="txtCust" type="text" class="txt c1"/>
						</td>
						<td style="width: 105px;"><span> </span><a id='lblCustno_uj' class="lbl">機台</a></td>
						<td style="width: 175px;"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td style="width: 20px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input id="btnEnda" type="button" value="總完工" style="display: none;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<!--匯入做排序不提供刪除和新增-->
					<td align="center" style="width:85px;display: none;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:20px;">No</td>
					<td align="center" style="width:120px;" class="M3"><a id='lblOrdeno_uj_s'> </a></td>
					<td align="center" style="width:120px;" class="M3"><a id='lblUno_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M3"><a id='lblProductno_uj_s'> </a></td>
					<td align="center" style="width:120px;" class="M5 M4"><a id='lblProduct2_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M5 M4"><a id='lblProductno2_uj_s'> </a></td>
					<td align="center" style="width:80px;" class="M5 M4"><a id='lblLengthb_uj_s'> </a></td>
					<td align="center" style="width:80px;" class="M5 M4 M3"><a id='lblWeight_uj_s'> </a></td>
					<td align="center" style="width:80px;" class="M5 M4"><a id='lblWeight1_uj_s'> </a></td>
					<td align="center" style="width:80px;" class="M5 M4 M3"><a id='lblWeight2_uj_s'> </a></td>
					
					<td align="center" style="width:150px;" class="M3"><a id='lblF04_uj_s'> </a></td>
					<td align="center" style="width:120px;" class="M3"><a id='lblF05_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M3"><a id='lblF08_uj_s'> </a></td>
					<td align="center" style="width:120px;" class="M3"><a id='lblF09_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M3"><a id='lblF06_uj_s'> </a></td>
					<td align="center" style="width:120px;" class="M3"><a id='lblF07_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M3"><a id='lblSpec_uj_s'> </a></td>
					
					<td align="center" style="width:120px;" class="M5 M4 M3"><a id='lblF01_uj_s'> </a></td>
					<td align="center" style="width:150px;" class="M5 M4 M3"><a id='lblF02_uj_s'> </a></td>
					<td align="center" style="width:80px;" class="M4 M3"><a id='lblF03_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4"><a id='lblPrint_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount1_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount2_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount3_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount4_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount5_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount6_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount7_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M5 M4 M3"><a id='lblMount8_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M3"><a id='lblMount9_uj_s'> </a></td>
					<td align="center" style="width:50px;" class="M3"><a id='lblMount10_uj_s'> </a></td>
					
				</tr>
				<tr id="trSel.*">
					<td align="center" style="display: none;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; display: none;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtMechno.*" type="hidden" class="txt c1"/>
						<input id="txtMemo.*" type="hidden" class="txt c1"/>
						<input id="txtSource.*" type="hidden" class="txt c1"/>
						<input id="txtNo2.*" type="hidden" class="txt c1"/>
						<input id="chkEnda.*" type="checkbox" style="display: none;" /> <!--結案的才顯示-->
					</td>
					<td class="M3"><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="txtUno.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td class="M5 M4"><input id="txtProduct2.*" type="text" class="txt c1"/></td>
					<td class="M5 M4"><input id="txtProductno2.*" type="text" class="txt c1"/></td>
					<td class="M5 M4"><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4"><input id="txtWeight1.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtWeight2.*" type="text" class="txt num c1"/></td>
					
					<td class="M3"><input id="textF04.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF05.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF08.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF09.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF06.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF07.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="txtSpec.*" type="text" class="txt c1"/></td>
					
					<td class="M5 M4 M3"><input id="textF01.*" type="text" class="txt c1"/></td>
					<td class="M5 M4 M3"><input id="textF02.*" type="text" class="txt c1"/></td>
					<td class="M4 M3"><input id="textF03.*" type="text" class="txt c1"/></td>
					<td class="M5 M4" style="text-align: center;"><input id="btnPrint.*" type="button" value="印"/></td>
					<td class="M5 M4 M3"><input id="txtMount1.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount2.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount3.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount4.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount5.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount6.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount7.*" type="text" class="txt num c1"/></td>
					<td class="M5 M4 M3"><input id="txtMount8.*" type="text" class="txt num c1"/></td>
					<td class="M3"><input id="txtMount9.*" type="text" class="txt num c1"/></td>
					<td class="M3"><input id="txtMount10.*" type="text" class="txt num c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
