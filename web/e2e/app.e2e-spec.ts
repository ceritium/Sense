import { SensengPage } from './app.po';

describe('senseng App', () => {
  let page: SensengPage;

  beforeEach(() => {
    page = new SensengPage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!!');
  });
});
