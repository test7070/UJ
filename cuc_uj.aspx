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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "cuc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtMount3','txtMount4','txtSize','txtParab','txtUcolor','txtMount','txtW02','txtEtime','txtWeight3','txtParac','txtWeight9','txtM02','txtM03','txtWaste'];
            var bbmNum = [];
            var bbsNum = [['txtLengthb', 10, 0, 1], ['txtMount1', 10, 0, 1]
            , ['txtMount2', 10, 0, 1], ['txtMount3', 10, 0, 1], ['txtMount4', 10, 0, 1]
            , ['txtWeight1', 10, 0, 1], ['txtWeight2', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtW02', 10, 0, 1]
            , ['txtWeight3', 10, 0, 1], ['txtWeight4', 10, 0, 1], ['txtWeight5', 10, 0, 1], ['txtWeight6', 10, 0, 1]
            , ['txtWeight7', 10, 0, 1], ['txtWeight8', 10, 0, 1], ['txtWeight9', 10, 0, 1], ['txtWeight10', 10, 0, 1]
            , ['txtM01', 10, 0, 1], ['txtM02', 10, 0, 1], ['txtM03', 10, 0, 1]
            , ['txtW03', 10, 0, 1], ['txtW04', 10, 0, 1], ['txtW05', 10, 0, 1], ['txtWaste', 10, 0, 1], ['txtHours', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 6;
            aPop = new Array(['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'], ['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'], ['tx1tCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [['txtDatea', r_picd], ['txtUdate', r_picd], ['txtDate2', r_picd]];
                q_mask(bbmMask);
                
                q_cmbParse("cmbTypea", '希德,噴繪');	
                document.title='計畫性需求製令單';
                
                $('#cmbTypea').change(function() {
                	change_field();
				});
            }

            function q_popPost(s1) {
                switch(s1) {

                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {

                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                var t_date = trim($('#txtDatea').val());
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                //q_box('*.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	
                    	$('#txtLengthb_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#cmbTypea').val()=='希德'){
								Fsize(b_seq);
	                    		Fm03(b_seq);
	                    	}else{
	                    		Fparab(b_seq);
	                    	}
                    		
						});
                    	
                    	$('#chkIsfreeze_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#cmbTypea').val()=='希德'){
								Fetime(b_seq);
								Fparac(b_seq);
							}else{
								Fmount(b_seq);
								Fwaste(b_seq);
							}
						});
                    	
                    	$('#txtMount1_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fmount3(b_seq);
							if($('#cmbTypea').val()=='希德'){
								Fm03(b_seq);
							}
						});
						
						$('#txtMount2_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fmount3(b_seq);
							if($('#cmbTypea').val()=='希德'){
								Fparac(b_seq);
							}else{
								Fwaste(b_seq);
							}
						});
						
						$('#txtParaa_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fmount(b_seq);
						});
                    	
                    	$('#txtWeight4_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fucolor(b_seq);
							Fweight3(b_seq);
							Fparac(b_seq);
						});
						
						$('#txtWeight5_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fweight3(b_seq);
							Fparac(b_seq);
						});
						
						$('#txtWeight7_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fweight9(b_seq);
						});
						
						$('#txtWeight8_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fweight9(b_seq);
						});
						
						$('#txtWeight10_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fm02(b_seq);
						});
						
						$('#txtM01_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fm02(b_seq);
						});
						
						$('#txtW03_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							Fmount(b_seq);
						});
						
						$('#txtW04_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
                    	
                    	$('#txtW05_'+j).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fparab(b_seq);
						});
						
						$('#txtParad_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							Fucolor(b_seq);
							Fweight3(b_seq);
							Fparac(b_seq);
						});
						
						$('#txtParae_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
						});
                    }
                }
                _bbsAssign();
                change_field();
            }
            //------------------------------------------------------------------------------
            function Fmount3(i) { //總庫存(支)
            	var t_mount1=dec($('#txtMount1_'+i).val()); //已排未產(支)
				var t_mount2=dec($('#txtMount2_'+i).val()); //成品庫存(支)
				$('#txtMount3_'+i).val(q_add(t_mount1,t_mount2));
				
				Fmount4(i);
            }
            
            function Fmount4(i) {//原生產(支)
            	var t_mount3=dec($('#txtMount3_'+i).val()); //總庫存(支)
            	var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
            	
            	var t_mount2=dec($('#txtMount2_'+i).val()); //成品庫存(支)
            	
            	if($('#cmbTypea').val()=='希德'){
	            	if(t_m02<=t_mount3){
	            		$('#txtMount4_'+i).val(0);
	            	}else{
	            		$('#txtMount4_'+i).val(q_sub(t_m02,t_mount3));
	            	}
	            	Fsize(i);
	            	Fparac(i);
            	}else{
            		if(t_m02<=t_mount2){
	            		$('#txtMount4_'+i).val(0);
	            	}else{
	            		$('#txtMount4_'+i).val(q_sub(t_m02,t_mount2));
	            	}
	            	
	            	Fucolor(i);
            	}
            }
            
            function Fsize(i) {//原生產(Y)
            	var t_mount4=dec($('#txtMount4_'+i).val()); //原生產(支)
				var t_lengthb=dec($('#txtLengthb_'+i).val()); //長度(Y)
				$('#txtSize_'+i).val(q_mul(t_mount4,t_lengthb));
				
				Fucolor(i);
            }
            
            
            function Fparab(i) {//半成品轉成品(支)
            	var t_w05=dec($('#txtW05_'+i).val()); //投入(半成品)庫存
            	var t_lengthb=dec($('#txtLengthb_'+i).val()); //長度(Y)
            	if(t_lengthb==0){
            		$('#txtParab_'+i).val(0);
            	}else{
            		$('#txtParab_'+i).val(Math.floor(q_mul(q_div(t_w05,t_lengthb),0.95)));
            	}
            	Fucolor(i);
            }
            
            function Fucolor(i) { //庫存可生產量(支)&篩選生產量(支)
				var t_mount4=dec($('#txtMount4_'+i).val()); //原生產(支)
				var t_size=dec($('#txtSize_'+i).val()); //原生產(Y)
				var t_parad=$('#txtParad_'+i).val(); //再製品
				var t_weight4=dec($('#txtWeight4_'+i).val()); //再製品庫存(Y)
				var t_lengthb=dec($('#txtLengthb_'+i).val()); //長度(Y)
				
				var t_mount2=dec($('#txtMount2_'+i).val()); //成品庫存(支)
				var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
				var t_parab=dec($('#txtParab_'+i).val());//半成品轉成品(支)
				
				if($('#cmbTypea').val()=='希德'){
					if(t_mount4==0){
						$('#txtUcolor_'+i).val(0);
					}else{
						var t_sizetotal=0;
						for (var j = 0; j < q_bbsCount; j++) {
							if($('#txtParad_'+j).val()==t_parad){
								t_sizetotal=q_add(t_sizetotal,dec($('#txtSize_'+j).val()))
							}
						}
						if(t_sizetotal==0 || t_lengthb==0){
							$('#txtUcolor_'+i).val(0);
						}else{
							$('#txtUcolor_'+i).val(Math.floor(q_div(q_mul(q_div(t_size,t_sizetotal),t_weight4),t_lengthb)));
						}
					}
				}else{
					if(t_mount2>t_m02){
						$('#txtUcolor_'+i).val(0);
					}if(t_parab>t_mount4){
						$('#txtUcolor_'+i).val(t_mount4);
					}else{
						$('#txtUcolor_'+i).val(t_parab);
					}
				}
				Fmount(i);
            }
            
            function Fmount(i) { //生產量(支)
            	var t_ucolor=dec($('#txtUcolor_'+i).val()); //庫存可生產量(支)&篩選生產量(支)
				var t_paraa=$('#txtParaa_'+i).val(); //手調生產量(支)
				var t_mount1=dec($('#txtMount1_'+i).val()); //已排未產(支)
				var t_mount3=dec($('#txtMount3_'+i).val()); //總庫存(支)
				var t_weight9=dec($('#txtWeight9_'+i).val()); //生產點(支)
				var t_mount4=dec($('#txtMount4_'+i).val()); //原生產(支)
				var t_isfreeze=$('#chkIsfreeze_'+i).prop('checked'); //可做
				var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
				var t_w03=dec($('#txtW03_'+i).val());//1顆半成品轉成品(支)
				
				if($('#cmbTypea').val()=='希德'){
					if(t_ucolor==0 || t_paraa.toUpperCase()=='X'){
						$('#txtMount_'+i).val(0);
					}else{
						t_paraa=dec(t_paraa);
						if(t_paraa>0){
							$('#txtMount_'+i).val(t_paraa);
						}else if(t_mount1>0 && t_mount3>t_weight9){
							$('#txtMount_'+i).val(0);
						}else if(t_ucolor>t_mount4){
							$('#txtMount_'+i).val(t_mount4);
						}else{
							$('#txtMount_'+i).val(t_ucolor);
						}
					}
					Fetime(i);
					Fm03(i);
				}else{
					if(t_mount1>0 && t_mount3>t_weight9){
						$('#txtMount_'+i).val(0);
					}else if(t_ucolor==0 || t_paraa.toUpperCase()=='X'){
						$('#txtMount_'+i).val(0);
					}else{
						t_paraa=dec(t_paraa);
						t_w03=t_w03==0?1:t_w03;
						if(t_paraa>0){
							$('#txtMount_'+i).val(t_paraa);
						}else if(t_isfreeze && t_mount3<t_m02 && t_ucolor/t_w03<0.75){
							$('#txtMount_'+i).val(0);
						}else{
							$('#txtMount_'+i).val(t_ucolor);
						}
					}
					Fw02(i);
					Fetime(i);
				}
            }
            
            function Fw02(i) { //半成品(顆)
            	var t_mount=dec($('#txtMount_'+i).val()); //生產量(支)
				var t_w03=dec($('#txtW03_'+i).val());//1顆半成品轉成品(支)
				t_w03=t_w03==0?1:t_w03;
				$('#txtW02_'+i).val(round(q_div(t_mount,t_w03),0));
            }
            
            function Fetime(i) { //符合生產
            	var t_mount3=dec($('#txtMount3_'+i).val()); //總庫存(支)
            	var t_weight9=dec($('#txtWeight9_'+i).val());//生產點(支)
            	var t_mount1=dec($('#txtMount1_'+i).val()); //已排未產(支)
            	var t_isfreeze=$('#chkIsfreeze_'+i).prop('checked'); //可做
            	var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
            	var t_mount=dec($('#txtMount_'+i).val()); //生產量(支)
            	
            	if(t_mount3<t_weight9){
            		$('#txtEtime_'+i).val('急');
            	}else if (t_mount1>0 && t_isfreeze && t_mount3<t_m02){
            		$('#txtEtime_'+i).val('再');
            	}else if(t_isfreeze && t_mount3<t_m02){
            		$('#txtEtime_'+i).val('可');
            	}else if (t_mount1>0 || t_mount>0){
            		$('#txtEtime_'+i).val('@');
            	}else{
            		$('#txtEtime_'+i).val('');
            	}
            }
            
            function Fweight3(i) { //剩餘庫存合計(Y)
            	var t_m03=dec($('#txtM03_'+i).val()); //生產量(Y)
            	var t_weight4=dec($('#txtWeight4_'+i).val()); //再製品庫存(Y)
            	var t_weight5=dec($('#txtWeight5_'+i).val()); //中繼(半成品)庫存(Y)
            	var t_parad=$('#txtParad_'+i).val(); //再製品
            	
            	if(t_m03>0){
            		var t_m03total=0;
            		for (var j = 0; j < q_bbsCount; j++) {
						if($('#txtParad_'+j).val()==t_parad){
							t_m03total=q_add(t_m03total,dec($('#txtM03_'+j).val()))
						}
					}
            		$('#txtWeight3_'+i).val(q_sub(q_add(t_weight4,t_weight5),t_m03total));
            	}else{
            		$('#txtWeight3_'+i).val(0);
            	}
            }
            
            
            function Fparac(i) { //分條排程
            	var t_weight4=dec($('#txtWeight4_'+i).val()); //再製品庫存(Y)
            	var t_parad=$('#txtParad_'+i).val(); //再製品
            	var t_sizetotal=0;
				for (var j = 0; j < q_bbsCount; j++) {
					if($('#txtParad_'+j).val()==t_parad){
						t_sizetotal=q_add(t_sizetotal,dec($('#txtSize_'+j).val()))
					}
				}
            	var t_weight5=dec($('#txtWeight5_'+i).val()); //中繼(半成品)庫存(Y)
            	var t_mount4=dec($('#txtMount4_'+i).val()); //原生產(支)
            	var t_isfreeze=$('#chkIsfreeze_'+i).prop('checked'); //可做
            	var t_mount2=dec($('#txtMount2_'+i).val()); //成品庫存(支)
            	var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
            	if(t_weight4<t_sizetotal && t_weight5>0 && t_mount4>0){
            		$('#txtParac_'+i).val('急');
            	}else if(t_isfreeze && t_mount2<t_m02 && t_weight5>0){
            		$('#txtParac_'+i).val('分');
            	}else{
            		$('#txtParac_'+i).val('');
            	}
            }
            
            function Fweight9(i) { //生產點(支)
            	var t_weight8=dec($('#txtWeight8_'+i).val()); //手調生產點(支)
				var t_weight7=dec($('#txtWeight7_'+i).val()); //原生產點(支)
				if(t_weight8>0)
					$('#txtWeight9_'+i).val(t_weight8);
				else
					$('#txtWeight9_'+i).val(t_weight7);
					
				if($('#cmbTypea').val()=='希德'){
					Fetime(i);
				}else{
					Fmount(i);
					Fwaste(i);
				}
            }
            
            function Fm02(i) { //生產量(支)
            	var t_m01=dec($('#txtM01_'+i).val()); //手調生產點(支)
				var t_weight10=dec($('#txtWeight10_'+i).val()); //原生產點(支)
				if(t_m01>0)
					$('#txtM02_'+i).val(t_m01);
				else
					$('#txtM02_'+i).val(t_weight10);
				
				if($('#cmbTypea').val()=='希德'){
					Fmount4(i);
				}else{
					Fucolor(i);
					Fwaste(i);
				}
            }
            
            function Fm03(i) { //生產量(Y)
            	var t_mount1=dec($('#txtMount1_'+i).val()); //已排未產(支)
            	var t_mount=dec($('#txtMount_'+i).val()); //生產量(支)
				var t_lengthb=dec($('#txtLengthb_'+i).val()); //長度(Y)
				$('#txtM03_'+i).val(q_mul(q_add(t_mount1,t_mount),t_lengthb));
				
				Fweight3(i);
            }
            
            function Fwaste(i) { //庫存水位(%)
            	var t_isfreeze=$('#chkIsfreeze_'+i).prop('checked'); //可做
            	var t_mount2=dec($('#txtMount2_'+i).val()); //成品庫存(支)
            	var t_m02=dec($('#txtM02_'+i).val());//生產量(支)
            	var t_weight9=dec($('#txtWeight9_'+i).val());//生產點(支)
            	if(t_isfreeze){
            		if(t_m02==0){
            			$('#txtWaste_'+i).val(0);
            		}else{
            			$('#txtWaste_'+i).val(round(q_mul(q_div(t_mount2,t_m02),100),0));
            		}
            	}else{
            		if(t_weight9==0){
            			$('#txtWaste_'+i).val(0);
            		}else{
            			$('#txtWaste_'+i).val(round(q_mul(q_div(t_mount2,t_weight9),100),0));
            		}
            	}
            }
            
			//------------------------------------------------------------------------------
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                change_field();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                change_field();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                change_field();
            }
            
            function change_field () {
				if($('#cmbTypea').val()=='希德'){
					$('.F01').show();
					$('.F02').hide();
					$('.dbbs').css('width','3100px');
				}else{
					$('.F01').hide();
					$('.F02').show();
					$('.dbbs').css('width','2800px');
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 70%;
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
                width: 9%;
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
                width: 75%;
                float: left;
            }
            .txt.c3 {
                width: 47%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            .dbbs {
                width: 3000px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs {
                FONT-SIZE: medium;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 98%;
            }

            .tbbs .td1 {
                width: 8%;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewTypea_uj'>類別</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='typea'>~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class='td5'> </td>
						<td class="td6"> </td>
						<td class="td7"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTypea_uj" class="lbl">類別</a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1" style="font-size: medium;"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>

			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;'>
						<td align="center" style="width: 35px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"/></td>
						<td align="center" style="width: 30px;"> </td>
						<td align="center" style="width: 60px;"><a id='lblBtime_s_uj'>產品別</a></td><!--C-->
						<td align="center" style="width: 150px;"><a id='lblProductno_s_uj'>原成品料號</a></td><!--D-->
						<td align="center" style="width: 80px;"><a id='lblLengthb_s_uj'>長度<BR>(Y)</a></td><!--E-->
						<td align="center" style="width: 50px;"><a id='lblIsfreeze_s_uj'>可做</a></td><!--F-->
						<td align="center" style="width: 80px;"><a id='lblMount1_s_uj'>已排未產<BR>(支)</a></td><!--G-->
						<td align="center" style="width: 80px;"><a id='lblMount2_s_uj'>成品庫存<BR>(支)</a></td><!--H-->
						<td align="center" style="width: 80px;"><a id='lblMount3_s_uj'>總庫存<BR>(支)</a></td><!--I-->
						<td align="center" style="width: 80px;"><a id='lblMount4_s_uj'>原生產<BR>(支)</a></td><!--J-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblSize_s_uj'>原生產<BR>(Y)</a></td><!--K-->
						<td align="center" style="width: 80px;" class="F02"><a id='lblParab_s_uj'>半成品轉<BR>成品(支)</a></td>
						<td align="center" style="width: 90px;">
							<a id='lblUcolor1_s_uj' class="F01">庫存可<BR>生產量(支)</a>
							<a id='lblUcolor2_s_uj' class="F02">篩選<BR>生產量(支)</a>
						</td><!--L-->
						<td align="center" style="width: 90px;"><a id='lblParaa_s_uj'>手調<BR>生產量(支)</a></td><!--M-->
						<td align="center" style="width: 80px;"><a id='lblMount_s_uj'>生產量<BR>(支)</a></td><!--N-->
						<td align="center" style="width: 80px;" class="F02"><a id='lblW02_s_uj'>半成品<BR>(顆)</a></td><!--,O-->
						<td align="center" style="width: 80px;"><a id='lblEtime_s_uj'>符合生產</a></td><!--O,P-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblWeight2_s_uj'>月均</a></td><!--P,-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblWeight3_s_uj'>剩餘庫存<BR>合計(Y)</a></td><!--Q,-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblWeight4_s_uj'>再製品<BR>庫存(Y)</a></td><!--R,-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblWeight5_s_uj'>中繼(半成品)<BR>庫存(Y)</a></td><!--S,-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblParac_s_uj'>分條排程</a></td><!--T,-->
						<td align="center" style="width: 110px;" class="F01"><a id='lblClass_s_uj'>餘料對策</a></td><!--U,-->
						<td align="center" style="width: 150px;" class="F02"><a id='lblMemo_s_uj'>備註</a></td><!--,Q-->
						
						<td align="center" style="width: 80px;"><a id='lblWeight7_s_uj'>原生產點<BR>(支)</a></td><!--V,R-->
						<td align="center" style="width: 90px;"><a id='lblWeight8_s_uj'>手調<BR>生產點(支)</a></td><!--W,S-->
						<td align="center" style="width: 80px;"><a id='lblWeight9_s_uj'>生產點<BR>(支)</a></td><!--X,T-->
						<td align="center" style="width: 80px;"><a id='lblWeight10_s_uj'>原生產量<BR>(支)</a></td><!--Y,U-->
						<td align="center" style="width: 90px;"><a id='lblM01_s_uj'>手調<BR>生產量(支)</a></td><!--Z,V-->
						<td align="center" style="width: 80px;"><a id='lblM02_s_uj'>生產量<BR>(支)</a></td><!--AA,W-->
						<td align="center" style="width: 80px;" class="F01"><a id='lblM03_s_uj'>生產量<BR>(Y)</a></td><!--AB,-->
						<td align="center" style="width: 90px;" class="F02"><a id='lblW03_s_uj'>1顆半成品<BR>轉成品(支)</a></td><!--,X-->
						<td align="center" style="width: 90px;" class="F02"><a id='lblWaste_s_uj'>庫存水位<BR>(%)</a></td><!--,Y-->
						<td align="center" style="width: 90px;" class="F02"><a id='lblHours_s_uj'>月均<BR>(支)</a></td><!--,Z-->
						
						<td align="center" style="width: 150px;" class="F01"><a id='lblParad_s_uj'>再製品</a></td><!--AD,-->
						<td align="center" style="width: 80px;display: none;"><a id='lblW04_s_uj'>庫存</a></td>
						<td align="center" style="width: 150px;">
							<a id='lblParae1_s_uj' class="F01">中繼投入<BR>(半成品)</a><!--AE,-->
							<a id='lblParae2_s_uj' class="F02">投入<BR>(半成品)</a><!--,AB-->
						</td>
						<td align="center" style="width: 80px;" class="F02"><a id='lblW05_s_uj'>庫存</a></td><!--AG,AC-->
						
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
							<input id="txtNoq.*" type="hidden" class="txt c1"/>
						</td>
						<td><input id="txtBtime.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
						<td align="center"><input id="chkIsfreeze.*" type="checkbox"/></td>
						<td><input id="txtMount1.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount2.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount3.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount4.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtSize.*" type="text" class="txt num c1"/></td>
						<td class="F02"><input id="txtParab.*" type="text" class="txt num c1"/></td>
						<td><input id="txtUcolor.*" type="text" class="txt num c1"/></td>
						<td><input id="txtParaa.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td class="F02"><input id="txtW02.*" type="text" class="txt num c1"/></td>
						<td><input id="txtEtime.*" type="text" class="txt c1"/></td>
						<td class="F01"><input id="txtWeight2.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtWeight3.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtWeight4.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtWeight5.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtParac.*" type="text" class="txt c1"/></td>
						<td class="F01"><input id="txtClass.*" type="text" class="txt c1"/></td>
						<td class="F02"><input id="txtMemo.*" type="text" class="txt c1"/></td>
						
						<td><input id="txtWeight7.*" type="text" class="txt num c1"/></td>
						<td><input id="txtWeight8.*" type="text" class="txt num c1"/></td>
						<td><input id="txtWeight9.*" type="text" class="txt num c1"/></td>
						<td><input id="txtWeight10.*" type="text" class="txt num c1"/></td>
						<td><input id="txtM01.*" type="text" class="txt num c1"/></td>
						<td><input id="txtM02.*" type="text" class="txt num c1"/></td>
						<td class="F01"><input id="txtM03.*" type="text" class="txt num c1"/></td>
						<td class="F02"><input id="txtW03.*" type="text" class="txt num c1"/></td>
						<td class="F02"><input id="txtWaste.*" type="text" class="txt num c1"/></td>
						<td class="F02"><input id="txtHours.*" type="text" class="txt num c1"/></td>
						
						<td class="F01"><input id="txtParad.*" type="text" class="txt c1"/></td>
						<td style="display: none;"><input id="txtW04.*" type="text" class="txt num c1"/></td>
						<td><input id="txtParae.*" type="text" class="txt c1"/></td>
						<td class="F02"><input id="txtW05.*" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
