module CardsHelper
  
  def link_to_block_card(project, card)
    action = card.blocked ? 
              ['Unblock', unblock_project_card_path(@project, card)] : 
              ['Block'  , block_project_card_path(@project, card)]
            
    link_to(action[0], action[1], method: :put, class: 'block_card')
  end

  def link_to_make_card_ready(project, card)
    action = card.waiting ? 
              ['Not Ready', not_ready_project_card_path(@project, card)] : 
              ['Ready'    , ready_project_card_path(@project, card)]
            
    link_to(action[0], action[1], method: :put, class: 'ready_card')
  end
end
