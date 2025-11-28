import React, { Suspense, useState } from 'react'
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
} from "@ant-design/icons";
import { Button, Layout, theme, Input } from "antd";

const { Header, Content } = Layout;
const { Search } = Input;
import Sidebar from "./sidebar";
import { Outlet } from "react-router";

const App = ({children}) => {
  const [collapsed, setCollapsed] = useState(false);
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <Layout
      style={{
        minHeight: "100vh",
      }}
    >
      <Sidebar collapsed={collapsed} />
      <Layout>
        <Header style={{ padding: 0, background: colorBgContainer }}>
          <Button
            type="text"
            icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
            onClick={() => setCollapsed(!collapsed)}
            style={{
              fontSize: "16px",
              width: 64,
              height: 64,
            }}
          />
          <Search
            placeholder="input search text"
            allowClear
            style={{ width: 200 }}
          />
        </Header>
        <Content
          style={{
            margin: "24px 16px",
            padding: 24,
            minHeight: 280,
            background: colorBgContainer,
            borderRadius: borderRadiusLG,
          }}
        >
               {/* 在这里展示 Suspense fallback，按需加载子路由时用户看到加载态 */}
         <Suspense fallback={<div>加载中...</div>}>
           <Outlet />
          </Suspense>
        </Content>
      </Layout>
    </Layout>
  );
};
export default App;
