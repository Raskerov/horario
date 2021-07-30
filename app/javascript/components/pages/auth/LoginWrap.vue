<template>
  <div>
    <RouterView @success="loginSuccess" />
  </div>
</template>
<script>
export default {
  data() {
    return {
      redirectUrl: '/app',
    };
  },
  methods: {
    loginSuccess() {
      window.location = this.redirectUrl;
    },
  },
};
</script>
<style lang="scss" scoped>
</style>
