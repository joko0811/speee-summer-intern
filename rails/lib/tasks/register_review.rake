require "daru"

namespace :register_review do

    desc "Register reviews"
    task :original=> :environment do

        csv_data=Daru::DataFrame.from_csv("resources/口コミマスタ - マスタ.csv")

        review_records=[]
        csv_length=csv_data.nrow
        for idx in (0..csv_length-1) do

            user_record={
                name: csv_data["名前"][idx],
                gender_id: Gender.find_by_name(csv_data["性別"][idx]).id,
                age: csv_data["年齢"][idx].to_i, #ないぞ？
                email: nil,
                city: nil,#ここはアンケート結果
                address: nil, #ここはアンケート結果　ないぞ？
                assessment_request_date: nil,
                is_received: false,
            }
            p user_record
            user=AssessmentUser.create(user_record)

            review_record={
                property_city_id: City.find_by(name:csv_data["市区町村"]).id, #Cityからとってくる
                sotre_id: Store.find_by(ieul_store_id: csv_data["ieul_店舗id"]).id, #Storeから取ってくる
                property_adress: csv_data["住所全部"][idx],
                property: Property.find_by_name(csv_data["物件種別"][idx]).id,
                num_sale: NumSale.find_by_name(csv_data["売却回数"][idx]).id,
                date_considered: csv_data["売却検討時期"][idx].to_date,
                date_assessment: csv_data["査定依頼時期"][idx].to_date,
                start_sale: csv_data["売出時期"][idx].to_date,
                end_sale: csv_data["売却時期"][idx].to_date,
                date_handover: csv_data["引渡時期"][idx].to_date,
                score_speed: csv_data["売却スピードの満足度"][idx].to_i,
                price_assessment: csv_data["査定価格"][idx].to_i,
                price_sale: csv_data["販売価格"][idx].to_i,
                is_discount: !csv_data["値下げしたかどうか"][idx].to_i.zero?,
                discount_n_month_later: csv_data["売り出してから何ヶ月後に値下げしたか"][idx].to_i,
                price_discount: csv_data["値下げ価格"][idx].to_i,
                price_contract: csv_data["成約価格"][idx].to_i,
                score_conract: csv_data["売却価格の満足度"][idx].to_i,
                contract_type: ContractType.find(csv_data["媒介契約の形態"][idx].to_i).id,
                headline: csv_data["見出し"][idx],
                reason_sale: ReasonSale.find(csv_data["売却理由"][idx].to_i).id,
                anxiety: csv_data["売却時に不安だったこと"][idx],
                reason_decision: csv_data["この会社に決めた理由"][idx],
                score_store: csv_data["不動産会社の対応満足度"][idx].to_i,
                reason_score: csv_data["不動産会社の対応満足度の理由"][idx],
                advice: csv_data["今後売却する人へのアドバイス"][idx],
                improvement: csv_data["不動産会社に改善してほしい点"][idx],
            }
            p review_record
             
        end

        
        
    end

end