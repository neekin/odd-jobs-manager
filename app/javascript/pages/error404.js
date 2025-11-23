import React from 'react';
import { Button, Result } from 'antd';
import { useNavigate } from 'react-router';
const App = () => {
  const navigate = useNavigate();
  return(  <Result
    status="404"
    title="404"
    subTitle="Sorry, the page you visited does not exist."
    extra={
        <>
          {/* 跳回首页（替换当前历史记录） */}
          <Button type="primary" onClick={() => navigate('/', { replace: true })}>返回首页</Button>
          {/* 返回上一页（历史后退） */}
          <Button onClick={() => navigate(-1)}>返回上一页</Button>
        </>
      }
  />)

};
export default App;