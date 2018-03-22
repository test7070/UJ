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
			
			var t_enter1=false,t_enter2=false;
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
									}
									
									var t_issel=false,t_uno='';
									q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+encodeURI('8')+';'+encodeURI('1')+';'+encodeURI('5'),r_accy,1);
									var das = _q_appendData("tmp0", "", true, true);
									if (das[0] != undefined) {
										for(var i=0;i<das.length;i++){
											$('#lblProductno_'+i).text(das[i].productno);
											$('#lblOrdeno_'+i).text(das[i].ordeno);
											$('#lblNo2_'+i).text(das[i].no2);
											$('#lblNoa_'+i).text(das[i].noa);
											$('#lblNoq_'+i).text(das[i].noq);
											
											if(tt_noq==das[i].no2 && !t_issel){
												$('#lblNowgen_'+i).text('→');
												t_issel=true;
											}else{
												$('#lblNowgen_'+i).text('');
											}
											if(t_uno!=das[i].uno){
												$('#lblUno_'+i).show();
												t_uno=das[i].uno;
											}else{
												$('#lblUno_'+i).hide();
											}
											$('#lblUno_'+i).text(das[i].uno);
											$('#lblTimes_'+i).text(das[i].times);
											$('#txtProductno2_'+i).val(das[i].productno2);
											$('#txtProduct2_'+i).val(das[i].product2);
											$('#lblLengthb_'+i).text(das[i].lengthb);
											$('#lblSpec_'+i).text(das[i].spec);
										}
										
									}else{
										alert('派工單尚未進行【投入及產出作業】或已無可用的【上皮】製程!!');
									}
								}
								
							}else{
								alert('【'+t_noa+'】非製造派工單!!');
								$('#txtNoa').val('');
							}
						}else{
							alert('派工單【'+t_noa+'】不存在!!');
							$('#txtNoa').val('');
						}
						getuccstart();
					}
				});
				
				$('#txtWeight').change(function() {
					var t_lenghtb=dec($('#lblLengthb_0').text());
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
				
				for(var i=0;i<8;i++){
					$('#btnUp_'+i).click(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_ordeno=$.trim($('#lblOrdeno_'+n).text());
						var t_noa=$.trim($('#lblNoa_'+n).text());
						var t_noq1=$.trim($('#lblNoq_'+n).text());
						var t_noq2=$.trim($('#lblNoq_'+(dec(n)-1)).text());
						if(t_noa.length>0 && t_noq1.length>0 && t_noq2.length>0){
							q_func('qtxt.query.cudschgnoqup', 'orde_uj.txt,cudschgnoq,' + encodeURI(t_noa)+';'+encodeURI(t_noq1)+';'+encodeURI(t_noq2),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								for(var j=0;j<as.length;j++){
									for(var k=0;k<8;k++){
										if($('#lblNoa_'+k).text()==as[j].noa && $('#lblNoq_'+k).text()==as[j].noq){
											$('#lblProductno_'+k).text(as[j].productno);
											$('#lblOrdeno_'+k).text(as[j].ordeno);
											$('#lblNo2_'+k).text(as[j].no2);
											$('#lblUno_'+k).text(as[j].uno);
											$('#lblTimes_'+k).text(as[j].times);
											$('#txtProductno2_'+k).val(as[j].productno2);
											$('#txtProduct2_'+k).val(as[j].product2);
											$('#lblLengthb_'+k).text(as[j].lengthb);
											$('#lblSpec_'+k).text(as[j].spec);
											break;
										}
									}
								}
							}
							refreshgen(t_ordeno);
							getuccstart();
						}
					});
					
					$('#btnDown_'+i).click(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_ordeno=$.trim($('#lblOrdeno_'+n).text());
						var t_noa=$.trim($('#lblNoa_'+n).text());
						var t_noq1=$.trim($('#lblNoq_'+n).text());
						var t_noq2=$.trim($('#lblNoq_'+(dec(n)+1)).text());
						if(t_noa.length>0 && t_noq1.length>0 && t_noq2.length>0){
							q_func('qtxt.query.cudschgnoqdown', 'orde_uj.txt,cudschgnoq,' + encodeURI(t_noa)+';'+encodeURI(t_noq1)+';'+encodeURI(t_noq2),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								for(var j=0;j<as.length;j++){
									for(var k=0;k<8;k++){
										if($('#lblNoa_'+k).text()==as[j].noa && $('#lblNoq_'+k).text()==as[j].noq){
											$('#lblProductno_'+k).text(as[j].productno);
											$('#lblOrdeno_'+k).text(as[j].ordeno);
											$('#lblNo2_'+k).text(as[j].no2);
											$('#lblUno_'+k).text(as[j].uno);
											$('#lblTimes_'+k).text(as[j].times);
											$('#txtProductno2_'+k).val(as[j].productno2);
											$('#txtProduct2_'+k).val(as[j].product2);
											$('#lblLengthb_'+k).text(as[j].lengthb);
											$('#lblSpec_'+k).text(as[j].spec);
											break;
										}
									}
								}
							}
							refreshgen(t_ordeno);
							getuccstart();
						}
					});
					
					$('#btnIns_'+i).click(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_ordeno=$.trim($('#lblOrdeno_'+n).text());
						var t_noa=$.trim($('#lblNoa_'+n).text());
						var t_noq=$.trim($('#lblNoq_'+n).text());
						if(t_noa.length>0 && t_noq.length>0){
							var t_uno=prompt('請輸入批號:','');
							if(t_uno==null){
								t_uno='';
							}
							if(t_uno.length>0){
								//檢查批號
								q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								if (as[0] != undefined) {
									var t_pno=as[0].productno
									var t_spec=as[0].spec
									var t_weight=dec(as[0].mount)>1?as[0].lengthb:as[0].weight;
									if(t_pno.substr(0,2).toUpperCase()=='7S' || t_pno.substr(0,2).toUpperCase()=='8S' || t_pno.toUpperCase().substr(0,2)=='8P'){
										q_func('qtxt.query.cudsinsnoq', 'orde_uj.txt,cudsinsnoq,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
										+';'+encodeURI(t_uno)+';'+encodeURI(t_pno)+';'+encodeURI(t_weight)+';'+encodeURI(t_spec),r_accy,1);
										var ass = _q_appendData("tmp0", "", true, true);
										if (ass[0] != undefined) {
											for(var j=0;j<ass.length && (dec(n)+j)<8;j++){
												$('#lblProductno_'+(dec(n)+j)).text(ass[j].productno);
												$('#lblOrdeno_'+(dec(n)+j)).text(ass[j].ordeno);
												$('#lblNo2_'+(dec(n)+j)).text(ass[j].no2);
												$('#lblNoa_'+(dec(n)+j)).text(ass[j].noa);
												$('#lblNoq_'+(dec(n)+j)).text(ass[j].noq);
												$('#lblUno_'+(dec(n)+j)).text(ass[j].uno);
												$('#lblTimes_'+(dec(n)+j)).text(ass[j].times);
												$('#txtProductno2_'+(dec(n)+j)).val(ass[j].productno2);
												$('#txtProduct2_'+(dec(n)+j)).val(ass[j].product2);
												$('#lblLengthb_'+(dec(n)+j)).text(ass[j].lengthb);
												$('#lblSpec_'+(dec(n)+j)).text(ass[j].spec);
											}
											if((j+dec(n))<8){
												for(var k=(j+dec(n));k<8;k++){
													$('#lblProductno_'+k).text('');
													$('#lblOrdeno_'+k).text('');
													$('#lblNo2_'+k).text('');
													$('#lblNoa_'+k).text('');
													$('#lblNoq_'+k).text('');
													$('#lblUno_'+k).text('');
													$('#lblTimes_'+k).text('');
													$('#txtProductno2_'+k).val('');
													$('#txtProduct2_'+k).val('');
													$('#lblLengthb_'+k).text('');
													$('#lblSpec_'+k).text('');
												}
											}
										}
									}else{
										alert('批號【'+t_uno+'】所對應料號【'+t_pno+'】非皮料號，請重新輸入!!');
									}
								}else{
									alert('【'+t_uno+'】批號不存在!!');
								}
							}
							refreshgen(t_ordeno);
							getuccstart();
						}
					});
					
					$('#btnDele_'+i).click(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_ordeno=$.trim($('#lblOrdeno_'+n).text());
						var t_noa=$.trim($('#lblNoa_'+n).text());
						var t_noq=$.trim($('#lblNoq_'+n).text());
						if(t_noa.length>0 && t_noq.length>0){
							q_func('qtxt.query.cudsdelnoq', 'orde_uj.txt,cudsdelnoq,' + encodeURI(t_noa)+';'+encodeURI(t_noq),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								for(var j=0;j<as.length && (dec(n)+j)<8;j++){
									$('#lblProductno_'+(dec(n)+j)).text(as[j].productno);
									$('#lblOrdeno_'+(dec(n)+j)).text(as[j].ordeno);
									$('#lblNo2_'+(dec(n)+j)).text(as[j].no2);
									$('#lblNoa_'+(dec(n)+j)).text(as[j].noa);
									$('#lblNoq_'+(dec(n)+j)).text(as[j].noq);
									$('#lblUno_'+(dec(n)+j)).text(as[j].uno);
									$('#lblTimes_'+(dec(n)+j)).text(as[j].times);
									$('#txtProductno2_'+(dec(n)+j)).val(as[j].productno2);
									$('#txtProduct2_'+(dec(n)+j)).val(as[j].product2);
									$('#lblLengthb_'+(dec(n)+j)).text(as[j].lengthb);
									$('#lblSpec_'+(dec(n)+j)).text(as[j].spec);
								}
								if((j+dec(n))<8){
									for(var k=(j+dec(n));k<8;k++){
										$('#lblProductno_'+k).text('');
										$('#lblOrdeno_'+k).text('');
										$('#lblNo2_'+k).text('');
										$('#lblNoa_'+k).text('');
										$('#lblNoq_'+k).text('');
										$('#lblUno_'+k).text('');
										$('#lblTimes_'+k).text('');
										$('#txtProductno2_'+k).val('');
										$('#txtProduct2_'+k).val('');
										$('#lblLengthb_'+k).text('');
										$('#lblSpec_'+k).text('');
									}
								}
							}else{
								for(var k=dec(n);k<8;k++){
									$('#lblProductno_'+k).text('');
									$('#lblOrdeno_'+k).text('');
									$('#lblNo2_'+k).text('');
									$('#lblNoa_'+k).text('');
									$('#lblNoq_'+k).text('');
									$('#lblUno_'+k).text('');
									$('#lblTimes_'+k).text('');
									$('#txtProductno2_'+k).val('');
									$('#txtProduct2_'+k).val('');
									$('#lblLengthb_'+k).text('');
									$('#lblSpec_'+k).text('');
								}
								
							}
							refreshgen(t_ordeno);
							getuccstart();
						}
					});
					
					$('#btnWrite_'+i).click(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_noa=$.trim($('#lblNoa_'+n).text());
						var t_noq=$.trim($('#lblNoq_'+n).text());
						if(t_noa.length>0 && t_noq.length>0){
							var t_uno=prompt('請輸入批號:','');
							if(t_uno==null){
								t_uno='';
							}
							if(t_uno.length>0){
								//檢查批號
								q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								if (as[0] != undefined) {
									var t_pno=as[0].productno
									var t_spec=as[0].spec
									var t_weight=dec(as[0].mount)>1?as[0].lengthb:as[0].weight;
									if(t_pno.substr(0,2).toUpperCase()=='7S' || t_pno.substr(0,2).toUpperCase()=='8S' || t_pno.toUpperCase().substr(0,2)=='8P'){
										q_func('qtxt.query.cudschguno', 'orde_uj.txt,cudschguno,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
										+';'+encodeURI(t_uno)+';'+encodeURI(t_pno)+';'+encodeURI(t_weight)+';'+encodeURI(t_spec),r_accy,1);
										var ass = _q_appendData("tmp0", "", true, true);
										if (ass[0] != undefined) {
											if(ass[0].noa==$('#lblNoa_'+n).text() && ass[0].noq==$('#lblNoq_'+n).text()){
												$('#txtProductno2_'+n).val(ass[0].productno2);
												$('#txtProduct2_'+n).val(ass[0].product2);
												$('#lblLengthb_'+n).text(ass[0].lengthb);
												$('#lblSpec_'+n).text(ass[0].spec);
											}
										}
									}else{
										alert('批號【'+t_uno+'】所對應料號【'+t_pno+'】非皮料號，請重新輸入!!');
									}
								}else{
										alert('【'+t_uno+'】批號不存在!!');
								}
							}
						}
					});
				}
				
				$('#btnEnter').click(function() {
					var t_noa=$.trim($('#lblNoa_0').text());
					var t_noq=$.trim($('#lblNoq_0').text());
					var t_weight=dec($('#txtWeight').val());
					var t_weight1=dec($('#lblWeight1').text());
					var t_weight2=dec($('#lblWeight2').text());
					var t_memo1=emp($('#cmbMome1').val())?'#non':$('#cmbMome1').val();
					var t_memo3='#non';
					var t_width='#non';
					var t_dime='#non';
					if(t_noa.length>0 && t_noq.length>0 && t_weight>0){
						q_func('qtxt.query.cudsenter', 'orde_uj.txt,cudsenter,' + encodeURI(t_noa)+';'+encodeURI(t_noq)
						+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)+';'+encodeURI(t_weight2)
						+';'+encodeURI(t_memo1)+';'+encodeURI(t_memo3)+';'+encodeURI(t_width)+';'+encodeURI(t_dime),r_accy,1);
						
						t_enter1=true;
						btnendadisabled();
					}
				});
				
				$('#btnEnter2').click(function() {
					var t_noa=$.trim($('#lblNoa_0').text());
					var t_noq=$.trim($('#lblNoq_0').text());
					var t_m01=$('#chkMount1').prop('checked')?'1':'0';
					var t_m02=$('#chkMount2').prop('checked')?'1':'0';
					var t_m03=$('#chkMount3').prop('checked')?'1':'0';
					var t_m04=$('#chkMount4').prop('checked')?'1':'0';
					var t_m05=$('#chkMount5').prop('checked')?'1':'0';
					var t_m06=$('#chkMount6').prop('checked')?'1':'0';
					var t_m07=$('#chkMount7').prop('checked')?'1':'0';
					var t_m08=$('#chkMount8').prop('checked')?'1':'0';
					var t_m09='0';
					var t_m10='0';
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
					$('#cmbMome1').val('');
					$('#txtWeight').change();
					$('#chkMount1').prop('checked',false);
					$('#chkMount2').prop('checked',false);
					$('#chkMount3').prop('checked',false);
					$('#chkMount4').prop('checked',false);
					$('#chkMount5').prop('checked',false);
					$('#chkMount6').prop('checked',false);
					$('#chkMount7').prop('checked',false);
					$('#chkMount8').prop('checked',false);
					t_enter1=false;
					t_enter2=false;
					btnendadisabled();
				});
				
				$('#btnEnda_uj').click(function() {
					var t_ordeno=$('#lblOrdeno_0').text();
					var t_noa=$.trim($('#lblNoa_0').text());
					var t_noq=$.trim($('#lblNoq_0').text());
					if(t_noa.length>0 && t_noq.length>0){
						q_func('qtxt.query.cudsenda', 'orde_uj.txt,cudsenda,' + encodeURI(t_noa)+';'+encodeURI(t_noq),r_accy,1);
						var ass = _q_appendData("tmp0", "", true, true);
						if (ass[0] != undefined) {
							for(var j=0;j<ass.length && j<8;j++){
								$('#lblProductno_'+j).text(ass[j].productno);
								$('#lblOrdeno_'+j).text(ass[j].ordeno);
								$('#lblNo2_'+j).text(ass[j].no2);
								$('#lblNoa_'+j).text(ass[j].noa);
								$('#lblNoq_'+j).text(ass[j].noq);
								$('#lblUno_'+j).text(ass[j].uno);
								$('#lblTimes_'+j).text(ass[j].times);
								$('#txtProductno2_'+j).val(ass[j].productno2);
								$('#txtProduct2_'+j).val(ass[j].product2);
								$('#lblLengthb_'+j).text(ass[j].lengthb);
								$('#lblSpec_'+j).text(ass[j].spec);
							}
							if(j<8){
								for(var k=j;k<8;k++){
									$('#lblProductno_'+k).text('');
									$('#lblOrdeno_'+k).text('');
									$('#lblNo2_'+k).text('');
									$('#lblNoa_'+k).text('');
									$('#lblNoq_'+k).text('');
									$('#lblUno_'+k).text('');
									$('#lblTimes_'+k).text('');
									$('#txtProductno2_'+k).val('');
									$('#txtProduct2_'+k).val('');
									$('#lblLengthb_'+k).text('');
									$('#lblSpec_'+k).text('');
								}
							}
						}else{
							//目前是最後一筆 全部清除
							for(var k=0;k<8;k++){
								$('#lblProductno_'+k).text('');
								$('#lblOrdeno_'+k).text('');
								$('#lblNo2_'+k).text('');
								$('#lblNoa_'+k).text('');
								$('#lblNoq_'+k).text('');
								$('#lblUno_'+k).text('');
								$('#lblTimes_'+k).text('');
								$('#txtProductno2_'+k).val('');
								$('#txtProduct2_'+k).val('');
								$('#lblLengthb_'+k).text('');
								$('#lblSpec_'+k).text('');
							}
							alert('派工單【'+$('#txtNoa').val()+'】已無可用的【上皮】製程!!');
						}
						refreshgen(t_ordeno);
						$('#btnRepkey').click();
					}
				});
				
				$('#btnPrinttag').click(function() {
					
				});
				
            }
            
            function shownowtime() {
            	var t_time=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds(),'0',2);
            	$('#lblTimea').text(t_time);	
            }
            
            function btnendadisabled() {
            	if(t_enter1 && t_enter2){
					$('#btnEnda_uj').removeAttr('disabled');
            	}else{
            		$('#btnEnda_uj').attr('disabled', 'disabled');
            	}
            }
            
            function getuccstart() {
            	var t_pno=$('#txtProductno2_0').val();
            	if(t_pno.length>0){
            		q_gt('ucc',"where=^^noa='"+t_pno+"'^^", 0, 0, 0, "getucc", r_accy,1);
					var tucc = _q_appendData("ucc", "", true);
					if (tucc[0] != undefined) {
						$('#lblUccstart').text(tucc[0].start);
					}
            	}else{
            		$('#lblUccstart').text('');
            	}
            }
            
            function refreshgen(t_noa) {
            	if(t_noa.length==0){return;}
            	var tt_noq='';//現產序號
            	var t_uno='';
            	q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_noa),r_accy,1);
				var as = _q_appendData("tmp0", "", true, true);
				if (as[0] != undefined) {
					if(as[0].bdate=='製造'){
						tt_noq=as[0].edate;
					}
				}
				var t_issel=false;
            	for(var i=0;i<8;i++){
					if(tt_noq==$('#lblNo2_'+i).text() && !t_issel && !emp($('#lblNo2_'+i).text())){
						$('#lblNowgen_'+i).text('→');
						t_issel=true;
					}else{
						$('#lblNowgen_'+i).text('');
					}
					if(t_uno!=$('#lblUno_'+i).text()){
						$('#lblUno_'+i).show();
						t_uno=$('#lblUno_'+i).text();
					}else{
						$('#lblUno_'+i).hide();
					}
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
				<td><a id="lblNowProductno" style="float: left;"> </a></td>
				<td><a class="lbl">列管備註</a></td>
				<td colspan="5"><a id="lblNowF12" style="float: left;"> </a></td>
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
						<a id="lblNoa_0" style="display: none;"> </a>
						<a id="lblNoq_0" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_0"> </a></td>
					<td><input id="btnUp_0" type="button" value="↑" style="display: none;"></td>
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
					<td><input id="btnRepkey" type="button" value="重KEY"></td>
				</tr>
				<tr id="tr_1" align="center" style="height: 55px;">
					<td><a id="lblNowgen_1" style="color: red;"> </a></td>
					<td>
						<a id="lblUno_1"> </a>
						<a id="lblProductno_1" style="display: none;"> </a>
						<a id="lblOrdeno_1" style="display: none;"> </a>
						<a id="lblNo2_1" style="display: none;"> </a>
						<a id="lblNoa_1" style="display: none;"> </a>
						<a id="lblNoq_1" style="display: none;"> </a>
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
						<a id="lblNoa_2" style="display: none;"> </a>
						<a id="lblNoq_2" style="display: none;"> </a>
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
						<a id="lblNoa_3" style="display: none;"> </a>
						<a id="lblNoq_3" style="display: none;"> </a>
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
						<a id="lblNoa_4" style="display: none;"> </a>
						<a id="lblNoq_4" style="display: none;"> </a>
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
						<a id="lblNoa_5" style="display: none;"> </a>
						<a id="lblNoq_5" style="display: none;"> </a>
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
						<a id="lblNoa_6" style="display: none;"> </a>
						<a id="lblNoq_6" style="display: none;"> </a>
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
						<a id="lblNoa_7" style="display: none;"> </a>
						<a id="lblNoq_7" style="display: none;"> </a>
					</td>
					<td><a id="lblTimes_7"> </a></td>
					<td><input id="btnUp_7" type="button" value="↑"></td>
					<td><input id="btnDown_7" type="button" value="↓" style="display: none;"></td>
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
					<td colspan="2"><input id="btnEnda_uj" type="button" value="完工" disabled="disabled"></td>
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