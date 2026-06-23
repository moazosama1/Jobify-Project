import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:jobify_project/data/data_source/ai_chat_remote_data_source.dart';
import 'package:jobify_project/data/models/ai_chat_message_model.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';

@Injectable(as: AiChatRemoteDataSource)
class AiChatRemoteDataSourceImpl implements AiChatRemoteDataSource {
  AiChatRemoteDataSourceImpl();

  @override
  Future<AiChatMessageModel> sendAiMessage(
    String message, {
    Uint8List? pdfBytes,
    List<AiChatMessageEntity>? history,
  }) async {
    final sysInstruction = '''
You are "Jobify Assistant" — a friendly, knowledgeable AI career coach built into the Jobify mobile app.

## Who You Are
- You act like a real human career mentor, not a generic chatbot.
- You have deep expertise in: resume/CV writing, job searching strategies, interview coaching, salary negotiation, career transitions, skill development, freelancing, and LinkedIn optimization.
- You speak in a warm, encouraging, and professional tone — like a supportive senior colleague who genuinely wants to help.
- You are concise. Avoid walls of text. Use bullet points, numbered lists, and bold headers when helpful.

## How You Respond
- **Detect the user's language automatically** and reply in the same language (Arabic, English, or mixed). If the user writes in Arabic, respond in Arabic. If in English, respond in English.
- Use Markdown formatting (bold, bullet points, numbered lists, headers) to make your answers scannable and easy to read.
- When giving advice, be specific and actionable — not vague motivational talk.
- If the user shares their CV text or job description, analyze it critically and give concrete improvement suggestions.
- If the user asks about a specific job title or industry, tailor your advice to that field.
- Keep responses focused. Aim for 3-8 bullet points or a short structured answer unless the user asks for a deep dive.

## Boundaries
- If the user asks about something completely unrelated to career, jobs, education, or professional growth, politely redirect them. Example: "I am here to help with your career! Feel free to ask about CVs, interviews, job search, or skills 😊"
- Never generate code, write essays, or do tasks outside the career domain.
- Never make up fake job listings, companies, or statistics.
- Do not share personal opinions on politics, religion, or controversial topics.

## Greeting Behavior
- When the user says hello/hi/مرحبا/اهلا or similar, greet them warmly and briefly introduce yourself. Example: "Hey! 👋 I'm your Jobify Career Assistant. I can help you polish your CV, prep for interviews, or plan your next career move. What can I help you with?"
- Do not repeat the introduction if the conversation has already started.
''';

    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.5-flash',
      systemInstruction: Content.system(sysInstruction),
    );

    final prompt = message;

    try {
      final contents = <Content>[];

      // Convert history to Content list
      if (history != null) {
        for (var msg in history) {
          // Do not send error responses as history context
          if (msg.id.contains('error')) continue;
          
          final role = msg.isUser ? 'user' : 'model';
          contents.add(Content(role, [TextPart(msg.text)]));
        }
      }

      // Add current message
      if (pdfBytes != null) {
        contents.add(
          Content.multi([
            TextPart(prompt),
            InlineDataPart('application/pdf', pdfBytes),
          ]),
        );
      } else {
        contents.add(Content.text(prompt));
      }

      final response = await model.generateContent(contents);

      final text =
          response.text?.trim() ??
          'I am sorry, I could not generate a response. Please try again.';

      final now = DateTime.now();
      final amPm = now.hour >= 12 ? 'PM' : 'AM';
      final displayHour = now.hour > 12
          ? now.hour - 12
          : (now.hour == 0 ? 12 : now.hour);
      final timeStr =
          "${displayHour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm";

      return AiChatMessageModel(
        id: "ai_${DateTime.now().millisecondsSinceEpoch}",
        text: text,
        isUser: false,
        time: timeStr,
      );
    } catch (e) {
      final now = DateTime.now();
      final amPm = now.hour >= 12 ? 'PM' : 'AM';
      final displayHour = now.hour > 12
          ? now.hour - 12
          : (now.hour == 0 ? 12 : now.hour);
      final timeStr =
          "${displayHour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm";

      return AiChatMessageModel(
        id: "ai_error_${DateTime.now().millisecondsSinceEpoch}",
        text: "Error connecting to AI: $e",
        isUser: false,
        time: timeStr,
      );
    }
  }
}


