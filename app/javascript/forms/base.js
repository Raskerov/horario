import _ from 'lodash';

export default class BaseForm {
  fields = {};
  errors = {};
  loading = false;
  success = false;

  assign(attrs) {
    _.assign(this.fields, attrs);
  }

  clearErrors() {
    this.errors = {};
  }

  submit() {
    return this.actionWithLoading(() => this.action());
  }

  async actionWithLoading(action) {
    this.loading = true;
    let result = false;

    try {
      result = await action();

      this.success = true;
      this.clearErrors();
    } catch ({ details }) {
      this.success = false;
      this.errors = details;
    }

    this.loading = false;
    return result;
  }
}
