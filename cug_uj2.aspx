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
			var q_name = "cug_uj2";
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
                
                $('.csource').each(function(index) {
					q_cmbParse($(this).attr('id'),'掃條碼,系統選');
                });
                
                q_cur=2;
                document.title='投入及產出作業';
                
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
				
				$('#txtNoa').change(function() {
					var t_noa=$(this).val();
					if(t_noa.length>0){
						q_func('qtxt.query.getviewcug', 'orde_uj.txt,getviewcug,' + encodeURI(t_noa),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].bdate=='製造'){
								$('#txtDatea').val(as[0].datea);
								$('#txtMechno').val(as[0].processno);
							}else{
								alert('【'+t_noa+'】非製造派工單!!');
								$('#txtNoa').val('');
							}
						}else{
							alert('【'+t_noa+'】派工單不存在!!');
							$('#txtNoa').val('');
						}
					}else{
						$('#btnCancel_uj').click();
					}
				});
				
				$('#txtUno1').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_uno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_uno.length>0){
						q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtF06').val(as[0].productno);
							$('#lblF07').text(as[0].mount);
							$('#txtF06').change();
						}else{
							alert('【'+t_uno+'】批號不存在!!');
							$(this).val('');
						}
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtF06').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_pno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_pno.length>0){
						q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI(t_pno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';0',r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtAlert1').val('');
						}else{
							$('#txtAlert1').val('派工單內無此料號');
						}
						$('#txtAlert4').change();
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtUno2').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_uno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_uno.length>0){
						q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtF09').val(as[0].productno);
							$('#lblF10').text(as[0].mount);
							$('#txtF09').change();
						}else{
							alert('【'+t_uno+'】批號不存在!!');
							$(this).val('');
						}
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtF09').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_pno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_pno.length>0){
						q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+encodeURI(t_pno)+';'+encodeURI('#non')+';0',r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtAlert2').val('');
						}else{
							$('#txtAlert2').val('派工單內無此料號');
						}
						$('#txtAlert4').change();
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtUno3').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_uno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_uno.length>0){
						q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI(t_uno)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtF08').val(as[0].productno);
							$('#lblS3mount').text(as[0].mount);
							$('#txtF08').change();
						}else{
							alert('【'+t_uno+'】批號不存在!!');
							$(this).val('');
						}
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtF08').change(function() {
					var t_noa=emp($('#txtNoa').val())?'#non':$('#txtNoa').val();
					var t_pno=emp($(this).val())?'#non':$(this).val();
					if(t_noa.length>0 && t_pno.length>0){
						q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI(t_pno)+';0',r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#txtAlert3').val('');
						}else{
							$('#txtAlert3').val('派工單內無此料號');
						}
						$('#txtAlert4').change();
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#txtAlert4').change(function() {
					$('#lblCugcount').text('');
					$('#txtProductno').val('');
					$('#lblF12').text('');
					$('#combProductno').text('');
					$('#combProductno').hide();
					
					var t_noa=$('#txtNoa').val();
					var t_pno1=emp($('#txtF06').val())?'#non':$('#txtF06').val();
					var t_pno2=emp($('#txtF09').val())?'#non':$('#txtF09').val();
					var t_pno3=emp($('#txtF08').val())?'#non':$('#txtF08').val();
					if(t_noa.length>0){
						q_func('qtxt.query.getviewcugs', 'orde_uj.txt,getviewcugs,' + encodeURI(t_noa)+';'+encodeURI(t_pno1)+';'+encodeURI(t_pno2)+';'+encodeURI(t_pno3)+';1',r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							$('#lblCugcount').text(as.length);
							if(as.length>1){
								var t_item='##########@';
								for(var i=0;i<as.length;i++){
									t_item=t_item+(t_item.length>0?',':'')+as[i].noq+'#####'+as[i].productno+'#####'+as[i].f12+'@'+as[i].productno
								}
								q_cmbParse("combProductno",t_item);
								
								$('#combProductno').show();
							}else{
								$('#txtProductno').val(as[0].productno);
								$('#lblF12').text(as[0].f12);
								$('#txtNoq').val(as[0].noq);
							}
							$(this).val('');
						}else{
							$(this).val('警告');
						}
						$('#lblUcatype').change();
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#combProductno').change(function() {
					var t_noq=$(this).val().split('#####')[0];
					var t_pno=$(this).val().split('#####')[1];
					var t_f12=$(this).val().split('#####')[2];
					$('#txtNoq').val(t_noq);
					$('#txtProductno').val(t_pno);
					$('#lblF12').text(t_f12);
					$('#lblUcatype').change();
				});
				
				$('#lblUcatype').change(function() {
					var t_pno=$('#txtProductno').val();
					if(t_pno.substr(0,1)=='5'){
						$('#lblUcatype').text('半成品');
					}else if(t_pno.substr(0,1)=='#'){
						$('#lblUcatype').text('再製品');
					}else if(t_pno.substr(0,1)=='1'){
						$('#lblUcatype').text('成品');
					}else{
						$('#lblUcatype').text('');
					}
					
					if(t_pno.length>0){
						q_gt('uca',"where=^^noa='"+t_pno+"'^^", 0, 0, 0, "getuca", r_accy,1);
						var tuca = _q_appendData("uca", "", true);
						if (tuca[0] != undefined) {
							$('#lblUcatrans').text(tuca[0].trans);
						}	
					}else{
						$('#lblUcatrans').text('');
					}
				});
				
				$('#btnModi_uj').click(function() {
					$('.str').removeAttr('disabled');
					
					$('#btnModi_uj').attr('disabled', 'disabled');
					$('#btnEnda_uj').attr('disabled', 'disabled');
					$('#combProductno').removeAttr('disabled');
					$('#btnOk_uj').removeAttr('disabled');
				});
				
				$('#btnOk_uj').click(function() {
					if(emp($('#txtNoa').val())){
						alert('【派工單】禁止空白!!');
						return;
					}
					if(emp($('#txtProductno').val())){
						alert('【產出內容】禁止空白!!');
						return;
					}
					
					$('.str').attr('disabled', 'disabled');
					
					$('#btnOk_uj').attr('disabled', 'disabled');
					$('#combProductno').attr('disabled', 'disabled');
					$('#btnEnda_uj').removeAttr('disabled');
					$('#btnModi_uj').removeAttr('disabled');
				});
				
				//這功能應該表示現在進行生產，非真正完工(尚未確認)
				$('#btnEnda_uj').click(function() {
					//寫入cugs issel 表示 現產,orguindate 表示已入庫
					if(emp($('#txtNoa').val()) || emp($('#txtNoq').val())){
						alert('【派工單】禁止空白!!');
						return;
					}
					if(emp($('#txtMechno').val())){
						alert('【機台別】禁止空白!!');
						return;
					}
					var t_noa=$('#txtNoa').val();
					var t_noq=$('#txtNoq').val();
					var t_uno=replaceAll(q_date(),'/','').slice(-6)+$('#txtMechno').val();
					var t_uno1=$('#txtUno1').val();
					var t_uno2=$('#txtUno2').val();
					var t_uno3=$('#txtUno3').val();
					if(t_noa.length>0){
						q_func('qtxt.query.cugssel', 'orde_uj.txt,cugssel,' + encodeURI(t_noa)+';'+encodeURI(t_noq)+';'+encodeURI(r_accy)+';'+encodeURI(t_uno)+';'+encodeURI(t_uno1)+';'+encodeURI(t_uno2)+';'+encodeURI(t_uno3),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							alert('派工單【'+as[0].noa+'】生產料號【'+as[0].productno+'】進行生產投入及產出!!');
							$('#lblCugsuno').text(as[0].nosold);
							
							$('#combProductno').attr('disabled', 'disabled');
							$('#btnModi_uj').attr('disabled', 'disabled');
							$('#btnEnda_uj').attr('disabled', 'disabled');
						}else{
							alert('【派工單】遺失，畫面請重刷並請重新輸入!!');
						}
					}
					if(t_noa.length==0){
						alert('請輸入派工單號!!');
					}
				});
				
				$('#btnCancel_uj').click(function() {
					location.href=location.href;
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
		<p align="center" style="height: 10px;width: 1200px;">
			<a style="font-size: 20px;font-weight: bolder;text-align: center;">投入及產出作業</a>
		</p>
		<table id="table_cugtitle" style="width:1200px" cellpadding='2'  cellspacing='0'>
			<tr align="center">
				<td style="width: 105px;"><select id="combSourcetitle" class="csource"> </select></td>
				<td style="width: 100px;"><a class="lbl btn">派工單</a></td>
				<td style="width: 225px;">
					<input id="txtNoa" type="text" class="txt c1 str" style="width: 150px;"/>
					<input id="txtNoq" type="hidden"/>
				</td>
				<td style="width: 100px;"><a class="lbl">加工日</a></td>
				<td style="width: 150px;"><input id="txtDatea" type="text" class="txt c1" style="width: 100px;" disabled="disabled"/></td>
				<td style="width: 130px;"><a class="lbl">製造機台別</a></td>
				<td style="width: 75px;"><input id="txtMechno" type="text" class="txt c1" disabled="disabled"/></td>
				<td style="width: 115px;"><input id="btnDownimg" type="button" value="畫面擷取"><a id="Downimg"> </a></td>
				<td style="width: 200px;"><a id="lblTimea" class="lbl"> </a></td>
			</tr>
		</table>
		<table id="table_cug" style="width:1200px;border-top:1px #000000 solid;border-bottom:1px #000000 solid;border-left:1px #000000 solid;border-right:1px #000000 solid;" cellpadding='2' cellspacing='0'>
			<tr align="center" style="height: 30px;">
				<td style="background-color: gainsboro;width: 105px;" align="center">來源</td>
				<td style="background-color: gainsboro;width: 100px;">警告</td>
				<td style="background-color: gainsboro;width: 100px;">製程別</td>
				<td style="background-color: gainsboro;width: 100px;">條件</td>
				<td style="background-color: gainsboro;width: 250px;">投入</td>
				<td style="background-color: gainsboro;width: 100px;">產量</td>
				<td style="background-color: gainsboro;width: 445px;" colspan="2">產出</td>
			</tr>
			<tr align="center" style="height: 55px;">
				<td><select id="combSource1" class="csource"> </select></td>
				<td><input id="txtAlert1" type="text" class="txt c1" disabled="disabled"></td>
				<td>上皮</td>
				<td>條件1<BR>(批號)</td>
				<td>
					<input id="txtF06" type="text" class="txt c1" disabled="disabled"><BR>
					<input id="txtUno1" type="text" class="txt c1 str">
				</td>
				<td><a id="lblF07">0</a></td>
				<td style="width: 300px;">
					<input id="txtProductno" type="text" class="txt c1" style="width:250px;" disabled="disabled">
					<select id="combProductno" style="width: 20px;display: none;"> </select>
				</td>
				<td style="width: 145px;"><a id="lblUcatype"> </a></td>
			</tr>
			<tr align="center" style="height: 55px;">
				<td><select id="combSource2" class="csource"> </select></td>
				<td><input id="txtAlert2" type="text" class="txt c1" disabled="disabled"></td>
				<td>上紙</td>
				<td>條件2<BR>(批號)</td>
				<td>
					<input id="txtF09" type="text" class="txt c1" disabled="disabled"><BR>
					<input id="txtUno2" type="text" class="txt c1 str">
				</td>
				<td><a id="lblF10">0</a></td>
				<td>
					<a style="float: left;">符合條件</a><a id="lblCugcount"> </a><a>筆</a><BR>
					<a style="float: left;">皮長度(M)</a><a id="lblUcatrans"> </a>
				</td>
				<td><a id="lblCugsuno"> </a></td>
			</tr>
			<tr align="center" style="height: 55px;">
				<td><select id="combSource3" class="csource"> </select></td>
				<td><input id="txtAlert3" type="text" class="txt c1" disabled="disabled"></td>
				<td>上膠</td>
				<td>條件3<BR>(批號)</td>
				<td>
					<input id="txtF08" type="text" class="txt c1" disabled="disabled"><BR>
					<input id="txtUno3" type="text" class="txt c1 str">
				</td>
				<td><a id="lblS3mount">0</a></td>
				<td><a style="float: left;">列管備註</a><a id="lblF12"> </a></td>
				<td> </td>
			</tr>
			<tr align="center" style="height: 55px;">
				<td><a>無此組合</a></td>
				<td><input id="txtAlert4" type="text" class="txt c1" disabled="disabled"></td>
				<td> </td>
				<td><input type='button' id='btnModi_uj' style='font-size:16px;' value="修改" disabled="disabled"/></td>
				<td><input type='button' id='btnOk_uj' style='font-size:16px;' value="ENTER"/></td>
				<td> </td>
				<td><input type='button' id='btnEnda_uj' style='font-size:16px;' value="完工" disabled="disabled"/></td>
				<td><input type='button' id='btnCancel_uj' style='font-size:16px;' value="清除" /></td>
			</tr>
		</table>
	</body>
</html>