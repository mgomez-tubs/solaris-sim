for /r "./planet 3d model/" %%f in (*.fbx) do balsam "%%f" --generateSmoothNormals --findInvalidData
@echo Kopieren der .jpg Dateien in "/maps"
for /r "./planet jpg/" %%f in (*.*) do @copy "%%f" "./maps/"