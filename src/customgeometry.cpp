#include "customgeometry.h"
#include "QtQuick3DRuntimeRender/QtQuick3DRuntimeRender"

CustomGeometry::CustomGeometry() : QQuick3DGeometry()
{

}

CustomGeometry::~CustomGeometry()
{

}

int CustomGeometry::horizontalLines() const
{
    return m_horLines;
}

int CustomGeometry::verticalLines() const
{
    return m_vertLines;
}

float CustomGeometry::horizontalStep() const
{
    return m_horStep;
}

float CustomGeometry::verticalStep() const
{
    return m_vertStep;
}

void CustomGeometry::setHorizontalLines(int count)  // count: how many horizontal Lines
{
    count = qMax(count, 1);     // this line prevents the hoizontal lines to be less than 1
    if (m_horLines == count)    // and in case the horizontal lines equal 1, return.
        return;
    m_horLines = qMax(count, 1);        // for whatever reason qMax is called again
    emit horizontalLinesChanged();      // emit signal
    update();                           // update something to qtquick3d
    m_dirty = true;
}

void CustomGeometry::setVerticalLines(int count)    // same procedure as in horizontal Lines
{
    count = qMax(count, 1);
    if (m_vertLines == count)
        return;
    m_vertLines = qMax(count, 1);
    emit verticalLinesChanged();
    update();
    m_dirty = true;
}


void CustomGeometry::setHorizontalStep(float step)
{
    step = qMax(step, 0.0f);        // the step can be max 0.0
    if (qFuzzyCompare(m_horStep, step))     // same procedure as before, qfuzzy returns true if both are equal
        return;
    m_horStep = step;
    emit horizontalStepChanged();
    update();
    m_dirty = true;
}

void CustomGeometry::setVerticalStep(float step)
{
    step = qMax(step, 0.0f);
    if (qFuzzyCompare(m_vertStep, step))
        return;
    m_vertStep = step;
    emit verticalStepChanged();
    update();
    m_dirty = true;
}

static void fillVertexData(QByteArray &vertexData, int horLines, float horStep,
                           int vertLines, float vertStep)
{
    /* vertex data consists of dots */
    const int size = (horLines + vertLines) * sizeof(float) * 8 * 2;        // size in bits?
    vertexData.resize(size);
    float *dataPtr = reinterpret_cast<float *>(vertexData.data());

    float y0 = -float(horLines - 1) * horStep * .5f;
    float x0 = -float(vertLines - 1) * vertStep * .5f;
    float y1 = -y0;
    float x1 = -x0;

    for (int i = 0; i < horLines; ++i) {
        // start position           /* von links nach rechts ganz oben */
        dataPtr[0] = x0;
        dataPtr[1] = y0 + i * horStep;
        dataPtr[2] = .0f;
        dataPtr[3] = 1.f;

        dataPtr[4] = 0;
        dataPtr[5] = 0;
        dataPtr[6] = 1.f;
        dataPtr[7] = 0;

        dataPtr += 8;

        // end position             /* von links nach rechts ganz unten */
        dataPtr[0] = x1;
        dataPtr[1] = y0 + i * horStep;
        dataPtr[2] = .0f;
        dataPtr[3] = 1.f;

        dataPtr[4] = 0;
        dataPtr[5] = 0;
        dataPtr[6] = 1.f;
        dataPtr[7] = 0;

        dataPtr += 8;
    }

    for (int i = 0; i < vertLines; ++i) {
        // start position           /*  von oben nach unten ganz links  */
        dataPtr[0] = x0 + i * vertStep;
        dataPtr[1] = y0;
        dataPtr[2] = .0f;
        dataPtr[3] = 1.f;

        dataPtr[4] = 0;
        dataPtr[5] = 0;
        dataPtr[6] = 1.f;
        dataPtr[7] = 0;

        dataPtr += 8;

        // end position             /* von oben nach unten ganz rechts  */
        dataPtr[0] = x0 + i * vertStep;
        dataPtr[1] = y1;
        dataPtr[2] = .0f;
        dataPtr[3] = 1.f;

        dataPtr[4] = 0;
        dataPtr[5] = 0;
        dataPtr[6] = 1.f;
        dataPtr[7] = 0;

        dataPtr += 8;
    }
}

QSSGRenderGraphObject *CustomGeometry::updateSpatialNode(QSSGRenderGraphObject *node)
{
    if (m_dirty) {
        QByteArray vertexData;
        fillVertexData(vertexData, m_horLines, m_horStep, m_vertLines, m_vertStep);
        clear();
        addAttribute(QQuick3DGeometry::Attribute::PositionSemantic, 0,          // ?
                     QQuick3DGeometry::Attribute::ComponentType::F32Type);
        addAttribute(QQuick3DGeometry::Attribute::NormalSemantic, 16,           // ?
                     QQuick3DGeometry::Attribute::ComponentType::F32Type);
        setStride(32);
        setVertexData(vertexData);
        setPrimitiveType(QQuick3DGeometry::PrimitiveType::Lines);
        setBounds(QVector3D(-m_vertLines/2, -m_horLines/2, 0.0) * m_horStep,            // starting point (oben links) (as vector)
                            QVector3D(m_vertLines/2, m_horLines/2, 0.0) * m_vertStep);  // ending point (unten rechts) (as vector)
    }
    node = QQuick3DGeometry::updateSpatialNode(node);
    return node;
}
