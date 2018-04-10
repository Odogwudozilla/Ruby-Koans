require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "otu", :two => "abuo" }
    assert_equal "otu", hash[:one]
    assert_equal "abuo", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "ofu" }
    assert_equal "ofu", hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys? Answer: #fetch will return an optional value if it is supplied, or raise an error, while #[] will return nil in the same instance
  end

  def test_changing_hashes
    hash = { :one => "otu", :two => "abuo" }
    hash[:one] = "ofu"

    expected = { :one => "ofu", :two => "abuo" }
    assert_equal true, expected == hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal? Answer: If I knew, I won't tell you becuase I'm offended at the toughness of the question ;)
  end

  def test_hash_is_unordered
    hash1 = { :one => "otu", :two => "abuo" }
    hash2 = { :two => "abuo", :one => "otu" }

    assert_equal true, hash1 == hash2
  end

  def test_hash_keys
    hash = { :one => "otu", :two => "abuo" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "otu", :two => "abuo" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("otu")
    assert_equal true, hash.values.include?("abuo")
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("abuo")
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal "abuo", hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << "otu"
    hash[:two] << "abuo"

    assert_equal ["otu", "abuo"], hash[:one]
    assert_equal ["otu", "abuo"], hash[:two]
    assert_equal ["otu", "abuo"], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "otu"
    hash[:two] << "abuo"

    assert_equal ["otu"], hash[:one]
    assert_equal ["abuo"], hash[:two]
    assert_equal [], hash[:three]
  end
end
