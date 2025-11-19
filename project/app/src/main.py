import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import pickle
from utils import cargar_dataset, resumen_proyecto, preprocesar_entrada, cargar_modelo

# ---------------------------------------------------------
# CONFIGURACIÓN GENERAL DE LA APP
# ---------------------------------------------------------
st.set_page_config(page_title="Predicción de Deserción Estudiantil", layout="wide")
st.title("Predicción y Análisis de Deserción Estudiantil")
st.write("Aplicación desarrollada como parte del proyecto final de la especialidad Big Data & Machine Learning.")

# Variables de sesión
if "df" not in st.session_state:
    st.session_state.df = None


# ---------------------------------------------------------
# PESTAÑAS PRINCIPALES
# ---------------------------------------------------------
tabs = st.tabs([
    "Resumen del Proyecto",
    "Visualización de Datos",
    "Predicción con el Modelo",
    "Conclusiones"
])

# ---------------------------------------------------------
# 1 RESUMEN DEL PROYECTO
# ---------------------------------------------------------
with tabs[0]:
    st.header("Resumen del proyecto")

    st.markdown(resumen_proyecto())

    archivo = st.file_uploader("Sube tu dataset CSV *(opcional)*", type=["csv"])

    if archivo is not None:
        df = pd.read_csv(archivo)
        st.session_state.df = df
        st.success("Dataset cargado correctamente ✔")
        st.dataframe(df.head())
    else:
        st.info("No se ha cargado ningún archivo. Se usará el dataset por defecto.")
        df = cargar_dataset()
        st.session_state.df = df
        st.dataframe(df.head())


# ---------------------------------------------------------
# 2 VISUALIZACIÓN DE DATOS
# ---------------------------------------------------------
with tabs[1]:
    st.header("Visualización de datos")

    if st.session_state.df is None:
        st.warning("Primero debes cargar un dataset en la pestaña de 'Resumen del Proyecto'.")
    else:
        df = st.session_state.df

        columnas_numericas = df.select_dtypes(include="number").columns.tolist()

        if len(columnas_numericas) == 0:
            st.error("No hay columnas numéricas para graficar.")
        else:
            col = st.selectbox("Selecciona una columna numérica:", columnas_numericas)

            grafico = st.radio("Tipo de gráfico:", ["Histograma", "Boxplot"])

            if grafico == "Histograma":
                fig, ax = plt.subplots()
                ax.hist(df[col], bins=20)
                ax.set_title(f"Histograma de {col}")
                st.pyplot(fig)

            else:
                fig, ax = plt.subplots()
                ax.boxplot(df[col])
                ax.set_title(f"Boxplot de {col}")
                st.pyplot(fig)


# ---------------------------------------------------------
# 3 PREDICCIÓN CON EL MODELO
# ---------------------------------------------------------
with tabs[2]:
    st.header("Predicción de Deserción Estudiantil")

    # Cargar modelo
    modelo = cargar_modelo()

    # Lista de features del modelo
    feature_names = [
        'Marital Status', 'Application mode', 'Application order', 'Course',
        'Daytime/evening attendance', 'Previous qualification',
        'Previous qualification (grade)', 'Nacionality',
        "Mother's qualification", "Father's qualification",
        "Mother's occupation", "Father's occupation", "Admission grade",
        'Displaced', 'Educational special needs', 'Debtor',
        'Tuition fees up to date', 'Gender', 'Scholarship holder',
        'Age at enrollment', 'International',
        'Curricular units 1st sem (credited)',
        'Curricular units 1st sem (enrolled)',
        'Curricular units 1st sem (evaluations)',
        'Curricular units 1st sem (approved)',
        'Curricular units 1st sem (grade)',
        'Curricular units 1st sem (without evaluations)',
        'Curricular units 2nd sem (credited)',
        'Curricular units 2nd sem (enrolled)',
        'Curricular units 2nd sem (evaluations)',
        'Curricular units 2nd sem (approved)',
        'Curricular units 2nd sem (grade)',
        'Curricular units 2nd sem (without evaluations)',
        'Unemployment rate', 'Inflation rate', 'GDP'
    ]

    st.write("Introduce los valores para realizar la predicción:")

    # Inputs dinámicos
    input_values = {}
    for feature in feature_names:
        input_values[feature] = st.number_input(f'Ingresa {feature}', value=0.0)

    # Botón único de predicción
    if st.button("Predecir"):
        if modelo is None:
            st.warning("No hay modelo cargado")
        else:
            # Preprocesar los inputs
            df_input = preprocesar_entrada(input_values)
            # Obtener predicción
            pred = modelo.predict(df_input)
            # Mapear clases (ajusta según tu target real)
            clases = {0: "Continúa", 1: "Deserta", 2: "Se gradúa"}
            st.success(f"*Predicción del modelo:* {clases.get(pred[0], pred[0])}")


# ---------------------------------------------------------
# 4 CONCLUSIONES
# ---------------------------------------------------------
with tabs[3]:
    st.header("Conclusiones del Proyecto")

    st.markdown("""
    - La aplicación permite analizar datos académicos y predecir el riesgo de deserción.
    - La analítica predictiva ayuda a identificar estudiantes vulnerables.
    - Modelos como *XGBoost + SMOTE* mejoran la detección de casos minoritarios.
    - Esta herramienta puede apoyar decisiones institucionales de retención y éxito académico.
    """)