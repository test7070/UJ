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
            var q_name = "cug";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtHours','txtSmount','txtKdate'];
            var q_readonlys = ['txtOrdeno','textF01','txtProductno','txtThours','txtDhours','textF02','txtMount'
            				,'textF03','textF04','textF05','textF06','textF07','textF08','textF09','textF10'
            				,'textF11','textF12','textF13','textF14'];
            var bbmNum = [['txtSmount', 15, 0, 1],['txtHours', 10, 2, 1]];
            var bbsNum = [['txtMount', 10, 0, 1],['txtHours', 10, 2, 1],['txtThours', 10, 0, 1],['txtDhours', 10, 0, 1],['txtNos', 4, 0, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';            
            
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
                bbmMask = [['txtDatea', r_picd],['txtKdate', r_picd]];
                bbsMask = [];
                q_getFormat();
                q_mask(bbmMask);
                
                document.title='加工/製造派工單';
                
                q_cmbParse("cmbBdate", '加工,製造');	
                
                $('#cmbBdate').change(function() {
                	change_field();
                	for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_'+i).click();
					}
					$('#txtProcessno').val('');
				});
				
				$('#combProcessno').change(function() {
					if(q_cur==1|| q_cur==2){
						$('#txtProcessno').val($(this).val());
					}
				});
				
				$('#btnWorkg_uj').click(function() {
					if(q_cur==1 || q_cur==2){
						var t_datea=$('#txtDatea').val();
						var t_processno=$('#txtProcessno').val();
						
						if(emp(t_datea)){
							alert('請輸入日期!!');
							return;
						}
						if(emp(t_processno)){
							alert('請選擇機台!!');
							return;
						}
						if($('#cmbBdate').val()=='加工'){
							q_func('qtxt.query.workgimport1', 'orde_uj.txt,workgimport1,' + encodeURI(t_datea)+';'+encodeURI(t_processno),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							
							if (as[0] != undefined) {
								//刪除已存在的表身的資料
								for (var i = 0; i < as.length; i++) {
									for (var j = 0; j < q_bbsCount; j++) {
										if(as[i].workgno==$('#txtWorkgno_'+j).val()){
											as.splice(i, 1);
											i--;
											break;
										}
									}
								}
								if(as.length==0){
									alert('資料已存在表身!!');
								}
								
								var t_j=0;
								for (var i = 0; i < as.length; i++) {
									var t_iswrite=false;
									for (var j = t_j; j < q_bbsCount; j++) {
										if(emp($('#txtProductno_'+j).val()) && emp($('#txtWorkgno_'+j).val())){
											$('#txtWorkgno_'+j).val(as[i].workgno);
											$('#txtHours_'+j).val(as[i].hours);
											$('#txtOrdeno_'+j).val(as[i].ordeno);
											//$('#textF01_'+j).val(as[i].f01);
											$('#txtProductno_'+j).val(as[i].productno);
											$('#txtThours_'+j).val(as[i].thours);
											$('#txtDhours_'+j).val(as[i].dhours);
											$('#textF02_'+j).val(as[i].f02);
											$('#txtMount_'+j).val(as[i].mount);
											$('#textF03_'+j).val(as[i].f03);
											$('#textF04_'+j).val(as[i].f04);
											$('#textF05_'+j).val(as[i].f05);
											$('#textF14_'+j).val(as[i].f14);
											
											//合併儲存
											var tstr='';
											for (var k = 0; k < fbbs.length; k++) {
												if(fbbs[k].substr(0,4)=='text'){
													tstr+="@,#"+$('#'+fbbs[k]+'_'+j).val();
												}
											}
											$('#txtMemo_'+j).val(tstr);
											
											t_iswrite=true;
											t_j=j;
											break;
										}
									}
									if(!t_iswrite){
										i--;
										//t_j--;
										$('#btnPlus').click();
									}
								}
							}else{
								alert('無資料!!');
							}
						}
						if($('#cmbBdate').val()=='製造'){
							q_func('qtxt.query.workgimport2', 'orde_uj.txt,workgimport2,' + encodeURI(t_datea)+';'+encodeURI(t_processno),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							
							if (as[0] != undefined) {
								//刪除已存在的表身的資料
								for (var i = 0; i < as.length; i++) {
									for (var j = 0; j < q_bbsCount; j++) {
										if(as[i].workgno==$('#txtWorkgno_'+j).val()){
											as.splice(i, 1);
											i--;
											break;
										}
									}
								}
								if(as.length==0){
									alert('資料已存在表身!!');
								}
								
								var t_j=0;
								for (var i = 0; i < as.length; i++) {
									var t_iswrite=false;
									for (var j = t_j; j < q_bbsCount; j++) {
										if(emp($('#txtProductno_'+j).val()) && emp($('#txtWorkgno_'+j).val())){
											$('#txtWorkgno_'+j).val(as[i].workgno);
											$('#txtHours_'+j).val(as[i].hours);
											$('#txtProductno_'+j).val(as[i].productno);
											$('#txtThours_'+j).val(as[i].thours);
											$('#txtMount_'+j).val(as[i].mount);
											$('#textF06_'+j).val(as[i].f06);
											$('#textF07_'+j).val(as[i].f07);
											$('#textF08_'+j).val(as[i].f08);
											$('#textF09_'+j).val(as[i].f09);
											$('#textF10_'+j).val(as[i].f10);
											$('#textF11_'+j).val(as[i].f11);
											$('#textF12_'+j).val(as[i].f12);
											$('#textF13_'+j).val(as[i].f13);
											$('#textF14_'+j).val(as[i].f14);
											
											//合併儲存
											var tstr='';
											for (var k = 0; k < fbbs.length; k++) {
												if(fbbs[k].substr(0,4)=='text'){
													tstr+="@,#"+$('#'+fbbs[k]+'_'+j).val();
												}
											}
											$('#txtMemo_'+j).val(tstr);
											
											t_iswrite=true;
											t_j=j;
											break;
										}
									}
									if(!t_iswrite){
										i--;
										t_j--;
										$('#btnPlus').click();
									}
								}
							}else{
								alert('無資料!!');
							}
						}
						
						sum();
					}
				});
				
				$('#btnCugt2_uj').click(function() {
					var t_noa=$('#txtNoa').val();
					q_box("cugt_uj.aspx?;;;noa='" + t_noa + "' and stationno='2'", 'cugt2', "98%", "95%", "加工半成品備料單");
				});
				$('#btnCugt3_uj').click(function() {
					var t_noa=$('#txtNoa').val();
					q_box("cugt_uj.aspx?;;;noa='" + t_noa + "' and stationno='3'", 'cugt3', "98%", "95%", "加工再製品備料單");
				});
				$('#btnCugt6_uj').click(function() {
					var t_noa=$('#txtNoa').val();
					q_box("cugt_uj.aspx?;;;noa='" + t_noa + "' and stationno='6'", 'cugt6', "98%", "95%", "加工物料備料單");
				});
				$('#btnCugt5_uj').click(function() {
					var t_noa=$('#txtNoa').val();
					q_box("cugt_uj.aspx?;;;noa='" + t_noa + "' and stationno='5'", 'cugt5', "98%", "95%", "製造(皮料)備料單");
				});
				$('#btnCugt4_uj').click(function() {
					var t_noa=$('#txtNoa').val();
					q_box("cugt_uj.aspx?;;;noa='" + t_noa + "' and stationno='4'", 'cugt4', "98%", "95%", "製造(離型紙)備料單");
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
				
				//產生cugt
				var t_noa=$('#txtNoa').val();
				q_func('qtxt.query.cugt_uj', 'orde_uj.txt,cugt_uj,' + encodeURI(t_noa)+';'+encodeURI(r_accy),r_accy,1);
				var as = _q_appendData("tmp0", "", true, true);
				if (as[0] != undefined) {
					var t_count=0;
					for (var i = 0; i < as.length; i++) {
						t_count=q_add(t_count,dec(as[i].xcount));
					}
					if(t_count>0){
						if(q_cur==1){
							alert('成功產生備料單!!');
						}else{
							alert('重新產生備料單!!');
						}
					}else{
						alert('無備料單產生，請確認是否正常!!');
					}
				}
				
            }
			
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtProcessno', '機台'],['txtDatea', '日期']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                sum();
                
                //清除noq
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtNoq_'+i).val('');
                }
                
                //依nos寫入noq----------------------------------------------------
                var bbsnoqs=[];
                for (var i = 0; i < q_bbsCount; i++) {
                	bbsnoqs.push({
                		'noq':i,
                		'nos':emp($('#txtNos_'+i).val())?99999:dec($('#txtNos_'+i).val())
                	});
                }
                bbsnoqs.sort(function(a, b){
                	if (dec(a.nos) > dec(b.nos)) {return 1;} 
                	if (dec(a.nos) < dec(b.nos)) {return -1;}
                	if (dec(a.noq) > dec(b.noq)) {return 1;}
                	if (dec(a.noq) > dec(b.noq)) {return -1;}
                });
                
                for (var i = 0; i < bbsnoqs.length; i++) {
                	bbsnoqs[i].newnoq=(i+1);
                }
                bbsnoqs.sort(function(a, b){if (dec(a.noq) > dec(b.noq)) {return 1;}if (dec(a.noq) > dec(b.noq)) {return -1;}});
                
                var tn=bbsnoqs.length.toString().length;//noq長度
                if(tn<3){tn=3;}
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtNoq_'+i).val(('0000'+bbsnoqs[i].newnoq.toString()).slice(-1*tn));
                }
                //----------------------------------------------------------------
                
                for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr='';
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							tstr+="@,#"+$('#'+fbbs[j]+'_'+i).val();
						}
					}
					$('#txtMemo_'+i).val(tstr);
				}
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
				
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                t_date=replaceAll((t_date.length == 0 ? q_date() : t_date),'/','');
                t_date=t_date.slice(-6);
                var t_mech=trim($('#txtProcessno').val());

                if (q_cur==1)
                    wrServer(t_date+'-'+t_mech);
                else
                    wrServer(t_noa);
            }
            
            function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtMemo_'+i).val().split('@,#');
					var tstc=1;
					for (var j = 0; j < fbbs.length; j++) {
						if(fbbs[j].substr(0,4)=='text'){
							$('#'+fbbs[j]+'_'+i).val(tstr[tstc]);
							tstc++;
						}
					}
				}
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cug_uj_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtKdate').val(q_date());
                $('#txtDatea').val(q_cdn(q_date(),7));
                change_field();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                change_field();
            }

            function btnPrint() {
                q_box("z_cugp_uj.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
		                	//if(q_cur==1 || q_cur==2){}
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
				
				as['processno'] = abbm2['processno'];
                q_nowf();

                return true;
            }

            function sum() {
                var t1 = 0,t2=0;
                for (var j = 0; j < q_bbsCount; j++) {
					t1=q_add(t1,q_float('txtHours_'+j));
					t2=q_add(t2,q_float('txtMount_'+j));
                } // j
                $('#txtHours').val(t1);
                $('#txtSmount').val(t2);
            }

            function refresh(recno) {
                _refresh(recno);
                change_field();
            }
            
            function change_field () {
            	$('#combProcessno').text('');
                if($('#cmbBdate').val()=='加工'){
                	q_cmbParse("combProcessno", ',分1,分2,分3,分4,覆1,覆2,覆3,其他');	
                }else{
                	q_cmbParse("combProcessno", ',A,B');	
                }
            	
				if($('#cmbBdate').val()=='製造'){
					$('.M1').hide();
					$('.M3').show();
					$('.dbbs').css('width','1750px');
				}else{
					$('.M3').hide();
					$('.M1').show();
					$('.dbbs').css('width','1450px');
				}
			}

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para){
                	$('.btncugt').removeAttr('disabled');
                	$('#btnWorkg_uj').attr('disabled', 'disabled');
	            }else{
	            	$('.btncugt').attr('disabled', 'disabled');
	            	$('#btnWorkg_uj').removeAttr('disabled');
	            }
	            if(q_cur==1){
	            	$('#combProcessno').show();
	            }else{
	            	$('#combProcessno').hide();
	            	$('#txtDatea').attr('disabled', 'disabled');
	            	$('#cmbBdate').attr('disabled', 'disabled');
	            	$('#txtProcessno').attr('disabled', 'disabled');
	            }
	            
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
						<td align="center" style="width:20%"><a id='vewDatea_uj'>日期</a></td>
						<td align="center" style="width:20%"><a id='vewBdate_uj'>類別</a></td>
						<td align="center" style="width:15%"><a id='vewProcessno_uj'>機台</a></td>
						<td align="center" style="width:30%"><a id='vewNoa_uj'>派工單號</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='bdate'>~bdate</td>
						<td align="center" id='processno'>~processno</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td style="width: 105px;"><span> </span><a id='lblNoa_uj' class="lbl">派工單號</a></td>
						<td style="width: 175px;"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td style="width: 105px;"><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td style="width: 175px;"><input id="txtKdate" type="text" class="txt c1"/></td>
						<td style="width: 105px;"> </td>
						<td style="width: 20px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea_uj' class="lbl">日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><input id="chkIsset" type="checkbox" style="display: none;"/></td><!--表示完工-->
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate_uj' class="lbl">類別</a></td>
						<td><select id="cmbBdate" class="txt c1"> </select></td>
						<td><span> </span><a id='lblProcessno_uj' class="lbl">機台</a></td>
						<td>
							<input id="txtProcessno" type="text" class="txt c1" style="width: 50%;"/>
							<select id="combProcessno" style="widows: 20px;"> </select>
						</td>
						<td><input id="btnWorkg_uj" type="button" value="排程匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSmount_uj' class="lbl">總產出</a></td>
						<td><input id="txtSmount" type="text" class="txt num c1"/></td>
						<td ><span> </span><a id='lblHours_uj' class="lbl">總工時</a></td>
						<td><input id="txtHours" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3">
							<input id="btnCugt2_uj" type="button" class="M1 btncugt" style="display: none;" value="加工半成品備料單"/>
							<input id="btnCugt3_uj" type="button" class="btncugt" style="display: none;" value="加工再製品備料單"/>
							<input id="btnCugt6_uj" type="button" class="M1 btncugt" style="display: none;" value="加工物料備料單"/>
							<input id="btnCugt5_uj" type="button" class="M3 btncugt" style="display: none;" value="製造(皮料)備料單"/>
							<input id="btnCugt4_uj" type="button" class="M3 btncugt" style="display: none;" value="製造(離型紙)備料單"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<!--匯入做排序不提供刪除和新增-->
					<td align="center" style="width:85px;display: none;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:75px;"><a id='lblNos_uj_s'>排序</a></td>
					<td align="center" style="width:150px;" class="M1"><a id='lblOrdeno_uj_s'>訂單名稱</a></td>
					<td align="center" style="width:200px;display: none;"><a id='lblF01_s'>料號(原成品名)</a></td>
					<td align="center" style="width:200px;">
						<a id='lblProductno1_uj_s' class="M1">料號</a><!--新成品編碼-->
						<a id='lblProductno2_uj_s' class="M3">生產料號</a>
					</td>
					<td align="center" style="width:100px;">
						<a id='lblThours1_uj_s' class="M1">寬(mm)</a>
						<a id='lblThours2_uj_s' class="M3">有效寬(mm)</a>
					</td>
					<td align="center" style="width:100px;" class="M1"><a id='lblDhours_uj_s'>長(M)</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF02_s'>長度備註</a></td>
					<td align="center" style="width:100px;">
						<a id='lblMount1_uj_s' class="M1">數量</a>
						<a id='lblMount2_uj_s' class="M3">產出(M)</a>
					</td>
					
					<td align="center" style="width:100px;" class="M1"><a id='lblF03_uj_s'>成品指令</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF04_uj_s'>限定餘數</a></td>
					<td align="center" style="width:100px;" class="M1"><a id='lblF05_uj_s'>需求級別</a></td>
					
					<td align="center" style="width:175px;" class="M3"><a id='lblF06_uj_s'>上皮投入</a></td>
					<td align="center" style="width:100px;" class="M3"><a id='lblF07_uj_s'>指定(M)</a></td>
					<td align="center" style="width:100px;" class="M3"><a id='lblF08_uj_s'>上膠面</a></td>
					<td align="center" style="width:175px;" class="M3"><a id='lblF09_uj_s'>上紙投入</a></td>
					<td align="center" style="width:100px;" class="M3"><a id='lblF10_uj_s'>指定(M)</a></td>
					<td align="center" style="width:130px;" class="M3"><a id='lblF11_uj_s'>下料指令</a></td>
					<td align="center" style="width:130px;" class="M3"><a id='lblF12_uj_s'>列管備註</a></td>
					<td align="center" style="width:130px;" class="M3"><a id='lblF13_uj_s'>注意事項</a></td>
					
					<td align="center" style="width:200px;"><a id='lblF14_uj_s'>備註</a></td>
				</tr>
				<tr id="trSel.*">
					<td align="center" style="display: none;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; display: none;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtNos.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
						<input id="txtMemo.*" type="hidden" class="txt c1"/>
						<input id="txtWorkgno.*" type="hidden" class="txt c1"/>
						<input id="txtHours.*" type="hidden" class="txt c1"/>
					</td>
					<td class="M1"><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
					<td style="display: none;"><input id="textF01.*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td><input id="txtThours.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="txtDhours.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="textF02.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td class="M1"><input id="textF03.*" type="text" class="txt c1"/></td>
					<td class="M1"><input id="textF04.*" type="text" class="txt c1"/></td>
					<td class="M1"><input id="textF05.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF06.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF07.*" type="text" class="txt num c1"/></td>
					<td class="M3"><input id="textF08.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF09.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF10.*" type="text" class="txt num c1"/></td>
					<td class="M3"><input id="textF11.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF12.*" type="text" class="txt c1"/></td>
					<td class="M3"><input id="textF13.*" type="text" class="txt c1"/></td>
					<td><input id="textF14.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
