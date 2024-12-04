import React from 'react';
import { within, userEvent } from '@storybook/test';
import Game from './Game';
import '../styles.css';

export default {
    component: Game,
    title: 'Game',
};

const Template = () => <Game />;

export const Default = Template.bind({});

Default.play = async ({ canvasElement }) => {
    const canvas = within(canvasElement);
  
    await userEvent.click(canvas.getAllByRole('button')[0], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[1], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[2], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[3], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[4], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[5], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[6], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[7], {
        delay: 100
    });  
    await userEvent.click(canvas.getAllByRole('button')[8], {
        delay: 100
    });  
  };