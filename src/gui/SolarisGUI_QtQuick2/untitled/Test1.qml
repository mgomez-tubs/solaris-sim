import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Extras 2.12
import Qt3D.Input 2.12


Entity {
    components: [       // A list of components is always needed
        RenderSettings{
            activeFrameGraph: ForwardRenderer{
                clearColor: "black"     // Background color
                camera: Camera {
                    id: camera
                    projectionType: CameraLens.PerspectiveProjection
                    fieldOfView: 45
                    nearPlane: 0.1      // minimal rendering distance
                    farPlane: 1000.0    // max render distance
                    position: Qt.vector3d(20,20,20)
                    upVector: Qt.vector3d(0,0,1)
                    viewCenter: Qt.vector3d(0,0,0)
                 }
            }
        },
        InputSettings{

        }
    ]
    FirstPersonCameraController{
        camera: camera
    }

    Entity {        // Light
        components: [
            DirectionalLight{
                color: Qt.rgba(1,1,1)
                intensity: 1
                worldDirection: Qt.vector3d(0,-1,0)
            }
        ]
    }

    Entity{         // sphere mesh sun
        components: [
           SphereMesh{

           },
           TextureMaterial{
               id: material
               texture: TextureLoader{
                   id: textureLoader
                   source: "textures/2k_sun.jpg"
               }
           },
           Transform{
               scale: 2
               translation: Qt.vector3d(0,0,0);
          }
        ]
    }

    Entity{         // sphere mesh
        components: [
            SphereMesh{

            },
            DiffuseSpecularMaterial{
                diffuse: "#4287f5"      //blue
                shininess: 100;

            },
            Transform{
                scale: 2
                translation: Qt.vector3d(0,5,0);

            }
        ]
    }

    Entity{         // sphere mesh
        components: [
            SphereMesh{

            },
            DiffuseSpecularMaterial{
                diffuse: "#4287f5"      //blue
                shininess: 100;

            },
            Transform{
                scale: 10
                translation: Qt.vector3d(0,0,5);

            }
        ]
    }
}
