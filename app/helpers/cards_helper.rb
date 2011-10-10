module CardsHelper
  
  def link_to_block_card(project, card)
    action = card.blocked ? 
              ['Unblock', unblock_project_card_path(@project, card)] : 
              ['Block'  , block_project_card_path(@project, card)]
            
    link_to(action[0], action[1], method: :put, class: 'block_card')
  end
end
