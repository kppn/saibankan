require 'opal-jquery'

#
# CheckboxDifferenceHiddenAppender
#   チェックボックスのOn/Offの差分を<input type="hidden">で追加する
#
#   ページ読み込み時にその時のチェックOn/Off状態を保存し、timingで指定されたイベントで
#   target配下にhiddenを追加する
#
#     * usage
#        AppendHiddenCheckboxDifference.new do
#          selector  '.marking_checkbox'          # チェックボックスのセレクタを指定する
#          id_to_val /([0-9]+)$/                  # チェックボックスのIDからhiddenの値への変換ルールを指定する
#          target    '#new_marking'               # 追加先のタグを指定する
#          timing    '#submit', :click            # hiddenを追加するエレメントのID、イベント
#          name_add  'markings[add_mark_ids][]'   # hiddenのname. チェックが追加されたもの
#          name_sub  'markings[sub_mark_ids][]'   # hiddenのname. チェックが削除されたもの
#        end
#  
#   e.x.)
#     1. ページロード時
#       <form class="new_marking" id="new_marking" ...>
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_10" value="1" class="marking_checkbox" checked="checked">
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_20" value="1" class="marking_checkbox" checked="checked">
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_30" value="2" class="marking_checkbox">
#         <input type="submit" name="commit" value="設定" id="submit">
#  
#     2. markings_mark_ids_1のチェック外し、markings_mark_ids_2をチェック
#  
#     3. submitボタン押下時
#       <form class="new_marking" id="new_marking" ...>
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_10" value="1" class="marking_checkbox">
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_20" value="1" class="marking_checkbox" checked="checked">
#         <input type="checkbox" name="markings[mark_ids][]" id="markings_mark_ids_30" value="2" class="marking_checkbox" checked="checked">
#         <input type="submit" name="commit" value="設定" id="submit">
#         <input type="hidden" name="markings[add_mark_ids][]" value="30">
#         <input type="hidden" name="markings[sub_mark_ids][]" value="10">

class CheckboxDifferenceHiddenAppender
  def initialize(&block)
    self.instance_eval &block
    initial_ids = get_checked_ids(@selector, @id_to_val)
    set_handler(initial_ids, @target, @selector, @id, @id_to_val, @event, @name_add, @name_sub)
  end

  private
    def get_checked_ids(selector, regex)
      Element[selector].select{|elem|
        elem.prop('checked')
      }.map{|elem|
        elem.id =~ regex
        $1.to_i
      }
    end
  
    def set_handler(initial_ids, target, selector, id, id_to_val, event, name_add, name_sub)
      Element[id].on event do |evt|
        delete_hidden(target, name_add, name_sub)

        current_ids = get_checked_ids(selector, id_to_val)
        append_hidden_difference(target, initial_ids, current_ids, name_add, name_sub)
      end
    end

    def delete_hidden(target, name_add, name_sub)
      Element[":hidden[name='#{name_add}']"].each(&:remove)
      Element[":hidden[name='#{name_sub}']"].each(&:remove)
    end

    def append_ids(to_elem, name, id)
      elem_mark_id_hidden = Element.new(:input)
      elem_mark_id_hidden.attr(:type, :hidden)
      elem_mark_id_hidden.attr(:name, name)
      elem_mark_id_hidden.attr(:value, id.to_s)
      elem_mark_id_hidden.append_to(to_elem)
    end
  
    def append_add_ids(target, name, ids)
      ids.each do |id|
        append_ids(Element[target], name, id)
      end
    end

    def append_sub_ids(target, name, ids)
      ids.each do |id|
        append_ids(Element[target], name, id)
      end
    end

    def append_hidden_difference(target, initial_ids, current_ids, name_add, name_sub)
      append_add_ids(target, name_add, current_ids - initial_ids)
      append_sub_ids(target, name_sub, initial_ids - current_ids)
    end
  
    def selector(s)
      @selector = s
    end
  
    def target(t)
      @target = t
    end
  
    def timing(id, event)
      @id = id
      @event = event
    end
  
    def name_add(n)
      @name_add = n
    end
  
    def name_sub(n)
      @name_sub = n
    end
  
    def id_to_val(regex)
      @id_to_val = regex
    end
end

