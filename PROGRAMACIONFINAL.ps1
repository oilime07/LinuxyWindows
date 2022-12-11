Add-Type -AssemblyName System.windows.Forms
Add-Type -AssemblyName System.Drawing

#Creación del Form (Interfaz)
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Modificacion de BASE DE DATOS: USUARIOS-Programacion'
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = 'CenterScreen'

#Creación de botón Aceptar
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,280)
$okButton.Size = New-Object System.Drawing.Size(73,23)
$okButton.Text = 'Aceptar'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.add($okButton)

#Creación de botón Cancelar
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,280)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancelar'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.add($cancelButton)

#Creación de Label "Elije una opcion:"
$labOpcion = New-Object System.Windows.Forms.Label
$labOpcion.Location = New-Object System.Drawing.Point(10,50)
$labOpcion.Size = New-Object System.Drawing.Size(150,20)
$labOpcion.Text = 'Elije una opción:'
$form.Controls.add($labOpcion)

#Creación de comboBox
$cbOpcion = New-Object System.Windows.Forms.ComboBox
$cbOpcion.Location = New-Object System.Drawing.Point(160,50)
$cbOpcion.Size = New-Object System.Drawing.Size(310,20)
$cbOpcion.Items.AddRange(("1. Crear usuario", "2.Modificar usuario", "3.Eliminar usuarios", "4.Listar procesos", "5.Matar procesos", "6.Listar Archivos", "7.Enviar Mensajes", "8.Leer Mensajes"));
$cbOpcion.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$form.Controls.add($cbOpcion)

#Ejecutar ventana
$form.TopMost = $true
$result = $form.ShowDialog()

#si el resultado de la ventana es OK hacer lo siguiente:
if($result -eq [System.Windows.Forms.DialogResult]::OK){

    #Guarda la opción seleccionada en la variable
    $opcion = $cbOpcion.SelectedItem
    #Guarda
    switch ($opcion){
        "1. Crear usuario" {
            Write-Host "Ingresa los datos del usuario por favor:"
            #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = '1. Crear usuario'
            $form1.Size = New-Object System.Drawing.Size(500,400)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)

            #if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE usuarios; SELECT nombre FROM usuario;" | Select-Object -ExpandProperty nombre) -ne  $usuario){

            #ingrese el nombre de usuario

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese el nombre: '
            $form1.Controls.add($labusuario)

           

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            #$usuario= $txtusuario

            #ingrese contrasena de usuario
            $labcontra = New-Object System.Windows.Forms.Label
            $labcontra.Location = New-Object System.Drawing.Point(10,50)
            $labcontra.Size = New-Object System.Drawing.Size(150,50)
            $labcontra.Text = 'Ingrese la contraseña:'
            $form1.Controls.add($labcontra)

            $txtcontra = New-Object System.Windows.Forms.TextBox
            $txtcontra.Location = New-Object System.Drawing.Point(160,50)
            $txtcontra.Size = New-Object System.Drawing.Size(100,50)
            $form1.Controls.add($txtcontra)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
            
            
            
            
   $usuario= $txtusuario.Text
   $contra= $txtcontra.Text
   <#$llavep= $txtllavep.Text
   $llavepriva= $txtllavepriva.Text
   $firma= $txtfirma.Text#>
$contras=ConvertTo-SecureString -Force $contra


if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE usuarios; SELECT nombre FROM usuario;" | Select-Object -ExpandProperty nombre) -ne  $usuario){

$dirp= "C:\Users\$usuario"
Invoke-Sqlcmd -Query "USE Usuarios1; INSERT INTO datosusuario(nombre,contrasena,directorio,publica,privada,firma) VALUES ('$usuario','$contra','$dirp','$llavep','$llavepriva','$firma');"

#contra sgura para windows

#$contras=ConvertTo-SecureString -AsPlaintText -Force $contra
#creacion del usuario de manera local en windows
New-LocalUser $usuario -Password $contras -FullName $usuario
#creacion de su directorio del usuario

New-Item "C:\Users\$usuario" -ItemType Directory
}
}

"2.Modificar usuario" {
Write-Host "Ingresa el nombre de usuario:"
            #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = '1. Modifica usuario'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #MODIFICAR USUARIO: NOMBRE

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()


$usuario= $txtusuario.Text


if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE Usuarios1; SELECT nombre FROM datosusuario;" | Select-Object -ExpandProperty nombre) -eq  $usuario){
#Vamos a modificar usuario
 #ingrese el nombre de usuario
 #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = '1. MODIFICAR USUARIO'
            $form1.Size = New-Object System.Drawing.Size(500,400)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese el nombre nuevo: '
            $form1.Controls.add($labusuario)

           

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            #$usuario= $txtusuario

            #ingrese contrasena de usuario
            $labcontra = New-Object System.Windows.Forms.Label
            $labcontra.Location = New-Object System.Drawing.Point(10,50)
            $labcontra.Size = New-Object System.Drawing.Size(150,50)
            $labcontra.Text = 'Ingrese la contraseña nueva:'
            $form1.Controls.add($labcontra)

            $txtcontra = New-Object System.Windows.Forms.TextBox
            $txtcontra.Location = New-Object System.Drawing.Point(160,50)
            $txtcontra.Size = New-Object System.Drawing.Size(100,50)
            $form1.Controls.add($txtcontra)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
            $usuario= $txtusuario.Text
            $contra= $txtcontra.Text

}
}


"3.Eliminar usuarios" {
Write-Host "Ingresa el nombre de usuario A ELIMINAR:"
            #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = '1. ELIMINAR USUARIO'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()

            $usuario= $txtusuario.Text

if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE Usuarios1; SELECT nombre FROM datosusuario;" | Select-Object -ExpandProperty nombre) -eq  $usuario){


#DROP USER $usuario ;
#DELETE FROM usuarios WHERE columna1='$usuario'
Invoke-Sqlcmd -Query "USE Usuarios1; DELETE FROM datosusuario WHERE nombre='$usuario';"
#Remove-item C:\Users\$usuario -ItemType Directory



}

}
 "4.Listar procesos" {

 Write-Host "Ingresa el nombre de usuario:"
            #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = 'Listar Procesos del USUARIO'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
 $usuario= $txtusuario.Text
 

if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE Usuarios1; SELECT nombre FROM datosusuario;" | Select-Object -ExpandProperty nombre) -eq  $usuario){

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,386)
$Form.text                       = "Form"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#cfe3fb")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Desea listar procesos "
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(35,56)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(38,87)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)


$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(151,87)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)



$Form.controls.AddRange(@($Label1))


$form.Add_Shown({$okButton.Select()})

$okButton = $form.ShowDialog()

if ($okButton -eq [System.Windows.Forms.DialogResult]::ok)
{
    $x = $okButton
    $x 

Get-Process -IncludeUserName | where {$_.UserName -match '$usuario' | select Id,UserName,ProccessName} | Out-File C:\Users\procesos.txt
     C:\Users\procesos.txt


}




#region Logic 

#endregion

[void]$Form.ShowDialog()


 }

 }



 "5.Matar procesos" {
 #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = 'MATAR PROCESOS DEL USUARIO'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()

            $usuario= $txtusuario.Text
 
 }


 "6.Listar Archivos" {
  #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = 'LISTAR ARCHIVOS DEL USUARIO'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
            $usuario= $txtusuario.Text


 }
 "7.Enviar Mensajes" {
  #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = 'ENVIAR MENSAJES'
            $form1.Size = New-Object System.Drawing.Size(500,600)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
            $usuario= $txtusuario.Text

if($result -eq [System.Windows.Forms.DialogResult]::OK -and (Invoke-Sqlcmd -Query "USE Usuarios1; SELECT nombre FROM datosusuario;" | Select-Object -ExpandProperty nombre) -eq  $usuario){



            #
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Ingrese un mesaje para enviar:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$form.Topmost = $true


$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $x

    $x | Out-File C:\Users\mensaje.txt
}
}

#


 }
"8.Leer Mensajes"{
 #Crear Form
            $form1 = New-Object System.Windows.Forms.Form
            $form1.Text = 'ENVIAR MENSAJES'
            $form1.Size = New-Object System.Drawing.Size(500,400)
            $form1.StartPosition = 'CenterScreen'

            $form1.AcceptButton = $okButton
            $form1.Controls.add($okButton)

            $form1.CancelButton = $cancelButton
            $form1.Controls.add($cancelButton)
            #ELIMINAR USUARIO

            $labusuario = New-Object System.Windows.Forms.Label
            $labusuario.Location = New-Object System.Drawing.Point(10,20)
            $labusuario.Size = New-Object System.Drawing.Size(150,20)
            $labusuario.Text = 'Ingrese usuario: '
            $form1.Controls.add($labusuario)

            $txtusuario = New-Object System.Windows.Forms.TextBox
            $txtusuario.Location = New-Object System.Drawing.Point(160,20)
            $txtusuario.Size = New-Object System.Drawing.Size(100,20)
            $form1.Controls.add($txtusuario)

            $form1.TopMost = $true
            $result = $form1.ShowDialog()
            $usuario= $txtusuario.Text
}

#
#
}
}
Write-Host "$usuario"