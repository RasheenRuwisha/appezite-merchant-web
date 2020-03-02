<div class="modal fade" id="order-details-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="order-id">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body" id="order-details">

                <div class="row">
                <div class="col-md-12 paddingless-col">
                <div class="row">
                    <div id="view-po-loader-message" class="modal-loader">
                        <i class="fa fa-spinner fa-spin fa-2x"></i>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-5 col-md-offset-1 col-xs-6 header-parameters">
                        Order Id
                    </div>
                    <div class="col-md-5 col-xs-6 text-right">
                        <span><label id="po-modal-receipt-id" class="label label-theme"></label></span>
                    </div>
                </div>

                    <div id="po-collector-name-div" class="row content-row">
                        <div class="col-md-5 col-md-offset-1 col-xs-6 header-parameters">
                            Customer Name
                        </div>
                        <div class="col-md-5 col-xs-6 text-right">
                            <span id="po-collector-name-span"></span>
                        </div>
                    </div>


                    <div id="po-collector-number-div" class="row content-row">
                        <div class="col-md-5 col-md-offset-1 col-xs-6 header-parameters">
                            Customer Phone
                        </div>
                        <div class="col-md-5 col-xs-6 text-right">
                            <span id="po-collector-number-span"></span>
                        </div>
                    </div>

                    <div id="po-order-status-div" class="row content-row">
                        <div class="col-md-5 col-md-offset-1 col-xs-6 header-parameters">
                            Order Status
                        </div>
                        <div class="col-md-5 col-xs-6 text-right">
                            <span><label id="po-modal-order-status-id" class="label"></label></span>
                        </div>
                    </div>


                    <div id="po-ready-time-div" class="row content-row">
                        <div id="pickup-time-label" class="col-md-5 col-md-offset-1 col-xs-6 hide header-parameters">
                            Pickup At
                        </div>
                        <div id="delivery-time-label" class="col-md-5 col-md-offset-1 col-xs-6 hide header-parameters">
                           Delivered By
                        </div>
                        <div class="col-md-5 col-xs-6 text-right">
                            <span id="po-ready-time-span"></span>
                        </div>
                    </div>


                    <div class="po-items" id="purchase-order-item-list-area">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                                <div class="row header-row">
                                    <div class="col-md-5 col-xs-5 paddingless-col">
                                        Item
                                    </div>
                                    <div class="col-md-4 col-xs-4 paddingless-col text-right">
                                        Quantity
                                    </div>
                                    <div class="col-md-3 col-xs-3 paddingless-col text-right">
                                        Total
                                    </div>
                                </div>



                                <span id="po-items-list"></span>

                            </div>
                        </div>

                    </div>


                    <div class="po-sub-info ">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">

                                <div class="row footer-row">
                                    <div class=" row item-row ">
                                        <div class="col-md-6 col-xs-6 paddingless-col ">
                                           Subtotal
                                        </div>
                                        <div class="col-md-6 col-xs-6 paddingless-col text-right sub-info-values ">
                                            <span id="po-sub-total-amount"></span>
                                        </div>
                                    </div>


                                </div>
                            </div>

                            <div class="col-md-10 col-md-offset-1">

                                    <div id="po-delivery-charge-div" class="row item-row hide">
                                        <div class="col-md-6 col-xs-6 paddingless-col ">
                                            Delivery Charge
                                            <span id="po-delivery-charge-percentage-span"></span>
                                        </div>
                                        <div class="col-md-6 col-xs-6 paddingless-col text-right sub-info-values ">
                                            + <span id="po-delivery-charge-span"></span>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="po-grand-totol-area ">
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <div class="row footer-row ">
                                        <div class="col-md-6 col-xs-6 paddingless-col">
                                  Grandtotal
                                        </div>
                                        <div class="col-md-6 col-xs-6 paddingless-col text-right grand-total">
                                            <span id="po-grand-total-amount"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                </div>


            </div>

        </div>
    </div>
</div>