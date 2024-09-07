---
title: "The Step-by-Step Prompt Fallacy: Boosting AI Reasoning"
date: 2024-09-06
tags: [llm, prompt]
published: true
image: /img/2024-09-06-the-step-by-step-prompt-fallacy-boosting-ai-reasoning.jpg
---

A popular trick to make prompts better is to add "step-by-step" instructions. For example:

> Think through the query step by step before giving your final answer.

This rarely improves the outcome. The reason is that models aren't obligated to write their reasoning before providing the final answer.

Asking the model to write out its thought process can significantly improve reasoning and outcomes. For example:

> Reason through the query inside `<thinking>` tags, and then provide your final response.

To enhance this approach further, consider adding a reflection step:

> Reason through the query inside `<thinking>` tags, and then provide your final response. If you detect that you made a mistake in your reasoning at any point, correct yourself inside `<reflection>` tags.

For even more effective results, you can assign a specific role to the AI:

> You are a world-class AI system, capable of complex reasoning and reflection. Reason through the query inside `<thinking>` tags, and then provide your final response inside `<output>` tags. If you detect that you made a mistake in your reasoning at any point, correct yourself inside `<reflection>` tags.

## Example in Action

I am using Claude 3.5 Sonnet for this example. Notice how Claude reflects on its reasoning and corrects itself when it detects a mistake in the example thread.

Prompt:
```markdown
You are a world-class AI system, capable of complex reasoning and reflection. Reason through the query inside <thinking> tags, and then provide your final response inside <output> tags. If you detect that you made a mistake in your reasoning at any point, correct yourself inside <reflection> tags.

I am working on a feature where I need to show a list of 10 records with the most number of similar records. The similarity is a score from 0 to 1, identified by running a vector similarity search for each record to all records in the database. I plan to store record ids and their similarity scores in a table if the similarity score is above a certain threshold. I need your help to find a way to store and keep this list updated efficiently. Can you help me with this? Think carefully.
```

Response:
````markdown
<thinking>
To approach this problem, let's break it down into steps and consider the most efficient way to implement and maintain this feature:

1. Data Storage:
   - We need a table to store the similarity scores between records.
   - Let's call this table `record_similarities`.
   - Structure: `record_id`, `similar_record_id`, `similarity_score`
   - We'll add an index on `record_id` and `similarity_score` for faster querying.

2. Updating mechanism:
   - We need to update this table whenever a new record is added or an existing record is modified.
   - We can use callbacks in our Rails model to trigger the similarity calculation.

3. Querying for top similar records:
   - We need an efficient way to query the top 10 records with the most similar records.
   - This could be done with a SQL query that counts the number of similar records for each record and orders by this count.

4. Optimization considerations:
   - Calculating similarity for all pairs of records could be computationally expensive as the dataset grows.
   - We might want to implement a background job to handle these calculations asynchronously.
   - We should consider using a threshold for similarity scores to reduce the number of stored similarities.

5. Keeping the list updated:
   - We need to ensure that the list of top 10 records is always current.
   - We could cache this list and invalidate the cache whenever the `record_similarities` table is updated.

Let's outline a potential implementation:
</thinking>

<output>

Here's a proposed implementation to efficiently store and keep updated a list of 10 records with the most number of similar records:

1. Create a new table to store similarity scores:

```ruby
class CreateRecordSimilarities < ActiveRecord::Migration[6.1]
  def change
    create_table :record_similarities do |t|
      t.references :record, null: false, foreign_key: true
      t.references :similar_record, null: false, foreign_key: { to_table: :records }
      t.float :similarity_score, null: false

      t.timestamps
    end

    add_index :record_similarities, [:record_id, :similarity_score]
  end
end
```

2. Add a model for the new table:

```ruby
class RecordSimilarity < ApplicationRecord
  belongs_to :record
  belongs_to :similar_record, class_name: 'Record'

  validates :similarity_score, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
end
```

3. Add callbacks to the Record model to update similarities:

```ruby
class Record < ApplicationRecord
  has_many :record_similarities
  has_many :similar_records, through: :record_similarities

  after_create :calculate_similarities
  after_update :recalculate_similarities

  SIMILARITY_THRESHOLD = 0.5

  private

  def calculate_similarities
    RecordSimilarityJob.perform_later(self)
  end

  def recalculate_similarities
    RecordSimilarity.where(record: self).or(RecordSimilarity.where(similar_record: self)).destroy_all
    calculate_similarities
  end
end
```

4. Create a background job to handle similarity calculations:

```ruby
class RecordSimilarityJob < ApplicationJob
  queue_as :default

  def perform(record)
    Record.where.not(id: record.id).find_each do |other_record|
      similarity = calculate_similarity(record, other_record)
      if similarity >= Record::SIMILARITY_THRESHOLD
        RecordSimilarity.create(record: record, similar_record: other_record, similarity_score: similarity)
        RecordSimilarity.create(record: other_record, similar_record: record, similarity_score: similarity)
      end
    end
    Rails.cache.delete('top_similar_records')
  end

  private

  def calculate_similarity(record1, record2)
    # Implement your vector similarity calculation here
    # This is a placeholder implementation
    rand(0.0..1.0)
  end
end
```

5. Add a method to fetch the top 10 records with most similar records:

```ruby
class Record < ApplicationRecord
  # ... existing code ...

  def self.top_similar_records(limit = 10)
    Rails.cache.fetch('top_similar_records', expires_in: 1.hour) do
      Record.joins(:record_similarities)
            .group(:id)
            .select('records.*, COUNT(record_similarities.id) as similar_count')
            .order('similar_count DESC')
            .limit(limit)
    end
  end
end
```

This implementation provides an efficient way to store and keep updated a list of records with the most similar records. It uses background jobs for similarity calculations, caches the results, and uses database indexing for faster queries. The cache is invalidated whenever new similarities are calculated, ensuring that the list stays up-to-date.

</output>

<reflection>
Upon reflection, I realize that there's a potential improvement we could make to the implementation. In the current setup, we're creating two RecordSimilarity entries for each pair of similar records (one in each direction). This redundancy isn't necessary and could lead to increased storage requirements and slower queries as the dataset grows.

We can optimize this by only storing one RecordSimilarity entry per pair of records, always ensuring that the record_id is less than the similar_record_id. This will halve the number of entries in the RecordSimilarity table and simplify our queries.

Here's how we could modify the implementation to account for this:
</reflection>

<output>

Let's update our implementation to store only one RecordSimilarity entry per pair of records:

1. Modify the RecordSimilarity model:

```ruby
class RecordSimilarity < ApplicationRecord
  belongs_to :record
  belongs_to :similar_record, class_name: 'Record'

  validates :similarity_score, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
  validate :record_id_less_than_similar_record_id

  private

  def record_id_less_than_similar_record_id
    if record_id >= similar_record_id
      errors.add(:record_id, "must be less than similar_record_id")
    end
  end
end
```

2. Update the RecordSimilarityJob:

```ruby
class RecordSimilarityJob < ApplicationJob
  queue_as :default

  def perform(record)
    Record.where('id > ?', record.id).find_each do |other_record|
      similarity = calculate_similarity(record, other_record)
      if similarity >= Record::SIMILARITY_THRESHOLD
        RecordSimilarity.create(record: record, similar_record: other_record, similarity_score: similarity)
      end
    end
    Rails.cache.delete('top_similar_records')
  end

  private

  def calculate_similarity(record1, record2)
    # Implement your vector similarity calculation here
    # This is a placeholder implementation
    rand(0.0..1.0)
  end
end
```

3. Update the top_similar_records method:

```ruby
class Record < ApplicationRecord
  # ... existing code ...

  def self.top_similar_records(limit = 10)
    Rails.cache.fetch('top_similar_records', expires_in: 1.hour) do
      Record.joins("LEFT JOIN record_similarities rs1 ON records.id = rs1.record_id")
            .joins("LEFT JOIN record_similarities rs2 ON records.id = rs2.similar_record_id")
            .group(:id)
            .select('records.*, COUNT(rs1.id) + COUNT(rs2.id) as similar_count')
            .order('similar_count DESC')
            .limit(limit)
    end
  end
end
```

These changes will significantly reduce the storage requirements for the RecordSimilarity table and improve query performance. The top_similar_records method now counts similarities where the record appears in either the record_id or similar_record_id column.

This optimized implementation provides a more efficient solution to store and keep updated a list of 10 records with the most number of similar records.

</output>
````

Follow-up prompt:
```markdown
Thank you! I think there is a bug in the updated implementation, specifically in the `after_create :calculate_similarities` and `after_update :recalculate_similarities` in the Record model.
```

Response:
````markdown
<thinking>
You're right to point this out. Let me review the implementation and identify the potential bug in the Record model callbacks.

1. The `after_create :calculate_similarities` callback:
   - This seems fine as it triggers the RecordSimilarityJob for a newly created record.

2. The `after_update :recalculate_similarities` callback:
   - This is where the bug likely exists. Let's examine it:

```ruby
def recalculate_similarities
  RecordSimilarity.where(record: self).or(RecordSimilarity.where(similar_record: self)).destroy_all
  calculate_similarities
end
```

The issue here is that this method is deleting all existing similarities for the updated record and then recalculating them all. This approach has several problems:

a) It's inefficient, as it's deleting and recreating all similarities even if the update didn't affect the similarity calculations.
b) It's not consistent with our optimized approach of storing only one RecordSimilarity entry per pair of records.
c) The `calculate_similarities` method only calculates similarities with records that have a higher ID, which means we might lose some similarity data after an update.

Let's correct this implementation.
</thinking>

<output>
You're correct, and thank you for catching that. Let's fix the implementation in the Record model to address these issues:

```ruby
class Record < ApplicationRecord
  has_many :record_similarities
  has_many :inverse_record_similarities, class_name: 'RecordSimilarity', foreign_key: 'similar_record_id'
  has_many :similar_records, through: :record_similarities
  has_many :inverse_similar_records, through: :inverse_record_similarities, source: :record

  after_create :calculate_similarities
  after_update :recalculate_similarities, if: :requires_similarity_recalculation?

  SIMILARITY_THRESHOLD = 0.5

  private

  def calculate_similarities
    RecordSimilarityJob.perform_later(self)
  end

  def recalculate_similarities
    RecordSimilarityJob.perform_later(self, recalculate: true)
  end

  def requires_similarity_recalculation?
    # Add logic here to determine if the update requires recalculation
    # For example, if you have a 'content' attribute that affects similarity:
    saved_change_to_content?
  end
end
```

Now, let's update the RecordSimilarityJob to handle both initial calculation and recalculation:

```ruby
class RecordSimilarityJob < ApplicationJob
  queue_as :default

  def perform(record, recalculate: false)
    if recalculate
      # Delete existing similarities
      RecordSimilarity.where(record: record).or(RecordSimilarity.where(similar_record: record)).destroy_all
    end

    Record.where.not(id: record.id).find_each do |other_record|
      similarity = calculate_similarity(record, other_record)
      if similarity >= Record::SIMILARITY_THRESHOLD
        create_or_update_similarity(record, other_record, similarity)
      end
    end

    Rails.cache.delete('top_similar_records')
  end

  private

  def calculate_similarity(record1, record2)
    # Implement your vector similarity calculation here
    # This is a placeholder implementation
    rand(0.0..1.0)
  end

  def create_or_update_similarity(record1, record2, similarity)
    smaller_id, larger_id = [record1.id, record2.id].sort
    similarity_record = RecordSimilarity.find_or_initialize_by(
      record_id: smaller_id,
      similar_record_id: larger_id
    )
    similarity_record.update(similarity_score: similarity)
  end
end
```

These changes address the issues in the previous implementation:

1. We only trigger recalculation when necessary, based on the `requires_similarity_recalculation?` method.
2. The RecordSimilarityJob now handles both initial calculation and recalculation.
3. We maintain the optimized approach of storing only one RecordSimilarity entry per pair of records.
4. When recalculating, we delete existing similarities for the record before recalculating.
5. We calculate similarities with all other records, not just those with higher IDs.
6. We use `find_or_initialize_by` and `update` to either create new similarity records or update existing ones.

This implementation should provide a more efficient and correct way to handle similarity calculations and updates.
</output>
````
