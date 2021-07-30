<template>
  <div :class="{ 'has-errors': hasErrors }">
    <slot />

    <span class="error-message">
      {{ humanError }}
    </span>
  </div>
</template>

<script>
import _ from 'lodash';

export default {
  props: {
    errors: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  computed: {
    hasErrors() {
      return this.errors && this.errors.length > 0;
    },
    humanError() {
      return this.notEmptyErrors.join(', ');
    },
    notEmptyErrors() {
      return _.filter(this.errors, error => !_.isEmpty(error));
    },
  },
};
</script>
<style lang="scss" scoped>
  .has-errors,
  .input-settings .has-errors {
    input[type=text],
    input[type=password],
    input[type=email],
    input[name=phone] {
      border: solid 2px #ff2373;
      background-color: #fff2f7;
    }

    label {
      color: #ff2373;
    }

    .error-message {
      display: block;
      margin-top: 10px;
      font-size: 12px;
      color: #ff2373;
    }
  }
</style>
