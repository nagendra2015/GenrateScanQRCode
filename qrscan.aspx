<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="qrscan.aspx.cs" Inherits="eAPF.admin.qrscan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script src="../Scripts/html5-qrcode.min.js" type="text/javascript"></script>

    <style>

        #successAlert {
            font-size:xx-large;
        }
        #errorAlert {
            font-size:xx-large;
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container">


    

    
    <div class="panel-group">
        <div class="panel panel-info">
            <div class="panel-heading">QR Code Scanner</div>
            <div class="panel-body">
               

        <div  id="infoMsg" class="alert ">
 <p id="result">  </p>
</div>

    

    <div id="reader" ></div>
    <script>
        var html5QrCode = new Html5Qrcode("reader");
        var oldQRNum = "";
        html5QrCode.start(
            { facingMode: "environment" }, // options
            {
                qrbox: 250, // size of QR code scanning area
                fps: 10,    // frames per second
            },
            async (qrCodeMessage) => {
                try {
                    // Callback function when QR code is detected
                    console.log("QR Code detected:", qrCodeMessage);

                    if (oldQRNum == qrCodeMessage) {
                        console.log("already checked");
                        return;
                    }

                    var result = await getQRCodeName(qrCodeMessage);
                    oldQRNum = qrCodeMessage;
                    //-----------------------

                    var successAlert = document.getElementById("successAlert");
                    var errorAlert = document.getElementById("errorAlert");



                    console.log("returning result is " + result);
                    var element = document.getElementById("infoMsg");
                    element.classList.remove("alert-danger");
                    element.classList.remove("alert-success");
                    if (result === "0") {
                        console.log("The string is empty");

                        $("#result").text("You are not valid user");
                        $("#errorAlert").text("You are not valid user");

                        element.classList.add("alert-danger");

                        showAndHideAlert(errorAlert, 3000);

                        // alert("User does not exist");
                    } else if (result === "E") {
                        console.log("Something went wrong");
                        $("#result").text("Error occurred. Please try again.");
                        $("#errorAlert").text("Error occurred. Please try again.");

                        element.classList.add("alert-danger");

                        showAndHideAlert(errorAlert, 3000);
                        //alert("Something went wrong");
                    } else {
                        console.log("The string is not empty: " + result);
                        //  alert("Welcome " + result);
                        $("#result").text("Welcome " + result);
                        $("#successAlert").text("Welcome " + result);
                        element.classList.add("alert-success");
                        showAndHideAlert(successAlert, 3000);
                    }
                } catch (error) {
                    console.error("Error:", error);
                }
            },
            (errorMessage) => {
                // Callback function when an error occurs
                // console.error(errorMessage);
            }
        );

        async function getQRCodeName(qrCodeContent) {
            try {
                console.log(" qr code start scan .." + qrCodeContent);
                var response = await $.ajax({
                    type: "POST",
                    url: "qrscan.aspx/GetQRCodeName",
                    data: JSON.stringify({ qrCodeContent: qrCodeContent }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                });
                console.log("Response from database " + response.d);

                if (response.d === null)
                    return "0";

                return response.d;
            } catch (error) {
                console.error("Error:", error);
                return "E";
            }
        }


        function showAndHideAlert(element, duration) {
            element.style.display = "block"; // Show the alert
            centerAlert(element); // Center the alert
            setTimeout(function () {
                element.style.display = "none"; // Hide the alert after the specified duration
            }, duration);
        }

        function centerAlert(element) {
            var screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var elementWidth = element.offsetWidth;
            var elementHeight = element.offsetHeight;

            var left = (screenWidth - elementWidth) / 2;
            var top = (screenHeight - elementHeight) / 2;
            element.style.position = "fixed";
            element.style.left = left + "px";
            element.style.top = top + "px";
        }




    </script>





                <div id="successAlert" style="display: none;" class="alert alert-success">
    <!-- Your success alert content goes here -->
</div>

<div id="errorAlert" style="display: none;" class="alert alert-danger">
    <!-- Your error alert content goes here -->
</div>



            </div>
            <div class="panel-footer">NHRC India</div>

        </div>
    </div>


        </div>

</asp:Content>
