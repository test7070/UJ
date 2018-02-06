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
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
		<script type="text/javascript">
			var q_name = "cug_uj3";
			aPop = new Array();
			
			$(document).ready(function() {
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
			});
			
			function q_gfPost() {
				
				q_getFormat();
                q_langShow();
                q_popAssign();
                //$('#txtDatea').mask(r_picd);
                //$('#txtDatea').val(q_date());
				q_cmbParse('cmbMome1',',退良品,退不良品,歸0');
                q_cur=2;
                document.title='上皮作業';
                
                setInterval("shownowtime()",1000);
                
				//登出
				$('#logout').click(function() {
					q_logout(q_idr);
				});
				
				$('#btnDownimg').click(function() {
					html2canvas($("body"), {
						onrendered: function(canvas) {
							$('#Downimg').attr('href',canvas.toDataURL("image/jpeg"));
							var t_time=replaceAll(q_date(),'/','')+padL(new Date().getHours(), '0', 2)+padL(new Date().getMinutes(),'0',2)+padL(new Date().getSeconds(),'0',2);
							$('#Downimg').attr('download',t_time+'.jpeg') ;
							var lnk = document.getElementById("Downimg");
                    		lnk.click();
						}
					});
				});
				
				$('#btnInspection').click(function() {
					$('#table_cuds2').show();
				});
				
				$('#btnCancel2').click(function() {
					$('#table_cuds2').hide();
				});
				
				$('#txtNoa').change(function() {
					var t_noa=emp($(this).val())?'#non':$(this).val();
					q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_noa),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						if(as[0].bdate=='製造'){
							$('#txtDatea').val(as[0].datea);
							$('#txtMechno').val(as[0].processno);
							
							var tt_noq=as[0].edate;//現產序號
							var t_issel=false;
							q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' + encodeURI(t_noa)+';'+encodeURI('8')+';'+encodeURI('1')+';'+encodeURI('5'),r_accy,1);
							var das = _q_appendData("tmp0", "", true, true);
							if (das[0] != undefined) {
								for(var i=0;i<das.length;i++){
									$('#lblProductno_'+i).text(das[i].productno);
									$('#lblOrdeno_'+i).text(das[i].ordeno);
									$('#lblNo2_'+i).text(das[i].no2);
									
									if(tt_noq==das[i].no2 && !t_issel){
										$('#lblNowgen_'+i).text('→');
										t_issel=true;
									}else{
										$('#lblNowgen_'+i).text('');
									}
									
									$('#lblUno_'+i).text(das[i].uno);
									$('#lblTimes_'+i).text(das[i].times);
									$('#txtProductno2_'+i).val(das[i].productno2);
									$('#txtProduct2_'+i).val(das[i].product2);
									$('#lblLengthb_'+i).text(das[i].lengthb);
									$('#lblSpec_'+i).text(das[i].spec);
								}
								
							}else{
								alert('投入及產出作業沒進行完工!!');
							}
							
							
						}else{
							alert('【'+t_noa+'】非製造派工單!!');
							$('#txtNoa').val('');
						}
					}else{
						alert('【'+t_noa+'】派工單不存在!!');
						$('#txtNoa').val('');
					}
				});
				
				$('#txtWeight').change(function() {
					var t_lenghtb=dec($('#lblLengthb_0').val());
					var t_weight=dec($('#txtWeight').val());
					$('#lblWeight2').text(q_sub(t_lenghtb,t_weight));
					var t_weight1=0;
					
					if(dec(t_lenghtb)>0){
						t_weight1=q_div(t_weight,t_lenghtb);
						$('#lblWeight1').text(round(t_weight1*100,0).toString()+'%');
					}else{
						$('#lblWeight1').text(t_weight1.toString()+'%');
					}
					if(t_weight1>1 || t_weight1<0.92){
						$('#lblAlert').text('警告');
					}else{
						$('#lblAlert').text('');
					}
					
					var t_uccstart=dec($('#lblUccstart').text());
					if(t_uccstart==0){
						$('#lblDecide').text('自判');
					}else{
						if(q_sub(t_lenghtb,t_weight)>t_uccstart){
							$('#lblDecide').text('退料');
						}else{
							$('#lblDecide').text('歸0');
						}
					}
					
				});
				
            }
            
            function shownowtime() {
            	var t_time=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds(),'0',2);
            	$('#lblTimea').text(t_time);	
            }
            
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
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
		</script>
		<style type="text/css">
			.txt.c1 {
				width: 98%;
				float: left;
			}
			
            input[type="text"],input[type="button"],select {	 
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<a id='logout' class="lbl" style="color: coral;cursor: pointer;font-weight: bolder;float: right;">登出</a>
		
		<table id="table_cugtitle" style="width:1200px" cellpadding='2'  cellspacing='0'>
			<tr align="center">
				<td style="width: 100px;"><a class="lbl">派工單</a></td>
				<td style="width: 225px;">
					<input id="txtNoa" type="text" class="txt c1 str" style="width: 150px;"/>
					<input id="txtNoq" type="hidden"/>
				</td>
				<td style="width: 100px;"><a class="lbl">加工日</a></td>
				<td style="width: 150px;"><input id="txtDatea" type="text" class="txt c1" style="width: 100px;" disabled="disabled"/></td>
				<td style="width: 130px;"><a class="lbl">製程別</a></td>
				<td style="width: 75px;">上皮</td>
				<td style="width: 130px;"><a class="lbl">機台別</a></td>
				<td style="width: 75px;"><input id="txtMechno" type="text" class="txt c1" disabled="disabled"/></td>
				<td style="width: 215px;"><input id="btnDownimg" type="button" value="畫面擷取"><a id="Downimg"> </a></td>
			</tr>
			<tr align="center">
				<td><a class="lbl">現產</a></td>
				<td><a id="lblNowProductno"> </a></td>
				<td><a class="lbl">列管備註</a></td>
				<td colspan="5"><a id="lblNowF12"> </a></td>
				<td><a id="lblTimea" class="lbl"> </a></td>
			</tr>
		</table>
		<div id="div_cuds" style="width: 1280px;">
			<table id="table_cuds" style="width:1100px;float:left;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
				<tr align="center" style="height: 30px;">
					<td style="background-color: gainsboro;width: 50px;">現產</td>
					<td style="background-color: gainsboro;width: 140px;">身分證號(半)</td>
					<td style="background-color: gainsboro;width: 50px;">排序</td>
					<td style="background-color: gainsboro;width: 40px;">調上</td>
					<td style="background-color: gainsboro;width: 40px;">調下</td>
					<td style="background-color: gainsboro;width: 40px;">插入</td>
					<td style="background-color: gainsboro;width: 40px;">刪除</td>
					<td style="background-color: gainsboro;width: 40px;">重掃</td>
					<td style="background-color: gainsboro;width: 180px;">料號</td>
					<td style="background-color: gainsboro;width: 80px;">長(M)</td>
					<td style="background-color: gainsboro;width: 120px;">列管備註</td>
					<td style="background-color: gainsboro;width: 100px;">產出</td>
					<td style="background-color: gainsboro;width: 90px;"> </td>
					<td style="background-color: gainsboro;width: 90px;"> </td>
				</tr>
				<tr id="tr_0" align="center" style="height: 55px;">
					<td><a id="lblNowgen_0" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_0"> </a>
						<a id="lblProductno_0" style="display: none;"> </a>
						<a id="lblOrdeno_0" style="display: none;"> </a>
						<a id="lblNo2_0" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_0"> </a></td>
					<td><input id="btnUp_0" type="button" value="↑"></td>
					<td><input id="btnDown_0" type="button" value="↓"></td>
					<td><input id="btnIns_0" type="button" value="插"></td>
					<td><input id="btnDele_0" type="button" value="刪"></td>
					<td><input id="btnWrite_0" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_0" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_0" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_0"> </a></td>
					<td><a id="lblSpec_0"> </a></td>
					<td><input id="txtWeight" type="text" class="txt c1" style="text-align: right;"></td>
					<td><input id="btnEnter" type="button" value="ENTER"></td>
					<td><input id="btnRep" type="button" value="重KEY"></td>
				</tr>
				<tr id="tr_1" align="center" style="height: 55px;">
					<td><a id="lblNowgen_1" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_1"> </a>
						<a id="lblProductno_1" style="display: none;"> </a>
						<a id="lblOrdeno_1" style="display: none;"> </a>
						<a id="lblNo2_1" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_1"> </a></td>
					<td><input id="btnUp_1" type="button" value="↑"></td>
					<td><input id="btnDown_1" type="button" value="↓"></td>
					<td><input id="btnIns_1" type="button" value="插"></td>
					<td><input id="btnDele_1" type="button" value="刪"></td>
					<td><input id="btnWrite_1" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_1" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_1" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_1"> </a></td>
					<td><a id="lblSpec_1"> </a></td>
					<td><a>餘料</a></td>
					<td><a>產出(%)</a></td>
					<td><a>歸0值</a></td>
				</tr>
				<tr id="tr_2" align="center" style="height: 55px;">
					<td><a id="lblNowgen_2" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_2"> </a>
						<a id="lblProductno_2" style="display: none;"> </a>
						<a id="lblOrdeno_2" style="display: none;"> </a>
						<a id="lblNo2_2" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_2"> </a></td>
					<td><input id="btnUp_2" type="button" value="↑"></td>
					<td><input id="btnDown_2" type="button" value="↓"></td>
					<td><input id="btnIns_2" type="button" value="插"></td>
					<td><input id="btnDele_2" type="button" value="刪"></td>
					<td><input id="btnWrite_2" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_2" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_2" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_2"> </a></td>
					<td><a id="lblSpec_2"> </a></td>
					<td><a id="lblWeight2"> </a></td>
					<td><a id="lblWeight1"> </a></td>
					<td><a id="lblUccstart"> </a></td>
				</tr>
				<tr id="tr_3" align="center" style="height: 55px;">
					<td><a id="lblNowgen_3" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_3"> </a>
						<a id="lblProductno_3" style="display: none;"> </a>
						<a id="lblOrdeno_3" style="display: none;"> </a>
						<a id="lblNo2_3" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_3"> </a></td>
					<td><input id="btnUp_3" type="button" value="↑"></td>
					<td><input id="btnDown_3" type="button" value="↓"></td>
					<td><input id="btnIns_3" type="button" value="插"></td>
					<td><input id="btnDele_3" type="button" value="刪"></td>
					<td><input id="btnWrite_3" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_3" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_3" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_3"> </a></td>
					<td><a id="lblSpec_3"> </a></td>
					<td><a id="lblAlert"> </a></td>
					<td><a>判定</a></td>
					<td><a id="lblDecide"> </a></td>
				</tr>
				<tr id="tr_4" align="center" style="height: 55px;">
					<td><a id="lblNowgen_4" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_4"> </a>
						<a id="lblProductno_4" style="display: none;"> </a>
						<a id="lblOrdeno_4" style="display: none;"> </a>
						<a id="lblNo2_4" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_4"> </a></td>
					<td><input id="btnUp_4" type="button" value="↑"></td>
					<td><input id="btnDown_4" type="button" value="↓"></td>
					<td><input id="btnIns_4" type="button" value="插"></td>
					<td><input id="btnDele_4" type="button" value="刪"></td>
					<td><input id="btnWrite_4" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_4" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_4" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_4"> </a></td>
					<td><a id="lblSpec_4"> </a></td>
					<td><a>餘料</a></td>
					<td colspan="2"><select id="cmbMome1" class="txt c1"> </select></td>
				</tr>
				<tr id="tr_5" align="center" style="height: 55px;">
					<td><a id="lblNowgen_5" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_5"> </a>
						<a id="lblProductno_5" style="display: none;"> </a>
						<a id="lblOrdeno_5" style="display: none;"> </a>
						<a id="lblNo2_5" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_5"> </a></td>
					<td><input id="btnUp_5" type="button" value="↑"></td>
					<td><input id="btnDown_5" type="button" value="↓"></td>
					<td><input id="btnIns_5" type="button" value="插"></td>
					<td><input id="btnDele_5" type="button" value="刪"></td>
					<td><input id="btnWrite_5" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_5" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_5" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_5"> </a></td>
					<td><a id="lblSpec_5"> </a></td>
					<td><a>退料</a></td>
					<td colspan="2"><input id="btnPrinttag" type="button" value="印標籤"></td>
				</tr>
				<tr id="tr_6" align="center" style="height: 55px;">
					<td><a id="lblNowgen_6" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_6"> </a>
						<a id="lblProductno_6" style="display: none;"> </a>
						<a id="lblOrdeno_6" style="display: none;"> </a>
						<a id="lblNo2_6" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_6"> </a></td>
					<td><input id="btnUp_6" type="button" value="↑"></td>
					<td><input id="btnDown_6" type="button" value="↓"></td>
					<td><input id="btnIns_6" type="button" value="插"></td>
					<td><input id="btnDele_6" type="button" value="刪"></td>
					<td><input id="btnWrite_6" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_6" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_6" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_6"> </a></td>
					<td><a id="lblSpec_6"> </a></td>
					<td colspan="3"> </td>
				</tr>
				<tr id="tr_7" align="center" style="height: 55px;">
					<td><a id="lblNowgen_7" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_7"> </a>
						<a id="lblProductno_7" style="display: none;"> </a>
						<a id="lblOrdeno_7" style="display: none;"> </a>
						<a id="lblNo2_7" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_7"> </a></td>
					<td><input id="btnUp_7" type="button" value="↑"></td>
					<td><input id="btnDown_7" type="button" value="↓"></td>
					<td><input id="btnIns_7" type="button" value="插"></td>
					<td><input id="btnDele_7" type="button" value="刪"></td>
					<td><input id="btnWrite_7" type="button" value="掃"></td>
					<td>
						<input id="txtProductno2_7" type="text" class="txt c1" disabled="disabled"><BR>
						<input id="txtProduct2_7" type="text" class="txt c1" disabled="disabled"> <!--批號-->
					</td>
					<td><a id="lblLengthb_7"> </a></td>
					<td><a id="lblSpec_7"> </a></td>
					<td><input id="btnInspection" type="button" value="自主檢"></td>
					<td colspan="2"><input id="btnEnda" type="button" value="完工"></td>
				</tr>
			</table>
			<table id="table_cuds2" style="width:160px;float:right;display:none;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
				<tr align="center" style="height: 30px;">
					<td><input id="btnEnter2" type="button" value="ENTER"></td>
					<td><input id="btnCancel2" type="button" value="關閉"></td>
				</tr>
				<tr align="center" style="height: 30px;">
					<td style="background-color: gainsboro;width: 80px;">自主檢</td>
					<td style="background-color: gainsboro;width: 80px;">判定</td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>外觀</a></td>
					<td><input id="chkMount1" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>色差</a></td>
					<td><input id="chkMount2" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>寬幅</a></td>
					<td><input id="chkMount3" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>出油</a></td>
					<td><input id="chkMount4" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>變形</a></td>
					<td><input id="chkMount5" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>管底</a></td>
					<td><input id="chkMount6" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>異常單</a></td>
					<td><input id="chkMount7" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>留樣</a></td>
					<td><input id="chkMount8" type="checkbox"></td>
				</tr>
			</table>
		</div>
	</body>
</html>