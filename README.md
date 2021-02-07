# Fullfuel APP (v1)

<p align="center">
  <img width="150" alt="Fullfuel" src="lib/assets/icon/fullfuelIcon.png">
</p>

## Documentación
- [¿Qué es Fullfuel APP?](#qué-es-fullfuel-app)
- [¿Qúe necesito para poder hacer funcionar este proyecto?](#qúe-necesito-para-poder-hacer-funcionar-este-proyecto)
- [¿Cómo configurar el proyecto?](#cómo-configurar-el-proyecto)
- [Comandos de utilidad](#comandos-de-utilidad)

## ¿Qué es Fullfuel APP?
Fullfuel APP es una aplicación móvil Android e IOS (inicialmente Android) que permite conocer el coste de los carburantes de estaciones de servicio próximas a nuestra ubicación a tiempo real y que, además de esto, proporciona la capacidad de configurar alertas que nos notificarán cuando las estaciones de servicio marcadas como favoritas tienen el mejor precio para repostar.

## ¿Qúe necesito para poder hacer funcionar este proyecto?
Esta aplicación ha sido desarrollada utilizando el lenguaje de programación [Dart](https://dart.dev/) y el UI toolkit [Flutter](https://flutter.dev/) de Google, por lo que es necesario disponer de ambos SDKs. Además de esto, es importante tener en cuenta que, al tratarse de una aplicación Android, se requiere disponer de [Android Studio](https://developer.android.com/studio).

La mejor manera de configurar el entorno de desarrollo en nuestro equipo de trabajo es seguir la guía oficial de instalación y configuración de Flutter que podremos encontrar en el siguiente enlace: [¿Cómo instalar Flutter en nuestro equipo de desarrollo?](https://esflutter.dev/docs/get-started/install).

Si se presentan inconvenientes a la hora de instalar y configurar el entorno, también podremos consultar la siguiente lista de reproducción en Youtube que muestra como instalar y configurar Flutter en Windows haciendo uso de Visual Studio code: [Flutter: Instalación y virtual - Windows](https://www.youtube.com/playlist?list=PLCKuOXG0bPi1Z9nyvmjP8_J27EiUNCZb3)

## ¿Cómo configurar el proyecto?
Con el entorno preparado, comenzaremos clonando la rama master de este repositorio a nuestro equipo. Hecho esto y antes de proseguir, instalaremos las dependencias del proyecto ejecutando el siguiente comando en la raíz del proyecto:
```
flutter packages get
```

Continuaremos creando nuestro fichero de variables de entorno. Para ello, también en la raiz del proyecto crearemos un nuevo fichero que llamaremos **.env**. Dentro de este fichero deberemos configurar las siguientes variables de entorno:

- API_URL
- API_VERSION
- API_AUTH_KEY

Os preguntaréis 🤔 ¿de dónde debemos sacar los valores para esas varibles? ¿a qué API se refiere? Pues, básicamente, este proyecto se apolla a su vez en la API que podremos encontrar en el siguiente enlace [Fullfuel API](https://github.com/medinamarquezp/full-fuel). Para poder trabajar con esta, debemos seguir su guía de instalación y tenerla disponible en nuestro equipo local. Tras esto y si seguimos la documentación de instalación de la API, los valores que deberemos indicar en estas variables son:

- API_URL="http://localhost:SERVER_PORT"
- API_VERSION="v1"
- API_AUTH_KEY="bearer API_TOKEN"

Con esto ya dispondremos de todo lo necesario para comenzar. Si trabajamos con Visual Studio Code (recomendado), tan solo deberemos pulsar la tecla f5 o ctrl + f5 para ejecutar el proyecto con o sin debbug.

## Comandos de utilidad
- Descarga de paquetes: ```flutter packages get```
- Generar APK: ```flutter build apk --release```