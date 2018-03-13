while :

do

echo " "
echo "what do you want to do?"
echo "1. add"
echo "2. subtract"
echo "3. divide"
echo "4. multiply"
echo "5. modulus"
echo "6. exit"
read ans

if [ $ans != 6 ]
then
echo "What is your number?"
read n1 
echo "what is your second number?"
read n2

fi

case $ans in

	1)
		echo "sum:"
		echo `expr $n1 + $n2 `
		;;

	2)
		echo "difference:"
		echo `expr $n1 - $n2 `
		;;

	3)
		echo "quetient:"
		echo `expr $n1 / $n2 `
		;;

	4)
		echo "product:"
		echo `expr $n1 \* $n2 `
		;;

	5)
		echo "remainder:"
		echo ` expr $n1 % $n2 `
		;;

	6)
		echo "bye...."
		exit
		;;

	*)
		echo "sorry..enter a valid key.."
		;;

esac

echo "        _________________________________________________________________"

done

