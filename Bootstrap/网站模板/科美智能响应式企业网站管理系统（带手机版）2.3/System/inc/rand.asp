<%
'生成随机6位数字
randomize
dim jhyRndNum1,jhyRndNum2,jhyRndNum3,jhyRndNum4,jhyRndNum5,jhyRndNum6,juhaoyongRndNumber
jhyRndNum1=Int(10 * Rnd)

jhyRndNum2=Int(10 * Rnd)
do while jhyRndNum2=jhyRndNum1
jhyRndNum2=Int(10 * Rnd)
loop

jhyRndNum3=Int(10 * Rnd)
do while jhyRndNum3=jhyRndNum1 or jhyRndNum3=jhyRndNum2
jhyRndNum3=Int(10 * Rnd)
loop

jhyRndNum4=Int(10 * Rnd)
do while jhyRndNum4=jhyRndNum1 or jhyRndNum4=jhyRndNum2 or jhyRndNum4=jhyRndNum3
jhyRndNum4=Int(10 * Rnd)
loop

jhyRndNum5=Int(10 * Rnd)
do while jhyRndNum5=jhyRndNum1 or jhyRndNum5=jhyRndNum2 or jhyRndNum5=jhyRndNum3 or jhyRndNum5=jhyRndNum4
jhyRndNum5=Int(10 * Rnd)
loop

jhyRndNum6=Int(10 * Rnd)
do while jhyRndNum6=jhyRndNum1 or jhyRndNum6=jhyRndNum2 or jhyRndNum6=jhyRndNum3 or jhyRndNum6=jhyRndNum4  or jhyRndNum6=jhyRndNum5
jhyRndNum6=Int(10 * Rnd)
loop

juhaoyongRndNumber=jhyRndNum1&jhyRndNum2&jhyRndNum3&jhyRndNum4&jhyRndNum5&jhyRndNum6
%>