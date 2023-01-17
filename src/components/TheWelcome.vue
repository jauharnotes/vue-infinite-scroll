<script setup>
import { ref } from '@vue/reactivity';
import InfiniteLoading from 'v3-infinite-loading';
import 'v3-infinite-loading/lib/style.css'; //required if you're not going to override default slots

let comments = ref([]);
let page = 1;
const load = async ($state) => {
  console.log('loading...');

  try {
    const response = await fetch(
      'https://medis-api.devb.idbrilian.com/api/v1/products?rows=3&page=' + page
    );
    const json = await response.json();
    console.log(json.data.datas);
    const productDatas = json.data.datas;
    if (productDatas.length < 3) $state.complete();
    else {
      // comments.value.push(...json);
      comments.value.push(...json.data.datas);
      $state.loaded();
    }
    page++;
  } catch (error) {
    $state.error();
  }
};
</script>

<template>
  <div class="result" v-for="comment in comments" :key="comment.id">
    <div>{{ comment.product_nama }}</div>
    <div>{{ comment.product_harga }}</div>
  </div>
  <InfiniteLoading @infinite="load" />
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.result {
  display: flex;
  flex-direction: column;
  gap: 5px;
  font-weight: 300;
  width: 400px;
  padding: 110px;
  text-align: center;
  margin: 0 auto 10px auto;
  background: #eceef0;
  border-radius: 10px;
}
</style>
