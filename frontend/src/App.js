// App.js

import React from 'react';
import BookList from './BookList';
import AddBookForm from './AddBookForm';
import EditBookForm from './EditBookForm';
import DeleteBookButton from './DeleteBookButton';

const App = () => {
  return (
    <div>
      <h1>Book Management Application</h1>
      <BookList />
      <AddBookForm />
      {/* Use EditBookForm and DeleteBookButton as needed */}
    </div>
  );
};

export default App;
