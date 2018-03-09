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
			var q_name = "cug_uj6";
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
                $('#txtPdate').mask(r_picd);
                $('#txtPdate').val(q_date());
                q_cmbParse('cmbNoa','掃派工單條碼,系統選派工單');
                q_cmbParse('cmbUno','1@掃投入條碼,2@自鍵投入料號');
                q_cmbParse('cmbUcaunotypea','掃條碼,流水號,無');
				q_cmbParse('cmbSpec',',紅標,黃標,藍標');
				q_cmbParse('cmbPdate','今日,製造日,自鍵,無');
				q_cmbParse('cmbReason','1.膠線,2.折痕,3.邊無膠,4.出膠,5.寬幅,6.膠面,7.含水率,8.背印,9.接頭,10.管底不良,11.原紙接頭,12.米數不符,13.凸龜,14.跑捲,15.異物,16.外傷(他),17.外傷(自),18.內傷(商),19.其他');
				q_cmbParse('cmbWay','重工-自,重工-他,待判定,次級品,皮紙分離,垃圾');
				q_cmbParse('cmbUnotypea3','掃條碼,流水號,同成品板號,無');
				q_cmbParse('cmbMemo14','退良品,退不良品,轉內銷,接做其他家,歸0');
				
				$('#cmbUcaunotypea').val('流水號');
				
                q_cur=2;
                document.title='加工生產作業';
                
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
				
				$('#btnRepsel').click(function() {
					location.href=location.href;
				});
				
				$('#btnNoa').click(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$.trim($('#txtNoa').val());
					if(t_noa.length>0){
						q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_noa),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].bdate=='加工'){
								$('#txtDatea').val(as[0].datea);
								$('#txtMechno').val(as[0].processno);
								
								q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';1',r_accy,1);
								var as = _q_appendData("tmp0", "", true, true);
								if(as.length>0){
									$('#btnNoa').attr('disabled', 'disabled');
									$('#txtNoa').attr('disabled', 'disabled');
									
									$('#btnUno').removeAttr('disabled');
									$('#cmbUno').removeAttr('disabled');
									$('#cmbUno').change();
								}else{
									alert('派工單已完工!!');
									$('#txtNoa').val('');
								}
							}else{
								alert('【'+t_noa+'】非加工派工單!!');
								$('#txtNoa').val('');
							}
						}else{
							alert('【'+t_noa+'】派工單不存在!!');
							$('#txtNoa').val('');
						}
					}
				});
				
				$('#cmbUno').change(function() {
					if($('#cmbUno').val()=='1'){
						$('#txtUcano').attr('disabled', 'disabled');
						$('#txtUno').removeAttr('disabled');
					}else{
						$('#txtUcano').removeAttr('disabled');
						$('#txtUno').attr('disabled', 'disabled');
					}
					$('#txtUcano').val('');
					$('#txtUno').val('');
					$('#lblUcatypea').text('');
					$('#lblSpec').text('');
				});
				
				$('#btnUno').click(function() {
					var t_noa=$('#txtNoa').val();
					var t_ucano=$('#txtUcano').val();
					var noqas=[];
					if(t_noa.length>0 && t_ucano.length>0){
						q_gt('view_cugt',"where=^^noa='"+t_noa+"' and dbo.split(memo,'@,#',4)='"+t_ucano+"' and exists (select * from view_cugs where noa=view_cugt"+r_accy+".noa and noq=dbo.split(view_cugt"+r_accy+".memo,'@,#',1) and isnull(issel,0)=0) ^^", 0, 0, 0, "getcugt", r_accy,1);
						var as = _q_appendData("view_cugt", "", true);
						if (as[0] != undefined) {
							for(var i=0;i<as.length;i++){
								var t_noq=as[i].memo.split('@,#')[1];
								if(t_noq.length>0)
									noqas.push(t_noq);
							}
							
							$('#btnUno').attr('disabled', 'disabled');
							$('#txtUcano').attr('disabled', 'disabled');
							$('#txtUno').attr('disabled', 'disabled');
							$('#cmbUno').attr('disabled', 'disabled');
						}else{
							alert('派工單無使用此料號!!');
							$('#lblAlert').text('禁止');
						}
					}else{
						alert('請輸入條碼或料號!!');
					}
					
					$('#cmbF01').text('');
					if(noqas.length>0){
						var t_cf01='',t_count=0;
						q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';1',r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for(var i=0;i<as.length;i++){
								var texist=false;
								for(var j=0;j<noqas.length;j++){
									if(as[i].noq==noqas[j]){
										texist=true;
										break;
									}
								}
								if(texist){
									var t_f01=as[i].f01;
									if(t_f01.length>0)
										t_cf01+=(t_cf01.length>0?',':'')+as[i].noq+"@"+t_f01;
									else
										t_cf01+=(t_cf01.length>0?',':'')+as[i].noq+"@"+as[i].productno;
									t_count++;
								}
							}
						}
						q_cmbParse('cmbF01',t_cf01);
						$('#lblCount').text(t_count);
						$('#cmbF01').change();
						
						$('#lblUcano2').text($('#txtUcano').val());
					}
				});
				
				$('#txtUno').change(function() {
					var t_uno=$.trim($('#txtUno').val());
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						$('#txtUcano').val(as[0].productno);
						$('#lblSpec').text(as[0].spec);
						$('#lblLengthb').text(round(dec(as[0].weight),0));
						getucatypea();
					}else{
						alert('【'+t_uno+'】批號不存在!!');
						$('#txtUno').val('');
					}
				});
				
				$('#txtUcano').change(function() {
					var t_pno=$.trim($('#txtUcano').val());
					if(t_pno.length>0){
						q_gt('uca',"where=^^noa='"+t_pno+"' ^^", 0, 0, 0, "getuca", r_accy,1);
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							$('#lblLengthb').text(round(dec(as[0].trans),0));
						}
					}
					
					getucatypea();
				});
				
				$('#cmbF01').change(function() {
					var t_f01=$('#cmbF01').find(":selected").text();
					if(t_f01.substr(0,1)=='6'){
						$('#lblF01typea').text('再製品');
					}else{
						$('#lblF01typea').text('成品');
					}
					if($('#cmbF01').val()!=null){
						if($('#cmbF01').val().length>0){
							var t_noa=$('#txtNoa').val();
							var t_noq=$('#cmbF01').val();
							q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI(t_noq)+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';'+ encodeURI('#non')+';1',r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								var tworkgnoa=as[0].workgno.split('-')[0];
								var tworkgnoq=as[0].workgno.split('-')[1];
								if(tworkgnoa.length>0 && tworkgnoq.length>0){
									q_func('qtxt.query.getviewworkgs', 'orde_uj.txt,getviewworkgs,' + encodeURI(tworkgnoa)+';'+encodeURI(tworkgnoq),r_accy,1);
									var ass = _q_appendData("tmp0", "", true, true);
									if (ass[0] != undefined) {
										var t_memo2=ass[0].memo2.split('@,#');
										$('#lblOrdeno').text(t_memo2[1]); //訂單號/指令流水號
										var tcubnoa=ass[0].workhno.split('-')[0];
										var tcubnoq=ass[0].workhno.split('-')[1];
										if(tcubnoa.length>0){
											q_gt('view_cub',"where=^^noa='"+tcubnoa+"' ^^", 0, 0, 0, "getcub", r_accy,1);
											var asc = _q_appendData("view_cub", "", true);
											if (asc[0] != undefined) {
												$('#lblCubm4').text(asc[0].m4); //指送
												$('#lblCubprocess').text(asc[0].processno);//入庫倉別
											}
										}
									}
								}
								$('#lblOrdename').text(as[0].ordeno); //訂單名稱
								$('#lblProductno').text(as[0].productno); //新成品編碼
								$('#lblDhours').text(as[0].dhours); //長
								$('#lblF02').text(as[0].f02); //長度備註
							}
							var t_pno=$.trim($('#lblProductno').text());
							if(t_pno.length>0){
								q_gt('uca',"where=^^noa='"+t_pno+"' ^^", 0, 0, 0, "getuca", r_accy,1);
								var as = _q_appendData("uca", "", true);
								if (as[0] != undefined) {
									$('#lblProduct').text(as[0].product);
									$('#lblUcamolds').text(as[0].molds);
									$('#lblUcabdate').text(as[0].bdate);
									$('#lblUnit').text(as[0].unit);
									
									if($('#lblF01typea').text()!='再製品'){
										$('#lblUcano3').text(as[0].groupkno);
									}else{
										$('#lblUcano3').text(as[0].grouplno);
									}
								}else{
									if($('#lblF01typea').text()=='再製品'){
										$('#lblUnit').text('顆');
									}else{
										$('#lblUnit').text('');
									}
								}
							}
							
							//重新取得累積量
							var t_mount=0,t_weight2=0;
							q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' 
							+ encodeURI(t_noa)+';'+encodeURI(t_noq)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							for(var i=0;i<as.length;i++){
								if(as[i].source=='2' || as[i].source=='8'){
									t_mount=q_add(t_mount,dec(as[i].mount));
									t_weight2=q_add(t_weight2,dec(as[i].weight2));
								}
							}
							
							$('#lblTmount').text(t_mount);
							$('#lblTweight').text(t_weight2);
							
							var t_mount=0,t_weight2=0;
							for(var i=0;i<as.length;i++){
								if(as[i].source=='7'){
									t_mount=q_add(t_mount,dec(as[i].mount));
									t_weight2=q_add(t_weight2,dec(as[i].weight2));
								}
							}
							
							$('#lblTmount2').text(t_mount);
							$('#lblTweight2').text(t_weight2);
							
							var t_mount=0,t_weight2=0;
							for(var i=0;i<as.length;i++){
								if(as[i].source=='6'){
									t_mount=q_add(t_mount,dec(as[i].mount));
									t_weight2=q_add(t_weight2,dec(as[i].weight2));
								}
							}
							
							$('#lblTmount3').text(t_mount);
							$('#lblTweight3').text(t_weight2);
							
							totalmw();
						}
					}
					//重新取的新批號
					getnewunos();
					
				});
				
				$('#btnEnda').click(function() {
					var t_ordeno=$.trim($('#txtNoa').val()); //派工單
					var t_no2=$('#cmbF01').val();
					if($('#cmbF01').val()==null){t_no2='';}
					
					q_func('qtxt.query.cugssel2', 'orde_uj.txt,cugssel2,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI(q_date())+';'+encodeURI(r_accy),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						$('#btnRepsel').click();
					}else{
						alert('派工單失效，請確認派工單是否存在!!');
					}
				});
				
				$('#cmbUcaunotypea').change(function() {
					if($('#cmbUcaunotypea').val()=='掃條碼'){
						$('#txtUcauno').val('');
						$('#txtUcauno').removeAttr('disabled');
					}
					if($('#cmbUcaunotypea').val()=='流水號'){ //目前不知道流水號產生方式
						$('#txtUcauno').val('');
						$('#txtUcauno').removeAttr('disabled');
					}
					if($('#cmbUcaunotypea').val()=='無'){
						$('#txtUcauno').val('');
						$('#txtUcauno').attr('disabled', 'disabled');
					}
				});
				
				$('#btnIns1').click(function() {
					
				});
				$('#btnModi1').click(function() {
					
				});
				$('#btnOk1').click(function() {
					
				});
				
				$('#btnEnter1').click(function() {
					var t_typea=$.trim($('#lblF01typea').text());
					if(t_typea.length==0){t_typea=='成品';}
					
					var t_ordeno=$.trim($('#txtNoa').val()); //派工單
					var t_no2=$('#cmbF01').val();
					if($('#cmbF01').val()==null){t_no2='';}
					var t_source=t_typea!='成品'?'8':'2';//產出別 (2成品8再製7不良6零碼9餘料)
					var t_mechno=emp($('#txtMechno').val())?'#non':$.trim($('#txtMechno').val());//機台
					var t_pno=$.trim($('#lblProductno').text());//品名
					var t_uno=emp($('#lblProductno2').text())?'#non':$.trim($('#lblProductno2').text());//產生身分證號//再製品
					var t_mount=dec($('#txtMount').val());//產出
					var t_weight=dec($('#txtWeight').val()); //長
					var t_weight1='#non';//出(%)
					var t_spec=emp($('#lblSpec').text())?'#non':$.trim($('#lblSpec').text());//列管備註
					var t_lengthb='#non';//投入(M)
					var t_pno2=$.trim($('#txtUcano').val());//投入料號
					var t_product2=emp($('#txtUno').val())?'#non':$.trim($('#txtUno').val());//投入身分證號
					var tm1=$.trim($('#lblF02').text());//長度備註
					var tm2='';//備註
					var tm3=$.trim($('#cmbSpec').val());//加工列管
					var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds() ,'0',2);
					var tm4=q_date()+' '+t_timea;//第幾支 //寫日期時間
					var tm5=$.trim($('#lblOrdename').text());//訂單名稱
					var tm6=$.trim($('#cmbF01').find(":selected").text());//舊成品名
					var tm7=$.trim($('#txtUcauno').val());//板號
					var tm8=$.trim($('#lblUnit').text());//單位
					var tm9=$.trim($('#lblCubprocess').text());//入庫倉別
					var tm10='';
					
					var t_memo='@X#'+tm1+'@X#'+tm2+'@X#'+tm3+'@X#'+tm4+'@X#'+tm5
					+'@X#'+tm6+'@X#'+tm7+'@X#'+tm8+'@X#'+tm9+'@X#'+tm10+'@X#';
					var t_datea=emp($('#txtDatea').val())?q_date():$.trim($('#txtDatea').val());//加工日期
					var t_noa=replaceAll(t_datea,'/','')+'-'+t_mechno+'-'+(t_typea.substr(0,2));
					
					if(dec(t_weight)==0){
						t_weight=dec($('#lblDhours').text());
					}
					
					if(t_pno.length==0 || t_no2.length==0){
						alert('請先選擇要產出的成品!!');
						return;
					}
					if(t_mount>9){
						if(!confirm('產出數量高於9，確認是否要生產?')){
							return;
						}
					}
					
					q_func('qtxt.query.cudsenter2', 'orde_uj.txt,cudsenter6,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI(t_source)+';'+encodeURI(t_mechno)
					+';'+encodeURI(t_pno)+';'+encodeURI(t_uno)+';'+encodeURI(t_mount)+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)
					+';'+encodeURI(t_spec)+';'+encodeURI(t_lengthb)+';'+encodeURI(t_pno2)+';'+encodeURI(t_product2)
					+';'+encodeURI(t_memo)+';'+encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(t_datea)
					,r_accy,1);
					var as = [];
					as=_q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert('產出成功');
					}else{
						alert('產出失敗，請重新ENTER');
					}
					
					//重新取得累積量
					var t_mount=0,t_weight2=0;
					q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' 
					+ encodeURI(t_ordeno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('2'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for(var i=0;i<as.length;i++){
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight2=q_add(t_weight2,dec(as[i].weight2));
					}
					
					q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('8'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for(var i=0;i<as.length;i++){
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight2=q_add(t_weight2,dec(as[i].weight2));
					}
					$('#lblTmount').text(t_mount);
					$('#lblTweight').text(t_weight2);
					totalmw();
					
					//重新取的新批號
					getnewunos();
				});
				
				$('#cmbWay').change(function() {
					if($(this).val()=='重工-自'){
						$('#lblStoreno2').text('B');
					}else if($(this).val()=='重工-他' || $(this).val()=='待判定'){
						$('#lblStoreno2').text('Q');
					}else if($(this).val()=='次級品'){
						$('#lblStoreno2').text('P');
					}else{
						$('#lblStoreno2').text('');
					}
				});
				
				$('#btnEnter2').click(function() {
					var t_ordeno=$.trim($('#txtNoa').val()); //派工單
					var t_no2=$('#cmbF01').val();
					if($('#cmbF01').val()==null){t_no2='#non';}
					var t_source='7';//產出別 (2成品8再製7不良6零碼9餘料)
					var t_mechno=emp($('#txtMechno').val())?'#non':$.trim($('#txtMechno').val());//機台
					var t_pno=$.trim($('#lblUcano2').text());//品名
					var t_uno=emp($('#lblUno2').text())?'#non':$.trim($('#lblUno2').text());//產生身分證號
					var t_mount='1';//產出
					var t_weight=dec($('#txtWeight2').val()); //長
					var t_weight1='#non';//出(%)
					var t_spec='#non';//列管備註
					var t_lengthb='#non';//投入(M)
					var t_pno2=$.trim($('#txtUcano').val());//投入料號
					var t_product2=emp($('#txtUno').val())?'#non':$.trim($('#txtUno').val());//投入身分證號
					var tm1=$('#cmbWay').val();//判定
					if(tm1==null){tm1='';}
					var tm2='';//備註
					var tm3=$('#cmbReason').val();//不良原因
					if(tm3==null){tm3='';}
					var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds() ,'0',2);
					var tm4=q_date()+' '+t_timea;//第幾支 //寫日期時間
					var tm5=$.trim($('#lblOrdename').text());//訂單名稱
					var tm6='';//舊成品名
					var tm7='';//板號
					var tm8='支';//單位
					var tm9=$.trim($('#lblStoreno2').text());//入庫倉別
					var tm10=$.trim($('#txtMemo2').val());//不良備註
					
					var t_memo='@X#'+tm1+'@X#'+tm2+'@X#'+tm3+'@X#'+tm4+'@X#'+tm5
					+'@X#'+tm6+'@X#'+tm7+'@X#'+tm8+'@X#'+tm9+'@X#'+tm10+'@X#';
					var t_datea=emp($('#txtDatea').val())?q_date():$.trim($('#txtDatea').val());//加工日期
					var t_noa=replaceAll(t_datea,'/','')+'-'+t_mechno+'-不良';
					
					if(t_pno.length==0){
						alert('投入料號禁止空白!!');
						return;
					}
					
					q_func('qtxt.query.cudsenter7', 'orde_uj.txt,cudsenter6,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI(t_source)+';'+encodeURI(t_mechno)
					+';'+encodeURI(t_pno)+';'+encodeURI(t_uno)+';'+encodeURI(t_mount)+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)
					+';'+encodeURI(t_spec)+';'+encodeURI(t_lengthb)+';'+encodeURI(t_pno2)+';'+encodeURI(t_product2)
					+';'+encodeURI(t_memo)+';'+encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(t_datea)
					,r_accy,1);
					var as = [];
					as=_q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert('產出成功');
					}else{
						alert('產出失敗，請重新ENTER');
					}
					
					//重新取得累積量
					var t_mount=0,t_weight2=0;
					q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('7'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for(var i=0;i<as.length;i++){
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight2=q_add(t_weight2,dec(as[i].weight2));
					}
					
					$('#lblTmount2').text(t_mount);
					$('#lblTweight2').text(t_weight2);
					totalmw();
					
					//重新取的新批號
					getnewunos();
				});
				
				$('#cmbUnotypea3').change(function() {
					if($('#cmbUnotypea3').val()=='掃條碼'){
						$('#txtUcauno3').val('');
						$('#txtUcauno3').removeAttr('disabled');
					}
					if($('#cmbUnotypea3').val()=='流水號'){ //目前不知道流水號產生方式
						$('#txtUcauno3').val('');
						$('#txtUcauno3').removeAttr('disabled');
					}
					if($('#cmbUnotypea3').val()=='同成品板號'){
						$('#txtUcauno3').val($('#txtUcauno').val());
						$('#txtUcauno3').attr('disabled', 'disabled');
					}
					if($('#cmbUnotypea3').val()=='無'){
						$('#txtUcauno3').val('');
						$('#txtUcauno3').attr('disabled', 'disabled');
					}
				});
				
				$('#btnIns3').click(function() {
					
				});
				$('#btnModi3').click(function() {
					
				});
				$('#btnOk3').click(function() {
					
				});
				
				$('#btnEnter3').click(function() {
					var t_ordeno=$.trim($('#txtNoa').val()); //派工單
					var t_no2=$('#cmbF01').val();
					if($('#cmbF01').val()==null){t_no2='#non';}
					var t_source='6';//產出別 (2成品8再製7不良6零碼9餘料)
					var t_mechno=emp($('#txtMechno').val())?'#non':$.trim($('#txtMechno').val());//機台
					var t_pno=$.trim($('#lblUcano3').text());//品名
					var t_uno=emp($('#lblUno3').text())?'#non':$.trim($('#lblUno3').text());//產生身分證號
					var t_mount='1';//產出
					var t_weight=dec($('#txtWeight3').val()); //長
					var t_weight1='#non';//出(%)
					var t_spec='#non';//列管備註
					var t_lengthb='#non';//投入(M)
					var t_pno2=$.trim($('#txtUcano').val());//投入料號
					var t_product2=emp($('#txtUno').val())?'#non':$.trim($('#txtUno').val());//投入身分證號
					var tm1='';//
					var tm2='';//備註
					var tm3='';//
					var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds() ,'0',2);
					var tm4=q_date()+' '+t_timea;//第幾支 //寫日期時間
					var tm5=$.trim($('#lblOrdename').text());//訂單名稱
					var tm6='';//舊成品名
					var tm7=$.trim($('#txtUcauno3').val());//板號
					var tm8='支';//單位
					var tm9=$.trim($('#lblStoreno3').text());//入庫倉別
					var tm10='';
					
					var t_memo='@X#'+tm1+'@X#'+tm2+'@X#'+tm3+'@X#'+tm4+'@X#'+tm5
					+'@X#'+tm6+'@X#'+tm7+'@X#'+tm8+'@X#'+tm9+'@X#'+tm10+'@X#';
					var t_datea=emp($('#txtDatea').val())?q_date():$.trim($('#txtDatea').val());//加工日期
					var t_noa=replaceAll(t_datea,'/','')+'-'+t_mechno+'-零碼';
					
					if(t_pno.length==0){
						alert('零碼料號禁止空白!!');
						return;
					}
					
					q_func('qtxt.query.cudsenter6', 'orde_uj.txt,cudsenter6,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI(t_source)+';'+encodeURI(t_mechno)
					+';'+encodeURI(t_pno)+';'+encodeURI(t_uno)+';'+encodeURI(t_mount)+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)
					+';'+encodeURI(t_spec)+';'+encodeURI(t_lengthb)+';'+encodeURI(t_pno2)+';'+encodeURI(t_product2)
					+';'+encodeURI(t_memo)+';'+encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(t_datea)
					,r_accy,1);
					var as = [];
					as=_q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert('產出成功');
					}else{
						alert('產出失敗，請重新ENTER');
					}
					
					//重新取得累積量
					var t_mount=0,t_weight2=0;
					q_func('qtxt.query.getviewcuds', 'orde_uj.txt,getviewcuds,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('6'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					for(var i=0;i<as.length;i++){
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight2=q_add(t_weight2,dec(as[i].weight2));
					}
					
					$('#lblTmount3').text(t_mount);
					$('#lblTweight3').text(t_weight2);
					totalmw();
					
					//重新取的新批號
					getnewunos();
				});
				
				$('#btnEnter4').click(function() {
					var t_ordeno=$.trim($('#txtNoa').val()); //派工單
					var t_no2=$('#cmbF01').val();
					if($('#cmbF01').val()==null){t_no2='#non';}
					var t_source='9';//產出別 (2成品8再製7不良6零碼9餘料)
					var t_mechno=emp($('#txtMechno').val())?'#non':$.trim($('#txtMechno').val());//機台
					var t_pno=$.trim($('#txtUcano').val());//品名
					var t_uno=emp($('#txtUno').val())?'#non':$.trim($('#txtUno').val());//產生身分證號
					var t_mount='1';//產出
					var t_weight=dec($('#lblWeight2').text()); //長
					var t_weight1=dec($('#lblWeight1').text());//出(%)
					var t_spec='#non';//列管備註
					var t_lengthb=dec($('#lblLengthb').text());//投入(M)
					var t_pno2=$.trim($('#txtUcano').val());//投入料號
					var t_product2=emp($('#txtUno').val())?'#non':$.trim($('#txtUno').val());//投入身分證號
					var tm1=$('#cmbMemo14').val();//餘料判定
					if(tm1==null){tm1='';}
					var tm2='';//備註
					var tm3='';//
					var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds() ,'0',2);
					var tm4=q_date()+' '+t_timea;//第幾支 //寫日期時間
					var tm5=$.trim($('#lblOrdename').text());//訂單名稱
					var tm6='';//舊成品名
					var tm7=$.trim($('#txtUcauno3').val());//板號
					var tm8='';//單位
					var tm9='';//入庫倉別
					var tm10='';
					
					var t_memo='@X#'+tm1+'@X#'+tm2+'@X#'+tm3+'@X#'+tm4+'@X#'+tm5
					+'@X#'+tm6+'@X#'+tm7+'@X#'+tm8+'@X#'+tm9+'@X#'+tm10+'@X#';
					var t_datea=emp($('#txtDatea').val())?q_date():$.trim($('#txtDatea').val());//加工日期
					var t_noa=replaceAll(t_datea,'/','')+'-'+t_mechno+'-餘料';
					
					if(t_pno.length==0){
						alert('投入料號禁止空白!!');
						return;
					}
					
					q_func('qtxt.query.cudsenter9', 'orde_uj.txt,cudsenter6,' 
					+ encodeURI(t_ordeno)+';'+encodeURI(t_no2)+';'+encodeURI(t_source)+';'+encodeURI(t_mechno)
					+';'+encodeURI(t_pno)+';'+encodeURI(t_uno)+';'+encodeURI(t_mount)+';'+encodeURI(t_weight)+';'+encodeURI(t_weight1)
					+';'+encodeURI(t_spec)+';'+encodeURI(t_lengthb)+';'+encodeURI(t_pno2)+';'+encodeURI(t_product2)
					+';'+encodeURI(t_memo)+';'+encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(t_datea)
					,r_accy,1);
					var as = [];
					as=_q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert('產出成功');
					}else{
						alert('產出失敗，請重新ENTER');
					}
				});
            }
            
            function shownowtime() {
            	var t_time=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds(),'0',2);
            	$('#lblTimea').text(t_time);	
            }
            
            function getucatypea() {
            	var tpno=$('#txtUcano').val();
				var t_typea='';
				if(tpno.length>0){
					if(tpno.substr(0,2).toUpperCase()=='7S' || tpno.substr(0,2).toUpperCase()=='8S' || tpno.substr(0,2).toUpperCase()=='8P'){
						t_typea='皮料';
					}else if(tpno.substr(0,2).toUpperCase()=='7L' || tpno.substr(0,2).toUpperCase()=='8L'){
						t_typea='離型紙';
					}else if(tpno.substr(0,1).toUpperCase()=='Z'){
						t_typea='零碼';
					}else if(tpno.substr(0,1).toUpperCase()=='5'){
						t_typea='半成品';
					}else if(tpno.substr(0,1).toUpperCase()=='6'){
						t_typea='再製品';
					}else if(tpno.substr(0,1).toUpperCase()=='1' || tpno.substr(0,1).toUpperCase()=='2' || tpno.substr(0,1).toUpperCase()=='3' || tpno.substr(0,1).toUpperCase()=='4'
						|| tpno.substr(0,1).toUpperCase()=='P' || tpno.substr(0,1).toUpperCase()=='C' || tpno.substr(0,1).toUpperCase()=='S'){
						t_typea='成品';
					}
				}
				$('#lblUcatypea').text(t_typea);
            }
            
            function sum4() {
            	var t_lengthb=dec($('#lblLengthb').text());
				var t_weight4=dec($('#lblTweight4').text());
				$('#lblWeight2').text(q_sub(t_lengthb,t_weight4));
				var t_weight2=dec($('#lblWeight2').text());
				if(t_lengthb>0)
					$('#lblWeight1').text(round(q_mul(q_div(q_sub(t_lengthb,t_weight2),t_lengthb),100),1)+' %');
				else
					$('#lblWeight1').text(' %');
            }
            
            function totalmw() {
            	var t_tm1=dec($('#lblTmount').text());
            	var t_tm2=dec($('#lblTmount2').text());
            	var t_tm3=dec($('#lblTmount3').text());
            	var t_tw1=dec($('#lblTweight').text());
            	var t_tw2=dec($('#lblTweight2').text());
            	var t_tw3=dec($('#lblTweight3').text());
            	
            	$('#lblTmount4').text(q_add(q_add(t_tm1,t_tm2),t_tm3));
            	$('#lblTweight4').text(q_add(q_add(t_tw1,t_tw2),t_tw3));
            	
            	sum4();
            }
            
            function getnewunos() {
            	getnewunos
            	var todayuno=replaceAll(q_date(),'/','').slice(-6);
            	
            	q_func('qtxt.query.getnewunos', 'orde_uj.txt,getnewunos,'+ encodeURI(todayuno),r_accy,1);
				var as = _q_appendData("tmp0", "", true, true);
				if (as[0] != undefined) {
					if($('#lblF01typea').text()!='成品'){
						$('#lblProductno2').text(as[0].uno3);
					}else{
						$('#lblProductno2').text('');
					}
					$('#lblUno2').text(as[0].uno4);
					$('#lblUno3').text(as[0].uno5);
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
			<tr align="center" style="height: 1px;">
				<td style="width: 125px;"> </td>
				<td style="width: 80px;"> </td>
				<td style="width: 180px;"> </td>
				<td style="width: 180px;"> </td>
				<td style="width: 180px;"> </td>
				<td style="width: 180px;"> </td>
				<td style="width: 80px;"> </td>
				<td style="width: 80px;"> </td>
				<td style="width: 80px;"> </td>
			</tr>
			<tr>
				<td colspan="5" style="text-align: center;"><a class="lbl" style="font-size: 24px;font-weight: bold;">加工生產製令單</a></td>
				<td colspan="4">
					<a class="lbl" style="float: left;font-weight: bold;">加工日：</a>
					<input id="txtDatea" type="text" class="txt c1" disabled="disabled" style="width: 120px;"/>
					<a class="lbl" style="float: left;">　　</a>
					<a class="lbl" style="float: left;font-weight: bold;">機台：</a>
					<input id="txtMechno" type="text" class="txt c1" disabled="disabled" style="width: 90px;"/>
				</td>
			</tr>
			<tr>
				<td><select id="cmbNoa"> </select></td>
				<td><input id="btnNoa" type="button" value="ENTER"></td>
				<td>
					<input id="txtNoa" type="text" class="txt c1"/>
					<input id="txtNoq" type="hidden"/>
					<a id="Downimg"> </a>
					<input id="btnDownimg" type="button" value="畫面擷取" style="display: none;">
				</td>
				<td><a>訂單號：</a><a id="lblOrdeno"> </a></td>
				<td><a>訂單名稱：</a><a id="lblOrdename"> </a></td>
				<td><a>指送：</a><a id="lblCubm4"> </a></td>
				<td><input id="btnRepsel" type="button" value="重選"></td>
				<td><a id="lblAlert"> </a></td>
				<td><input id="btnEnda" type="button" value="完工"></td>
			</tr>
			<tr>
				<td><select id="cmbUno" disabled="disabled"> </select></td>
				<td><input id="btnUno" type="button" value="ENTER" disabled="disabled"></td>
				<td><input id="txtUcano" type="text" class="txt c1" disabled="disabled"/></td>
				<td><input id="txtUno" type="text" class="txt c1" disabled="disabled"/></td>
				<td><a id="lblUcatypea"> </a></td>
				<td><a>列管備註：</a><a id="lblSpec"> </a></td>
				<td> </td>
				<td colspan="2"><a id="lblTimea" class="lbl"> </a></td>
			</tr>
			
		</table>
		<div id="div_cuds" style="width: 1200px;">
			<table id="table_cuds" style="width:1200px;float:left;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
				<tr align="center" style="height: 0px;">
					<td style="background-color: gainsboro;width: 30px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 150px;"> </td>
					<td style="background-color: gainsboro;width: 80px;"> </td>
					<td style="background-color: gainsboro;width: 120px;"> </td>
					<td style="background-color: gainsboro;width: 120px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
					<td style="background-color: gainsboro;width: 100px;"> </td>
				</tr>
				<tr align="center" style="height: 40px;background-color: gainsboro;">
					<td> </td>
					<td colspan="4"> </td>
					<td>長度</td>
					<td>數量</td>
					<td>單位</td>
					<td> </td>
					<td>累積量</td>
					<td>累積(M)</td>
					<td>列印</td>
				</tr>
				<tr id="tr_0" align="center" style="height: 30px;">
					<td rowspan="5">產出</td>
					<td><a>成品板號</a></td>
					<td colspan="2"><input id="txtUcauno" type="text" class="txt c1"/></td>
					<td><select id="cmbUcaunotypea"> </select></td>
					<td><input id="btnIns1" type="button" value="新增"></td>
					<td><input id="btnModi1" type="button" value="修改"></td>
					<td> </td>
					<td><input id="btnOk1" type="button" value="確定"></td>
				</tr>
				<tr id="tr_1" align="center" style="height: 40px;">
					<td><a id="lblF01typea">成品</a></td>
					<td colspan="2"><select id="cmbF01"> </select></td>
					<td><a>長</a><a id="lblDhours" style="margin-left: 20px;"> </a></td>
					<td><a id="lblF02"> </a></td>
					<td><input id="txtMount" type="text" class="txt c1"/></td>
					<td><a id="lblUnit"> </a></td>
					<td><input id="btnEnter1" type="button" value="ENTER"></td>
					<td><a id="lblTmount"> </a></td>
					<td><a id="lblTweight"> </a></td>
					<td><input id="btnPrint1" type="button" value="印標籤"></td>
				</tr>
				<tr id="tr_2" align="center" style="height: 40px;">
					<td><a>新成品</a></td>
					<td colspan="2"><a id="lblProductno"> </a></td>
					<td><a>符合條件</a></td>
					<td><a id="lblCount"> </a>筆</td>
					<td><input id="txtWeight" type="text" class="txt c1"/></td>
					<td><a>M</a></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td><input id="btnPrint11" type="button" value="印條碼"></td>
				</tr>
				<tr id="tr_3" align="center" style="height: 40px;">
					<td><a>出貨名</a></td>
					<td colspan="2"><a id="lblProduct"> </a></td>
					<td><a>入庫倉別</a></td>
					<td><a id="lblCubprocess"> </a><a style="margin-left: 10px;">倉</a></td>
					<td><a id="lblUcamolds"> </a>刀</td>
					<td><a>標籤規格</a></td>
					<td><a id="lblUcabdate"> </a></td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr id="tr_4" align="center" style="height: 40px;">
					<td><a>再製品號</a></td>
					<td colspan="2"><a id="lblProductno2"> </a></td>
					<td><a>加工列管</a></td>
					<td><select id="cmbSpec"> </select></td>
					<td><a>列印日期</a></td>
					<td><select id="cmbPdate"> </select></td>
					<td><input id="txtPdate" type="text" class="txt c1"/></td>
					<td> </td>
					<td> </td>
					<td><a>張/次</a><input id="txtPage" type="text" class="txt c1" style="width: 30%;" value="1"/></td>
				</tr>
				<tr id="tr_5" align="center" style="height: 40px;">
					<td rowspan="2" style="border-top: 1px #000000 dashed;">不良</td>
					<td style="border-top: 1px #000000 dashed;"><a>原因</a></td>
					<td style="border-top: 1px #000000 dashed;"><select id="cmbReason"> </select></td>
					<td style="border-top: 1px #000000 dashed;"><a>對策</a></td>
					<td style="border-top: 1px #000000 dashed;"><select id="cmbWay"> </select></td>
					<td style="border-top: 1px #000000 dashed;">入<a id="lblStoreno2"> </a>倉</td>
					<td style="border-top: 1px #000000 dashed;"><a>備註</a></td>
					<td colspan="2" style="border-top: 1px #000000 dashed;"><input id="txtMemo2" type="text" class="txt c1"/></td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"> </td>
				</tr>
				<tr id="tr_6" align="center" style="height: 40px;">
					<td><a>投入料號</a></td>
					<td><a id="lblUcano2"> </a></td>
					<td><a>身分證號</a></td>
					<td colspan="2"><a id="lblUno2"> </a></td>
					<td><input id="txtWeight2" type="text" class="txt c1" style="width: 70%;margin-right: 10px;"/>M</td>
					<td><a>1支</a></td>
					<td><input id="btnEnter2" type="button" value="ENTER"></td>
					<td><a id="lblTmount2"> </a></td>
					<td><a id="lblTweight2"> </a></td>
					<td><input id="btnPrint2" type="button" value="印標籤"></td>
				</tr>
				<tr id="tr_7" align="center" style="height: 40px;">
					<td rowspan="2" style="border-top: 1px #000000 dashed;">零碼</td>
					<td style="border-top: 1px #000000 dashed;"><a>零碼板號</a></td>
					<td colspan="2" style="border-top: 1px #000000 dashed;"><input id="txtUcauno3" type="text" class="txt c1"/></td>
					<td style="border-top: 1px #000000 dashed;"><select id="cmbUnotypea3"> </select></td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnIns3" type="button" value="新增"></td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnModi3" type="button" value="修改"></td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnOk3" type="button" value="確定"></td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnPrint3" type="button" value="印標籤"></td>
				</tr>
				<tr id="tr_8" align="center" style="height: 40px;">
					<td><a>零碼料號</a></td>
					<td><a id="lblUcano3"> </a></td>
					<td><a>身分證號</a></td>
					<td><a id="lblUno3"> </a></td>
					<td><a id="lblStoreno3">Z</a>倉</td>
					<td><input id="txtWeight3" type="text" class="txt c1" style="width: 70%;margin-right: 10px;"/>M</td>
					<td><a>1支</a></td>
					<td><input id="btnEnter3" type="button" value="ENTER"></td>
					<td><a id="lblTmount3"> </a></td>
					<td><a id="lblTweight3"> </a></td>
					<td><input id="btnPrint33" type="button" value="印條碼"></td>
				</tr>
				<tr id="tr_9" align="center" style="height: 40px;">
					<td rowspan="2" style="border-top: 1px #000000 dashed;">餘料</td>
					<td style="border-top: 1px #000000 dashed;"><a> </a></td>
					<td style="border-top: 1px #000000 dashed;"><a>投入(M)</a></td>
					<td style="border-top: 1px #000000 dashed;"><a id="lblLengthb"> </a></td>
					<td style="border-top: 1px #000000 dashed;"><a>餘(M)</a><a id="lblWeight2" style="margin-left: 20px;"> </a></td>
					<td style="border-top: 1px #000000 dashed;"><a>出(%)</a></td>
					<td style="border-top: 1px #000000 dashed;"><a id="lblWeight1"> </a></td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnEnter4" type="button" value="ENTER"></td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"> </td>
					<td style="border-top: 1px #000000 dashed;"><input id="btnPrint4" type="button" value="印標籤"></td>
				</tr>
				<tr id="tr_10" align="center" style="height: 40px;">
					<td> </td>
					<td><a>餘料判定</a></td>
					<td colspan="2"><select id="cmbMemo14"> </select></td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td><a>累計總量</a></td>
					<td><a id="lblTmount4"> </a></td>
					<td><a id="lblTweight4"> </a></td>
					<td> </td>
				</tr>
			</table>
		</div>
	</body>
</html>