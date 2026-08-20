# Propuesta de Proyecto — 1.ª Entrega

**Proyecto:** LabResultados — Portal de resultados y seguimiento de órdenes para un laboratorio de análisis clínicos chico/mediano.
**Materia:** Trabajo Final Integrador — Tecnicatura Universitaria en Programación (UTN).
**Integrantes:** Ariel Grela, Matías Higa.
**Tutor/a:** _[POR COMPLETAR — elegir en el campus]_
**Repositorio único:** _[POR COMPLETAR — URL de GitHub]_
**Fecha máxima de entrega:** 30/08.

> Este documento es un **borrador base** para iterar en equipo. Los marcadores _[POR COMPLETAR]_ indican dónde hace falta información propia (datos reales del relevamiento, decisiones del equipo, etc.).

---

## 1. Identificación de la problemática (A1)

### Contexto
Un laboratorio de análisis clínicos chico/mediano (de barrio) atiende pacientes que se realizan estudios (análisis de sangre, orina, etc.). La toma de muestra es por orden de llegada. Los resultados se procesan a lo largo de uno o varios días.

### El problema
El paciente **no tiene forma de saber si sus estudios ya están listos**. Para averiguarlo, llama por teléfono o se acerca al laboratorio sin necesidad. Esto:
- Satura a la recepción con consultas repetitivas del tipo *"¿ya están mis análisis?"*.
- Genera viajes y esperas innecesarias para el paciente.
- Vuelve la entrega de resultados un proceso manual: se imprimen en papel o se envían como PDF por WhatsApp/email uno por uno.

### ¿A quién afecta?
- **Paciente:** incertidumbre, viajes al pedo, resultados dispersos que se pierden.
- **Recepción:** tiempo consumido en atención telefónica repetitiva.
- **Bioquímico/laboratorio:** entrega manual e ineficiente de resultados.

### Impacto medible
_[POR COMPLETAR con datos del relevamiento — Ariel puede validarlos con su hermana que trabaja en un laboratorio.]_
Ejemplos de métricas a relevar:
- Cantidad de llamados/consultas por día preguntando por resultados.
- Minutos de recepción dedicados por día a esa atención.
- % de pacientes que va al laboratorio y sus resultados todavía no estaban listos.

### ¿Admite solución tecnológica?
Sí. La información (órdenes, estudios, resultados, estados) es estructurada y centralizable, y la consulta de estado/resultados es un caso de uso web claro.

---

## 2. Actores y necesidades (A1)

| Actor | Rol | Necesidad principal | Limitación |
|---|---|---|---|
| Paciente | Consulta estado y resultados | Saber si están listos y ver/descargar resultados sin llamar | Puede no ser experto en tecnología → UX simple |
| Recepcionista | Registra la orden del paciente | Cargar rápido la orden al momento de la extracción | Poco tiempo por paciente |
| Bioquímico/técnico | Carga resultados y cambia estados | Cargar valores de forma ágil y confiable | Evitar doble carga / errores |
| Administrador | Configura estudios, analitos y rangos | Mantener el catálogo de estudios y rangos de referencia | — |

---

## 3. Propuesta de valor y diferenciación (A3)

### Valor real
- **Reduce un costo medible:** menos carga telefónica sobre la recepción y menos viajes innecesarios del paciente.
- **Habilita algo que antes no se podía:** al guardar los resultados como **datos estructurados** (analito, valor, unidad, rango) el sistema puede **resaltar automáticamente los valores fuera de rango** y mostrar la **evolución histórica** de un analito. Un PDF suelto no permite esto.

### Análisis de competencia
- **Competidores directos:** portales de resultados de laboratorios grandes (cadenas). Robustos pero pensados para su propia operación; no son un producto accesible para el laboratorio chico.
- **Competidores indirectos:** entrega por WhatsApp/email manual, retiro de papel en mostrador, llamado telefónico.
- **Variables de comparación:** costo, facilidad de adopción, integración con equipos, valor agregado sobre el resultado.
- **Diferenciadores de LabResultados:** foco en el laboratorio chico/mediano, bajo costo, simple, sin depender de integración con equipos, con resaltado de fuera de rango e historial.

_[POR COMPLETAR — armar la matriz competitiva en tabla y, si se puede, mirar 2-3 portales reales de referencia.]_

---

## 4. Alcance y No-Alcance (A3)

### Alcance (MVP)
- Registro de órdenes (paciente + estudios pedidos).
- Carga de resultados estructurados con rango de referencia.
- Estados de la orden: en proceso → listo → entregado.
- Consulta del paciente por código de orden / DNI.
- Resaltado automático de valores fuera de rango.
- Historial de resultados por paciente.
- Aviso por email cuando los resultados pasan a "listo".

### No-Alcance (explícito)
- Integración con equipos/analizadores del laboratorio.
- Facturación / pasarela de pagos.
- Firma digital y validación regulatoria del bioquímico.
- Aplicación móvil nativa.

---

## 5. Stack tecnológico y justificación (A2)

| Capa | Elección | Justificación |
|---|---|---|
| Backend | Java + Spring Boot + JPA/Hibernate | Es lo que el equipo ya domina (Programación III: Spring Boot, JPA, DTOs, Lombok, APIs REST). Cero curva de aprendizaje. |
| Frontend | HTML + CSS + JavaScript | También del plan de estudios. Sin framework SPA porque no se cursó, para no sumar costo de aprendizaje. |
| Base de datos | PostgreSQL (SQL) | Datos estructurados con relaciones fuertes e integridad (ACID). Integra nativo con JPA. |
| Despliegue | Docker Compose (dev) + nube (Render/Railway + Supabase/Aiven) | Docker iguala entornos entre los dos integrantes; la nube cumple el requisito de tener un componente online. |

Respuestas a las preguntas de justificación de la A2:
- **¿Por qué este backend?** Es el stack conocido y adecuado para lógica de negocio web con datos relacionales.
- **¿Por qué SQL y no NoSQL?** El modelo es naturalmente relacional (paciente → orden → estudios → resultados) y requiere integridad transaccional.
- **¿Por qué esta plataforma de despliegue?** Bajo costo/gratuito para MVP académico y soporta el stack elegido.
- **¿Experiencia previa?** Sí, es la tecnología cursada por el equipo.

---

## 6. Plan de trabajo (A3)

### Objetivo general
Desarrollar un MVP funcional de portal de resultados y seguimiento de órdenes para un laboratorio chico/mediano, desplegado online.

### Objetivos específicos (medibles)
- Permitir al paciente consultar el estado de su orden por código/DNI.
- Permitir la carga de resultados estructurados con rangos de referencia.
- Resaltar automáticamente los valores fuera de rango.
- Enviar aviso por email al pasar a "listo".

### Entregables por etapa (según cronograma de la cátedra)
| Etapa | Fecha máxima | Entregable |
|---|---|---|
| 1.ª Entrega | 30/08 | Propuesta + plan de trabajo + URL del repositorio |
| 2.ª Entrega | 27/09 | Esquema de base de datos + listado de módulos (Condición de Regular) |
| Entrega Final | 14/11 (cursado hasta 21/11) | Repo completo, despliegue online, informe y video |

### Riesgos iniciales y mitigaciones
- **Alcance mayor al tiempo disponible** → priorizar el MVP y respetar el No-Alcance.
- **Curva del despliegue en la nube** → probar el deploy temprano con un "hola mundo".
- **Coordinación entre dos personas** → Trello + repositorio único + Docker para igualar entornos.

### Criterios de éxito del MVP
- Un paciente puede consultar el estado y ver sus resultados sin llamar al laboratorio.
- El laboratorio puede cargar una orden y sus resultados de punta a punta.
- Los valores fuera de rango se resaltan correctamente.

---

## 7. Viabilidad (A3)

- **Técnica:** viable con el stack conocido. Única dependencia externa: envío de email (SMTP), no crítica y postergable.
- **Operativa:** el laboratorio puede adoptarlo sin cambiar sus equipos; solo carga de datos.
- **Temporal:** el alcance del MVP entra en el cronograma (30/08, 27/09, 21/11).

Preguntas de control:
- **¿Qué dependencia crítica puede bloquear el desarrollo?** Ninguna externa crítica; el email es opcional para el MVP.
- **¿Qué parece necesario pero se puede postergar?** El aviso por email y el historial/tendencias pueden ir en una segunda iteración si apremia el tiempo.
- **¿Qué evidencia mínima valida el valor?** Que un paciente de prueba consulte su estado/resultado sin contactar al laboratorio.
