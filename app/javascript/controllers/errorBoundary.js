import React from "react";
import Error500 from "../pages/error500";
export default class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, info) {
    // 记录日志
    console.error("ErrorBoundary caught", error, info);
    // 可上报到监控服务
  }

  render() {
    if (this.state.hasError) {
      // 简单 UI，或导航到 /500
      return <Error500 />;
    }

    return this.props.children;
  }
}