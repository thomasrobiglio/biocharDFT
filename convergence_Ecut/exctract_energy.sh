Ecut="10 15 20 25 30 35 40 45 50 55 60 65 70 75"

for ec in $Ecut
do
printf "${ec}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' graphite_${ec}.scf.out 
done > energy.dat
