import React from "react";
import {
  DesktopOutlined,
  FileOutlined,
  PieChartOutlined,
  UserOutlined,
  UserSwitchOutlined,
  UsergroupAddOutlined,
  FieldTimeOutlined,
  CloudSyncOutlined,
  TagsOutlined
} from "@ant-design/icons";
import { Layout, Menu } from "antd";
const { Sider } = Layout;
import { useNavigate, useLocation } from "react-router"; // 使用 react-router-dom
import { CHILD_ROUTES } from "../routes"; // 从路由中复用配置

const ICON_MAP = {
  datacenter: <PieChartOutlined />,
  gigmanage: <UserOutlined />,
  gigtags: <TagsOutlined />,
  giggroup: <UsergroupAddOutlined />,
  latemanager: <FieldTimeOutlined />,
  cclatemanager: <CloudSyncOutlined />,
};

function Sidebar({ collapsed = false }) {
  // 只保留包含 meta 的路由用于菜单展示
  const menuRoutes = CHILD_ROUTES.filter(
    (r) => r.meta && r.meta.key && r.meta.label
  );

  function toMenuItem(route) {
    const key = route.meta.key;
    return {
      key,
      icon: ICON_MAP[key] || <FileOutlined />,
      label: route.meta.label,
    };
  }

  const menuItems = menuRoutes.map((r) => toMenuItem(r));
  const navigate = useNavigate();
  const location = useLocation();

  const pathname = location.pathname;
  const selectedKey = (() => {
    // 如果在根路径，优先查找有 meta 的 index 路由
    if (pathname === "/") {
      const idx = menuRoutes.find((r) => r.index);
      return idx ? idx.meta.key : null;
    }
    const seg = pathname.split("/").filter(Boolean)[0];
    const route = menuRoutes.find((r) => r.path === seg);
    return route?.meta?.key || null;
  })();

  return (
    <Sider trigger={null} collapsible collapsed={collapsed}>
      <div className="demo-logo-vertical" />
      <Menu
        theme="dark"
        selectedKeys={selectedKey ? [selectedKey] : []}
        mode="inline"
        items={menuItems}
        onClick={({ key }) => {
          const route = menuRoutes.find((r) => r.meta.key === key);
          if (!route) return;
          const to = route.index ? "/" : `/${route.path}`;
          navigate(to);
        }}
        // 预取：鼠标移入时加载对应 chunk，减少点击等待
        onMouseEnter={(e) => {
          const item = e.target.closest('[data-menu-key]');
          if (!item) return;
          const key = item.getAttribute('data-menu-key');
          const route = menuRoutes.find((r) => r.meta.key === key);
          if (route && route.path) {
            // 根据 path 做一次动态 import 的预取（与 routes 中的懒加载路径对应）
            import(`../pages/dashboard/${route.path}`).catch(() => {});
          }
        }}
      />
    </Sider>
  );
}

export default Sidebar;
