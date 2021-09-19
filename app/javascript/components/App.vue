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
    background-color: #e2e2e2;
    height: calc(100vh - 50px);
    overflow-y: scroll;
  }
</style>
