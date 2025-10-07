import { ActiveUser } from './activeUser.decorator';

describe('ActiveUser Decorator', () => {
  it('should be defined', () => {
    expect(ActiveUser).toBeDefined();
  });

  it('should be a parameter decorator', () => {
    expect(typeof ActiveUser).toBe('function');
  });
});
