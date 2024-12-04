import React from 'react';
import Square from './Square';

export default {
  component: Square,
  title: 'Square',
};

const Template = (args) => <Square {...args} />;

export const Empty = Template.bind({});
Empty.args = {
  square: {
    value: null,
    onclick: () => {},
    }
};