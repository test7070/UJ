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
            q_tables = 't';
            var q_name = "cub";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 5;
            aPop = new Array(
            	['txtCustno', 'lblCustno_uj', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            	['txtM3', 'lblM3_uj', 'cust', 'noa,comp', 'txtM3,txtM4', 'cust_b.aspx'],
            	['txtProcessno', 'lblProcessno_uj', 'store', 'noa,store', 'txtProcessno,txtProcess', 'store_b.aspx'],
            	['txtProductno_', 'btnProduct_', 'uca', 'noa', '0txtProductno_', 'uca_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function sum() {
                for (var j = 0; j < q_bbsCount; j++) {
					
                }
            }
            
            function bbsremake(t_n) {
            	//製造成品
                if($('#txtProductno_'+t_n).val().substr(0,1)=='5' || emp($('#txtProductno2_'+t_n).val())){
                	$('#txtX01_'+t_n).val(0);
                }else if(q_add(dec($('#txtW01_'+t_n).val()),dec($('#txtW02_'+t_n).val()))>=dec($('#txtMount_'+t_n).val())){
                	$('#txtX01_'+t_n).val(0);
                }else{
                	$('#txtX01_'+t_n).val(q_sub(dec($('#txtMount_'+t_n).val()),q_add(dec($('#txtW01_'+t_n).val()),dec($('#txtW02_'+t_n).val()))));
                }
                
                //製造換算
                if(emp($('#txtProductno2_'+t_n).val())){
                	$('#txtX03_'+t_n).val(0);
                }else if($('#txtProductno_'+t_n).val().substr(0,1)=='5'){
                	$('#txtX03_'+t_n).val($('#txtMount_'+t_n).val());
                }else{
                	var t_badperc=1;//取得良率
                	q_gt('uca',"where=^^noa='"+$('#txtProductno2_'+t_n).val()+"'^^", 0, 0, 0, "getuca", r_accy,1);
					var tuca = _q_appendData("uca", "", true);
					if (tuca[0] != undefined) {
						t_badperc=dec(tuca[0].badperc);
					}
                	
                	$('#txtX03_'+t_n).val(q_add(q_div(q_div(q_mul(dec($('#txtX01_'+t_n).val()),dec($('#txtLengthb_'+t_n).val())),(dec($('#txtDime_'+t_n).val())==0?1:dec($('#txtDime_'+t_n).val()))),(t_badperc==0?1:t_badperc)),dec($('#txtX02_'+t_n).val())));
                }
                
                //加工原生產成品
                if($('#txtProductno_'+t_n).val().substr(0,1)=='1' || $('#txtProductno_'+t_n).val().substr(0,1)=='5'){
                	$('#txtX06_'+t_n).val(0);
                }else if(q_sub(dec($('#txtMount_'+t_n).val()),dec($('#txtW01_'+t_n).val()))<0){
                	$('#txtX06_'+t_n).val(0);
                }else{
                	$('#txtX06_'+t_n).val(q_sub(dec($('#txtMount_'+t_n).val()),dec($('#txtW01_'+t_n).val())));
                }
                
                //加工成品
                $('#txtX08_'+t_n).val(q_add(dec($('#txtX06_'+t_n).val()),dec($('#txtX07_'+t_n).val())));
                
                //底材合計
                var t_w05=0;
                for (var j = 0; j < q_bbsCount; j++) {
					if($('#txtOrdcno_'+t_n).val()==$('#txtOrdcno_'+j).val()){
						t_w05=q_add(t_w05,dec($('#txtX03_'+j).val()));
					}
                }
                $('#txtW05_'+t_n).val(t_w05);
                
                
                //低於MOQ
                if($('#txtProductno_'+t_n).val().substr(0,1)=='5'){
                	$('#txtX05_'+t_n).val(0);
                }else{
                	if(dec($('#txtW05_'+t_n).val())<dec($('#txtX04_'+t_n).val())){
                		$('#txtX05_'+t_n).val(q_sub(dec($('#txtX04_'+t_n).val()),dec($('#txtW05_'+t_n).val())));
                	}else{
                		$('#txtX05_'+t_n).val(0);
                	}
                }
                
                //同紙 同半成品(已排程/未排程)
                if(emp($('#txtOrdcno_'+t_n).val()) || dec($('#txtX03_'+t_n))==0){
                	$('#txtY01_'+t_n).val(0);
                	$('#txtY02_'+t_n).val(0);
                	$('#txtY03_'+t_n).val(0);
                	$('#txtY04_'+t_n).val(0);
                }else{
                	q_func('qtxt.query.schlen_uj', 'orde_uj.txt,schlen_uj,' + encodeURI($('#txtOrdcno_'+t_n).val())+';'+encodeURI($('#txtProductno2_'+t_n).val()),r_accy,1);
                	var tas = _q_appendData("tmp0", "", true, true);
                	if (tas[0] != undefined) {
                		$('#txtY03_'+t_n).val(tas[0].ymount1);//同紙(已排程)
	                	$('#txtY04_'+t_n).val(tas[0].ymount2);//同半成品(已排程)
	                	$('#txtY01_'+t_n).val(q_add(q_sub(tas[0].xmount1,dec($('#txtX03_'+t_n).val())),dec(tas[0].ymount1)));//同紙(未排程)
	                	$('#txtY02_'+t_n).val(q_add(q_sub(tas[0].xmount2,dec($('#txtX03_'+t_n).val())),dec(tas[0].ymount2)));//同半成品(未排程)
                	}
                }
                
                //物料需求(支) 紙管(根)
                if($('#txtProductno_'+t_n).val().substr(0,1)=='5'){
                	$('#txtY08_'+t_n).val(0);
                }else{
                	$('#txtY08_'+t_n).val(q_div(dec($('#txtX08_'+t_n).val()),(dec($('#txtDime_'+t_n).val())==0?1:dec($('#txtDime_'+t_n).val()))));
                }
                
                var t_packs=0,t_stationg='';//裝箱支數,塞頭
                q_gt('uca',"where=^^noa='"+$('#txtProductno_'+t_n).val()+"'^^", 0, 0, 0, "getuca", r_accy,1);
				var tuca = _q_appendData("uca", "", true);
				if (tuca[0] != undefined) {
					t_packs=dec(tuca[0].packs);
					t_stationg=tuca[0].stationg;
				}
                //物料需求(支) 紙箱(箱)
                if($('#txtProductno_'+t_n).val().substr(0,1)=='5'){
                	$('#txtY09_'+t_n).val(0);
                }else{
                	$('#txtY09_'+t_n).val(q_div(dec($('#txtX08_'+t_n).val()),(t_packs==0?1:t_packs)));
                }
                
                //物料需求(支) 塞頭(個)
                if($('#txtProductno_'+t_n).val().substr(0,1)=='5' || t_stationg=='無'){
                	$('#txtY10_'+t_n).val(0);
                }else{
                	$('#txtY10_'+t_n).val(q_mul(dec($('#txtX08_'+t_n).val()),2));
                }
            }

            function mainPost() {
            	bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1]];
            	bbtNum = [['txtGmount', 10, q_getPara('vcc.mountPrecision'), 1],['txtMount', 10, q_getPara('vcc.mountPrecision'), 1]];
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMedate', r_picd]];
                bbsMask = [['txtDatea', r_picd],['txtDate2', r_picd]];
                q_mask(bbmMask);
                
                document.title='生產指令';
                
                /*$('#btnOrde').click(function() {
                	var t_where="1=1";
                	var t_custno=$('#txtCustno').val();
                	var t_ordeno=$('#txtOrdeno').val();
                	var t_datea=$('#txtBdate').val();
                	var t_noa=$('#txtNoa').val();
                	if(t_custno.length==0){t_custno='#non';}
                	if(t_ordeno.length==0){t_ordeno='#non';}
                	if(t_datea.length==0){t_datea='#non';}
                	if(t_noa.length==0){t_noa='#non';}
                	if(q_cur==1 || q_cur==2){
                		q_func('qtxt.query.orde_import_uj', 'orde_uj.txt,orde_import_uj,' + encodeURI(t_custno)+';'+encodeURI(t_ordeno)+';'+encodeURI(t_datea)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
                	}
                	
                });*/
               
				$('#btnCug').click(function() {
					//不經"生管"排程  直接轉cug
					
				});
				
				$('#btnEnda').click(function() {
					//正常作業下當完成【出貨單】作業,按下"完工"此筆"生產指令"完成任務,如有剩餘料自動轉帳到:s倉:成品計畫性,T倉:成品計畫性
					//按下"完工"時,如果餘料為"成-計"會轉入S倉,此時系統自動產生調撥單 (目的倉庫存放成品區域不同,由T倉轉移至S倉)
					//1.當對應所有"生產指令"都"完工",方可執行完工作業
					//2.權限為"生產"
					
				});
                
                $('#btnClose_div_stk').click(function() {
                	//判斷是否是負庫存
                	var s_emount=dec($('#s_totlstk').text());//總庫存
					var s_prmount=dec($('#s_prstk').text());//前單預扣
					var s_psmount=dec($('#s_psstk').text());//前單指定
					var s_prmounts=dec($('#textPrmount').val());//預扣
                	var s_psmounts=0;//指定
					$('.stksnum').each(function(index) {
						s_psmounts=s_psmounts+dec($(this).val());
					});
					if(q_sub(q_sub(q_sub(q_sub(s_emount,s_prmount),s_psmount),s_prmounts),s_psmounts)<0){
						alert('預扣/指定數量大於可用庫存!!');
						return;
					}
                	
                	//刪除已寫入的bbt
                	for (var i = 0; i < q_bbtCount; i++) {
                		if($('#s_bbsnoq').val()==$('#txtNor__'+i).val() && $('#s_bbssource').val()==$('#txtSource__'+i).val()){
                			$('#btnMinut__'+i).click();
                		}
                	}
                	//寫入bbt
                	var tas=[];
                	if($('#checkPrmount').prop('checked')){
                		//預扣
                		if(dec($('#textPrmount').val())>0){
	                		tas.push({
								nor : $('#s_bbsnoq').val(), //非bbsnoq 因 存檔時 bbsnoq尚未產生
								uno : '',
								productno : $('#s_productno').text(),
								source : $('#s_bbssource').val(),//2半成品8再製品
								gmount : 0,//實際領料
								mount:$('#textPrmount').val()//配料
							});
						}
                	}else{
                		//指定
                		var rowslength=document.getElementById("table_stk").rows.length-10;
						for (var j = 0; j < rowslength; j++) {
							if(dec($('#stk_txtPrmount_'+j).val())>0){
								tas.push({
									nor : $('#s_bbsnoq').val(), //非bbsnoq 因 存檔時 bbsnoq尚未產生
									uno : $('#stk_tdUno_'+j).text(),
									productno : $('#s_productno').text(),
									source : $('#s_bbssource').val(),//2半成品8再製品
									gmount : 0,//實際領料
									mount:$('#stk_txtPrmount_'+j).val()//配料
								});
							}
						}
                	}
                	
                	q_gridAddRow(bbtHtm, 'tbbt'
					, 'txtNor,txtUno,txtProductno,txtSource,txtGmount,txtMount', tas.length, tas
					, 'nor,uno,productno,source,gmount,mount', 'txtNor,txtUno,txtProductno');
                	
                	//寫入bbs 半成品+再製品庫存(M)
                	var t_mount=0,t_n=$('#s_bbsnoq').val();
	                if($('#s_bbssource').val()=='2'){
	                	for(var i=0;i<tas.length;i++){
	                		t_mount=q_add(t_mount,dec(tas[i].mount));
	                	}
	                	$('#txtW03_'+t_n).val(t_mount);
                	}
                	
                	if($('#s_bbssource').val()=='8'){
	                	for(var i=0;i<tas.length;i++){
	                		t_mount=q_add(t_mount,dec(tas[i].mount));
	                	}
	                	$('#txtW04_'+t_n).val(t_mount);
                	}
                	//重新計算製造成品
                	//bbsremake(t_n);
                	
                	pdate(t_n);
                	$('#div_stk').hide();
				});
                
                $('#btnClose_div_stk2').click(function() {
                	$('#div_stk').hide();
				});
                
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                   case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            
           
            function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.orde_import_uj':
						var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click()
							}						
							q_gridAddRow(bbsHtm, 'tbbs'
							, 'txtOrdeno,txtNo2,txtProductno,txtProduct,txtMount,txtUnit,txtBtime,txtWidth,txtLengthb,txtDime,txtW01,txtProductno2,txtEtime,txtX01,txtX02,txtX03,txtX06,txtX07,txtX08,txtOrdcno,txtDate2,txtW04,txtW05,txtOth,txtX04,txtX05,txtY01,txtY02,txtY03,txtY04,txtProcessno,txtY08,txtCno,txtY09,txtTggno,txtY10,txtMakeno,txtDate3,txtW06,txtOrdcno2,txtHdate,txtW07', as.length, as
							, 'noa,no2,productno,product,mount,unit,salea,width,lengthb,dime,smount,productno2,sale2,tmount,tmount2,tmount3,amount,amount2,amount3,productno3,sale3,cmount,cmount2,moqlimited,moq,moqbelow,xmount1,xmount2,ymount1,ymount2,uproductno1,umount1,uproductno2,umount2,uproductno3,umount3,productno4,sale4,dmount,productno5,sale5,emount', '');
							//,txtW02,txtW03
							//,smount3,smount2
                		}else{
                			alert('無訂單資料!!');
                		}
						break;
				}
								
				if(t_func.substr(0,21)=='qtxt.query.ordestk_uj'){
					var t_n=replaceAll(t_func,'qtxt.query.ordestk_uj_','')
					var as = _q_appendData("tmp0", "", true, true);
					
					var text_prmount=0;
					//扣除bbt已配置其他bbs領料數量
					//加回bbt已實際領料的批號數量
					for (var i = 0; i < q_bbtCount; i++) {
						if($('#s_bbssource').val()==$('#txtSource__'+i).val()){
							if($('#txtNor__'+i).val()!=t_n){ //非自身已領料
								if(emp($('#txtUno__'+i).val())){//預扣
									for (var j = 0; j < as.length; j++) {
										if(as[j].productno==$('#txtProductno__'+i).val()){
											as[j].prmount=q_add(dec(as[j].prmount),q_add(dec($('#txtGmount__'+i).val()),dec($('#txtMount__'+i).val())));
										}
									}
								}else{//指定
									for (var j = 0; j < as.length; j++) {
										if(as[j].uno==$('#txtUno__'+i).val()){
											as[j].psmount=q_add(dec(as[j].psmount),q_add(dec($('#txtGmount__'+i).val()),dec($('#txtMount__'+i).val())));
										}
									}
								}
							}else{//領料一定要有批號才能領
								if(dec($('#txtGmount__'+i).val())>0 && !emp($('#txtUno__'+i).val())){//實際已扣庫存
									var isexists=false;
									for (var j = 0; j < as.length; j++) {
										if(as[j].uno==$('#txtUno__'+i).val()){
											as[j].emount=q_add(dec(as[j].emount),dec($('#txtGmount__'+i).val()));
											isexists=true;
											break;
										}
									}
									//批號不存在
									if(!isexists){
										as.push({
											uno : $('#txtUno__'+i).val(),
											productno : $('#txtProductno__'+i).val(),
											product : '',
											emount : $('#txtGmount__'+i).val(),
											memo : '',
											psmount : 0,
											prmount : 0
										});
									}
								}
								
								if(dec($('#txtGmount__'+i).val())==0 && emp($('#txtUno__'+i).val())){
									text_prmount=q_add(text_prmount,dec($('#txtMount__'+i).val()));
								}
							}
						}
					}
					
					$('#textPrmount').val(text_prmount);
					
					if (as[0] != undefined) {
						var t_emount=0;//總庫存
						var t_prmount=0;//前單預扣
						var t_psmount=0;//前單指定
						
						var rowslength=document.getElementById("table_stk").rows.length-10;
						for (var j = 0; j < rowslength; j++) {
							document.getElementById("table_stk").deleteRow(9);
						}
						
						for (var i = 0; i < as.length; i++) {
							t_emount=q_add(t_emount,dec(as[i].emount));
							t_prmount=dec(as[i].prmount);//非累加
							t_psmount=q_add(t_psmount,dec(as[i].psmount));
							
							var t_unomount=0;
							for (var j = 0; j < q_bbtCount; j++) {
								if(as[i].uno==$('#txtUno__'+j).val() && t_n==$('#txtNor__'+j).val() && $('#s_bbssource').val()==$('#txtSource__'+j).val()){
									t_unomount=dec($('#txtMount__'+j).val());
									break;
								}
							}
							
							var tr = document.createElement("tr");
							tr.id = "bbs_"+i;
							tr.innerHTML+="<td id='stk_tdUno_"+i+"'>"+as[i].uno+"</td>";
							tr.innerHTML+="<td id='stk_tdMount_"+i+"'style='text-align: right;'>"+dec(as[i].emount)+"</td>";
							tr.innerHTML+="<td id='stk_tdPsmount_"+i+"' style='text-align: right;'>"+dec(as[i].psmount)+"</td>";
							tr.innerHTML+= "<td id='stk_tdPrmount_"+i+"'><input id='stk_txtPrmount_"+i+"' type='text' class='stknum stksnum' style='width: 98%;text-align: right;' value='"+t_unomount+"' /></td>";
							tr.innerHTML+="<td id='stk_tdMemo_"+i+"'>"+as[i].memo+"</td>";
								
							var tmp = document.getElementById("stk_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						$('.stknum').each(function(index) {
							$(this).unbind('keyup');
							$(this).unbind('change');
							
							$(this).keyup(function() {
								var tmp=$(this).val();
								tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
								$(this).val(tmp);
							});
							
							$(this).change(function() {
								var t_id=$(this).attr('id');
								var s_emount=dec($('#s_totlstk').text());//總庫存
								var s_prmount=dec($('#s_prstk').text());//前單預扣
								var s_psmount=dec($('#s_psstk').text());//前單指定
								var s_prmounts=dec($('#textPrmount').val());//預扣
								
								if(t_id=='textPrmount'){
									if(s_prmounts>q_sub(q_sub(s_emount,s_prmount),s_psmount)){
										alert('預扣長度大於總庫存長度!!');
										$('#textPrmount').val(q_sub(q_sub(s_emount,s_prmount),s_psmount));
										s_prmounts=dec($('#textPrmount').val());
									}
								}else{
									var t_n=$(this).attr('id').split('_')[2];
									var st_mount=dec($('#stk_tdMount_'+t_n).text());
									var st_psmount=dec($('#stk_tdPsmount_'+t_n).text());
									var st_prmount=dec($('#stk_txtPrmount_'+t_n).val());
									var t_uno=$('#stk_tdUno_'+t_n).text();
									if(st_mount<q_add(st_psmount,st_prmount)){
										alert('生產編號【'+t_uno+'】鎖定與指定長度大於總長度!!');
										$('#stk_txtPrmount_'+t_n).val(q_sub(st_mount,st_psmount));
									}
								}
								
								var s_psmounts=0;//指定
								$('.stksnum').each(function(index) {
									s_psmounts=s_psmounts+dec($(this).val());
								});
								$('#s_psmount').text(s_psmounts);
								
								$('#s_canusestk').text(q_sub(q_sub(q_sub(q_sub(s_emount,s_prmount),s_psmount),s_prmounts),s_psmounts));
							});
						});
						
						$('#s_totlstk').text(t_emount);//總庫存
						$('#s_prstk').text(t_prmount);//前單預扣
						$('#s_psstk').text(t_psmount);//前單指定
						$('#s_canusestk').text(q_sub(q_sub(t_emount,t_prmount),t_psmount));
						
						$('#checkPrmount').unbind('click');
						$('#checkPrmount').click(function() {
							if($(this).prop('checked')){
								$('#textPrmount').removeAttr('disabled');
								$('.stksnum').val(0).attr('disabled','disabled');
								$('#checkPsmountAll').prop('checked',false);
								$('#checkPsmountAll').attr('disabled','disabled');
							}else{
								$('#textPrmount').val(0).attr('disabled','disabled');
								$('.stksnum').removeAttr('disabled');
								$('#checkPsmountAll').removeAttr('disabled');
							}
							$('#textPrmount').change();
						});
						
						$('#checkPsmountAll').unbind('click');
						$('#checkPsmountAll').click(function() {
							var s_psmounts=0;//指定
							if($(this).prop('checked')){
								$('.stksnum').each(function(index) {
									var t_n=$(this).attr('id').split('_')[2];
									var st_mount=dec($('#stk_tdMount_'+t_n).text());
									var st_psmount=dec($('#stk_tdPsmount_'+t_n).text());
									$(this).val(q_sub(st_mount,st_psmount));
									s_psmounts=s_psmounts+dec($(this).val());
								});
							}else{
								$('.stksnum').val(0);
							}
							
							$('#s_psmount').text(s_psmounts);
							$('#textPrmount').change();
						});
						
						//開啟div
						if(text_prmount>0){
							$('#textPrmount').removeAttr('disabled');
							$('#checkPrmount').prop('checked',true);
							$('#checkPsmountAll').prop('checked',false);
							$('#checkPsmountAll').attr('disabled','disabled');
							$('.stksnum').attr('disabled','disabled');
						}else{
							$('#textPrmount').val(0).attr('disabled','disabled');
							$('#checkPrmount').prop('checked',false);
							$('#checkPsmountAll').prop('checked',false);
							$('#checkPsmountAll').removeAttr('disabled');
						}
						$('#s_psmount').text(0);
						$('#textPrmount').change();
						$('#div_stk').show();
					}else{
						alert('無庫存!!');
					}
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

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
				q_box('cub_uj_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                //q_box('z_cubp_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
			
            function btnOk() {
            	t_err = q_chkEmpField([['txtDatea', '日期']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                
                sum();
                
                if(q_cur==1){
                	$('#txtWorker').val(r_name);
                }else{
                	$('#txtWorker2').val(r_name);
                }
                                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['ordeno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function bbtSave(as) {
                if (!as['productno'] && !as['uno'] && !as['nor']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#btnOrde').attr('disabled','disabled');
                	$('#btnEnda').removeAttr('disabled');
                	$('#btnCug').removeAttr('disabled');
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP1_'+i).attr('disabled','disabled');
                		$('#btnP2_'+i).attr('disabled','disabled');
                	}
                }else{
                	$('#btnOrde').removeAttr('disabled');
                	$('#btnEnda').attr('disabled','disabled');
                	$('#btnCug').attr('disabled','disabled');
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP1_'+i).removeAttr('disabled');
                		$('#btnP2_'+i).removeAttr('disabled');
                	}
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtUcolor_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_engpro=$('#txtUcolor_'+b_seq).val();
							if(t_engpro.length>0){//判斷舊編號
								q_gt('uca',"where=^^engpro='"+t_engpro+"'^^", 0, 0, 0, "getuca", r_accy,1);
								var tuca = _q_appendData("uca", "", true);
								if (tuca[0] != undefined) {
									if(tuca[0].typea=='2'){//成品
										$('#txtProductno_'+b_seq).val(tuca[0].noa);
										$('#txtBtime_'+b_seq).val(tuca[0].groupdno);//銷售政策
										$('#txtWidth_'+b_seq).val(tuca[0].mechs);//寬(mm)
										$('#txtLengthb_'+b_seq).val(tuca[0].trans);//長(M)	
										$('#txtUnit_'+b_seq).val(tuca[0].unit);//單位
										
										$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
										$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品
	
										if($('#txtProductno2_'+b_seq).val().length>0){
											var t_productno= $('#txtProductno2_'+b_seq).val();
	                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
	                        				var tpuca = _q_appendData("uca", "", true);
	                        				if (tpuca[0] != undefined) {
												$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
												$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
												$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
											}
										}
									}else{
										t_unit1=t_engpro.substr(0,1).toLocaleUpperCase();
										if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
											$('#txtUnit_'+b_seq).val('支');//單位
										}else if(t_unit1=='C'){
											$('#txtUnit_'+b_seq).val('張');//單位
										}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
											$('#txtUnit_'+b_seq).val('M');//單位
										}else{
											$('#txtUnit_'+b_seq).val('');//單位
										}
										
										if(tuca[0].typea=='3'){//半成品
											$('#txtProductno2_'+b_seq).val(t_engpro)//中繼產品料號
											if($('#txtProductno2_'+b_seq).val().length>0){
												var t_productno= $('#txtProductno2_'+b_seq).val();
		                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
		                        				var tpuca = _q_appendData("uca", "", true);
		                        				if (tpuca[0] != undefined) {
													$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
													$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
													$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
												}
											}
										}
									}
								}else{//判斷新編號
									$('#txtProductno_'+b_seq).val(t_engpro);
									q_gt('uca',"where=^^noa='"+t_engpro+"'^^", 0, 0, 0, "getuca", r_accy,1);
									var tuca = _q_appendData("uca", "", true);
									if (tuca[0] != undefined) {
										if(tuca[0].typea=='2'){//成品
											$('#txtProductno_'+b_seq).val(tuca[0].noa);
											$('#txtBtime_'+b_seq).val(tuca[0].groupdno);//銷售政策
											$('#txtWidth_'+b_seq).val(tuca[0].mechs);//寬(mm)
											$('#txtLengthb_'+b_seq).val(tuca[0].trans);//長(M)	
											$('#txtUnit_'+b_seq).val(tuca[0].unit);//單位
											
											$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
											$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品
		
											if($('#txtProductno2_'+b_seq).val().length>0){
												var t_productno= $('#txtProductno2_'+b_seq).val();
		                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
		                        				var tpuca = _q_appendData("uca", "", true);
		                        				if (tpuca[0] != undefined) {
													$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
													$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
													$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
												}
											}
										}else{
											t_unit1=t_engpro.substr(0,1).toLocaleUpperCase();
											if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
												$('#txtUnit_'+b_seq).val('支');//單位
											}else if(t_unit1=='C'){
												$('#txtUnit_'+b_seq).val('張');//單位
											}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
												$('#txtUnit_'+b_seq).val('M');//單位
											}else{
												$('#txtUnit_'+b_seq).val('');//單位
											}
											
											if(tuca[0].typea=='3'){//半成品
												$('#txtProductno2_'+b_seq).val(t_engpro)//中繼產品料號
												if($('#txtProductno2_'+b_seq).val().length>0){
													var t_productno= $('#txtProductno2_'+b_seq).val();
			                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
			                        				var tpuca = _q_appendData("uca", "", true);
			                        				if (tpuca[0] != undefined) {
														$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
														$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
														$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
													}
												}
											}
										}
									}else{
										alart('無此料號!!');
									}
								}
							}
						});
                    	
                    	$('#txtMount_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtProductno_' + b_seq).val().length>0){
	                        	var t_productno= $('#txtProductno_' + b_seq).val();
	                        	var t_mount= dec($('#txtMount_'+b_seq).val());
	                        	var t_weight= 0;
	                        	var t_ptype='';//類別
	                        	var t_makes=0;//半-計 交期
	                        	var t_pretime=0;//半-訂 交期
	                        	var t_preday=0;//訂單交期
	                        	q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca", r_accy,1);
								var tuca = _q_appendData("uca", "", true);
								if (tuca[0] != undefined) {
									t_ptype=tuca[0].typea;
									if(tuca[0].typea=='2'){//成品
										//公式2 支數轉長度(支→M)
										//=需求支數÷ROUNDDOWN(標準半成品長÷成品長/支×良率%,0),0)×標準半成品長÷裁切數
										
										t_makes=tuca[0].makes
										t_pretime=tuca[0].pretime
										t_preday=tuca[0].preday
										var t_productno2=tuca[0].groupbno//半成品
										var t_p2lengb=0;//標準半成品長
										var t_p1lengb=tuca[0].trans;//成品長
										var t_p1badperc=tuca[0].badperc;//良率%
										t_p1badperc=dec(t_p1badperc)/100.0;
										var t_p1molds=dec(tuca[0].molds);//裁切數
										if(t_p1molds==0){
											t_p1molds=1;
										}
										if(t_productno2.length==0){//沒有資料抓表身半成品
											t_productno2=$('#txtProductno2_'+b_seq).val();
										}
										if(t_productno2.length>0){//抓半成品
											q_gt('uca',"where=^^noa='"+t_productno2+"'^^", 0, 0, 0, "getuca2", r_accy,1);
											var tuca2 = _q_appendData("uca", "", true);
											if (tuca2[0] != undefined) {
												t_p2lengb=tuca2[0].trans;
											}
										}
										t_weight=q_div(q_mul(q_div(t_mount,Math.floor(q_div(t_p2lengb,q_mul(t_p1lengb,t_p1badperc)))),t_p2lengb),t_p1molds);
									}else{
										//判斷單位是否為'M'
										if($.trim(tuca[0].unit).toLocaleUpperCase()=='M'){//單位
											t_weight=q_mul(dec(tuca[0].trans),t_mount);
										}
									}
								}
	                        		                        	
	                        	$('#txtWeight_'+b_seq).val(round(t_weight,4));//需求長度(M)
	                        	
	                        	pdate(b_seq);
	                        }
                    		
						});
						
						$('#btnP1_'+i).click(function(e) {//半成品
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtProductno_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtProductno2_' + b_seq).val();
	                        	var t_noa= $('#txtNoa').val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('2');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.ordestk_uj_'+b_seq, 'orde_uj.txt,ordestk_uj,' + encodeURI(t_productno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
							}
						});
						
						$('#btnP2_'+i).click(function(e) {//再製品
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtOrdcno2_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtOrdcno2_' + b_seq).val();
	                        	var t_noa= $('#txtNoa').val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('8');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.ordestk_uj_'+b_seq, 'orde_uj.txt,ordestk_uj,' + encodeURI(t_productno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
							}
						});
						
						$('#txtW01_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
						
						$('#txtW02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
						
						$('#txtW03_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
                    	
                    	$('#txtW04_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
						
						$('#txtW05_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
						
						$('#txtX02_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pdate(b_seq);
						});
                    }
                }
                _bbsAssign();
            }
            
            function pdate(t_n) {//交期
            	
            	if($('#txtProductno_' + t_n).val().length>0){
					var t_productno= $('#txtProductno_' + t_n).val();
					var t_mount= dec($('#txtMount_'+t_n).val());
					var t_ptype='';//類別
					var t_makes=0;//半-計 交期
					var t_pretime=0;//半-訂 交期
					var t_preday=0;//訂單交期
					q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca", r_accy,1);
					var tuca = _q_appendData("uca", "", true);
					if (tuca[0] != undefined) {
						t_ptype=tuca[0].typea;
						if(tuca[0].typea=='2'){//成品
							t_makes=tuca[0].makes
							t_pretime=dec(tuca[0].pretime)
							t_preday=dec(tuca[0].preday)
						}
					}
	            	//可動用庫存
					var t_w01=dec($('#txtW01_'+t_n).val());//可動用成品數
					var t_w02=dec($('#txtW02_'+t_n).val());//可動用成品長
					var t_w03=dec($('#txtW03_'+t_n).val());//半成品可動用(M)
					var t_w04=dec($('#txtW04_'+t_n).val());//再製品可動用(M)
					var t_w05=dec($('#txtW05_'+t_n).val());//上皮可動用(M)
		                        	
					var t_source='';//供貨滿足點
					var t_x01=0;//完工天數
					var t_x02=dec($('#txtX02_'+t_n).val());//自行評估完工天數
					var t_weight=dec($('#txtWeight_'+t_n).val());//需求長度(M)
					if(t_ptype=='2'){
						if(t_w01>=t_mount){
							t_source='成品';
							t_x01=1;
						}else if (t_w02+t_w03+t_w04>=t_weight){
							t_source='半成品';
							t_x01=t_makes;
						}else if (t_w02+t_w03+t_w04+t_w05>=t_weight){
							t_source='皮料';
							t_x01=t_pretime;
						}else{
							t_source='無';
							t_x01=t_preday;
						}
					}
					$('#txtSource_'+t_n).val(t_source);//供貨滿足點
					$('#txtX01_'+t_n).val(t_x01);//完工天數
		                        	
					if(t_x01==0 || t_x01.length==0){
						$('#txtDate2_'+t_n).val('生管確認');
					}else{
						var tt_date=$('#txtDatea').val();
						if(tt_date.length==0)
							tt_date=q_date();
						if(t_x02>0){
							tt_date=q_cdn(tt_date,t_x02+1);
						}else{
							tt_date=q_cdn(tt_date,t_x01+1);
						}
						$('#txtDate2_'+t_n).val(tt_date);
					}
				}
            }
            
            
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	
                    }
                }
                _bbtAssign();
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            function q_popPost(id) {
                switch (id) {
                   case 'txtProductno_':
                        if($('#txtProductno_' + b_seq).val().length>0){
                        	var t_productno= $('#txtProductno_' + b_seq).val();
                        	q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca", r_accy,1);
							var tuca = _q_appendData("uca", "", true);
							if (tuca[0] != undefined) {
								if(tuca[0].typea=='2'){//成品
									$('#txtBtime_'+b_seq).val(tuca[0].groupdno);//銷售政策
									$('#txtWidth_'+b_seq).val(tuca[0].mechs);//寬(mm)
									$('#txtLengthb_'+b_seq).val(tuca[0].trans);//長(M)
									if(tuca[0].groupdno=='特規')
										$('#txtUnit_'+b_seq).val('');//單位
									else
										$('#txtUnit_'+b_seq).val(tuca[0].unit);//單位
									
									$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
									$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品

									if($('#txtProductno2_'+b_seq).val().length>0){
										var t_productno= $('#txtProductno2_'+b_seq).val();
                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
                        				var tpuca = _q_appendData("uca", "", true);
                        				if (tpuca[0] != undefined) {
											$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
											$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
											$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
										}
									}
								}else{
									t_unit1=t_productno.substr(0,1).toLocaleUpperCase();
									if(t_unit1=='1' || t_unit1=='2' || t_unit1=='P' || t_unit1=='Z'|| t_unit1=='S'){
										$('#txtUnit_'+b_seq).val('支');//單位
									}else if(t_unit1=='C'){
										$('#txtUnit_'+b_seq).val('張');//單位
									}else if(t_unit1=='6' || t_unit1=='5' || t_unit1=='#'|| t_unit1=='7' || t_unit1=='8'){
										$('#txtUnit_'+b_seq).val('M');//單位
									}else{
										$('#txtUnit_'+b_seq).val('');//單位
									}
									
									if(tuca[0].typea=='3'){//半成品
										$('#txtProductno2_'+b_seq).val(t_productno)//中繼產品料號
										if($('#txtProductno2_'+b_seq).val().length>0){
											var t_productno= $('#txtProductno2_'+b_seq).val();
	                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
	                        				var tpuca = _q_appendData("uca", "", true);
	                        				if (tpuca[0] != undefined) {
												$('#txtClass_'+b_seq).val(tpuca[0].groupdno);//MOQ
												$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
												$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
											}
										}
									}
								}
							}
                        }
                        break;
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
               color: blue;
            }
            .dbbm {
                float: left;
                width: 75%;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 9%;
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
               color: black;
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
                width: 95%;
                float: left;
            }

            .num {
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
            input[type="text"], input[type="button"] ,select{
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
               color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 100%;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
               color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<!--#include file="../inc/toolbar.inc"-->
		<div id="div_stk" style="position:absolute; top:180px; left:20px; display:none; width:530px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr style="display: none;">
					<td style="width:530px;" colspan="5">
						<input id='s_bbsnoq' type="hidden">
						<input id='s_bbssource' type="hidden">
					</td>
				</tr>
				<tr>
					<td style="width:130px;" align="center">庫存料號</td>
					<td style="width:400px;" id='s_productno' colspan="4"> </td>
				</tr>
				<tr>
					<td style="width:130px;" align="center">總庫存</td>
					<td style="width:200px;" align="center" id='s_totlstk' colspan="2"> </td>
					<td style="width:100px;" align="center" rowspan="3">可用庫存</td>
					<td style="width:200px;" align="center" rowspan="3" id='s_canusestk' colspan="2"> </td>
				</tr>
				<tr>
					<td style="width:130px;" align="center">前單預扣</td>
					<td style="width:200px;" align="center" id='s_prstk' colspan="2"> </td>
				</tr>
				<tr>
					<td style="width:130px;" align="center">前單「指定」</td>
					<td style="width:200px;" align="center" id='s_psstk' colspan="2"> </td>
				</tr>
				<tr>
					<td style="width:530px;" align="center" colspan="5"> </td>
				</tr>
				<tr>
					<td style="width:330px;" colspan="3">
						<input id='checkPrmount' type="checkbox">本單不指定，所可用庫存
					</td>
					<td style="width:100px;" align="center">預扣</td>
					<td style="width:100px;" align="center"><input id='textPrmount' type="text" class="txt num stknum c1"></td>
				</tr>
				<tr>
					<td style="width:330px;" colspan="3">
						<input id='checkPsmountAll' type="checkbox">「指定」全選/清除
					</td>
					<td style="width:100px;" align="center">指定</td>
					<td style="width:100px;" align="center" id='s_psmount'> </td>
				</tr>
				<tr>
					<td style="width:130px;" align="center">生產編號</td>
					<td style="width:100px;" align="center">長</td>
					<td style="width:100px;" align="center">鎖住</td>
					<td style="width:100px;" align="center">指定</td>
					<td style="width:100px;" align="center">備註</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='5'>
						<input id="btnClose_div_stk" type="button" value="確定">
						<input id="btnClose_div_stk2" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa_uj'>指令流水號</a></td>
						<td style="width:100px; color:black;"><a id='vewDatea_uj'>立單日</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea_uj" class="lbl">立單日</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa_uj" class="lbl">指令流水號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblProduct_uj" class="lbl">指令名稱</a></td>
						<td><input id="txtProduct" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno_uj" class="lbl" >客戶</a></td>
						<td><input id="txtCustno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtComp" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="btnOrde" type="button" value="訂單匯入" style="display: none;" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProcessno_uj" class="lbl" >成品入庫倉別</a></td>
						<td><input id="txtProcessno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtProcess" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="btnCug" type="button" value="派工單"/></td>
						<td><input id="btnEnda" type="button" value="完工" /></td>
						<td><input id="chkMenda" type="checkbox" /><a id="lblMenda_uj" class="lbl" style="float: left;" >鎖單</a></td>
						<!--<td><span> </span><a id="lblOrdeno_uj" class="lbl" >訂單編號</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1" style="width: 99%;"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblEdate_uj" class="lbl" >交期</a></td>
						<td><input id="txtEdate" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><span> </span><a id="lblMedate_uj" class="lbl" >最快交期</a></td>
						<td><input id="txtMedate" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><span> </span><a id="lblBdate_uj" class="lbl" >上膠日</a></td>
						<td><input id="txtBdate" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM1_uj" class="lbl" >成品指令</a></td>
						<td colspan="5"><input id="txtM1" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM2_uj" class="lbl" >餘料指令</a></td>
						<td colspan="5"><input id="txtM2" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM3_uj" class="lbl" >指送客戶</a></td>
						<td><input id="txtM3" type="text" class="txt c1" style="width: 99%;"/></td>
						<td colspan="2"><input id="txtM4" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' style="min-width: 3550px;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:30px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:50px;">項次</td>
						<td style="width:180px;"><a id='lblUcolor_uj'>料號(需求)</a></td>
						<td style="width:90px;"><a id='lblBtime_uj_s'>銷售政策</a></td>
						<td style="width:180px;"><a id='lblProductno_uj_s'>新料號</a></td>
						<td style="width:90px;"><a id='lblWidth_uj_s'>寬(mm)</a></td>
						<td style="width:90px;"><a id='lblLengthb_uj_s'>長(M)</a></td>
						<td style="width:90px;"><a id='lblMount_uj_s'>數量</a></td>
						<td style="width:50px;"><a id='lblUnit_uj_s'>單位</a></td>
						<td style="width:90px;"><a id='lblWeight_uj_s'>需求長度(M)</a></td>
						<td style="width:90px;"><a id='lblClass_uj_s'>MOQ</a></td>
						<td style="width:90px;"><a id='lblOth_uj_s'>生產順位</a></td>
						<td style="width:180px;"><a id='lblMemo_uj_s'>備註</a></td>
						<td style="width:100px;"><a id='lblSource_uj_s'>供貨滿足點</a></td>
						<td style="width:90px;"><a id='lblX01_uj_s'>完工天數</a></td>
						<td style="width:90px;"><a id='lblX02_uj_s'>自行評估完工天數</a></td>
						<td style="width:100px;"><a id='lblDate2_uj_s'>完工日期</a></td>
						<td style="width:90px;"><a id='lblW01_uj_s'>成品數</a></td>
						<td style="width:90px;"><a id='lblW02_uj_s'>成品長</a></td>
						<td style="width:180px;"><a id='lblProductno2_uj_s'>中繼產品料號</a></td>
						<td style="width:50px;"><a>連接</a></td>
						<td style="width:90px;"><a id='lblW03_uj_s'>可動用(M)</a></td>
						<td style="width:180px;"><a id='lblOrdcno2_uj_s'>再製品</a></td>
						<td style="width:50px;"><a>連接</a></td>
						<td style="width:90px;"><a id='lblW04_uj_s'>可動用(M)</a></td>
						<td style="width:180px;"><a id='lblMakeno_uj_s'>製造"上皮"投入</a></td>
						<td style="width:90px;"><a id='lblW05_uj_s'>可動用(M)</a></td>
						<td style="width:90px;"><a id='lblW06_uj_s'>｢採｣可動用(M)</a></td>
						<td style="width:180px;"><a id='lblOrdcno_uj_s'>製造"上紙"投入</a></td>
						<td style="width:90px;"><a id='lblW07_uj_s'>可動用(M)</a></td>
						<td style="width:90px;"><a id='lblW08_uj_s'>｢採｣可動用(M)</a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
							<input id="txtOrdeno.*" type="text" style="display: none;"/><!--訂單用-->
							<input id="txtNo2.*" type="text" style="display: none;"/><!--訂單用-->
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtUcolor.*" type="text" class="txt c1"/></td>
						<td><input id="txtBtime.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtWidth.*" type="text" class="txt num c1"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
						<td><input id="txtClass.*" type="text" class="txt c1"/></td>
						<td><input id="txtOth.*" type="text" class="txt c1"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtSource.*" type="text" class="txt c1"/></td>
						<td><input id="txtX01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="txtW01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtProductno2.*" type="text" class="txt c1"/></td>
						<td><input id="btnP1.*" type="button" value="+"/></td>
						<td><input id="txtW03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno2.*" type="text" class="txt c1"/></td>
						<td><input id="btnP2.*" type="button" value="+"/></td>
						<td><input id="txtW04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMakeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtW05.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW06.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno.*" type="text" class="txt c1"/></td>
						<td><input id="txtW07.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW08.*" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="width: 750px;display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:40px;"> </td>
					<td style="width:80px;"><a id='lblNor_uj_t'>表身項次</a></td>
					<td style="width:180px;"><a id='lblUno_uj_t'>指定批號</a></td>
					<td style="width:150px;"><a id='lblProductno_uj_t'>對應品項</a></td>
					<td style="width:80px;"><a id='lblSource_uj_t'>對應來源</a></td>
					<td style="width:80px;"><a id='lblGmount_uj_t'>領料長度</a></td>
					<td style="width:80px;"><a id='lblMount_uj_t'>配料長度</a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtNor..*" type="text" class="txt c1"/></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtSource..*" type="text" class="txt c1"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>