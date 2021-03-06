module Refinery
  class Snippet < ActiveRecord::Base
    validates :title, :presence => true, :uniqueness => true

    translates :body
    class Translation

    end


    has_many :snippet_page_parts, :dependent => :destroy
    has_many :page_parts, :through => :snippet_page_parts

    scope :for_page, lambda{ |page|
      raise RuntimeError.new("Couldn't find Snippet for a nil Page") if page.blank?
      joins(:page_parts => :page).where(:refinery_pages => {:id => page.id})
    }

    scope :before, -> { where(:snippets_page_parts => {:before_body => true}) }
    scope :after, -> { where(:snippets_page_parts => {:before_body => false}) }
    scope :before_or_after, -> { select('refinery_snippets.* , snippets_page_parts.before_body').includes(:translations).reorder('snippets_page_parts.page_part_id ASC, snippets_page_parts.position ASC') }



    # rejects any page that has not been translated to the current locale.
    scope :translated, lambda {
      pages = Arel::Table.new(Refinery::Snippet.table_name)
      translations = Arel::Table.new(Refinery::Snippet.translations_table_name)

      includes(:translations).where(
        translations[:locale].eq(Globalize.locale)).where(pages[:id].eq(translations[:snippet_id]))
    }

    def deletable?
      deletable === true
    end


    def pages
      Refinery::Page.for_snippet(self)
    end

    def before?(part)
      part.snippets.before.include? self
    end

    def after?(part)
      part.snippets.after.include? self
    end

  end
end