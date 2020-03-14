<template>
  <div id="app">
    <ReactiveBase
      app="books"
      url="http://127.0.0.1:9200"
    >
      <div class="navbar">
        <h2>📚Book<span>Search</span></h2>
        <DataSearch
          componentId="title"
          iconPosition="right"
          :dataField="[
            'original_title',
            'original_title.search',
            'original_title.autosuggest',
            'authors',
            'authors.search',
            'authors.autosuggest',
          ]"
          className="data-search"
          :showClear="false"
          queryFormat="and"
          :fieldWeights="[3, 3, 1, 2, 2, 1]"
          placeholder="Search for book"
      />
      </div>
      <button class="toggle" @click="switchContainer">
        {{ showBooks ? "Show Filter 💣" : "Show Books 📚" }}
      </button>
      <div class="container">
        <div class="filters-container" :class="{ full: !showBooks }">
          <MultiList
            componentId="Authors"
            dataField="authors.keyword"
            class="filter"
            title="Select Authors"
            selectAllLabel="All Authors"
            :react="{ and: ['Ratings', 'title'] }"
          />
          <MultiRange
            componentId="Ratings"
            dataField="average_rating"
            :data="[
              { start: 0, end: 3, label: 'Rating < 3' },
              { start: 3, end: 4, label: 'Rating 3 to 4' },
              { start: 4, end: 5, label: 'Rating > 4' }
            ]"
            title="Book Ratings"
            class="filter"
          />
        </div>

        <div class="result-container" :class="{ full: showBooks }">
          <SelectedFilters
            className="selected-filters"
          />
          <ReactiveList
            componentId="SearchResult"
            dataField="original_title.keyword"
            :pagination="true"
            :pages="10"
            :from="0"
            :size="10"
            :showEndPage="true"
            :showResultStats="true"
            className="result-list-container"
            :react="{ and: ['Ratings', 'Authors', 'title'] }"
            :innerClass="{ list: 'foo', poweredBy: 'appbase' }"
            :sortOptions="[
              {
                label: 'Best Match',
                dataField: '_score',
                sortBy: 'desc'
              },
              {
                label: 'Most Ratings',
                dataField: 'ratings_count',
                sortBy: 'desc'
              },
              {
                label: 'Most Stars',
                dataField: 'average_rating',
                sortBy: 'desc'
              },
              {
                label: 'Fewest Stars',
                dataField: 'average_rating',
                sortBy: 'asc'
              },
              {
                label: 'Publication year',
                dataField: 'original_publication_year',
                sortBy: 'desc'
              },
              {
                label: 'Number of books',
                dataField: 'books_count',
                sortBy: 'desc'
              },
            ]"
          >
            <div slot="renderItem" slot-scope="{ item }">
              <div class="flex book-content" key="item._id">
                <img :src="item.image" alt="Book Cover" class="book-image" />
                <div class="book-card flex justify-center">
                  <div class="book-title">{{ item.original_title }}</div>
                  <div class="flex justify-space-between">
                    <div>by <span class="authors-list">{{ item.authors }}</span></div>
                    <div class="book-bottom">
                      <span class="pub-year">Pub {{item.original_publication_year}}     </span>
                      <span class="rating">{{item.average_rating}} ⭐️ ({{Math.floor(item.ratings_count / 1000)}}k)</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </ReactiveList>
        </div>
      </div>
    </ReactiveBase>
  </div>
</template>

<script>
import "./styles.css";
export default {
  name: "app",
  data: function() {
    return {
      showBooks: window.innerWidth <= 768 ? true : false
    };
  },
  methods: {
    switchContainer: function() {
      return (this.showBooks = !this.showBooks);
    }
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
