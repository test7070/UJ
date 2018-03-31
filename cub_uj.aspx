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
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtMo'];
            var q_readonlys = ['txtBtime','txtWidth','txtLengthb','txtUnit','txtClass','txtSource'
            ,'txtX01','txtDate2','txtW01','txtW02','txtW03','txtW04','txtW05','txtW06','txtW07','txtW08'];
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
            brwCount2 = 10;
            aPop = new Array(
            	['txtCustno', 'lblCustno_uj', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            	['txtM3', 'lblM3_uj', 'cust', 'noa,comp', 'txtM3,txtM4', 'cust_b.aspx'],
            	['txtProcessno', 'lblProcessno_uj', 'store', 'noa,store', 'txtProcessno,txtProcess', 'store_b.aspx'],
            	['txtProductno_', 'btnProduct_', 'uca', 'noa', '0txtProductno_', 'uca_b.aspx'],
            	['txtProductno2_', '', 'uca', 'noa', 'txtProductno2_', 'uca_b.aspx'],
            	['txtOrdcno2_', '', 'uca', 'noa', 'txtOrdcno2_', 'uca_b.aspx'],
            	['txtMakeno_', '', 'ucc', 'noa', 'txtMakeno_', 'ucc_b.aspx'],
            	['txtOrdcno_', '', 'ucc', 'noa', 'txtOrdcno_', 'ucc_b.aspx']
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

            function mainPost() {
            	bbsNum = [
	            	['txtWidth', 10, 0, 1],['txtLengthb', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 10, 2, 1],
	            	['txtX01', 10, 0, 1],['txtX02', 10, 0, 1],['txtW01', 10, 0, 1],['txtW02', 10, 2, 1],
	            	['txtW03', 10, 2, 1],['txtW04', 10, 2, 1],['txtW05', 10, 2, 1],['txtW06', 10, 2, 1],['txtW07', 10, 2, 1],['txtW08', 10, 2, 1]
            	];
            	bbtNum = [];
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMedate', r_picd]];
                bbsMask = [['txtDatea', r_picd],['txtDate2', r_picd]];
                
                q_cmbParse("cmbItype", '業務,內分,內覆,生管,預留,特殊');	
                
                q_mask(bbmMask);
                
                document.title='生產指令';
                
                $('#btnOrde_uj').click(function() {
                	var t_noa=$.trim($('#txtNoa').val());
                	var t_custno=$.trim($('#txtCustno').val());
                	
                	q_gt('view_ordes',"where=^^ custno='"+t_custno+"' and not exists(select * from view_cubs where noa='"+t_noa+"' and ordeno=a.noa and no2=a.no2 ) and isnull(a.enda,0)=0 and isnull(a.cancel,0)=0 and isnull(mount,0)>0 ^^", 0, 0, 0, "getordes", r_accy,1);
					var as = _q_appendData("view_ordes", "", true);
					var t_i=-1;
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtUcolor_'+i).val()) || !emp($('#txtProductno_'+i).val())){
							t_i=i;
						}
					}
					for (var i = 0; i < as.length; i++) {
						for (var j = 0; j < q_bbsCount; j++) {
							if(as[i].noa==$('#txtOrdeno_'+j).val() && as[i].no2==$('#txtNo2_'+j).val()){
								as.splice(i, 1);
								i--;
								break;
							}
						}
					}
					
					Lock(1, {
						opacity : 0
					});
					for (var i = 0; i < as.length; i++) {
						if(t_i+1>=q_bbsCount){
							$('#btnPlus').click();
						}
						t_i++;
						$('#txtUcolor_'+t_i).val(as[i].productno);
						$('#txtMount_'+t_i).val(as[i].mount);
						$('#txtOrdeno_'+t_i).val(as[i].noa)
						$('#txtNo2_'+t_i).val(as[i].no2)
						$('#txtUcolor_'+t_i).change();
						$('#txtMount_'+t_i).change();
					}
					Unlock(1);
				});
                
                $('#txtProduct').change(function() {
                	var t_noa=$.trim($('#txtNoa').val());
					var t_product=$.trim($('#txtProduct').val());
					if(t_product.length>0){
						q_gt('view_cub',"where=^^product='"+t_product+"' and noa!='"+t_noa+"' ^^", 0, 0, 0, "checkproductuj", r_accy,1);
						var as = _q_appendData("view_cub", "", true);
						if (as[0] != undefined) {
							alert('指令名稱重覆!!【'+as[0].noa+'】');
						}
					}
				});
               
				$('#btnCug_uj').click(function() {
					//不經"生管"排程  直接轉cug
					var t_noa=$('#txtNoa').val();
					var t_datea=emp($('#txtBdate').val())?q_date():$('#txtBdate').val();
					
					q_gt('view_workg',"where=^^exists (select * from view_workgs where noa=view_workg.noa and workhno like '"+t_noa+"%') ^^", 0, 0, 0, "inworkgs", r_accy,1);
					var as = _q_appendData("view_workg", "", true);
					if (as[0] != undefined) {
						alert('此「指令指令」已存在「'+as[0].stype+'排程表」【'+as[0].noa+'】中禁止轉派工單!!')
						return;
					}
					
					if(t_noa.length>0 && $('#cmbItype').val()=='特殊' && !(q_cur==1 || q_cur==2)){
						if(emp($('#txtStatus').val())){
							q_func('qtxt.query.cub2cug_uj', 'orde_uj.txt,cub2cug_uj,' + encodeURI(r_accy)+';'+encodeURI(q_date())+';'
							+encodeURI(t_datea)+';'+encodeURI(t_noa)+';'+encodeURI(r_name),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								if(as[0].noa==$('#txtNoa').val()){
									abbm[q_recno]['status'] = as[0].status;
									$('#txtStatus').val(as[0].status);
									alert('派工單【'+as[0].status+'】產生完成!!');
								}
							}
						}else{
							alert('已轉過派工單【'+$('#txtStatus').val()+'】!!');
						}
					}else{
						if($('#cmbItype').val()!='特殊'){
							alert('【指令代號】非「特殊」!!')
						}
					}
				});
				
				$('#btnEnda_uj').click(function() {
					//正常作業下當完成【出貨單】作業,按下"完工"此筆"生產指令"完成任務,如有剩餘料自動轉帳到:s倉:成品計畫性,T倉:成品計畫性
					//按下"完工"時,如果餘料為"成-計"會轉入S倉,此時系統自動產生調撥單 (目的倉庫存放成品區域不同,由T倉轉移至S倉)
					//1.當對應所有"生產指令"都"完工",方可執行完工作業
					//2.權限為"生產"
					
				});
                
                $('#btnClose_div_stk').click(function() {
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
					case 'qtxt.query.div_stk_uj':
						var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			var rowslength=document.getElementById("table_stk").rows.length-4;
							for (var j = 0; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
							
							for (var i = 0; i < as.length; i++) {
								if(as[i].mount==1){
									as[i].lengthc=as[i].weight;
									as[i].lengthb='';
								}else{
									as[i].lengthc='';
								}
								
								var tr = document.createElement("tr");
								tr.id = "bbs_"+i;
								tr.innerHTML+="<td id='stk_tdUno_"+i+"'>"+as[i].uno+"</td>"; //身分證號
								tr.innerHTML+="<td id='stk_tdSpec_"+i+"'>"+as[i].spec+"</td>"; //列管品
								tr.innerHTML+="<td id='stk_tdindate_"+i+"' align='center'>"+as[i].indate+"</td>"; //進貨(生產)日
								tr.innerHTML+="<td id='stk_tdMount_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].mount)+"</td>"; //數量
								tr.innerHTML+="<td id='stk_tdUnit_"+i+"'>"+as[i].unit+"</td>"; //單位
								tr.innerHTML+="<td id='stk_tdLengthb_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].lengthb)+"</td>"; //標準長(M)同規格
								tr.innerHTML+="<td id='stk_tdLengthc_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].lengthc)+"</td>"; //原長(M)
								tr.innerHTML+="<td id='stk_tdWeight_"+i+"'style='text-align: right;'>"+FormatNumber(as[i].weight)+"</td>"; //可用長
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
                			}
                			$('#div_stk').show();
                		}else{
                			alert('無可動用庫存資料!!');
                		}
						break;
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
				if(!emp($('#txtStatus').val())){
					alert('已轉派工單【'+$('#txtStatus').val()+'】禁止修改!!');
					return;
				}
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                //q_box('z_cubp_uj.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
			
            function btnOk() {
            	t_err = q_chkEmpField([['txtDatea', '日期'],['txtProduct', '指令名稱']]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                
                var t_noa=$.trim($('#txtNoa').val());
				var t_product=$.trim($('#txtProduct').val());
				if(t_product.length>0){
					q_gt('view_cub',"where=^^product='"+t_product+"' and noa!='"+t_noa+"' ^^", 0, 0, 0, "btnokproductuj", r_accy,1);
					var as = _q_appendData("view_cub", "", true);
					if (as[0] != undefined) {
						alert('指令名稱重覆!!【'+as[0].noa+'】');
						return;
					}
				}
                
                sum();
                
                if(q_cur==1){
                	$('#txtWorker').val(r_name);
                }else{
                	$('#txtWorker2').val(r_name);
                	
                	var t_mo=dec($('#txtMo').val());
                	$('#txtMo').val(q_add(t_mo,1));
                }
                                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                t_date=replaceAll((t_date.length == 0 ? q_date() : t_date),'/','');
                t_date=t_date.slice(-6);
                
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#cmbItype').val() + t_date + '-', '/', ''));
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
                	$('#btnEnda_uj').removeAttr('disabled');
                	$('#btnCug_uj').removeAttr('disabled');
                	$('#btnOrde_uj').attr('disabled','disabled');
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP1_'+i).attr('disabled','disabled');
                		$('#btnP2_'+i).attr('disabled','disabled');
                	}
                }else{
                	$('#btnEnda_uj').attr('disabled','disabled');
                	$('#btnCug_uj').attr('disabled','disabled');
                	$('#btnOrde_uj').removeAttr('disabled');
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#btnP1_'+i).removeAttr('disabled');
                		$('#btnP2_'+i).removeAttr('disabled');
                	}
                }
                
                if(q_cur!=1){
	            	$('#txtDatea').attr('disabled', 'disabled');
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
						
						$('#txtProductno2_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtOrdcno2_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtMakeno_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtOrdcno_'+i).change(function() {
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
										
										if($('#txtProductno_'+b_seq).val().length>0){
											getstk('0',b_seq);
										}
										
										$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
										$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品
	
										if($('#txtProductno2_'+b_seq).val().length>0){
											var t_productno= $('#txtProductno2_'+b_seq).val();
	                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
	                        				var tpuca = _q_appendData("uca", "", true);
	                        				if (tpuca[0] != undefined) {
												$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
												$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
												$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
											}
											getstk('1',b_seq);
										}
										if($('#txtOrdcno2_'+b_seq).val().length>0){
											getstk('2',b_seq);
										}
										if($('#txtMakeno_'+b_seq).val().length>0){
											getstk('3',b_seq);
											getordcnotv('3',b_seq);
										}
										if($('#txtOrdcno_'+b_seq).val().length>0){
											getstk('4',b_seq);
											getordcnotv('4',b_seq);
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
													$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
													$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
													$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
												}
												getstk('1',b_seq);
											}
											if($('#txtMakeno_'+b_seq).val().length>0){
												getstk('3',b_seq);
												getordcnotv('3',b_seq);
											}
											if($('#txtOrdcno_'+b_seq).val().length>0){
												getstk('4',b_seq);
												getordcnotv('4',b_seq);
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
											
											if($('#txtProductno_'+b_seq).val().length>0){
												getstk('0',b_seq);
											}
											
											$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
											$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品
		
											if($('#txtProductno2_'+b_seq).val().length>0){
												var t_productno= $('#txtProductno2_'+b_seq).val();
		                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
		                        				var tpuca = _q_appendData("uca", "", true);
		                        				if (tpuca[0] != undefined) {
													$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
													$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
													$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
												}
												getstk('1',b_seq);
											}
											if($('#txtOrdcno2_'+b_seq).val().length>0){
												getstk('2',b_seq);
											}
											if($('#txtMakeno_'+b_seq).val().length>0){
												getstk('3',b_seq);
												getordcnotv('3',b_seq);
											}
											if($('#txtOrdcno_'+b_seq).val().length>0){
												getstk('4',b_seq);
												getordcnotv('4',b_seq);
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
														$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
														$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
														$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
													}
													getstk('1',b_seq);
												}
												if($('#txtMakeno_'+b_seq).val().length>0){
													getstk('3',b_seq);
													getordcnotv('3',b_seq);
												}
												if($('#txtOrdcno_'+b_seq).val().length>0){
													getstk('4',b_seq);
													getordcnotv('4',b_seq);
												}
											}
										}
									}else{
										alert('無此料號!!');
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
                    		if($('#txtProductno2_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtProductno2_' + b_seq).val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('2');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
								
			                	q_func('qtxt.query.div_stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_productno)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI('#non'));
							}
						});
						
						$('#btnP2_'+i).click(function(e) {//再製品
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if($('#txtOrdcno2_' + b_seq).val().length>0 && (q_cur==1 || q_cur==2)){
								//get庫存
								var t_productno= $('#txtOrdcno2_' + b_seq).val();
	                        	
	                        	$('#s_bbsnoq').val(b_seq);
	                        	$('#s_bbssource').val('8');
	                        	$('#s_productno').text(t_productno);
	                        	
	                        	$('#div_stk').css('top', e.pageY- $('#div_stk').height());
								$('#div_stk').css('left', e.pageX - $('#div_stk').width());
			                	q_func('qtxt.query.div_stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_productno)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI('#non'));
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
            	if(!emp($('#txtStatus').val())){
					alert('已轉派工單【'+$('#txtStatus').val()+'】禁止刪除!!');
					return;
				}
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
									
									getstk('0',b_seq);
									
									$('#txtProductno2_'+b_seq).val(tuca[0].groupbno)//中繼產品料號
									$('#txtOrdcno2_'+b_seq).val(tuca[0].groupcno)//再製品

									if($('#txtProductno2_'+b_seq).val().length>0){
										var t_productno= $('#txtProductno2_'+b_seq).val();
                        				q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
                        				var tpuca = _q_appendData("uca", "", true);
                        				if (tpuca[0] != undefined) {
											$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
											$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
											$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
										}
										getstk('1',b_seq);
									}
									if($('#txtOrdcno2_'+b_seq).val().length>0){
										getstk('2',b_seq);
									}
									if($('#txtMakeno_'+b_seq).val().length>0){
										getstk('3',b_seq);
										getordcnotv('3',b_seq);
									}
									if($('#txtOrdcno_'+b_seq).val().length>0){
										getstk('4',b_seq);
										getordcnotv('4',b_seq);
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
												$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
												$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
												$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
											}
											getstk('1',b_seq);
										}
										if($('#txtMakeno_'+b_seq).val().length>0){
											getstk('3',b_seq);
											getordcnotv('3',b_seq);
										}
										if($('#txtOrdcno_'+b_seq).val().length>0){
											getstk('4',b_seq);
											getordcnotv('4',b_seq);
										}
									}
								}
							}
                        }
                        break;
                    case 'txtProductno2_':
                    	if($('#txtProductno2_'+b_seq).val().length>0){
							var t_productno= $('#txtProductno2_'+b_seq).val();
	                        q_gt('uca',"where=^^noa='"+t_productno+"'^^", 0, 0, 0, "getuca2", r_accy,1);
	                        var tpuca = _q_appendData("uca", "", true);
	                        if (tpuca[0] != undefined) {
								$('#txtClass_'+b_seq).val(tpuca[0].stdmount);//MOQ //groupdno
								$('#txtMakeno_'+b_seq).val(tpuca[0].grouphno)//上皮
								$('#txtOrdcno_'+b_seq).val(tpuca[0].groupino)//上紙
							}
							getstk('1',b_seq);
						}
						if($('#txtMakeno_'+b_seq).val().length>0){
							getstk('3',b_seq);
							getordcnotv('3',b_seq);
						}
						if($('#txtOrdcno_'+b_seq).val().length>0){
							getstk('4',b_seq);
							getordcnotv('4',b_seq);
						}
                    	break;
                    case 'txtOrdcno2_':
                    	if($('#txtOrdcno2_'+b_seq).val().length>0){
							getstk('2',b_seq);
						}
						break;
					case 'txtMakeno_':
                    	if($('#txtMakeno_'+b_seq).val().length>0){
							getstk('3',b_seq);
							getordcnotv('3',b_seq);
						}
						break;	
					case 'txtOrdcno_':
                    	if($('#txtOrdcno_'+b_seq).val().length>0){
							getstk('4',b_seq);
							getordcnotv('4',b_seq);
						}
						break;	
                    default:
                        break;
                }
            }
            
            function getstk(p,n) {
            	var t_productno='';
            	if(p=='0'){
            		t_productno= $('#txtProductno_' + n).val();
            	}
            	if(p=='1'){
            		t_productno= $('#txtProductno2_' + n).val();
            	}
            	if(p=='2'){
            		t_productno= $('#txtOrdcno2_' + n).val();
            	}
            	if(p=='3'){
            		t_productno= $('#txtMakeno_' + n).val();
            	}
            	if(p=='4'){
            		t_productno= $('#txtOrdcno_' + n).val();
            	}
            	if(t_productno.length>0){
					q_func('qtxt.query.stk_uj', 'orde_uj.txt,stk_uj,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI(t_productno)+';'+encodeURI('#non')+';'+encodeURI('1')+';'+encodeURI('#non'),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					var t_weight=0,t_mount=0;;
					for (var i = 0; i < as.length; i++) {
						t_mount=q_add(t_mount,dec(as[i].mount));
						t_weight=q_add(t_weight,dec(as[i].weight));
					}
					if(p=='0'){
						$('#txtW01_' + n).val(t_mount);
						$('#txtW02_' + n).val(t_weight);
					}
					if(p=='1'){
						$('#txtW03_' + n).val(t_weight);
					}
					if(p=='2'){
						$('#txtW04_' + n).val(t_weight);
					}
					if(p=='3'){
						$('#txtW05_' + n).val(t_weight);
					}
					if(p=='4'){
						$('#txtW07_' + n).val(t_weight);
					}
					pdate(n);
				}
            }
            
            function getordcnotv(p,n) {
            	var t_productno='';
            	if(p=='3'){
            		t_productno= $('#txtMakeno_' + n).val();
            	}
            	if(p=='4'){
            		t_productno= $('#txtOrdcno_' + n).val();
            	}
            	if(t_productno.length>0){
	            	q_func('qtxt.query.ordcnotv_uj', 'orde_uj.txt,ordcnotv_uj,' + encodeURI(q_date())+';'+encodeURI(t_productno),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					var t_weight=0;
					for (var i = 0; i < as.length; i++) {
						t_weight=q_add(t_weight,dec(as[i].weight));
					}
					
					if(p=='3'){
						$('#txtW06_' + n).val(t_weight);
					}
					if(p=='4'){
						$('#txtW08_' + n).val(t_weight);
					}
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
                /*overflow: hidden;*/
            }
            .dview {
            	width: 25%;
                float: left;
                border-width: 0px;
            }
            .tview {
            	width:100%;
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
		<div id="div_stk" style="position:absolute; top:180px; left:20px; display:none; width:800px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr style="display: none;">
					<td style="width:800px;" colspan="8">
						<input id='s_bbsnoq' type="hidden">
						<input id='s_bbssource' type="hidden">
					</td>
				</tr>
				<tr>
					<td style="width:150px;" align="center">料號</td>
					<td style="width:650px;" id='s_productno' colspan="7"> </td>
				</tr>
				<tr>
					<td style="width:150px;" align="center">身分證號</td>
					<td style="width:100px;" align="center">列管品</td>
					<td style="width:100px;" align="center">進貨<BR>(生產)日</td>
					<td style="width:100px;" align="center">數量</td>
					<td style="width:50px;" align="center">單位</td>
					<td style="width:100px;" align="center">標準長(M)<BR>同規格</td>
					<td style="width:100px;" align="center">原長(M)</td>
					<td style="width:100px;" align="center">可用長</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='8'>
						<input id="btnClose_div_stk" type="button" value="確定">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewNoa_uj'>指令流水號</a></td>
						<td style="width:80px; color:black;"><a id='vewDatea_uj'>立單日</a></td>
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
						<td><span> </span><a id="lblItype_uj" class="lbl">指令代號</a></td>
						<td><select id="cmbItype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa_uj" class="lbl">指令流水號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblProduct_uj" class="lbl">指令名稱</a></td>
						<td><input id="txtProduct" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno_uj" class="lbl" >客戶</a></td>
						<td><input id="txtCustno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtComp" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="btnOrde_uj" type="button" value="訂單匯入"/></td>
						<td><span> </span><a id="lblMo_uj" class="lbl" >改單</a></td>
						<td><input id="txtMo" type="text" class="txt num c1" style="width: 20%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProcessno_uj" class="lbl" >成品入庫倉別</a></td>
						<td><input id="txtProcessno" type="text" class="txt c1" style="width: 99%;"/></td>
						<td><input id="txtProcess" type="text" class="txt c1" style="width: 99%;"/></td>
						<td>
							<input id="btnCug_uj" type="button" value="派工單"/>
							<input id="txtStatus" type="hidden"/> <!--寫入已轉派工單號-->
						</td>
						<td>
							<input id="btnEnda_uj" type="button" value="完工" />
							<input id="chkEnda" type="checkbox"  style="display: none;"/><!--完工-->
							<span> </span><a id="lblMenda_uj" class="lbl">鎖單</a>
						</td>
						<td><input id="chkMenda" type="checkbox" /></td>
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
						<td><input id="txtClass.*" type="text" class="txt num c1"/></td>
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