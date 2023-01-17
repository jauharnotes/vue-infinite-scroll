<template>
  <div class="wrapper">
    <div class="row">
      <div v-for="img in images" :key="img.id" class="card">
        <p>{{ img.product_nama }}</p>
        <p>{{ finised }}</p>
      </div>
    </div>
    <div v-if="loading">Loading...</div>
    <div v-show="finised">finised</div>
  </div>
</template>

<script>
// import Preloader from './Preloader'
// import SingleImage from './SingleImage'
import axios from 'axios';

export default {
  data() {
    return {
      images: [],
      totalImages: 0,
      perPage: 7,
      currentPage: 1,
      finised: false,
      loading: false,
    };
  },

  created() {
    this.fetchImages();

    window.addEventListener('scroll', () => {
      if (this.finised != true) {
        this.onScroll();
      }
    });
  },

  methods: {
    fetchImages() {
      this.loading = true;

      axios
        .get(
          `https://medis-api.devb.idbrilian.com/api/v1/products?rows=${this.perPage}&page=${this.currentPage}`
        )
        .then((res) => {
          setTimeout(() => {
            this.handleImageUploading(res);
          }, 2000);
        })
        .catch((err) => this.handleErrorResponse(err));
    },

    handleErrorResponse(err) {
      this.loading = false;
      console.error(err);
    },

    handleImageUploading(res) {
      this.images = this.images.concat(res.data.data.datas);
      const datas = res.data.data.datas;
      if (datas.length === 0) {
        this.finised = true;
      }
      // this.totalImages = parseInt(res.headers['x-total']);
      this.currentPage = this.currentPage + 1;
      // if (this.images.length < this.perPage) {}
      this.loading = false;
    },

    onScroll() {
      let wrap = document.querySelector('.wrapper');
      let contentHeight = wrap.offsetHeight;
      let yOffset = window.pageYOffset;
      let currentPosition = yOffset + window.innerHeight;

      if (currentPosition >= contentHeight && !this.loading) {
        this.fetchImages();
      }
    },
  },

  // components: {
  //   Preloader,
  //   SingleImage,
  // },
};
</script>

<style>
.card {
  width: 200px;
  height: 100px;
  background: #fff;
  margin-top: 40px;
}
</style>
