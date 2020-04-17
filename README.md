
Installer un système de refroidissement pour un Raspberry Pi 4.

Egalement arrêter/démarrer le ventilateur suivant la température, suivre son évolution...

## Installation du ventilateur

Voir la vidéo sur https://www.youtube.com/watch?v=mTHAO9P_hxQ.

![pictures/DSCN7087.JPG](https://github.com/j-fremont/rpi-cooling/blob/master/pictures/DSCN7087.JPG)

![pictures/DSCN7090.JPG](https://github.com/j-fremont/rpi-cooling/blob/master/pictures/DSCN7090.JPG)

## Contrôle des GPIO du Raspberry

Voir http://wiringpi.com/.

Installer.

```bash
$ sudo apt-get install wiringpi
```

Tester l'installation.

```bash
$ gpio -v
$ gpio readall
Oops - unable to determine board type... model: 17
```

Et blink.c ne fonctionne pas. Il faut installer la dernière version (https://www.framboise314.fr/installer-la-derniere-version-de-wiringpi-sur-raspbian-buster/#Test_de_wiringpi_sur_le_Raspberry_Pi_4).

```bash
$ wget https://project-downloads.drogon.net/wiringpi-latest.deb
$ sudo dpkg -i wiringpi-latest.deb
$ gpio -v
$ gpio readall
 +-----+-----+---------+------+---+---Pi 4B--+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | IN   | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | IN   | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 4B--+---+------+---------+-----+-----+
```

Compiler.

```bash
$ gcc -Wall -o blink blink.c -lwiringPi
$ sudo ./blink
```

Ou encore.

```bash
#! /bin/bash
gpio mode 0 out 
while true; do 
 gpio write 0 1
 sleep 1
 gpio write 0 0
 sleep 1
done
```

## Arrêter/démarrer le ventilateur

Voir https://howchoo.com/g/ote2mjkzzta/control-raspberry-pi-fan-temperature-python.

## Moduler la vitesse du ventilateur

En fonction de la température.

Utiliser une sortie PWM du GPIO.

## Suivre l'évolution de la température

Lire la température avec "VideoCore general commands" (https://elinux.org/RPI_vcgencmd_usage).

```bash
$ vcgencmd measure_temp
$ vcgencmd measure_temp | sed -En "s/temp=(.*)'C/\1/p"
```

Afficher la courbe des température en temps-réel avec gnuplot. Installer gnuplot.

```bash
$ sudo apt-get install gnuplot
```

Lancer la mesure et le stockage des températures dans store.dat, puis lancer l'affichage de store.data avec gnuplot.

```bash
$ ./store.sh &
[1] 17346
$ gnuplot temperature.plt &
[1] 17386
```

Pour éviter que le terminal gunuplot ne revienne en foreground à chaque reread : menu Configuration , décocher "Put the window at the top...".













