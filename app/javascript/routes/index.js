import React from "react";
import { createBrowserRouter } from "react-router";
import Dashboard from '../components/dashboard';
import Error404 from '../pages/error404';

import GigManage from '../pages/dashboard/gigManage';
import GigGroup from '../pages/dashboard/gigGroup';
import GigTags from '../pages/dashboard/gigTags';
import LateManager from '../pages/dashboard/lateManage';
import CCLateManager from '../pages/dashboard/ccLateManage';
import DataCenter from '../pages/dashboard/dataCenter';


export const CHILD_ROUTES = [
  { index: true, Component: DataCenter},
  { path: "gigmanage", Component: GigManage, meta: { key: "gigmanage", label: "零工管理" } },
  { path: "gigtags", Component: GigTags, meta: { key: "gigtags", label: "零工标签" } },
  { path: "giggroup", Component: GigGroup, meta: { key: "giggroup", label: "零工分组" } },
  { path: "latemanager", Component: LateManager, meta: { key: "latemanager", label: "迟到管理" } },
  { path: "cclatemanager", Component: CCLateManager, meta: { key: "cclatemanager", label: "云中客迟到管理" } },
  { path: "datecenter", Component: DataCenter, meta: { key: "datacenter", label: "数据中心" } },
  // 如果需要更多页面，直接在这里添加一条对象即可
];

const router = createBrowserRouter([
  {
    path: "/",
    Component: Dashboard,
    errorElement: <Error404 />,
    children: CHILD_ROUTES,
  }
]);
export default router;