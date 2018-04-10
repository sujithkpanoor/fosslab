#!/bin/bash
pdftotext -layout s1_result.pdf s1_result.txt
pdftotext -layout s2_result.pdf s2_result.txt

tr -d '\040\011\012\015\014\054'< s1_result.txt> temp1.txt
tr -d '\040\011\012\015\014\054'< s2_result.txt>temp2.txt
 
sed -i 's/MDL16CS/\nMDL16CS/g' temp1.txt
sed -i "s/ELECTRONICS/\nELECTRONICS/g" temp1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' temp2.txt
sed -i "s/ELECTRONICS/\nELECTRONICS/g" temp2.txt

grep MDL16CS temp1.txt > grade_s1.txt
grep MDL16CS temp2.txt > grade_s2.txt

sed -i "s/MA101(/ /g" grade_s1.txt
sed -i "s/PH100(/ /g" grade_s1.txt
sed -i "s/BE110(/ /g" grade_s1.txt
sed -i "s/BE10105(/ /g" grade_s1.txt
sed -i "s/BE103(/ /g" grade_s1.txt
sed -i "s/EE100(/ /g" grade_s1.txt
sed -i "s/PH110(/ /g" grade_s1.txt
sed -i "s/EE110(/ /g" grade_s1.txt
sed -i "s/CS110(/ /g" grade_s1.txt
sed -i "s/)/ /g" grade_s1.txt

sed -i "s/EC100(/ /g" grade_s2.txt
sed -i "s/CY100(/ /g" grade_s2.txt
sed -i "s/BE100(/ /g" grade_s2.txt
sed -i "s/CY110(/ /g" grade_s2.txt
sed -i "s/EC110(/ /g" grade_s2.txt
sed -i "s/MA102(/ /g" grade_s2.txt
sed -i "s/BE102(/ /g" grade_s2.txt
sed -i "s/CS100(/ /g" grade_s2.txt
sed -i "s/CS120(/ /g" grade_s2.txt
sed -i "s/)/ /g" grade_s2.txt

sed -i "s/O/10/g" grade_s1.txt
sed -i "s/A+/9/g" grade_s1.txt
sed -i "s/A/8.5/g" grade_s1.txt
sed -i "s/B+/8/g" grade_s1.txt
sed -i "s/B/7/g" grade_s1.txt
sed -i "s/C/6/g" grade_s1.txt
sed -i "s/P/5/g" grade_s1.txt
sed -i "s/F/0/g" grade_s1.txt

sed -i "s/O/10/g" grade_s2.txt
sed -i "s/A+/9/g" grade_s2.txt
sed -i "s/A/8.5/g" grade_s2.txt
sed -i "s/B+/8/g" grade_s2.txt
sed -i "s/B/7/g" grade_s2.txt
sed -i "s/C/6/g" grade_s2.txt
sed -i "s/P/5/g" grade_s2.txt
sed -i "s/F/0/g" grade_s2.txt

sed -i "s/166/16C/g" grade_s1.txt
sed -i "s/166/16C/g" grade_s2.txt

grep -v "ELE6TR10NI6S" grade_s1.txt > temp1.txt
grep -v "ELE6TR10NI6S" grade_s1.txt > temp2.txt

>s1GPA.txt
>s2GPA.txt

mapfile < grade_s1.txt

for i in `seq 0 122`
do
  temp=(${MAPFILE[$i]})
  sum=$(printf "%.1f" "$(echo "((${temp[1]} *4) + (${temp[2]} * 4) + (${temp[3]} * 3) + (${temp[4]} * 3) + (${temp[5]} *3) + (${temp[6]} *3) + (${temp[7]}) + ${temp[8]} + ${temp[9]})/23"|bc -l)")
  echo "$sum" >> s1GPA.txt
done

paste grade_s1.txt s1GPA.txt> s1SGPA.txt

sed -i 's/T6E16CS006/\nT6E16CS006/g' grade_s2.txt

grep -v "T6E16CS" grade_s2.txt> S2CS.txt

mapfile < S2CS.txt

for i in `seq 0 122`
do
  tmp=(${MAPFILE[$i]})
  sum=$(printf "%.1f" "$(echo "((${tmp[1]} *4) + (${tmp[2]} * 4) + (${tmp[3]} * 3) + (${tmp[4]} * 1) + (${tmp[5]} *1) + (${tmp[6]} *4) + (${tmp[7]} *3) + (${tmp[8]} *3) + ${tmp[9]})/24"|bc -l)")
  echo "$sum" >> s2GPA.txt
done

paste S2CS.txt s2GPA.txt> s2SGPA.txt

paste s2SGPA.txt s1SGPA.txt | awk '{printf "%s  %.1f\n",$1,($11 *24 + $22 *23)/47}'> CGPA.txt

join -1 6 -2 1 csb_list.txt CGPA.txt > c4Bcgpa.txt

#rm grade_s1.txt grade_S2.txt grade_s2.txt S2CS.txt s2SGPA.txt s2_result.txt s2GPA.txt s1SGPA.txt s1_result.txt s1GPA.txt CGPA.txt
