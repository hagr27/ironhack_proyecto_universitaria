import pandas as pd
import pickle
from google.cloud import storage
import pandas as pd
from io import StringIO

# ---------------------------------------------------------
# Cargar dataset por defecto
# ---------------------------------------------------------
def cargar_dataset():
    try:
        SERVICE_ACCOUNT_JSON = "../../../credentials_gcp.json"
        bucket_name = "proyecto-universitaria-bronze"
        file_name = "datasets/students_dropout_academic_success.csv"

        client = storage.Client.from_service_account_json(SERVICE_ACCOUNT_JSON)
        bucket = client.get_bucket(bucket_name)
        blob = bucket.blob(file_name)
        data = blob.download_as_text()

        df = pd.read_csv(StringIO(data))
        return df
    except Exception as e:
        print(f"No se pudo cargar el dataset: {e}")
        return pd.DataFrame()

    

# ---------------------------------------------------------
# Resumen del proyecto mostrado en la app
# ---------------------------------------------------------
def resumen_proyecto():
    return """
### Objetivo del Proyecto
Desarrollar un modelo predictivo capaz de identificar el riesgo de *deserción estudiantil*, utilizando técnicas de Machine Learning y Big Data.

### ¿Qué hace esta aplicación?
- Carga y visualiza datos académicos.
- Permite ver gráficos simples.
- Realiza predicciones a partir de un modelo entrenado.
- Presenta conclusiones clave del proyecto.

### Dataset utilizado
El dataset contiene ***4424 registros*** con variables académicas, socioeconómicas y administrativas.

"""

# ---------------------------------------------------------
# Preprocesamiento de la entrada (ajustar según el modelo)
# ---------------------------------------------------------
def preprocesar_entrada(input_values: dict) -> pd.DataFrame:
    # Verificar que input_values no esté vacío
    if not input_values:
        raise ValueError("No se recibieron valores de entrada para preprocesar.")

    # Crear DataFrame con una sola fila
    df_input = pd.DataFrame([input_values])

    return df_input

# ---------------------------------------------------------
# Cargar modelo entrenado
# ---------------------------------------------------------
def cargar_modelo():
    with open("../model/modelo_entrenado.sav", "rb") as f:
        modelo = pickle.load(f)
    return modelo