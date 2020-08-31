#ifndef DRAWCIRCLEQT_H
#define DRAWCIRCLEQT_H

#include "qquick3dgeometry.h"
#include <QVector3D>

class DrawCircleQt : public QQuick3DGeometry
{
    Q_OBJECT
    Q_PROPERTY(QVector3D centerPoint READ centerPoint WRITE setCenterPoint NOTIFY centerPointChanged);
    Q_PROPERTY(float radius READ radius WRITE setRadius NOTIFY radiusChanged);
    Q_PROPERTY(int lineSteps READ lineSteps WRITE setLineSteps NOTIFY lineStepsChanged);

    public:
        DrawCircleQt();
        ~DrawCircleQt() override;

        // Properties values, now C++ declared
        QVector3D centerPoint() const;
        float radius() const;
        int lineSteps() const;

    public Q_SLOTS:
        void setCenterPoint(QVector3D point);
        void setRadius(float point);
        void setLineSteps(int steps);

    Q_SIGNALS:
        void centerPointChanged();
        void radiusChanged();
        void lineStepsChanged();

    protected:
         QSSGRenderGraphObject *updateSpatialNode(QSSGRenderGraphObject *node) override;

    private:
        QVector3D m_centerPoint = QVector3D(0,0,0);
        float m_radius = 100;
        int m_lineSteps = 100;

        bool m_dirty = true;
};


#endif // DRAWCIRCLEQT_H
