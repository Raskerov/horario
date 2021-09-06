<template>
  <form @submit.prevent="update">
    <InputBuilder
        v-model.lazy="form.fields.name"
        name="fullName"
        :label="$t('settings.fields.company.label')"
        :errors="form.errors.name"
        required
    />

    <button type="submit" class="button">
      {{ $t('settings.update_user') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import InputError from "../common/InputError";
import CompanyForm from "../../../forms/company"

export default {
  components: {
    InputBuilder,
    InputError
  },
  data() {
    return {
      form: new CompanyForm(),
    };
  },
  created() {
    this.form.fields.name = this.$auth.user.company;
  },
  methods: {
    async update() {
      //  Handle company update
    },
  },

}
</script>
