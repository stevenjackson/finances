module ImportFiles
  def csv_file
  '''
Description,,Summary Amt.
Beginning balance as of 04/19/2013,,"1766.30"
Total credits,,"902.96"
Total debits,,"-400.48"
Ending balance as of 05/12/2013,,"1268.78"

Date,Description,Amount,Running Bal.
04/19/2013,Beginning balance as of 04/19/2013,,"1766.30"
04/19/2013,"ENERGY Bill Payment","-50.52","1715.78"
04/19/2013,"MUD NO. 144 Bill Payment","-41.11","1674.67"
04/22/2013,"CHECKCARD 0420 SPEEDWAY 09338 CLE CLEVELAND OH 24224433111101030759182","-10.57","1664.10"
  '''
  end


  def ofx_file
  '''
OFXHEADER:100
DATA:OFXSGML
VERSION:102
SECURITY:TYPE1
ENCODING:USASCII
CHARSET:1252
COMPRESSION:NONE
OLDFILEUID:NONE
NEWFILEUID:NONE


<OFX>
<SIGNONMSGSRSV1>
<SONRS>
<STATUS>
<CODE>0
<SEVERITY>INFO
<MESSAGE>OK
</STATUS>
<DTSERVER>20090211000000[-5:EST]
<USERKEY>--NoUserKey--
  <LANGUAGE>ENG
<INTU.BID>00002
</SONRS>
</SIGNONMSGSRSV1>
<BANKMSGSRSV1>
<STMTTRNRS>
<TRNUID>XXXX - 20090211000000
<STATUS>
<CODE>0
<SEVERITY>INFO
<MESSAGE>OK
</STATUS>
<STMTRS>
<CURDEF>CAD
<BANKACCTFROM>
<BANKID>000000000
<ACCTID>000000
<ACCTTYPE>CHECKING
</BANKACCTFROM>
<BANKTRANLIST>
<DTSTART>20090209
<DTEND>20090209000000[-5:EST]
<STMTTRN>
<TRNTYPE>DEBIT
<DTPOSTED>20090209000000[-5:EST]
<TRNAMT>-98.91
<FITID>00000000000000000000000004
<NAME>GROCER A & Z
</STMTTRN>
<STMTTRN>
<TRNTYPE>CREDIT
<DTPOSTED>20090209000000[-5:EST]
<TRNAMT>308.86
<FITID>00000000000000000000000007
<NAME>DEPOSIT    000000
</STMTTRN>
</BANKTRANLIST>
<LEDGERBAL>
<BALAMT>256.94
<DTASOF>20090209000000[-5:EST]
</LEDGERBAL>
<AVAILBAL>
<BALAMT>256.94
<DTASOF>20090211000000[-5:EST]
</AVAILBAL>
</STMTRS>
</STMTTRNRS>
</BANKMSGSRSV1>
</OFX>
  '''
  end
end
