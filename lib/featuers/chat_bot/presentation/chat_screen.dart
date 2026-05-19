import 'package:cubit_pro/featuers/chat_bot/data_sor/chat_service.dart';
import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/controller/chat_cubit.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/chat_app_bar_widget.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/chat_empty_state_widget.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/chat_input_field_widget.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/chat_messages_list_widget.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/suggested_questions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatCubit _chatCubit;

  final List<String> _suggestedQuestions = [
    'كيف أطلب مؤثر لإعلان؟',
    'طريقة شحن المحفظة؟',
    'الفرق بين الطلب العام والخاص؟',
    'كيف أقيم المؤثر بعد العمل؟',
    'ما هي دورة المشروع للشركات؟',
    'كيف أسترد أموالي في حال الإلغاء؟',
  ];

  @override
  void initState() {
    super.initState();
    _chatCubit = ChatCubit(ChatService());
    _chatCubit.sendWelcomeMessage();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _chatCubit.close();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      _chatCubit.sendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: ChatAppBarWidget(
        onClearChat: () {
          _chatCubit.clearChat();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, List<Message>>(
              bloc: _chatCubit,
              listener: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _scrollToBottom(),
                );
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: state.isEmpty
                          ? const ChatEmptyStateWidget()
                          : ChatMessagesListWidget(
                              messages: state,
                              scrollController: _scrollController,
                              onOptionSelected: (option) {
                                _chatCubit.sendMessage(option);
                              },
                            ),
                    ),
                    if (state.length <= 1)
                      SuggestedQuestionsWidget(
                        questions: _suggestedQuestions,
                        onQuestionSelected: (question) {
                          _chatCubit.sendMessage(question);
                        },
                      ),
                  ],
                );
              },
            ),
          ),
          ChatInputFieldWidget(controller: _controller, onSend: _handleSend),
        ],
      ),
    );
  }
}
