#!/bin/sh
smearing="0.5 0.3 0.1 0.09 0.07 0.05 0.03 0.01 0.005"

for sm in $smearing
do
er="8"
cat > graphite.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'C',
 pseudo_dir = '/home/max/Desktop/graphite_DFT/Pseudo',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
ibrav = 4,
a = 2.47,
b = 2.47,
c = 8.33,

cosab = -0.5,
cosac = 1.0,
cosbc = 1.0,

nat = 4,
ntyp = 1,

ecutwfc = 45,
ecutrho = 360,

occupations = 'smearing'
smearing ='mp',
degauss = ${sm},
/
&ELECTRONS
 conv_thr =   1.0d-9
/
ATOMIC_SPECIES
 C  12.011   C.pbe-n-rrkjus_psl.1.0.0.UPF

ATOMIC_POSITIONS crystal
 C 0.00000000000000   0.00000000000000   0.25000000000000      
 C 0.00000000000000   0.00000000000000   0.75000000000000       
 C 0.33330000000000   0.66660000000000   0.25000000000000      
 C 0.66670000000000   0.33340000000000   0.75000000000000

K_POINTS {automatic}
12 12 4 0 0 0
EOF

pw.x < graphite.scf.in > graphite_sm${sm}.scf.out
rm -rf tmp
done
