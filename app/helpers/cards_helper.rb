module CardsHelper
  
  def link_to_block_card(project, card)
    text = card.blocked ? 'Blocked' : 'Block'
    path = card.blocked ? 
            unblock_project_card_path(@project, card) : 
            block_project_card_path(@project, card)
    link_to(text, path, method: :put, class: 'block_card')
  end
end
