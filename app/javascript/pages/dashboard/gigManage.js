import React from 'react'
import { Button, Form, Input, Radio, Tabs, Spin, List } from 'antd';
import useFetch from '../../hooks/useFetch'; // 新增
export default function GigManager() {
    const [form] = Form.useForm();
    const { data, loading, error, reload } = useFetch('/api/v2/users', { auto: true });
    const users = (data && data['data']) || [];
    const groups = (data && data['groups']) || [];
    console.log('Fetched users:', groups);
    return <>
          <Tabs
        defaultActiveKey="1"
        tabPlacement={'top'}
        style={{ height: 220 }}
        items={groups.map((group, index) => ({
          label: `${group.name}(${group.users_count})`,
          key: String(group.id)
        }))}
      />
        <Form
      layout={'inline'}
      form={form}
      initialValues={{ layout: 'inline' }}

    >

      <Form.Item label="Field A">
        <Input placeholder="input placeholder" />
      </Form.Item>
      <Form.Item label="Field B">
        <Input placeholder="input placeholder" />
      </Form.Item>
      <Form.Item>
        <Button type="primary">Submit</Button>
      </Form.Item>
    </Form>
    </>
}