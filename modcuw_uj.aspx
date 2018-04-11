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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_desc=1;
            q_tables = 't';
            var q_name = "modcuw";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtMech','txtAddtime','txtFaulttime','txtWaitfedtime','txtClassk'];
            var q_readonlyt = ['txtMech'];
            var bbmNum = [];
            var bbsNum = [
            	['txtBorntime',15,0,1],['txtAddtime',10,1,1],['txtChgfre',10,0,1],
            	['txtChgtime',15,0,1],['txtFaulttime',10,1,1],['txtDelaytime',10,0,1],
            	['txtWaittime',15,0,1],['txtWaitfedtime',10,1,1],['txtLacksss',10,0,1],['txtClassk',10,0,1]
            ];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            brwCount2 = 4;

            aPop = new Array(
            	['txtMechno_', '', 'cust', 'noa,nick', 'txtMechno_,txtMech_', 'cust_b.aspx'],
            	['txtMechno__', '', 'cust', 'noa,nick', 'txtMechno__,txtMech__', 'cust_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

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
                bbsMask = [['txtBdate', r_picd],['txtEdate', r_picd]];
                q_mask(bbmMask);
                
                document.title='績效達成回饋獎勵主檔';
                
                $('#btnClosesModcuwt').click(function() {
                	$('#textMechno').val('');
                	$('#dbbt').hide();
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
                }
            }

            function btnOk() {
                sum();
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if(q_cur==1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
	
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modcuw') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                //q_box('modcuw_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }
			
			var t_orgcustno='',t_orgcust='';
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    	$('#txtMechno_'+i).focusin(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_orgcustno=$('#txtMechno_'+b_seq).val();
							t_orgcust=$('#txtMech_'+b_seq).val();
						});
                    	
                    	$('#txtMechno_'+i).blur(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
						});
                    	
                    	$('#btnBbt_'+i).click(function(e) {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if(emp($('#txtMechno_'+b_seq).val())){
                    			alert('請先輸入(母公司)客戶編號!!');
                    		}else{
                    			var t_custno=$('#txtMechno_'+b_seq).val();
                    			$('#textMechno').val(t_custno);
                    			for (var i = 0; i < q_bbtCount; i++) {
                    				if($('#txtWorktime__'+i).val()==t_custno || (emp($('#txtWorktime__'+i).val()) && emp($('#txtMechno__'+i).val()))){
                    					$('#bbtid__'+i).show();
                    				}else{
                    					$('#bbtid__'+i).hide();
                    				}
                    			}
                    			$('#dbbt').css('top', e.pageY+5);
								$('#dbbt').css('left', e.pageX-$('#dbbt').width()-25);
                    			$('#dbbt').show();
                    		}
						});
						
						$('#txtBorntime_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_money=dec($('#txtBorntime_'+b_seq).val());
							
							$('#txtAddtime_'+b_seq).val(round(q_div(t_money,1000000),1));
						});
						
						$('#txtChgtime_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_money=dec($('#txtChgtime_'+b_seq).val());
							
							$('#txtFaulttime_'+b_seq).val(round(q_div(t_money,1000000),1));
						});
						
						$('#txtWaittime_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_money=dec($('#txtWaittime_'+b_seq).val());
							
							$('#txtWaitfedtime_'+b_seq).val(round(q_div(t_money,1000000),1));
						});
						
						$('#txtBdate_'+i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var tbdate=$('#txtBdate_'+b_seq).val();
							var tedate=$('#txtEdate_'+b_seq).val();
							
							if(tbdate.length>0 && tedate.length>0){
								var tdatea = new Date();  
								var tdateb = new Date();  								
								
								if(r_len==3){
									tdatea = new Date(dec(tbdate.substr(0,r_len))+1911,dec(tbdate.substr(r_len+1,2)),dec(tbdate.substr(r_lenm+1,2)),0,0,0);  
									tdateb = new Date(dec(tedate.substr(0,r_len))+1911,dec(tedate.substr(r_len+1,2)),dec(tedate.substr(r_lenm+1,2)),0,0,0);
								}else{
									tdatea = new Date(dec(tbdate.substr(0,r_len)),dec(tbdate.substr(r_len+1,2)),dec(tbdate.substr(r_lenm+1,2)),0,0,0);  
									tdateb = new Date(dec(tedate.substr(0,r_len)),dec(tedate.substr(r_len+1,2)),dec(tedate.substr(r_lenm+1,2)),0,0,0);
								}
								var tdiff = tdateb-tdatea;
								var dmon=round(tdiff/(1000 * 60 * 60 * 24 * 30),0)
								$('#txtClassk_'+b_seq).val(dmon);
							}else{
								$('#txtClassk_'+b_seq).val('');
							}
						});
						
						$('#txtEdate_'+i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var tbdate=$('#txtBdate_'+b_seq).val();
							var tedate=$('#txtEdate_'+b_seq).val();
							
							if(tbdate.length>0 && tedate.length>0){
								var tdatea = new Date();  
								var tdateb = new Date();  								
								
								if(r_len==3){
									tdatea = new Date(dec(tbdate.substr(0,r_len))+1911,dec(tbdate.substr(r_len+1,2)),dec(tbdate.substr(r_lenm+1,2)),0,0,0);  
									tdateb = new Date(dec(tedate.substr(0,r_len))+1911,dec(tedate.substr(r_len+1,2)),dec(tedate.substr(r_lenm+1,2)),0,0,0);
								}else{
									tdatea = new Date(dec(tbdate.substr(0,r_len)),dec(tbdate.substr(r_len+1,2)),dec(tbdate.substr(r_lenm+1,2)),0,0,0);  
									tdateb = new Date(dec(tedate.substr(0,r_len)),dec(tedate.substr(r_len+1,2)),dec(tedate.substr(r_lenm+1,2)),0,0,0);
								}
								var tdiff = tdateb-tdatea;
								var dmon=round(tdiff/(1000 * 60 * 60 * 24 * 30),0)
								$('#txtClassk_'+b_seq).val(dmon);
							}else{
								$('#txtClassk_'+b_seq).val('');
							}
						});
						
                    }
                }
                _bbsAssign();
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtMechno__'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(!emp($('#txtMechno__'+b_seq).val())){
								$('#txtWorktime__'+b_seq).val('');
							}
						});
                    }
                }
                _bbtAssign();
            }
            
            function q_popPost(s1) {
				switch (s1) {
					case 'txtMechno_':
						if(emp($('#txtMechno_'+b_seq).val())){
							for (var j = 0; j < q_bbtCount; j++) {
								if($('#txtWorktime__'+j).val()==t_orgcustno)
									$('#btnMinut__'+j).click();
							}
						}else{
							var t_custno=$('#txtMechno_'+b_seq).val();
							var t_count=0;
							for (var j = 0; j < q_bbsCount; j++) {
								if($('#txtMechno_'+j).val()==t_custno){
									t_count++;
								}
							}
							if(t_count>1){
								$('#txtMechno_'+b_seq).val(t_orgcustno);
								$('#txtMech_'+b_seq).val(t_orgcust)
								alert('母公司客戶編號重覆!!');
							}else{
								if($('#txtMechno_'+b_seq).val()!=t_orgcustno && t_orgcustno!=''){
									for (var j = 0; j < q_bbtCount; j++) {
										if($('#txtWorktime__'+j).val()==t_orgcustno)
											$('#txtWorktime__'+j).val($('#txtMechno_'+b_seq).val());
									}
								}
							}
						}
						t_orgcustno='';
						break;
					case 'txtMechno__':
						var t_custno=$('#textMechno').val();
						if(t_custno.length>0 && !emp($('#txtMechno__'+b_seq).val())){
							$('#txtWorktime__'+b_seq).val(t_custno);
						}else{
							$('#txtWorktime__'+b_seq).val('');
						}
						break;
				}
			}

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
               if (q_chkClose())
                        return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                //q_box("z_modcuwp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'modcuw', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['mechno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
            function bbtSave(as) {
                if (!as['mechno']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	
            }
            
            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                }
                Unlock();
            }
            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }
            function btnPlut(org_htm, dest_tag, afield) {
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
                 if (q_chkClose())
                        return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 130px;
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
                width: 550px;
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
                width: 15%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 1260px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            tr.sel td {
                background-color: yellow;
            }
            tr.chksel td {
                background-color: bisque;
            }
            #dbbt {
                width: 350px;
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
        <div id='dmain' >
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewDatea_uj'>登錄日期</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm" id="tbbm">
                    <tr class="tr0" style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl" > </a></td>
                        <td><input id="txtNoa"type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblDatea_uj" class="lbl">登錄日期</a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo_uj" class="lbl">備註</a></td>
                        <td colspan="3"><input id="txtMemo"  type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl" > </a></td>
                        <td><input id="txtWorker"  type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
                        <td><input id="txtWorker2"  type="text" class="txt c1" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <!--VVV抬頭用VVV-->
		<div class='topbbs' style="width: 1260px;margin-bottom: -2px;">
			<table id="topbbs" class='tbbs'>
				<tr style='color:white; background:#003366;'>
					<td align="center" style="width:30px;"> </td>
                    <td align="center" style="width:30px;"> </td>
                    <td style="width:250px; text-align: center;"><a>客戶(母公司)</a></td>
                    <td style="width:200px; text-align: center;"><a>1階</a></td>
                    <td style="width:200px; text-align: center;"><a>2階</a></td>
                    <td style="width:200px; text-align: center;"><a>3階</a></td>
                    <td style="width:260px; text-align: center;"><a>獎勵期間</a></td>
                    <td style="width:80px; text-align: center;"> </td>
				</tr>
			</table>
		</div>
		<!--^^^抬頭用^^^-->
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:30px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                    <td align="center" style="width:30px;">No.</td>
                    <td style="width:110px; text-align: center;"><a id='lblMechno_uj_s'>客戶編號</a></td>
                    <td style="width:140px; text-align: center;"><a id='lblMech_uj_s'>客戶簡稱</a></td>
                    <td style="width:75px; text-align: center;"><a id='lblBorntime_uj_s'>業績<BR>(元)</a></td>
                    <td style="width:65px; text-align: center;"><a id='lblAddtime_uj_s'>業績<BR>(百萬)</a></td>
                    <td style="width:60px; text-align: center;"><a id='lblChgfre_uj_s'>扣%</a></td>
                    <td style="width:75px; text-align: center;"><a id='lblChgtime_uj_s'>業績<BR>(元)</a></td>
                    <td style="width:65px; text-align: center;"><a id='lblFaulttime_uj_s'>業績<BR>(百萬)</a></td>
                    <td style="width:60px; text-align: center;"><a id='lblDelaytime_uj_s'>扣%</a></td>
                    <td style="width:75px; text-align: center;"><a id='lblWaittime_uj_s'>業績<BR>(元)</a></td>
                    <td style="width:65px; text-align: center;"><a id='lblWaitfedtime_uj_s'>業績<BR>(百萬)</a></td>
                    <td style="width:60px; text-align: center;"><a id='lblLacksss_uj_s'>扣%</a></td>
                    <td style="width:100px; text-align: center;"><a id='lblBdate_uj_s'>起始日</a></td>
                    <td style="width:100px; text-align: center;"><a id='lblEdate_uj_s'>終止日</a></td>
                    <td style="width:60px; text-align: center;"><a id='lblClassk_uj_s'>合計<BR>(月)</a></td>
                    <td style="width:80px; text-align: center;"><a id='lblBbt_uj_s'>績效合併<BR>計算客戶</a></td>
                </tr>
                <tr id="trSel.*" style='background:#cad3ff;'>
                    <td>
	                    <input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
	                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtMechno.*" type="text" class="txt c1"/></td>
                	<td><input id="txtMech.*" type="text" class="txt c1"/></td>
                    <td><input id="txtBorntime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtAddtime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtChgfre.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtChgtime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtFaulttime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtDelaytime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtWaittime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtWaitfedtime.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtLacksss.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtBdate.*" type="text" class="txt c1"/></td>
                    <td><input id="txtEdate.*" type="text" class="txt c1"/></td>
                    <td><input id="txtClassk.*" type="text" class="txt num c1"/></td>
                    <td><input id="btnBbt.*" type="button" value="+" /></td>
                </tr>
            </table>
        </div>
        <div id="dbbt" class="dbbt" style="position:absolute;display:none;">
        	<input id="btnClosesModcuwt" type="button" value="關閉" style=" float: right;"/>
        	<input id="textMechno" type="hidden"/>
			<BR>
            <table id="tbbt">
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:30px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="+"/></td>
                        <td style="width:30px;display: none;"> </td>
                        <td style="width:110px; text-align: center;"><a id='lblMechno_uj_t'>客戶編號</a></td>
                        <td style="width:140px; text-align: center;"><a id='lblMech_uj_t'>客戶簡稱</a></td>
                    </tr>
                    <tr id='bbtid..*'>
                        <td>
                            <input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="-"/>
                            <input id="txtNoq..*" type="text" style="display:none;"/>
                            <input id="txtWorktime..*" type="hidden"/><!--bbs.mechno-->
                        </td>
                        <td style="display: none;"><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td><input id="txtMechno..*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtMech..*" type="text" style="float:left;width:95%;"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
        
    </body>
</html>
