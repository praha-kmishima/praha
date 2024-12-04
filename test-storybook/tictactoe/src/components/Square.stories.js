import React from 'react';
import Square from './Square';
import '../styles.css';

export default {
  component: Square,
  title: 'Square',
};

const Template = (args) => <Square {...args} />;

export const Empty = Template.bind({});
Empty.args = {
    value: null,
    onclick: () => {},
};

export const IsX = Template.bind({});
IsX.args = {
    value: "x",
    onclick: () => {},
};

export const IsO = Template.bind({});
IsO.args = {
    value: "O",
    onclick: () => {},
};