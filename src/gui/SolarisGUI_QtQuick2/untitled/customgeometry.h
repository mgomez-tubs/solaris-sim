#ifndef CUSTOMGEOMETRY_H
#define CUSTOMGEOMETRY_H

#include "qquick3dgeometry.h"

class CustomGeometry : public QQuick3DGeometry
{
    Q_OBJECT
    /* This properties will also be the properties to be set when using this object from QML*/
    /* They have to be first QML declared */
    Q_PROPERTY(int horizontalLines READ horizontalLines WRITE setHorizontalLines NOTIFY horizontalLinesChanged);
    Q_PROPERTY(int verticalLines READ verticalLines WRITE setVerticalLines NOTIFY verticalLinesChanged);
    Q_PROPERTY(float horizontalStep READ horizontalStep WRITE setHorizontalStep NOTIFY horizontalStepChanged)
    Q_PROPERTY(float verticalStep READ verticalStep WRITE setVerticalStep NOTIFY verticalStepChanged)

    public:
        CustomGeometry();       // Constructor
        ~CustomGeometry() override;     // Destructor

        // Properties values, now C++ declared
        int horizontalLines() const;
        int verticalLines() const;
        float horizontalStep() const;
        float verticalStep() const;

    public Q_SLOTS:
        void setHorizontalLines(int count);
        void setVerticalLines(int count);
        void setHorizontalStep(float step);
        void setVerticalStep(float step);

    Q_SIGNALS:
        void horizontalLinesChanged();
        void verticalLinesChanged();
        void horizontalStepChanged();
        void verticalStepChanged();

        void setProperty()
        {

        }

    protected:
         QSSGRenderGraphObject *updateSpatialNode(QSSGRenderGraphObject *node) override;

    private:
        int m_horLines = 1000;
        int m_vertLines = 1000;
        float m_horStep = .1f;
        float m_vertStep = .1f;
        bool m_dirty = true;
};



#endif // CUSTOMGEOMETRY_H
