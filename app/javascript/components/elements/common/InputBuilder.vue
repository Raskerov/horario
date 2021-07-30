<template>
  <div>
    <InputError :errors="errors">
      <label :for="name">
        <slot name="label">
          {{ label }}
          <sup v-if="required">
            *
          </sup>
        </slot>
      </label>
      <slot>
        <input
          :id="name"
          :name="name"
          :value="value"
          :placeholder="placeholder"
          :disabled="disabled"
          :type="type"
          :autofocus="autofocus"
          :tabindex="tabindex"
          :autocomplete="autocomplete ? 'on' : 'off'"
          @input="updateValue($event.target.value)"
        >
      </slot>
      <small v-if="hint.length > 0">
        {{ hint }}
      </small>
    </InputError>
  </div>
</template>

<script>
import InputError from './InputError.vue';

export default {
  components: {
    InputError,
  },
  props: {
    errors: {
      type: Array,
      default() {
        return [];
      },
    },
    disabled: {
      type: Boolean,
      required: false,
      default: false,
    },
    required: {
      type: Boolean,
      required: false,
      default: false,
    },
    value: {
      type: String,
      required: false,
      default: '',
    },
    name: {
      type: String,
      required: false,
      default: '',
    },
    placeholder: {
      type: String,
      required: false,
      default: '',
    },
    hint: {
      type: String,
      required: false,
      default: '',
    },
    label: {
      type: String,
      required: false,
      default: '',
    },
    type: {
      type: String,
      required: false,
      default: 'text',
    },
    tabindex: {
      type: String,
      required: false,
      default: '',
    },
    autofocus: {
      type: Boolean,
      required: false,
      default: false,
    },
    autocomplete: {
      type: Boolean,
      required: false,
      default: true,
    },
  },
  methods: {
    updateValue(value) {
      this.$emit('input', value);
    },
  },
};
</script>

<style lang="scss" scoped>
  input {
    outline: none;
  }

  sup {
    color: #ff2373;
  }
</style>
