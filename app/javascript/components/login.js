import React from "react";
import {
  AlipayOutlined,
  LockOutlined,
  MobileOutlined,
  TaobaoOutlined,
  UserOutlined,
  WeiboOutlined,
} from "@ant-design/icons";
import {
  LoginFormPage,
  ProConfigProvider,
  ProFormCaptcha,
  ProFormCheckbox,
  ProFormText,
} from "@ant-design/pro-components";
import { Button, Divider, Space, Tabs, message, theme } from "antd";

import { useState } from "react";

const iconStyles = {
  color: "rgba(0, 0, 0, 0.2)",
  fontSize: "18px",
  verticalAlign: "middle",
  cursor: "pointer",
};

const Page = () => {

  const { token } = theme.useToken();
    // 登录提交处理：POST /sessions，带 X-CSRF-Token
  const handleSubmit = async (values) => {
    try {
      const csrf = document.querySelector('meta[name="csrf-token"]')?.content;
      // 将 autoLogin 一并提交（ProFormCheckbox 名为 autoLogin）
      const payload = {
        username: values.username,
        password: values.password,
        autoLogin: !!values.autoLogin
      };
      const res = await fetch("/sessions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrf || ""
        },
        body: JSON.stringify(payload),
        credentials: "same-origin" // 同源，cookie 会自动携带
      });

      if (res.ok) {
        const data = await res.json();
        message.success("登录成功");
        // 登录成功后跳回 SPA 根
        window.location.href = "/";
      } else {
        const err = await res.json().catch(() => ({}));
        message.error(err.error || "登录失败");
      }
    } catch (e) {
      console.error(e);
      message.error("网络错误");
    }
  };

  return (
    <div
      style={{
        backgroundColor: "white",
        height: "100vh",
      }}
    >
      <LoginFormPage
        backgroundImageUrl="https://mdn.alipayobjects.com/huamei_gcee1x/afts/img/A*y0ZTS6WLwvgAAAAAAAAAAAAADml6AQ/fmt.webp"
        logo="https://github.githubassets.com/favicons/favicon.png"
        backgroundVideoUrl="https://gw.alipayobjects.com/v/huamei_gcee1x/afts/video/jXRBRK_VAwoAAAAAAAAAAAAAK4eUAQBr"
        title="Github"
        containerStyle={{
          backgroundColor: "rgba(0, 0, 0,0.65)",
          backdropFilter: "blur(4px)",
        }}
        subTitle="全球最大的代码托管平台"
        activityConfig={{
          style: {
            boxShadow: "0px 0px 8px rgba(0, 0, 0, 0.2)",
            color: token.colorTextHeading,
            borderRadius: 8,
            backgroundColor: "rgba(255,255,255,0.25)",
            backdropFilter: "blur(4px)",
          },
          title: "活动标题，可配置图片",
          subTitle: "活动介绍说明文字",
          action: (
            <Button
              size="large"
              style={{
                borderRadius: 20,
                background: token.colorBgElevated,
                color: token.colorPrimary,
                width: 120,
              }}
              onClick={()=> {window.location.href='/'}}
            >
              去看看
            </Button>
          ),
        }}
        onFinish={async (values) =>handleSubmit(values)}
      >
          <>
            <ProFormText
              name="username"
              fieldProps={{
                size: "large",
                prefix: (
                  <UserOutlined
                    style={{
                      color: token.colorText,
                    }}
                    className={"prefixIcon"}
                  />
                ),
              }}
              placeholder={"用户名: admin or user"}
              rules={[
                {
                  required: true,
                  message: "请输入用户名!",
                },
              ]}
            />
            <ProFormText.Password
              name="password"
              fieldProps={{
                size: "large",
                prefix: (
                  <LockOutlined
                    style={{
                      color: token.colorText,
                    }}
                    className={"prefixIcon"}
                  />
                ),
              }}
              placeholder={"密码: ant.design"}
              rules={[
                {
                  required: true,
                  message: "请输入密码！",
                },
              ]}
            />
          </>
  
        <div
          style={{
            marginBlockEnd: 24,
          }}
        >
          <ProFormCheckbox noStyle name="autoLogin">
            自动登录
          </ProFormCheckbox>
          <a
            style={{
              float: "right",
            }}
          >
            忘记密码
          </a>
        </div>
      </LoginFormPage>
    </div>
  );
};

export default () => {
  return (
    <ProConfigProvider dark>
      <Page />
    </ProConfigProvider>
  );
};
