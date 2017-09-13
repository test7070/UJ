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
            var q_readonlys = ['txtOrdeno', 'txtNo2'
            //成品
            ,'txtUnit','txtBtime','txtWidth','txtLengthb','txtDime','txtW01','txtW02','txtW03'
            //半成品
            ,'txtProductno2','txtEtime','txtX01','txtX03','txtOth','txtX04','txtX05','txtX06','txtX08'
            //底材
            ,'txtOrdcno','txtDate2','txtW04','txtW05'
            //排程
            ,'txtY01','txtY02','txtY03','txtY04'
            //物料需求
            ,'txtY08','txtY09','txtY10'
            //面材
            ,'txtMakeno','txtDate3','txtW06'
            //材料
            ,'txtOrdcno2','txtHdate','txtW07'
            ];
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
            	['txtProductno_', 'btnProduct_', 'uca', 'noa,product', 'txtProductno_,txtProduct_', 'uca_b.aspx']
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
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                bbsMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                document.title='訂單彙總表';
                
                $('#btnOrde').click(function() {
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
								source : $('#s_bbssource').val(),//1成品2半成品3底材4面料5材料6紙管7紙箱8塞頭
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
									source : $('#s_bbssource').val(),//1成品2半成品3底材4面料5材料6紙管7紙箱8塞頭
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
	                	$('#txtW02_'+t_n).val(0);
	                	//重新計算 半成品+再製品可變成成品(支)
	                	if(t_mount>0){
	                		var t_w02=0;
	                		t_w02=Math.floor(q_div(q_mul(t_mount,0.92),dec($('#txtLengthb_'+t_n).val())));
	                		if($('#txtProductno_'+t_n).val().substr(0,1)=='2' && !emp($('#txtMakeno_'+t_n).val())){
	                			q_gt('ucc',"where=^^noa='"+$('#txtMakeno_'+t_n).val()+"'^^", 0, 0, 0, "getucc", r_accy,1);
								var tucc = _q_appendData("ucc", "", true);
								if (tucc[0] != undefined) {
									if(dec(tucc[0].beginmount)>0){
										t_w02=q_sub(t_w02,Math.floor(q_div(t_mount,dec(tucc[0].beginmount))));
									}
								}
	                		}
	                		$('#txtW02_'+t_n).val(t_w02);
	                	}
                	}
                	//重新計算製造成品
                	bbsremake(t_n);
                	
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
				if(t_func.substr(0,17)=='qtxt.query.uca_uj'){
					var t_n=replaceAll(t_func,'qtxt.query.uca_uj_','')
					var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						$('#txtUnit_'+t_n).val(as[0].unit);
						$('#txtBtime_'+t_n).val(as[0].salea);
						$('#txtWidth_'+t_n).val(as[0].width);
						$('#txtLengthb_'+t_n).val(as[0].lengthb);
						$('#txtDime_'+t_n).val(as[0].dime);
						$('#txtW01_'+t_n).val(as[0].smount);
						//$('#txtW02_'+t_n).val(as[0].smount3);
						//$('#txtW03_'+t_n).val(as[0].smount2);
						$('#txtProductno2_'+t_n).val(as[0].productno2);
						$('#txtEtime_'+t_n).val(as[0].sale2);
						$('#txtX01_'+t_n).val(as[0].tmount);
						//$('#txtX02_'+t_n).val(as[0].tmount2);
						$('#txtX03_'+t_n).val(as[0].tmount3);
						$('#txtX06_'+t_n).val(as[0].amount);
						//$('#txtX07_'+t_n).val(as[0].amount2);
						$('#txtX08_'+t_n).val(as[0].amount3);
						$('#txtOrdcno_'+t_n).val(as[0].productno3);
						$('#txtDate2_'+t_n).val(as[0].sale3);
						$('#txtW04_'+t_n).val(as[0].cmount);
						$('#txtW05_'+t_n).val(as[0].cmount2);
						$('#txtOth_'+t_n).val(as[0].moqlimited);
						$('#txtX04_'+t_n).val(as[0].moq);
						$('#txtX05_'+t_n).val(as[0].moqbelow);
						$('#txtY01_'+t_n).val(as[0].xmount1);
						$('#txtY02_'+t_n).val(as[0].xmount2);
						$('#txtY03_'+t_n).val(as[0].ymount1);
						$('#txtY04_'+t_n).val(as[0].ymount2);
						$('#txtProcessno_'+t_n).val(as[0].uproductno1);
						$('#txtY08_'+t_n).val(as[0].umount1);
						$('#txtCno_'+t_n).val(as[0].uproductno2);
						$('#txtY09_'+t_n).val(as[0].umount2);
						$('#txtTggno_'+t_n).val(as[0].uproductno3);
						$('#txtY10_'+t_n).val(as[0].umount3);
						$('#txtMakeno_'+t_n).val(as[0].productno4);
						$('#txtDate3_'+t_n).val(as[0].sale4);
						$('#txtW06_'+t_n).val(as[0].dmount);
						$('#txtOrdcno2_'+t_n).val(as[0].productno5);
						$('#txtHdate_'+t_n).val(as[0].sale5);
						$('#txtW07_'+t_n).val(as[0].emount);
						
						sum();
					}else{
						alert('無成品料號!!');
					}
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
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP2_'+i).attr('disabled','disabled');
                		$('#btnP3_'+i).attr('disabled','disabled');
                		$('#btnP4_'+i).attr('disabled','disabled');
                		$('#btnP5_'+i).attr('disabled','disabled');
                	}
                }else{
                	$('#btnOrde').removeAttr('disabled');
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP2_'+i).removeAttr('disabled');
                		$('#btnP3_'+i).removeAttr('disabled');
                		$('#btnP4_'+i).removeAttr('disabled');
                		$('#btnP5_'+i).removeAttr('disabled');
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
                    	
                    	$('#txtMount_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtProductno_' + b_seq).val().length>0){
	                        	var t_productno= $('#txtProductno_' + b_seq).val();
	                        	var t_mount= $('#txtMount_'+b_seq).val();
	                        	
			                	q_func('qtxt.query.uca_uj_'+b_seq, 'orde_uj.txt,uca_uj,' + encodeURI(t_productno)+';'+encodeURI(t_mount)+';'+encodeURI(q_date()));
	                        }
                    		
						});
						
						$('#btnP2_'+i).click(function(e) {
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
						
						$('#btnP3_'+i).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtOrdcno_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtOrdcno_' + b_seq).val();
	                        	var t_noa= $('#txtNoa').val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('3');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.ordestk_uj_'+b_seq, 'orde_uj.txt,ordestk_uj,' + encodeURI(t_productno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
							}
						});
						
						$('#btnP4_'+i).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtMakeno_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtMakeno_' + b_seq).val();
	                        	var t_noa= $('#txtNoa').val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('4');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.ordestk_uj_'+b_seq, 'orde_uj.txt,ordestk_uj,' + encodeURI(t_productno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
							}
						});
						
						$('#btnP5_'+i).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtOrdcno2_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtOrdcno2_' + b_seq).val();
	                        	var t_noa= $('#txtNoa').val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('5');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.ordestk_uj_'+b_seq, 'orde_uj.txt,ordestk_uj,' + encodeURI(t_productno)+';'+encodeURI(t_noa)+';'+encodeURI(q_date()));
							}
						});
                    	
                    	//製造增減((M)
                    	$('#txtX02_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							bbsremake(b_seq);
						});
						
						//加工增減成品(支)
                    	$('#txtX07_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							bbsremake(b_seq);
						});
                    }
                }
                _bbsAssign();
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
                        	var t_mount= 0;
                        	
		                	q_func('qtxt.query.uca_uj_'+b_seq, 'orde_uj.txt,uca_uj,' + encodeURI(t_productno)+';'+encodeURI(t_mount)+';'+encodeURI(q_date()));
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
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
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
						<td><span> </span><a id="lblDatea_uj" class="lbl">日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa_uj" class="lbl">單據編號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno_uj" class="lbl" >客戶</a></td>
						<td><input id="txtCustno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtComp" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="btnOrde" type="button" value="訂單匯入" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno_uj" class="lbl" >訂單編號</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><span> </span><a id="lblBdate_uj" class="lbl" >客戶交期</a></td>
						<td><input id="txtBdate" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' style="min-width: 4090px;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:50px;">項次</td>
						<td style="width:180px;"><a id='lblOrdeno_uj_s'>訂單號碼</a></td>
						<td style="width:180px;"><a id='lblProductno_uj_s'>成品料號</a></td>
						<td style="width:100px;"><a id='lblMount_uj_s'>數量<br>(毛需求-支)</a></td>
						<td style="width:60px;"><a id='lblUnit_uj_s'>單位</a></td>
						<td style="width:60px;"><a id='lblBtime_uj_s'>銷售<br>屬性</a></td>
						<td style="width:80px;"><a id='lblWidth_uj_s'>寬(mm)</a></td>
						<td style="width:80px;"><a id='lblLengthb_uj_s'>長(M)</a></td>
						<td style="width:60px;"><a id='lblDime_uj_s'>裁切</a></td>
						<td style="width:100px;"><a id='lblW01_uj_s'>成品庫存(支)</a></td>
						<td style="width:120px;"><a id='lblW02_uj_s'>半成品+再製品<br>可變成成品(支)</a></td>
						<td style="width:120px;"><a id='lblW03_uj_s'>半成品+再製品<br>庫存(M)</a></td>
						<td style="width:160px;"><a id='lblProductno2_uj_s'>半成品料號</a></td>
						<td style="width:60px;"><a id='lblEtime_uj_s'>半成品<br>屬性</a></td>
						<td style="width:60px;"><a id='lblP2_uj_s'>半成品<br>指定</a></td>
						<td style="width:100px;"><a id='lblX01_uj_s'>製造<br>成品<br>(淨需求-支)</a></td>
						<td style="width:100px;"><a id='lblX02_uj_s'>製造<br>增減((M)</a></td>
						<td style="width:100px;"><a id='lblX03_uj_s'>製造<br>(M)</a></td>
						<td style="width:100px;"><a id='lblOth_uj_s'>製造<br>MOQ限定</a></td>
						<td style="width:100px;"><a id='lblX04_uj_s'>製造<br>MOQ</a></td>
						<td style="width:100px;"><a id='lblX05_uj_s'>製造<br>低於MOQ</a></td>
						<td style="width:120px;"><a id='lblX06_uj_s'>加工<br>原生產成品(支)</a></td>
						<td style="width:100px;"><a id='lblX07_uj_s'>加工<br>增減成品(支)</a></td>
						<td style="width:100px;"><a id='lblX08_uj_s'>加工<br>成品(支)</a></td>
						<td style="width:160px;"><a id='lblOrdcno_uj_s'>底材<br>料號</a></td>
						<td style="width:60px;"><a id='lblDate2_uj_s'>底材<br>屬性</a></td>
						<td style="width:60px;"><a id='lblP3_uj_s'>底材<br>指定</a></td>
						<td style="width:100px;"><a id='lblW04_uj_s'>底材<br>可動用<br>廠內庫存</a></td>
						<td style="width:100px;"><a id='lblW05_uj_s'>底材<br>合計</a></td>
						<td style="width:100px;"><a id='lblY01_uj_s'>同紙<br>(未排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY02_uj_s'>同半成品<br>(未排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY03_uj_s'>同紙<br>(已排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY04_uj_s'>同半成品<br>(已排程)<br>長度</a></td>
						<td style="width:100px;"><a id='lblY08_uj_s'>物料需求(支)<br>紙管(根)</a></td>
						<td style="width:100px;"><a id='lblY09_uj_s'>物料需求(支)<br>紙箱(箱)</a></td>
						<td style="width:100px;"><a id='lblY10_uj_s'>物料需求(支)<br>塞頭(個)</a></td>
						<td style="width:150px;"><a id='lblMakeno_uj_s'>面材<br>料號</a></td>
						<td style="width:60px;"><a id='lblDate3_uj_s'>面材<br>屬性</a></td>
						<td style="width:60px;"><a id='lblP4_uj_s'>面材<br>指定</a></td>
						<td style="width:100px;display: none;"><a id='lblW06_uj_s'>面材<br>可動用<br>廠內庫存</a></td>
						<td style="width:150px;"><a id='lblOrdcno2_uj_s'>材料<br>料號</a></td>
						<td style="width:60px;"><a id='lblHdate_uj_s'>材料<br>屬性</a></td>
						<td style="width:60px;"><a id='lblP5_uj_s'>材料<br>指定</a></td>
						<td style="width:100px;display: none;"><a id='lblW07_uj_s'>材料<br>可動用<br>廠內庫存</a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtOrdeno.*" type="text" class="txt c1" style="width: 68%;"/>
							<input id="txtNo2.*" type="text" class="txt c1" style="width: 25%;"/>
						</td>
						<td>
							<input id="txtProductno.*" type="text" class="txt c1"/>
							<input id="txtProduct.*" type="text" class="txt c1" style="display: none;"/>
						</td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtBtime.*" type="text" class="txt c1"/></td>
						<td><input id="txtWidth.*" type="text" class="txt num c1"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
						<td><input id="txtDime.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtProductno2.*" type="text" class="txt c1"/></td>
						<td><input id="txtEtime.*" type="text" class="txt c1"/></td>
						<td><input id="btnP2.*" type="button" value="+"/></td>
						<td><input id="txtX01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOth.*" type="text" class="txt c1"/></td>
						<td><input id="txtX04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX05.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX06.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX07.*" type="text" class="txt num c1"/></td>
						<td><input id="txtX08.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="btnP3.*" type="button" value="+"/></td>
						<td><input id="txtW04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtW05.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY03.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY08.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY09.*" type="text" class="txt num c1"/></td>
						<td><input id="txtY10.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMakeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate3.*" type="text" class="txt c1"/></td>
						<td><input id="btnP4.*" type="button" value="+"/></td>
						<td style="display: none;"><input id="txtW06.*" type="text" class="txt num c1"/></td>
						<td><input id="txtOrdcno2.*" type="text" class="txt c1"/></td>
						<td><input id="txtHdate.*" type="text" class="txt c1"/></td>
						<td><input id="btnP5.*" type="button" value="+"/></td>
						<td style="display: none;"><input id="txtW07.*" type="text" class="txt num c1"/></td>
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