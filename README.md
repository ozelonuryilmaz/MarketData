
# 📄 README – Data Layer (İptal Edildi)

# 📦 MarketData Katmanı

## 🧠 Amaç

Bu katman, uygulamadaki **veri yönetimini** üstlenir. Verinin **nereden ve nasıl** geleceğine (Local - Core Data ya da Remote - API) **yalnızca bu katman karar verir**. Diğer katmanlar (Domain, App) veri kaynağının nerede olduğunu bilmez. Bu izolasyon Clean Architecture’ın temel prensibidir.

---

## 📐 Yapı

MarketData katmanı şu bileşenleri içerir:

- **DTO (Data Transfer Object):**  
  API ve Core Data gibi kaynaklardan gelen verileri temsil eder. App katmanında kullanılmaz, sadece Data içinde dolaşır.

- **RemoteDataSource:**  
  `NetworkManager` aracılığıyla REST API çağrılarını gerçekleştirir.

- **LocalDataSource:**  
  `CoreDataStack` ile birlikte Core Data işlemlerini yürütür.

- **BaseCoreDataService:**  
  Generic olarak çalışan, tüm `NSManagedObject` işlemlerini yöneten temel sınıf.

- **CartItemEntity (Core Data):**  
  `.xcdatamodeld` dosyasında tanımlı Core Data nesnesi.

---

## 🔄 Akış

1. `App` katmanı, yalnızca `UseCaseProvider` aracılığıyla `UseCase`'e ulaşır.
2. `UseCase`, `Repository` üzerinden `Data` katmanına erişir.
3. `Repository`, ihtiyaca göre `Remote` ya da `Local` veri kaynağını kullanır.
4. Veriler `DTO` olarak gelir ve `Entity`'e map'lenerek `App` katmanına döner.

---

## ❌ Domain Katmanı Neden Kaldırıldı?

Başta **Domain katmanı** kullanılmıştı. Ancak `Core Data`'nın `xcdatamodeld` yapısı ve `NSManagedObjectModel` kullanımı SPM’de sınırlamalara neden oldu.  
Bu nedenle:
- CoreData işlemleri yalnızca **App target’ı içinde sağlıklı çalışabildi.**
- Clean mimari korunarak tüm yapı App’e aktarıldı.
- `MarketData` katmanı domain görevlerini de üstlendi.

---

## ✅ Katman Kuralları

| Katman     | Gördüğü Katman | Göremediği Katmanlar |
|------------|----------------|-----------------------|
| App        | Domain         | Data                  |
| Domain     | Data           | App                   |
| Data       | (Kimseyi görmez, yalnızca çağrılır) | App, Domain |

---

## 🧪 Test Edilebilirlik

Tüm `LocalDataSource` ve `Repository` sınıfları `protocol` ile tanımlanmıştır.  
Bu sayede:
- Her katman **mock** nesnelerle izole test edilebilir.
- `Combine` ile birlikte `Unit Test` senaryoları kolayca yazılabilir.
- Unit Test yazımında GIVEN WHEN THEN prensibi uygulanır

---

## 📁 Örnek Dosya Yapısı

```
MarketData/
├── CoreDataManager/
│   ├── CoreDataStack.swift
│   ├── MarketData.xcdatamodeld
│   └── CartItemEntity.swift
├── DTO/
│   └── ProductCartDTO.swift
├── LocalDataSource/
│   ├── BaseCoreDataService.swift
│   └── CartLocalDataSource.swift
├── RemoteDataSource/
│   └── ProductRemoteDataSource.swift
├── Network/
│   ├── NetworkManager.swift
│   ├── HTTPRequest.swift
│   └── HTTPMethod.swift
└── Repository/
    └── CartRepository.swift
```

---
