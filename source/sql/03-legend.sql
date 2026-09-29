-- Source: Relationship Visualizer.xlsm, sql worksheet, row 17

SELECT TOP 1
'legend' AS [ITEM], 
'Legend' AS [TOOLTIP],
'<<font face="Calibri" point-size="10">
<table border="1" cellborder="0" cellspacing="1" color="#B3B3B3">'
& IIF(T.[V] IS NULL, '', '<tr><td colspan="9" align="center" ><font point-size="14">' & T.[V] & '</font></td></tr>')
&
'<tr>
  <td colspan="3" align="center"><B>Actor</B></td>
  <td colspan="3" align="center"><B>Application</B></td>
  <td colspan="3" align="center"><B>Data Store</B></td>
 </tr>
 <tr>
   <td bgcolor="#E6B8B7">  </td><td><img src="images/alarm.png" ></img></td><td align="left">Alarm</td>
   <td bgcolor="#4F81BD">  </td><td><img src="images/cloud.png"></img></td><td align="left">Cloud</td>
   <td bgcolor="#FFFFFF">  </td><td><img src="images/database.png"></img></td><td align="left">Database</td>
  </tr>
 <tr>
  <td bgcolor="#CCC0DA">  </td><td><img src="images/robot.png"></img></td><td align="left">Bot / Robot</td>
  <td bgcolor="#FF0000">  </td><td><img src="images/commercial.png"></img></td><td align="left">Commercial</td>
  <td bgcolor="#FFFFFF">  </td><td><img src="images/directory.png"></img></td><td align="left">Directory</td>
 </tr>
 <tr>
  <td bgcolor="#D8E4BC">  </td><td><img src="images/event.png"></img></td><td align="left">Event</td>
  <td bgcolor="#F79646">  </td><td><img src="images/homegrown.png"></img></td><td align="left">Homegrown</td>
  <td bgcolor="#FFFFFF">  </td><td><img src="images/file.png"></img></td><td align="left">File</td>
  </tr>
 <tr>
  <td bgcolor="#FCD5B4">  </td><td><img src="images/org.png"></img></td><td align="left">Organization</td>
  <td bgcolor="#9BBB59">  </td><td><img src="images/opensource.png"></img></td><td align="left">Open-source</td>
  <td bgcolor="#FFFFFF">  </td><td><img src="images/folder.png"></img></td><td align="left">Folder</td>
 </tr>
 <tr>
  <td bgcolor="#B8CCE4">  </td><td><img src="images/person.png"></img></td><td align="left">Person</td>
  <td bgcolor="#4BACC6">  </td><td><img src="images/partner.png"></img></td><td align="left">Partner</td>
  <td bgcolor="#FFFFFF">  </td><td><img src="images/queue.png"></img></td><td align="left">Queue</td>
 </tr>
 <tr>
  <td bgcolor="#B7DEE8">  </td><td><img src="images/process.png"></img></td><td align="left">Process</td>
  <td bgcolor="#D9D9D9">  </td><td><img src="images/system.png"></img></td><td align="left">System</td>
  <td bgcolor="#FFFFFF">  </td><td><img src="images/repository.png"></img></td><td align="left">Repository</td>
 </tr>
 <tr>
  <td colspan="9">
   <table border="0" cellborder="0" cellspacing="0" >
    <tr><td></td><td></td></tr>'
& IIF(F.[V] IS NULL, '', ' <tr><td align="right" border="1" bgcolor="#F0F0F0"><b>Source Data:</b></td><td align="left" border="1">' & F.[V] & '</td></tr>')
& IIF(A.[V] IS NULL, '', ' <tr><td align="right" border="1" bgcolor="#F0F0F0"><b>Author:</b></td><td align="left" border="1">' & A.[V] & '</td></tr>')
& IIF(D.[V] IS NULL, '', ' <tr><td align="right" border="1" bgcolor="#F0F0F0"><b>Date:</b></td><td align="left" border="1">' & D.[V] & '</td></tr>')
&
   '<tr><td></td><td></td></tr>
   </table>
  </td>
 </tr>
</table>
</font>>'
& Left(MA.[MemoAnchor] & '', 0)
AS [LABEL], 
'legend node' AS [STYLE NAME]
FROM   [Options$] L,
       (SELECT First([Value]) AS [V] FROM [Options$] WHERE [Option] = 'Title Block Title'    AND [Enabled] = TRUE) AS T,
       (SELECT First([Value]) AS [V] FROM [Options$] WHERE [Option] = 'Title Block Filename' AND [Enabled] = TRUE) AS F,
       (SELECT First([Value]) AS [V] FROM [Options$] WHERE [Option] = 'Title Block Author'   AND [Enabled] = TRUE) AS A,
       (SELECT First([Value]) AS [V] FROM [Options$] WHERE [Option] = 'Title Block Date'     AND [Enabled] = TRUE) AS D,
       (SELECT TOP 1 [Value] AS [MemoAnchor] FROM [Hidden Options$] WHERE [Option] = 'Memo Anchor') AS MA
WHERE  L.[Option]  = 'Add Legend' 
AND    L.[Enabled] = TRUE
