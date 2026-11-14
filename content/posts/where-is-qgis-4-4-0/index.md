---
title: "Where is QGIS 4.4.0?"
date: "2026-11-04T12:28:21+00:00"
draft: false
authors: ["timlinux"]
categories: ["Public Service Announcement"]
featured_image: "roadmap.png"
---

We recently
[announced](https://blog.qgis.org/2026/10/03/release-schedule-changes-for-next-qgis-ltr/)
that QGIS 4.4.0 would be delayed while we work to clear up a number of
regressions that occurred in the porting of QGIS from Qt5 to Qt6. The original
planned date for the release was 30 October 2026. The QGIS developer team is
working to systematically resolve the [blocking issues](https://github.com/orgs/qgis/projects/18).

![project board](project-board.png)

The logic being used to decide what blocking issues are is: Any issue which
occurs in QGIS 4.4 and does not occur in 3.x is considered blocking. Conversely,
any issue which occurs in both 3.x and 4.x is NOT considered blocking.

There are two mailing list threads that discuss this too, if you want further context.

1. https://lists.osgeo.org/pipermail/qgis-developer/2026-October/068634.html
2. https://lists.osgeo.org/pipermail/qgis-developer/2026-October/068652.html

We will keep you posted as things develop, but watching the [project board](https://github.com/orgs/qgis/projects/18) is the best way to keep track of progress towards QGIS 4.4.0.

Thanks!

The QGIS Team
