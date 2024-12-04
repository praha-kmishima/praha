import React from 'react';
import Board from './Board';
import '../styles.css';

export default {
    component: Board,
    title: 'Board',
};

const Template = (args) => <Board {...args} />;

export const Empty = Template.bind({});
Empty.args = {
    xisNext: true,
    squares: Array(9).fill(null),
    onPlay: () => {},
};

export const XWins = Template.bind({});
XWins.args = {
        squares: ['X', 'O', 'X', 'O', 'X', 'O', 'X', null, null],
};

export const OWins = Template.bind({});
OWins.args = {
        squares: ['O', 'X', 'O', 'X', 'O', 'X', 'O', null, null],
};