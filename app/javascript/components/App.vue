<template>
  <div>
    <NavigationBar />

    <div class="app-content">
      <RouterView />
    </div>
  </div>
</template>

<script>
import NavigationBar from "./elements/NavigationBar";

export default {
  components: { NavigationBar }
}
</script>

<style lang="scss">
  @import '../assets/styles/main';

  .app-content {
    padding: 30px;
    width: 100%;
    box-sizing: border-box;
  }
</style>
