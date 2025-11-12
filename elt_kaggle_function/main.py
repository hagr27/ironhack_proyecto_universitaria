import os
import tempfile
from google.cloud import storage

def download_kaggle_to_gcs(request):
    """
    Descarga un dataset de Kaggle y lo sube a un bucket de GCS.
    """
    # Configurar variables de entorno para Kaggle
    os.environ["KAGGLE_USERNAME"] = os.environ.get("KAGGLE_USER")
    os.environ["KAGGLE_KEY"] = os.environ.get("KAGGLE_KEY")

    # Importar KaggleApi después de configurar las variables
    from kaggle.api.kaggle_api_extended import KaggleApi
    api = KaggleApi()
    api.authenticate()

    # Dataset que quieres descargar
    dataset = "adilshamim8/predict-students-dropout-and-academic-success"

    # Crear directorio temporal
    temp_dir = tempfile.mkdtemp()
    api.dataset_download_files(dataset, path=temp_dir, unzip=True)

    # Cliente de GCS
    bucket_name = os.environ.get("BUCKET_NAME")
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)

    # Subir todos los archivos del dataset a GCS
    for file_name in os.listdir(temp_dir):
        file_path = os.path.join(temp_dir, file_name)
        blob = bucket.blob(f"datasets/{file_name}")
        blob.upload_from_filename(file_path)
        print(f"Archivo subido: {file_name}")

    return f"Dataset {dataset} descargado y subido a {bucket_name} correctamente."
