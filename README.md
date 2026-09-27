<p align=center>
<img src="./docs/images/logo-light.jpg" width=600>
</p>
<p align=center> <strong>Portal de resultados y seguimiento de órdenes para laboratorios de análisis clínicos</strong> </p>

<p align=center> <a href="docs/propuesta.md"> Propuesta de Proyecto</a> • <a href="docs/modulos.md">Listado de Módulos</a> • <a href="database/diagrama-er.md">Base de Datos</a> • <a href="docs/arquitectura.md">Arquitectura</a> • <a href="#créditos"> Créditos </p>

<p align=center> <a href="https://www.utn.edu.ar" >
    <img src="https://img.shields.io/badge/UTN-Universidad%20Tecnológica%20Nacional-0056b3?style=for-the-badge" alt="Universidad Tecnológica Nacional" >
</a> </p>

---

## 🧾 Descripción

**LabResultados** es un sistema web que permite a los pacientes de un laboratorio de análisis clínicos **consultar el estado de sus estudios y acceder a sus resultados de forma online**.

A su vez, permite al personal del laboratorio **registrar órdenes, cargar resultados y gestionar su estado** de manera centralizada.

## ⚠️ Problema

En laboratorios pequeños y medianos, la falta de un sistema que ordene los procesos de entrega y notificación de resultados a pacientes, puede ocasionar saturación al área administrativa. 

El sector de administrativo del laboratorio se ve desbordado por las siguientes tareas:
1. El laboratorio recibe llamados y/o visitas de los pacientes para consultar el estado de sus estudios.
2. La entrega de resultados es un proceso manual: Recepción se encarga de imprimir en papel o se enviar como PDF por WhatsApp/email cada uno.

En paralelo, desde la perspectiva del paciente, la calidad de servicio que reciben se ve afectada:
* Los pacientes que esperan sus resultados no tienen forma sencilla de saber si sus estudios ya están listos ni por qué medio los recibirán.
* Los pacientes del día se ven demorados en su atención, debido a la saturación administrativa.


## 💡 Solución

<p align=center>
<img src="./docs/images/solucion.png" height=250>
</p>

**LabResultados** propone un portal web que centraliza la gestión y consulta de los estudios:

1. La **recepción** registra las órdenes de los pacientes.
2. El **bioquímico** carga los resultados y actualiza el estado de los estudios.
3. Cuando los resultados están disponibles, el paciente recibe una **notificación por correo electrónico**.
4. El **paciente** consulta el estado de su orden y accede a sus resultados mediante un código de orden o DNI.


## 📍 Alcance

El sistema contempla:

- Registro y gestión de órdenes.
- Carga de resultados estructurados: analito, valor, unidad y rango de referencia.
- Gestión de estados de la orden: **En proceso → Listo → Entregado**.
- Consulta de órdenes y resultados por parte del paciente.
- Resaltado de valores fuera del rango de referencia.
- Consulta del historial de resultados.
- Notificación por correo electrónico cuando los resultados están disponibles.

## 💻 Stack tecnológico

### Frontend
<p>
  <img src="https://cdn.simpleicons.org/html5" width="48" alt="HTML5">
  &nbsp;&nbsp;
  <img src="https://cdn.simpleicons.org/css" width="48" alt="CSS3">
  &nbsp;&nbsp;
  <img src="https://cdn.simpleicons.org/javascript" width="48" alt="JavaScript">
</p>

### Backend
<p>
  <img src="https://cdn.simpleicons.org/openjdk" width="48" alt="Java">
  &nbsp;&nbsp;
  <img src="https://cdn.simpleicons.org/springboot" width="48" alt="Spring Boot">
</p>

### Base de datos e infraestructura
<p>
  <img src="https://cdn.simpleicons.org/postgresql" width="48" alt="PostgreSQL">
  &nbsp;&nbsp;
  <img src="https://cdn.simpleicons.org/docker" width="48" alt="Docker">
</p>

## 🗓️ Plan de trabajo

Desarrollar un MVP funcional de portal de resultados y seguimiento de órdenes, desplegado online, en 3 etapas:
| Etapa | Fecha máxima | Entregable |
|---|---|---|
| 1.ª Entrega | 30/08 | Propuesta + plan de trabajo + URL del repositorio |
| 2.ª Entrega | 27/09 | Esquema de base de datos + listado de módulos |
| Entrega Final | 14/11 | Repo completo, despliegue online, informe y video |

## 📖 Documentación

Documentación completa disponible en [`docs`](docs/)

## 📂 Estructura del repositorio 
```
labresultados/
├── backend/     # API REST (Spring Boot)
├── frontend/    # Interfaz web (HTML/CSS/JS)
├── database/    # Scripts DDL/DML, esquema y migraciones
├── docs/        # Propuesta, informes y documentación
└── README.md
```

## Créditos
**Grupo 111:** [Ariel Grela](https://github.com/AriGrela) • [Matías N. Higa](https://github.com/emegiga) 

**Tutor:** Fonzo, Santiago

---

<p align="center">
  <sub>2026 · Trabajo Final - Tecnicatura Universitaria en Programación a Distancia</sub><br>
</p>
