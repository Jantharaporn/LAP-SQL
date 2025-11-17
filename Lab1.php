<?php
    include 'otphp/lib/otphp.php';
    include 'Base32.php';
    
    $useraccount = "67040233127@udru.ac.th";
    
    $secret = "H6HRN6ARUHGHY6PV";
    
    $a = new Base32en();
    $secretcode = $a->base32_encode($secret); 
    $totp = new \OTPHP\TOTP($secretcode);
    $chl = $totp->provisioning_uri($useraccount); 

?>
<br>
<!-- <img src='https://www.google.com/chart?chs=250x250&chld=M|0&cht=qr&chl=<?php //echo $chl; ?>'> -->
<img src=' https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=<?php echo $chl; ?>'>

<?php
     echo "<br><h1>OTP ===> ". $totp->now(). "</h1>"; 
?>

