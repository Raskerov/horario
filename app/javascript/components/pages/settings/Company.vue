<template>
  <div>
    <div class="wrapper">
      <CompanyForm />

      <div class="company-delete">
        <div class="company-delete--label">
          {{ $t('settings.fields.company.delete') }}
        </div>

        <button type="submit" class="button button--reverse-color" @click="deleteCompany">
          {{ $t('settings.delete') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import CompanyForm from "../../elements/forms/CompanyForm";
import companyRepository from "../../../repositories/company_repository";

export default {
  components: { CompanyForm },
  methods: {
    deleteCompany() {
      this.$fire({
        text: `${this.$t('settings.fields.company.confirm_delete')}`,
        type: "question",
        input: 'text',
        inputPlaceholder: `${this.$t('settings.fields.password.label')}`,
        showCancelButton: true,
        buttonsStyling: false,
        confirmButtonText: `${this.$t('settings.delete')}`,
        confirmButtonClass: 'button button--alert',
        cancelButtonClass: 'button button--alert button--reverse-color',
        cancelButtonText: `${this.$t('settings.abort')}`
      }).then((input) => {
        companyRepository.delete({ password: input.value });
      });
    },
  },
}
</script>

<style lang="scss" scoped>
  .wrapper {
    max-width: 400px;
  }

  .company-delete {
    margin-top: 50px;
  }

  .company-delete--label {
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 10px;
  }
</style>
