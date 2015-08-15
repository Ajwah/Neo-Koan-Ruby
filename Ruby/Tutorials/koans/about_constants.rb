require File.expand_path(File.dirname(__FILE__) + '/neo')

C = "top level"

class AboutConstants < Neo::Koan

  C = "nested"

  def test_nested_constants_may_also_be_referenced_with_relative_paths
    assert_equal "nested", C
  end

  def test_top_level_constants_are_referenced_by_double_colons
    assert_equal "top level", ::C
  end

  def test_nested_constants_are_referenced_by_their_complete_path
    assert_equal 'nested', AboutConstants::C
    assert_equal 'nested', ::AboutConstants::C
  end

  # ------------------------------------------------------------------

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS
      end
    end
  end

  def test_nested_classes_inherit_constants_from_enclosing_classes
    assert_equal 4, Animal::NestedAnimal.new.legs_in_nested_animal
  end

  # ------------------------------------------------------------------

  class Reptile < Animal
    def legs_in_reptile
      LEGS
    end
  end

  def test_subclasses_inherit_constants_from_parent_classes
    assert_equal 4, Reptile.new.legs_in_reptile
  end

  # ------------------------------------------------------------------

  class MyAnimals
    LEGS = 2

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  def test_who_wins_with_both_nested_and_inherited_constants
    assert_equal 2, MyAnimals::Bird.new.legs_in_bird
  end

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?

  # ------------------------------------------------------------------

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  def test_who_wins_with_explicit_scoping_on_class_definition
    assert_equal 4, MyAnimals::Oyster.new.legs_in_oyster
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
  # The difference between the two is that Bird is explicitly declared within
  # the scope of MyAnimals whereas Oyster is not. In both cases the local scope
  # is taken but due to the different construct the local scopes differ. For Bird the
  # local scope is MyAnimal whereas for Oyster the scope is the global scope.
  # In the global scope LEGS is undefined so it will adopt the definition of LEGS
  # inherited from Animal. In the former case, LEGS is already defined in the local
  # scope, so it shadows the inherited definition.
  #
  # Ruby searches for the constant definition in this order:

        # The enclosing scope
        # Any outer scopes (repeat until top level is reached) Any outer scopes (up to but not including the top level
        # Included modules
        # Superclass(es)
        # Top level
        # Object
        # Kernel

  # Source: https://groups.google.com/forum/#!topic/comp.lang.ruby/t5rtDNol3P8
  # http://stackoverflow.com/questions/13661193/ruby-scopes-constants-precedence-lexical-scope-or-inheritance-tree
  # http://stackoverflow.com/questions/4627735/ruby-explicit-scoping-on-a-class-definition
end
