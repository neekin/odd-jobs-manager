import React from "react";
import { createBrowserRouter } from "react-router";
import Dashboard from '../components/dashboard';
import Error404 from '../pages/error404';

const DataCenter = React.lazy(() => import('../pages/dashboard/dataCenter'));
const GigManage = React.lazy(() => import('../pages/dashboard/gigManage'));
const GigGroup = React.lazy(() => import('../pages/dashboard/gigGroup'));
const GigTags = React.lazy(() => import('../pages/dashboard/gigTags'));
const LateManager = React.lazy(() => import('../pages/dashboard/lateManage'));
const CCLateManager = React.lazy(() => import('../pages/dashboard/ccLateManage'));



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