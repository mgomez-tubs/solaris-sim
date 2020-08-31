#include "drawcircleqt.h"
#include <QtQuick3DRuntimeRender>
#include <math.h>

/* The purpouse of this code is to create a circle made of infividual lines within Qt Quick 3D
 * Qt Quick 3D does not have the native ability to create either lines or circles, only 3D meshes.
 * For that reason a code for it had to be written.
 */

//! \brief Constructor
DrawCircleQt::DrawCircleQt() : QQuick3DGeometry()
{

}

//! \brief Destructor
DrawCircleQt::~DrawCircleQt()
{

}

//! \brief Returns the center point of the Circle (as a vector)
QVector3D DrawCircleQt::centerPoint() const
{
    return m_centerPoint;
}

//! \brief Returns the radius of the circle (as a float)
float DrawCircleQt::radius() const
{
    return m_radius;
}

//! \brief Returns the ammount of line stepes (as an int)
int DrawCircleQt::lineSteps() const
{
    return m_lineSteps;
}

//! \brief Sets the center point of the circle
//! \param point - The middle point of the circle
void DrawCircleQt::setCenterPoint(QVector3D point)
{
    m_centerPoint = point;
    emit centerPointChanged();
    update();
    m_dirty = true;
}

/*!
 * \brief Set the property: radius values
 * \param radius - The radius of the circle
 */
void DrawCircleQt::setRadius(float radius)
{
    radius = qMax(radius,1.0f);
    if(qFuzzyCompare(m_radius,radius))
        return;
    m_radius = radius;
    emit radiusChanged();
    update();
    m_dirty = true;
}

/*!
 * \brief Set the property: line steps
 * \param steps - The ammount of line steps
 */
void DrawCircleQt::setLineSteps(int steps)
{
    m_lineSteps = steps;
    emit lineStepsChanged();
    update();
    m_dirty = true;
}

/*!
 *  Fill the vertex data
 * \param &vertexdata - Array of bytes corresponding to every dot that consitutes the line (hier circle)
 * \param centerPoint - Property which describes the center from which the radius is to be calculated
 * \param radius - The radius of the circele
 * \param lineSteps - The ammount of line steps (sides) in which the circle is to be created
 */
static void fillVertexData(QByteArray &vertexData, QVector3D centerPoint, float radius,
                           int lineSteps)
{
    const int size = (lineSteps+1) * sizeof(float) * 8 * 1;         // 1 Element: # Lines
                                                                    // 2 Element: Size is in bytes, sizeof(float) = 4
                                                                    // 3 Element: see below dataPtr[] -> 8
                                                                    // 4 Element: Bei LineSteps immer 1
    vertexData.resize(size);
    float *dataPtr = reinterpret_cast<float *>(vertexData.data());  // reinterpret cast is used to convert a pointer type to another pointer type, here float qByteArray* to float*

    float winkelStep = (2*M_PI)/lineSteps;
    float currentAngle = 0;

    // This Loop reads the byte array and trand
    // First step: draw a circle with the basis vector (1,0,0) (0,1,0) (0,0,1)
    // Second step: define the normal vector
    for (int i = 0; i < lineSteps+1; ++i) {
        // start position           /* z.B.: erste iteration, oben links
        dataPtr[0] = centerPoint.x()+cos(currentAngle)*radius;
        dataPtr[1] = centerPoint.y()+sin(currentAngle)*radius;
        dataPtr[2] = 0;
        dataPtr[3] = 1.f;

        dataPtr[4] = 0;
        dataPtr[5] = 0;
        dataPtr[6] = 1.f;
        dataPtr[7] = 0;

        currentAngle+=winkelStep;
        dataPtr += 8;
    }
}

/*! \brief Constructs an object that can be understood and rendered with QML
 *  \param node - Pointer to the node object to be parsed
 *  \return node - The node object to be rendered
 */
QSSGRenderGraphObject *DrawCircleQt::updateSpatialNode(QSSGRenderGraphObject *node)
{
    if (m_dirty) {  // If there where no errors found and this bit was not reversed, proceed with creating
        QByteArray vertexData;
        fillVertexData(vertexData, m_centerPoint, m_radius, m_lineSteps);
        clear();
        addAttribute(QQuick3DGeometry::Attribute::PositionSemantic, 0,
                     QQuick3DGeometry::Attribute::ComponentType::F32Type);
        addAttribute(QQuick3DGeometry::Attribute::NormalSemantic, 16,
                     QQuick3DGeometry::Attribute::ComponentType::F32Type);
        setStride(32);

        setVertexData(vertexData);
        setPrimitiveType(QQuick3DGeometry::PrimitiveType::LineStrip);
        setBounds(QVector3D(-m_radius,-m_radius,0),QVector3D(m_radius,m_radius,0));
    }
    node = QQuick3DGeometry::updateSpatialNode(node);
    return node;
}
