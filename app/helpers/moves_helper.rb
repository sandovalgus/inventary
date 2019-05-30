module MovesHelper

    def sorted_voucher_type
        VoucherType.sorted
    end

    def sorted_user_register
        VoucherType.sorted
    end

    def sorted_users
        User.sorted
    end

    def sorted_deposit
        Deposit.sorted
    end

end
