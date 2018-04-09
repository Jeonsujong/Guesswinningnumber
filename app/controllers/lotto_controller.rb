require ('open-uri')        # 웹 페이지 open 에 필요.
require ('json')            # JSON을 Hash로 변환하는데 필요.

class LottoController < ApplicationController
  def index
  end

  def pick_and_check
  	# page에 해당 웹 페이지를 열어서 저장. 
  	# page = open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=') 

  	# lotto_info 에 page 내용 (JSON 형식의 data) 을 읽어서 저장.
  	# lotto_info = page.read  

  	# lotto_hash 에 JSON 형식인 lotto_info 를 Hash 로 파싱(변환)하여 저장.
  	# lotto_hash = JSON.parse(lotto_info)    

  	# puts lotto_hash    #=> JSON 데이터가 Hash 로 변환되어 출력.

  	# 위의 주석된 코드들을 1줄로 줄인 코드! get_info에 hash가 저장되어있음.
  	get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=800').read

  	drw_numbers = []		# 이번주 당첨번호
    get_info.each do |k, v|
       drw_numbers << v if k.include? 'drwtNo'
    end
    drw_numbers.sort!
    bonus_number = get_info["bnusNo"]		#보너스번호
 
    # 여기서 부터 코드를 작성해 주세요. 로또 번호 6개 랜덤생성 후 정렬.
    # 이번주 당첨번호와 비교해서 1등부터 6등까지의 결과를 출력해내세요.

    
    ran_numbers = (1..45).to_a.sample(6)
    ran_numbers.sort!

    ran_bonus = rand(1..45)
    
    if(ran_numbers.include?(ran_bonus))
       until(!ran_numbers.include?(ran_bonus))
             ran_bonus = rand(1..45)
       end
    end
    
    if (drw_numbers & ran_numbers) == []
      intersection = "빵개ㅠㅠ"
    else
      intersection = (drw_numbers & ran_numbers)
    end    
    
    
    if (ran_numbers & drw_numbers).size == 6
        result = "1등입니다!!!! 대박!! 1게임당 당첨금액은 약 16억"
    elsif (ran_numbers & drw_numbers).size == 5 && (ran_bonus == bonus_number)
        result = "2등입니다!!! 대박! 1게임당 당첨금액은 약 5,800만원"
    elsif (ran_numbers & drw_numbers).size == 5
        result = "3등입니다!! 오오! 1게임당 당첨금액은 약 130만원"
    elsif (ran_numbers & drw_numbers).size == 4
        result = "4등이닭! 저녁은 치킨이닭! 1게임당 당첨금액은 5만원"
    elsif (ran_numbers & drw_numbers).size == 3
        result = "5등이네요.. 당첨금을 다시 로또를 사는데 씁니다. 1게임당 당첨금액은 5천원"
    else
        result = "꽝! 로또는 인생의 낭비..."
    end
    
    
    


    # 인스턴스에 변수를 저장해주세요!
    @drw_numbers = drw_numbers
    @bonus_number = bonus_number
    @ran_numbers = ran_numbers
    @ran_bonus = ran_bonus
    @intersection = intersection
    @result = result
    # 추가생성한 변수들 인스턴스로 지정.

  end
end