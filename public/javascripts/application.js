function bet_one()
{
  bet = parseInt(document.bet.bet.value)
  if (bet==5) 
  {
     return
  }
  set_bet(bet + 1)
}

function clear_bets()
{
  set_bet(0)
}

function bet_max()
{
  set_bet(5)
  document.bet.onsubmit()
}


function set_bet(bet)
{
  document.bet.bet.value = bet
  document.getElementById('current-bet').innerHTML = "Current Credits: " + bet + " Credits"
}

function up_denomination()
{ 
  index = get_current_denomination_index()
  if (index < (denominations.length - 1) && index != -1)
  {
    set_denomination(denominations[index + 1])
  }
}

function down_denomination()
{
  index = get_current_denomination_index()
  if (index > 0 && index != -1)
  {      
    set_denomination(denominations[index-1]) 
  }
}

function get_current_denomination_index() 
{
     denomination = document.bet.denomination.value
     for (x = 0; x < denominations.length; x++)
     {
        if (denominations[x] == denomination)
        {
            return x
        }
     }
    return - 1
}


var denominations = new Array(1, 5, 10, 25, 100, 500, 1000)

function set_denomination(denomination)
{
  document.bet.denomination.value = denomination
  document.getElementById('current-denomination').innerHTML =  "Denomination: " + denomination + " Chips"
}

function toggle_hold_card(index)
{  
  fields = document.draw.elements
  for (x = 0; x < fields.length; x++)
  {

    if (fields[x].name == "hold_" + index)
    {
        if (fields[x].value == "true")
        {
            fields[x].value = "false"
            document.getElementById('hold_label_' + x).innerHTML = ""      
        } else
        {
            fields[x].value = "true"
            document.getElementById('hold_label_' + x).innerHTML = "HOLD"
        }
    }
  }
}


function test_alert()
{
    alert("Hello.")
}
