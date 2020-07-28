#!/bin/bash -x

# instalar-ardour6.sh 

# Instalador por Charlie Martínez ®

# Sitio oficial: www.quirinux.org
# Contacto directo: cmartinez@quirinux.org
# https://github.com/quirinux-so

# Licencia GPL Versión 3 
# https://github.com/quirinux-so/instalar-ardour6/blob/master/LICENCE

# Creando carpeta para archivos temporales

echo "# Creando directorios temporales..."; sleep 1s
sudo mkdir -p /opt/tmp/ardour6-postinstall

# Instalando dependencias del instalador:

sudo apt-get update
for paquetes_wget in wget zenity zenity-common; do sudo apt-get install -y $paquetes_wget; done
sudo apt-get install -f

# Generando el menú gráfico con Zenity:

opc=$(zenity --width=350 --height=220 --title=Quirinux --entry --text="        
              Instalación del Ardour 6.0
              de Paul Davis y otros.
              Introduce una opción: 
	             1) Instalar Ardour 6
	             2) Salir 
"
)
case $opc in

"1") 

(

echo "# Instalando dependencias..."; sleep 1s
sudo apt-get update
for paquetes_ardour in libboost-all-dev libasound2-dev libglib2.0-dev glibmm-2.4-dev libsndfile1-dev libcurl4-gnutls-dev liblo-dev libtag1-dev vamp-plugin-sdk librubberband-dev libfftw3-dev libaubio-dev libxml2-dev libcwiid-dev libjack-jackd2-dev jackd qjackctl liblrdf0-dev libsamplerate-dev lv2-dev libserd-dev libsord-dev libsratom-dev liblilv-dev libgtkmm-2.4-dev libarchive-dev git xjadeo; do sudo apt-get install -y $paquetes_ardour; done
sudo apt-get install -f -y

echo "# Descargando código fuente..."; sleep 1s
sudo mkdir /opt/tmp/
cd /opt/tmp/
git clone git://git.ardour.org/ardour/ardour.git

echo "# Compilando (ten paciencia)..."; sleep 1s
cd /opt/tmp/ardour
./waf configure
sudo ./waf install
sudo apt-get install -f -y

echo "# Descargando ícono y personalizaciones..."; sleep 1s

sudo wget  --no-check-certificate 'http://my.opendesktop.org/s/YjPGEJcENG6qXDt/download' -O /opt/tmp/ardour6-postinstall.tar
sudo chmod 777 -R /opt/tmp/
sudo chown $USER /opt/tmp/*
sudo chmod 777 /opt/tmp/ardour6-postinstall.tar

echo "# Instalando acceso directo..."; sleep 1s
cd /opt/tmp/
sudo tar -xvf /opt/tmp/ardour6-postinstall.tar
sudo cp -rf /opt/tmp/ardour6-postinstall/usr/* /usr/

echo "# Borrando temporales"; sleep 1s
sudo rm -rf /opt/tmp/ardour6-postinstall

echo "# Ardour 6 instalado correctamente."; sleep 1s
)|

zenity --progress --pulsate 

title="Quirinux Install"
percentage=0
;;

"2")

	exit 0
;; 

esac

