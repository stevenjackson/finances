module Finances::GroupByAccount

  def group_by_account(transactions)
    grouped_transactions = transactions.group_by(&:account_id)
    accounts_by_id(grouped_transactions.keys).each_with_object({}) do |account, hash|
      hash[account.to_h] = grouped_transactions[account.id].map(&:to_h)
    end
  end

  def accounts_by_id ids
    @gateway.accounts.select { |a| ids.include? a.id }
  end
end
