import React from 'react'
import { Button, Form, Input, Radio } from 'antd';
export default function GigManager() {
    const [form] = Form.useForm();
    return <>
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