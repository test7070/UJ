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
			var q_name = "cug_uj5";
			aPop = new Array();
			
			$(document).ready(function() {
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
			});
			
			var t_enter1=false,t_enter11=false,t_enter2=false;
			function q_gfPost() {
				
				q_getFormat();
                q_langShow();
                q_popAssign();
                //$('#txtDatea').mask(r_picd);
                //$('#txtDatea').val(q_date());
				q_cmbParse('cmbMome1','膠線,折痕,膠寬不足,膠面異常,含水率,凸龜,外傷(自),其他');
				q_cmbParse('cmbMome3','印@要印,@不印');
                q_cur=2;
                document.title='下料作業';
                
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
					if(t_noa.length>0){
						q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_noa),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].bdate=='製造'){
								if(as[0].isset=='true'){
									alert('派工單【'+t_noa+'】已完工!!');
									$('#txtNoa').val('');
								}else{
									$('#txtDatea').val(as[0].datea);
									$('#txtMechno').val(as[0].processno);
									
									var tt_noq=as[0].edate;//現產序號
									
									q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI(tt_noq)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';0',r_accy,1);
									var sas = _q_appendData("tmp0", "", true, true);
									if (sas[0] != undefined) {
										$('#lblNowProductno').text(sas[0].productno);
										$('#lblNowF12').text(sas[0].f12);
										$('#lblNowNosold').text(sas[0].nosold);		
									}
									
									var t_ordeno='',t_no2='';
									q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI('1')+';'+encodeURI('3'),r_accy,1);
									var das = _q_appendData("tmp0", "", true, true);
									if (das[0] != undefined) {
										var t_pno=das[0].productno;
										$('#lblProductno').text(t_pno);
										
										if(t_pno.substr(0,1)=='1'){
											$('#lblUcatypea').text('成品');
										}else if(t_pno.substr(0,1)=='5'){
											$('#lblUcatypea').text('半成品');
										}else if(t_pno.substr(0,1)=='1'){
											$('#lblUcatypea').text('再製品');
										}else{
											$('#lblUcatypea').text('');
										}
										
										$('#lblOrdeno').text(das[0].ordeno);
										$('#lblNo2').text(das[0].no2);
										t_ordeno=das[0].ordeno;
										t_no2=das[0].no2;
										$('#lblNoa').text(das[0].noa);
										$('#lblNoq').text(das[0].noq);
										$('#lblUno').text(das[0].uno);
										var tmemo=das[0].memo.split('@,#');
										$('#lblMemo4').text(tmemo[4]);
									}
									if(t_ordeno.length>0 && t_no2.length>0){
										q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' + encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('5'),r_accy,1);
										var das2 = _q_appendData("tmp0", "", true, true);
										var t_lengthb=0;
										var t_weight=0;
										for(var i=0;i<das2.length;i++){
											if(das2[i].enda=='true'){
												t_lengthb=q_add(t_lengthb,das2[i].lengthb);
												t_weight=q_add(t_weight,das2[i].weight);
											}
										}
										$('#lblLengthb').text(t_lengthb);
										$('#lblWeight').text(t_weight);
										
										q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_ordeno),r_accy,1);
										var das3 = _q_appendData("tmp0", "", true, true);
										if (das3[0] != undefined) {
											var tcs=das3[0].station.split('@');
											
											$('#lblCugstation1').text(tcs[0]);
											$('#lblCugstation2').text(tcs[1]);
											$('#lblCugstation3').text(tcs[2]);
											$('#lblAverage1').text(q_add(q_div(q_sub(dec(tcs[1]),dec(tcs[2])),2),dec(tcs[2])));
											$('#lblCugstation4').text(tcs[3]);
											$('#lblCugstation5').text(tcs[4]);
											$('#lblCugstation6').text(tcs[5]);
											$('#lblAverage2').text(q_add(q_div(q_sub(dec(tcs[4]),dec(tcs[5])),2),dec(tcs[5])));
										}
									}else{
										alert('派工單尚未進行【投入及產出作業】或已無可用的【下料】製程!!');
									}
								}
							}else{
								alert('【'+t_noa+'】非製造派工單!!');
								$('#txtNoa').val('');
							}
							
							
						}else{
							alert('【'+t_noa+'】派工單不存在!!');
							$('#txtNoa').val('');
						}
					}
				});
				
				$('#txtWeight').change(function() {
					var tweight=dec($('#txtWeight').val());
					var lweight=dec($('#lblWeight').text());
					if(lweight!=0 && tweight!=0){
						$('#lblRate').text(round(q_div(tweight,lweight)*100,2)+'%');
						if(q_div(tweight,lweight)>1.05 || q_div(tweight,lweight)<0.95)
							$('#lblAlert1').text('警告');
						else
							$('#lblAlert1').text('');
					}else{
						$('#lblRate').text('0%');
						$('#lblAlert1').text('警告');
					}
				});
				$('#btnSamepi').click(function() {
					$('#txtWeight').val(dec($('#lblLengthb').text()));
					$('#txtWeight').change();
				});
				$('#btnSamekey').click(function() {
					$('#txtWeight').val(dec($('#lblWeight').text()));
					$('#txtWeight').change();
				});
				
				$('#txtWeight2').change(function() {
					var tweight2=dec($('#txtWeight2').val());
					var tweight=dec($('#txtWeight').val());
					if(tweight2!=0 && tweight!=0){
						$('#lblRate2').text(round(q_div(tweight2,tweight)*100,2)+'%');
						if(q_div(tweight2,tweight)>1.05 || q_div(tweight2,tweight)<0.95)
							$('#lblAlert2').text('警告');
						else
							$('#lblAlert2').text('');
					}else{
						$('#lblRate2').text('0%');
						$('#lblAlert2').text('警告');
					}
				});
				
				$('#btnAuto').click(function() {
					$('#txtWeight2').val(q_sub(dec($('#txtWeight').val()),dec($('#txtLen').val())));
					$('#txtWeight2').change();
				});
				$('#btnSamekey2').click(function() {
					$('#txtWeight2').val(dec($('#txtWeight').val()));
					$('#txtWeight2').change();
				});
				
				
				$('#btnEnter').click(function() {
					var t_noa=$.trim($('#lblNoa').text());
					var t_noq=$.trim($('#lblNoq').text());
					var t_weight=dec($('#txtWeight').val());
					var t_weight1=dec($('#lblRate').text());
					var t_weight2=dec($('#txtWeight2').val());
					var t_memo1=emp($('#cmbMome1').val())?'#non':replaceAll($('#cmbMome1').val().toString(),',','#');
					var t_memo3=emp($('#cmbMome3').val())?'#non':$('#cmbMome3').val();//印標籤
					var t_width='#non';
					var t_dime='#non';
					if(t_noa.length>0 && t_noq.length>0 && t_weight>0){
						q_func('qtxt.query.cudsenter', 'orde_uj.txt,cudsenter,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
						+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)+';'+encodeURI(t_weight2)
						+';'+encodeURI(t_memo1)+';'+encodeURI(t_memo3)+';'+encodeURI(t_width)+';'+encodeURI(t_dime),r_accy,1);
						
						t_enter1=true;
						$('#txtWeight').attr('disabled', 'disabled');
						$('#btnEnter').attr('disabled', 'disabled');
						btnendadisabled();
					}
				});
				
				$('#btnEnter1').click(function() {
					var t_noa=$.trim($('#lblNoa').text());
					var t_noq=$.trim($('#lblNoq').text());
					var t_weight=dec($('#txtWeight').val());
					var t_weight1=dec($('#lblRate').text());
					var t_weight2=dec($('#txtWeight2').val());
					var t_memo1=emp($('#cmbMome1').val())?'#non':replaceAll($('#cmbMome1').val().toString(),',','#');
					var t_memo3=emp($('#cmbMome3').val())?'#non':$('#cmbMome3').val();//印標籤
					var t_width='#non';
					var t_dime='#non';
					if(t_noa.length>0 && t_noq.length>0 && t_weight>0){
						q_func('qtxt.query.cudsenter', 'orde_uj.txt,cudsenter,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
						+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)+';'+encodeURI(t_weight2)
						+';'+encodeURI(t_memo1)+';'+encodeURI(t_memo3)+';'+encodeURI(t_width)+';'+encodeURI(t_dime),r_accy,1);
						
						t_enter11=true;
						btnendadisabled();
						$('#txtWeight2').attr('disabled', 'disabled');
						$('#btnEnter1').attr('disabled', 'disabled');
					}
				});
				
				$('#btnEnter2').click(function() {
					var t_noa=$.trim($('#lblNoa').text());
					var t_noq=$.trim($('#lblNoq').text());
					var t_m01=$('#chkMount1').prop('checked')?'1':'0';
					var t_m02=$('#chkMount2').prop('checked')?'1':'0';
					var t_m03=$('#chkMount3').prop('checked')?'1':'0';
					var t_m04=$('#chkMount4').prop('checked')?'1':'0';
					var t_m05=$('#chkMount5').prop('checked')?'1':'0';
					var t_m06=$('#chkMount6').prop('checked')?'1':'0';
					var t_m07=$('#chkMount7').prop('checked')?'1':'0';
					var t_m08=$('#chkMount8').prop('checked')?'1':'0';
					var t_m09=$('#chkMount9').prop('checked')?'1':'0';
					var t_m10=$('#chkMount10').prop('checked')?'1':'0';
					if(t_noa.length>0 && t_noq.length>0){
						q_func('qtxt.query.cudsenter2', 'orde_uj.txt,cudsenter2,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
						+';'+encodeURI(t_m01)+';'+encodeURI(t_m02)+';'+encodeURI(t_m03)+';'+encodeURI(t_m04)+';'+encodeURI(t_m05)
						+';'+encodeURI(t_m06)+';'+encodeURI(t_m07)+';'+encodeURI(t_m08)+';'+encodeURI(t_m09)+';'+encodeURI(t_m10)
						,r_accy,1);
						
						t_enter2=true;
						btnendadisabled();
					}
				});
				
				$('#btnRepkey').click(function() {
					$('#txtWeight').val('');
					$('#txtWeight').change();
					$('#txtWeight').removeAttr('disabled');
					$('#btnEnter').removeAttr('disabled');
					
					t_enter1=false;
					btnendadisabled();
				});
				
				$('#btnRepkey2').click(function() {
					$('#txtWeight2').val('');
					$('#txtWeight2').change();
					$('#txtWeight2').removeAttr('disabled');
					$('#btnEnter1').removeAttr('disabled');
					
					t_enter11=false;
					btnendadisabled();
				});
				
				$('#btnEnda_uj').click(function() {
					var t_ordeno=$('#lblOrdeno').text();
					var t_noa=$.trim($('#lblNoa').text());
					var t_noq=$.trim($('#lblNoq').text());
					if(t_noa.length>0 && t_noq.length>0){
						q_func('qtxt.query.cudsenda', 'orde_uj.txt,cudsenda,' + encodeURI(t_noa)+';'+encodeURI(t_noq),r_accy,1);
						var ass = _q_appendData("tmp0", "", true, true);
						$('#btnRepkey').click();
						$('#btnRepkey2').click();
						t_enter2=false;
						$('#chkMount1').prop('checked',false);
						$('#chkMount2').prop('checked',false);
						$('#chkMount3').prop('checked',false);
						$('#chkMount4').prop('checked',false);
						$('#chkMount5').prop('checked',false);
						$('#chkMount6').prop('checked',false);
						$('#chkMount7').prop('checked',false);
						$('#chkMount8').prop('checked',false);
						$('#chkMount9').prop('checked',false);
						$('#chkMount10').prop('checked',false);
						$('#cmbMome1').val('');
						if (ass[0] != undefined) {
							$('#txtNoa').change();
						}else{
							//目前是最後一筆 全部清除
							$('#lblMemo4').text('');
							$('#lblUcatypea').text('');
							$('#lblProductno').text('');
							$('#lblUno').text('');
							$('#lblLengthb').text('');
							$('#lblWeight').text('');
							alert('派工單【'+$('#txtNoa').val()+'】已無可用的【下料】製程!!');
						}
					}
				});
				
            }
            
            function shownowtime() {
            	var t_time=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds(),'0',2);
            	$('#lblTimea').text(t_time);	
            }
            
            function btnendadisabled() {
            	if(t_enter1 && t_enter11 && t_enter2){
					$('#btnEnda_uj').removeAttr('disabled');
            	}else{
            		$('#btnEnda_uj').attr('disabled', 'disabled');
            	}
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
				width: 95%;
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
				<td style="width: 75px;">下料</td>
				<td style="width: 130px;"><a class="lbl">機台別</a></td>
				<td style="width: 75px;"><input id="txtMechno" type="text" class="txt c1" disabled="disabled"/></td>
				<td style="width: 215px;"><a id="Downimg"> </a></td>
			</tr>
			<tr align="center">
				<td><a class="lbl">身分證號</a></td>
				<td>
					<a id="lblNowProductno" style="float: left;display: none;"> </a>
					<a id="lblNowNosold" style="float: left;"> </a>
				</td>
				<td><a class="lbl">列管備註</a></td>
				<td colspan="2"><a id="lblNowF12" style="float: left;"> </a></td>
				<td colspan="2"><a id="lblTimea" class="lbl"> </a></td>
				<td><input id="btnDownimg" type="button" value="畫面擷取"></td>
			</tr>
		</table>
		<div id="div_cuds" style="width: 1000px;">
			<table id="table_cuds" style="width:800px;float:left;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
				<tr align="center" style="height: 0px;">
					<td style="background-color: gainsboro;width: 5px;"> </td>
					<td style="background-color: gainsboro;width: 70px;"> </td>
					<td style="background-color: gainsboro;width: 120px;"> </td>
					<td style="background-color: gainsboro;width: 50px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
				</tr>
				<tr align="center" style="height: 30px;">
					<td style="background-color: gainsboro;"> </td>
					<td colspan="3" style="background-color: gainsboro;">"上皮"製程段</td>
					<td style="background-color: gainsboro;">產出</td>
					<td colspan="2" style="background-color: gainsboro;">投入(M)　產出(M)</td>
					<td style="background-color: gainsboro;">確定</td>
					<td style="background-color: gainsboro;">重key長</td>
				</tr>
				<tr style="height: 10px;"> </tr>
				<tr id="tr_0" align="center" style="height: 30px;">
					<td>
						<a id="lblOrdeno" style="display: none;"> </a>
						<a id="lblNo2" style="display: none;"> </a>
						<a id="lblNoa" style="display: none;"> </a>
						<a id="lblNoq" style="display: none;"> </a>
					</td>
					<td colspan="3"><a id="lblMemo4"> </a></td>
					<td style="background-color: gainsboro;"><a id="lblUcatypea"> </a></td>
					<td colspan="2"><a id="lblProductno"> </a></td>
					<td colspan="2"><a id="lblUno"> </a></td>
				</tr>
				<tr style="height: 10px;"> </tr>
				<tr id="tr_1" align="center" style="height: 50px;">
					<td> </td>
					<td>投入(M)</td>
					<td colspan="2"><a id="lblLengthb"> </a></td>
					<td><input id="btnSamepi" type="button" value="同皮長"></td>
					<td><input id="btnSamekey" type="button" value="手KEY"></td>
					<td><input id="txtWeight" type="text" class="txt c1" style="width: 70%;text-align:right;">M</td>
					<td><input id="btnEnter" type="button" value="ENTER"></td>
					<td><input id="btnRepkey" type="button" value="重KEY"></td>
				</tr>
				<tr id="tr_2" align="center" style="height: 50px;">
					<td> </td>
					<td>產出(M)</td>
					<td colspan="2"><a id="lblWeight"> </a></td>
					<td> </td>
					<td><a id="lblAlert1"> </a></td>
					<td><a id="lblRate"> </a></td>
					<td> </td>
					<td> </td>
				</tr>
				<tr id="tr_3" align="center" style="height: 50px;">
					<td> </td>
					<td colspan="3" style="background-color: gainsboro;">製造成品"讓長"</td>
					<td><input id="btnAuto" type="button" value="自動"></td>
					<td><input id="btnSamekey2" type="button" value="手KEY"></td>
					<td><input id="txtWeight2" type="text" class="txt c1" style="width: 70%;text-align:right;">M</td>
					<td><input id="btnEnter1" type="button" value="ENTER"></td>
					<td><input id="btnRepkey2" type="button" value="重KEY"></td>
				</tr>
				<tr id="tr_4" align="center" style="height: 50px;">
					<td> </td>
					<td colspan="3"><a>上膠寬幅</a></td>
					<td><input id="txtLen" type="text" class="txt c1" style="width: 70%;text-align:right;">M</td>
					<td><a id="lblAlert2"> </a></td>
					<td><a id="lblRate2"> </a></td>
					<td> </td>
					<td> </td>
				</tr>
				<tr id="tr_5" align="center" style="height: 30px;">
					<td> </td>
					<td style="background-color: gainsboro;">留白</td>
					<td colspan="2" style="background-color: gainsboro;">右留白(mm)</td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr id="tr_6" align="center" style="height: 50px;">
					<td> </td>
					<td><a id="lblCugstation1"> </a></td>
					<td>
						<a id="lblCugstation2"> </a>
						<a style="margin: 10px;">~</a>
						<a id="lblCugstation3"> </a>
					</td>
					<td><a id="lblAverage1"> </a></td>
					<td><a>印標籤</a></td>
					<td><select id="cmbMome3" class="txt c1"> </select></td>
					<td> </td>
					<td colspan="2"><input id="btnInspection" type="button" value="自主檢"></td>
				</tr>
				<tr id="tr_7" align="center" style="height: 50px;vertical-align: top;">
					<td> </td>
					<td><a id="lblCugstation4"> </a></td>
					<td>
						<a id="lblCugstation5"> </a>
						<a style="margin: 10px;">~</a>
						<a id="lblCugstation6"> </a>
					</td>
					<td><a id="lblAverage2"> </a></td>
					<td><a>製造列管</a></td>
					<td colspan="2"><select id="cmbMome1" class="txt c1" multiple="multiple"> </select></td>
					<td colspan="2"><input id="btnEnda_uj" type="button" value="完工" disabled="disabled"></td>
				</tr>
			</table>
			<table id="table_cuds2" style="width:180px;float:right;display:none;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
				<tr align="center" style="height: 30px;">
					<td><input id="btnEnter2" type="button" value="ENTER"></td>
					<td><input id="btnCancel2" type="button" value="關閉"></td>
				</tr>
				<tr align="center" style="height: 30px;">
					<td style="background-color: gainsboro;width: 100px;">自主檢</td>
					<td style="background-color: gainsboro;width: 80px;">判定</td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>皮面出油</a></td>
					<td><input id="chkMount1" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>離不開</a></td>
					<td><input id="chkMount2" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>離卡卡</a></td>
					<td><input id="chkMount3" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>膠面顆粒</a></td>
					<td><input id="chkMount4" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>膠線</a></td>
					<td><input id="chkMount5" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>膠面無膠</a></td>
					<td><input id="chkMount6" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>含水率異常</a></td>
					<td><input id="chkMount7" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>膠寬動</a></td>
					<td><input id="chkMount8" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>膠線動</a></td>
					<td><input id="chkMount9" type="checkbox"></td>
				</tr>
				<tr align="center" style="height: 45px;">
					<td><a>異常單</a></td>
					<td><input id="chkMount10" type="checkbox"></td>
				</tr>
			</table>
		</div>
	</body>
</html>