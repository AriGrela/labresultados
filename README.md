# Trabajo Final Integrador — Grupo 111

# Proyecto: LabResultados
Portal de resultados y seguimiento de órdenes para un laboratorio de análisis clínicos.

## Grupo 111
* Grela, Ariel
* Higa, Matías

**Tutor:** Fonzo, Santiago

**Tecnicatura Universitaria en Programación**

[![UTN](https://img.shields.io/badge/UTN-Universidad_Tecnológica_Nacional-0056b3?style=for-the-badge)](https://www.utn.edu.ar)

## Descripción
LabResultados es un sistema web que permite a los pacientes de un laboratorio de análisis clínicos **consultar el estado de sus estudios y acceder a sus resultados online**, y al personal del laboratorio **registrar órdenes y cargar resultados** de forma centralizada.

## Problema
En los laboratorios chicos/medianos, el paciente no tiene forma de saber si sus estudios ya están listos: llama por teléfono o se acerca sin necesidad, y la recepción se satura con consultas del tipo *"¿ya están mis análisis?"*. La entrega, además, suele ser en papel o por PDF enviado a mano por WhatsApp.

## Solución
Un portal donde la recepción registra la orden, el bioquímico carga los resultados y actualiza su estado, y el paciente consulta por código de orden / DNI el estado y sus resultados —con los **valores fuera de rango resaltados** y su **historial**—, con aviso por email cuando están listos.

## Alcance
- Registro de órdenes y carga de resultados estructurados (analito, valor, unidad, rango).
- Estados de la orden (en proceso → listo → entregado) y consulta del paciente.
- Resaltado de valores fuera de rango, historial y aviso por email.

## Stack tecnológico
Frontend:
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)

Backend:
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)

Base de datos e infraestructura:
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## Plan de trabajo
| Etapa | Fecha máxima | Entregable |
|---|---|---|
| 1.ª Entrega | 30/08 | Propuesta + plan de trabajo + URL del repositorio |
| 2.ª Entrega | 27/09 | Esquema de base de datos + listado de módulos (Condición de Regular) |
| Entrega Final | 14/11 | Repo completo, despliegue online, informe y video |

## Recursos y Documentación
→ 📂 Propuesta completa: [`docs/propuesta.md`](docs/propuesta.md)

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/AriGrela/labresultados)
![Trello](https://img.shields.io/badge/Trello-0052CC?style=for-the-badge&logo=trello&logoColor=white)

## Estructura del repositorio
```
labresultados/
├── backend/     # API REST (Spring Boot)
├── frontend/    # Interfaz web (HTML/CSS/JS)
├── database/    # Scripts DDL/DML, esquema y migraciones
├── docs/        # Propuesta, informes y documentación
└── README.md
```
