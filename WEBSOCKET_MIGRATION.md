# WebSocket Chatbot - دليل الاستخدام

## 📋 نظرة عامة

تم تحويل التطبيق للاعتماد بالكامل على **WebSocket API** الخاص بك بدلاً من Groq API.

---

## 🚀 البدء السريع

### 1. تشغيل WebSocket Server

تأكد من تشغيل الخادم على:
```
ws://localhost:62754/ws/chat/postman_socket
```

### 2. تكوين URL حسب نوع الجهاز

في ملف `lib/featuers/chat_bot/data_sor/chat_constants.dart`:

| نوع الجهاز | URL المناسب |
|------------|-------------|
| **Android Emulator** | `ws://10.0.2.2:62754/ws/chat/postman_socket` ✅ (افتراضي) |
| **iOS Simulator** | `ws://localhost:62754/ws/chat/postman_socket` |
| **جهاز حقيقي** | `ws://192.168.x.x:62754/ws/chat/postman_socket` |

**لمعرفة IP جهازك:**
```bash
ipconfig  # Windows
ifconfig  # Mac/Linux
```

### 3. تشغيل التطبيق

```bash
flutter pub get
flutter run
```

---

## 📨 بروتوكول الرسائل

### الإرسال إلى الخادم:
```json
{
  "type": "message",
  "content": "السؤال هنا"
}
```

### الاستقبال من الخادم (3 رسائل):

1. **رسالة الترحيب** (يتم تجاهلها تلقائياً):
```json
{
  "type": "connected",
  "message": "Welcome to Influencer Platform Chatbot!",
  "client_id": "postman_socket"
}
```

2. **مؤشر الكتابة** (يتم تجاهله تلقائياً):
```json
{
  "type": "typing"
}
```

3. **الرد النهائي** (هذا ما يُعرض للمستخدم):
```json
{
  "type": "response",
  "content": "الإجابة هنا",
  "sources": ["file_data_1.txt"],
  "success": true
}
```

---

## 📁 البنية الجديدة

```
lib/featuers/chat_bot/data_sor/
├── chat_constants.dart      # إعدادات WebSocket URL
├── websocket_service.dart   # خدمة WebSocket الأساسية
├── chat_service.dart        # واجهة موحدة للشات
└── app_knowledge.dart       # قاعدة المعرفة (اختياري)
```

---

## ✨ الميزات

- ✅ اتصال WebSocket تلقائي
- ✅ معالجة ذكية للرسائل (تجاهل connected و typing)
- ✅ Timeout handling (30 ثانية)
- ✅ معالجة الأخطاء بالعربية
- ✅ تنظيف الموارد تلقائياً

---

## 🔧 استكشاف الأخطاء

### ❌ "فشل الاتصال بالخادم"
**السبب:** WebSocket Server غير مشغل  
**الحل:** 
1. تأكد من تشغيل الخادم
2. تحقق من المنفذ 62754

### ❌ "انتهت مهلة الاتصال"
**السبب:** الخادم بطيء أو لا يستجيب  
**الحل:**
1. تحقق من اتصال الإنترنت
2. أعد تشغيل الخادم

### ❌ "عذراً، حدث خطأ في الاتصال"
**السبب:** الخادم أرسل رد بصيغة خاطئة  
**الحل:** تحقق من أن الخادم يرسل `{type: "response", success: true, content: "..."}`

---

## 📝 ملاحظات مهمة

1. **Android Emulator**: يجب استخدام `10.0.2.2` بدلاً من `localhost`
2. **الاتصال المستمر**: WebSocket يبقى متصل طوال جلسة الشات
3. **التنظيف التلقائي**: عند إغلاق الشات، يتم قطع الاتصال تلقائياً

---

## 🎯 الخطوات التالية (اختياري)

- [ ] إضافة مؤشر "البوت يكتب..." باستخدام رسالة `typing`
- [ ] حفظ تاريخ المحادثات في قاعدة بيانات محلية
- [ ] إضافة إعادة الاتصال التلقائي عند انقطاع الشبكة
- [ ] دعم إرسال الصور والملفات

---

**تم بنجاح! 🎉**  
التطبيق الآن يعتمد بالكامل على WebSocket API الخاص بك.
