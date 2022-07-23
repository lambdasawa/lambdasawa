package main

type LiveChatFile = []LiveChat

type LiveChat struct {
	ClickTrackingParams  *string              `json:"clickTrackingParams,omitempty"`
	ReplayChatItemAction ReplayChatItemAction `json:"replayChatItemAction"`
}

type ReplayChatItemAction struct {
	Actions             []ReplayChatItemActionAction `json:"actions"`
	VideoOffsetTimeMsec string                       `json:"videoOffsetTimeMsec"`
}

type ReplayChatItemActionAction struct {
	ClickTrackingParams           *string                        `json:"clickTrackingParams,omitempty"`
	AddChatItemAction             *AddChatItemAction             `json:"addChatItemAction,omitempty"`
	ReplaceLiveChatRendererAction *ReplaceLiveChatRendererAction `json:"replaceLiveChatRendererAction,omitempty"`
	AddLiveChatTickerItemAction   *AddLiveChatTickerItemAction   `json:"addLiveChatTickerItemAction,omitempty"`
}

type AddChatItemAction struct {
	Item     AddChatItemActionItem `json:"item"`
	ClientID *string               `json:"clientId,omitempty"`
}

type AddChatItemActionItem struct {
	LiveChatViewerEngagementMessageRenderer                *LiveChatViewerEngagementMessageRenderer                  `json:"liveChatViewerEngagementMessageRenderer,omitempty"`
	LiveChatModeChangeMessageRenderer                      *LiveChatModeChangeMessageRenderer                        `json:"liveChatModeChangeMessageRenderer,omitempty"`
	LiveChatTextMessageRenderer                            *LiveChatTextMessageRenderer                              `json:"liveChatTextMessageRenderer,omitempty"`
	LiveChatPlaceholderItemRenderer                        *LiveChatPlaceholderItemRenderer                          `json:"liveChatPlaceholderItemRenderer,omitempty"`
	LiveChatPaidMessageRenderer                            *ItemLiveChatPaidMessageRenderer                          `json:"liveChatPaidMessageRenderer,omitempty"`
	LiveChatMembershipItemRenderer                         *LiveChatRenderer                                         `json:"liveChatMembershipItemRenderer,omitempty"`
	LiveChatSponsorshipsGiftPurchaseAnnouncementRenderer   *ItemLiveChatSponsorshipsGiftPurchaseAnnouncementRenderer `json:"liveChatSponsorshipsGiftPurchaseAnnouncementRenderer,omitempty"`
	LiveChatSponsorshipsGiftRedemptionAnnouncementRenderer *LiveChatRenderer                                         `json:"liveChatSponsorshipsGiftRedemptionAnnouncementRenderer,omitempty"`
	LiveChatPaidStickerRenderer                            *LiveChatPaidStickerRenderer                              `json:"liveChatPaidStickerRenderer,omitempty"`
}

type LiveChatRenderer struct {
	ID                       string                                            `json:"id"`
	TimestampUsec            string                                            `json:"timestampUsec"`
	TimestampText            SimpleText                                        `json:"timestampText"`
	AuthorExternalChannelID  string                                            `json:"authorExternalChannelId"`
	HeaderSubtext            *HeaderSubtext                                    `json:"headerSubtext,omitempty"`
	AuthorName               SimpleText                                        `json:"authorName"`
	AuthorPhoto              OrPhoto                                           `json:"authorPhoto"`
	AuthorBadges             []AuthorBadge                                     `json:"authorBadges,omitempty"`
	ContextMenuEndpoint      LiveChatMembershipItemRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	ContextMenuAccessibility ContextMenuAccessibility                          `json:"contextMenuAccessibility"`
	Message                  *LiveChatMembershipItemRendererMessage            `json:"message,omitempty"`
}

type AuthorBadge struct {
	LiveChatAuthorBadgeRenderer LiveChatAuthorBadgeRenderer `json:"liveChatAuthorBadgeRenderer"`
}

type LiveChatAuthorBadgeRenderer struct {
	CustomThumbnail CustomThumbnailClass     `json:"customThumbnail"`
	Tooltip         string                   `json:"tooltip"`
	Accessibility   ContextMenuAccessibility `json:"accessibility"`
}

type ContextMenuAccessibility struct {
	AccessibilityData AccessibilityData `json:"accessibilityData"`
}

type AccessibilityData struct {
	Label string `json:"label"`
}

type CustomThumbnailClass struct {
	Thumbnails []CustomThumbnailThumbnail `json:"thumbnails"`
}

type CustomThumbnailThumbnail struct {
	URL string `json:"url"`
}

type SimpleText struct {
	SimpleText string `json:"simpleText"`
}

type OrPhoto struct {
	Thumbnails []AuthorPhotoThumbnail `json:"thumbnails"`
}

type AuthorPhotoThumbnail struct {
	URL    string `json:"url"`
	Width  *int64 `json:"width,omitempty"`
	Height *int64 `json:"height,omitempty"`
}

type LiveChatMembershipItemRendererContextMenuEndpoint struct {
	CommandMetadata                 ContextMenuEndpointCommandMetadata `json:"commandMetadata"`
	LiveChatItemContextMenuEndpoint LiveChatItemContextMenuEndpoint    `json:"liveChatItemContextMenuEndpoint"`
}

type ContextMenuEndpointCommandMetadata struct {
	WebCommandMetadata PurpleWebCommandMetadata `json:"webCommandMetadata"`
}

type PurpleWebCommandMetadata struct {
	IgnoreNavigation bool `json:"ignoreNavigation"`
}

type LiveChatItemContextMenuEndpoint struct {
	Params string `json:"params"`
}

type HeaderSubtext struct {
	Runs []HeaderSubtextRun `json:"runs"`
}

type HeaderSubtextRun struct {
	Text string `json:"text"`
}

type LiveChatMembershipItemRendererMessage struct {
	Runs []PurpleRun `json:"runs"`
}

type PurpleRun struct {
	Text    string `json:"text"`
	Italics bool   `json:"italics"`
	Bold    *bool  `json:"bold,omitempty"`
}

type LiveChatModeChangeMessageRenderer struct {
	ID            string     `json:"id"`
	TimestampUsec string     `json:"timestampUsec"`
	Icon          Icon       `json:"icon"`
	Text          TextClass  `json:"text"`
	Subtext       Subtext    `json:"subtext"`
	TimestampText SimpleText `json:"timestampText"`
}

type Icon struct {
	IconType string `json:"iconType"`
}

type Subtext struct {
	Runs []SubtextRun `json:"runs"`
}

type SubtextRun struct {
	Text    string `json:"text"`
	Italics bool   `json:"italics"`
}

type TextClass struct {
	Runs []TextRun `json:"runs"`
}

type TextRun struct {
	Text string `json:"text"`
	Bold bool   `json:"bold"`
}

type ItemLiveChatPaidMessageRenderer struct {
	ID                       string                                            `json:"id"`
	TimestampUsec            string                                            `json:"timestampUsec"`
	AuthorName               SimpleText                                        `json:"authorName"`
	AuthorPhoto              OrPhoto                                           `json:"authorPhoto"`
	PurchaseAmountText       SimpleText                                        `json:"purchaseAmountText"`
	Message                  *LiveChatPaidMessageRendererMessage               `json:"message,omitempty"`
	HeaderBackgroundColor    int64                                             `json:"headerBackgroundColor"`
	HeaderTextColor          int64                                             `json:"headerTextColor"`
	BodyBackgroundColor      int64                                             `json:"bodyBackgroundColor"`
	BodyTextColor            int64                                             `json:"bodyTextColor"`
	AuthorExternalChannelID  string                                            `json:"authorExternalChannelId"`
	AuthorNameTextColor      int64                                             `json:"authorNameTextColor"`
	ContextMenuEndpoint      LiveChatMembershipItemRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	TimestampColor           int64                                             `json:"timestampColor"`
	ContextMenuAccessibility ContextMenuAccessibility                          `json:"contextMenuAccessibility"`
	TimestampText            SimpleText                                        `json:"timestampText"`
	TextInputBackgroundColor int64                                             `json:"textInputBackgroundColor"`
}

type LiveChatPaidMessageRendererMessage struct {
	Runs []FluffyRun `json:"runs"`
}

type FluffyRun struct {
	Text  *string      `json:"text,omitempty"`
	Emoji *PurpleEmoji `json:"emoji,omitempty"`
}

type PurpleEmoji struct {
	EmojiID     string     `json:"emojiId"`
	Shortcuts   []string   `json:"shortcuts"`
	SearchTerms []string   `json:"searchTerms"`
	Image       EmojiImage `json:"image"`
}

type EmojiImage struct {
	Thumbnails    []CustomThumbnailThumbnail `json:"thumbnails"`
	Accessibility ContextMenuAccessibility   `json:"accessibility"`
}

type LiveChatPaidStickerRenderer struct {
	ID                       string                                            `json:"id"`
	ContextMenuEndpoint      LiveChatMembershipItemRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	ContextMenuAccessibility ContextMenuAccessibility                          `json:"contextMenuAccessibility"`
	TimestampUsec            string                                            `json:"timestampUsec"`
	AuthorPhoto              OrPhoto                                           `json:"authorPhoto"`
	AuthorName               SimpleText                                        `json:"authorName"`
	AuthorExternalChannelID  string                                            `json:"authorExternalChannelId"`
	TimestampText            SimpleText                                        `json:"timestampText"`
	Sticker                  Sticker                                           `json:"sticker"`
	MoneyChipBackgroundColor int64                                             `json:"moneyChipBackgroundColor"`
	MoneyChipTextColor       int64                                             `json:"moneyChipTextColor"`
	PurchaseAmountText       SimpleText                                        `json:"purchaseAmountText"`
	StickerDisplayWidth      int64                                             `json:"stickerDisplayWidth"`
	StickerDisplayHeight     int64                                             `json:"stickerDisplayHeight"`
	BackgroundColor          int64                                             `json:"backgroundColor"`
	AuthorNameTextColor      int64                                             `json:"authorNameTextColor"`
}

type Sticker struct {
	Thumbnails    []AuthorPhotoThumbnail   `json:"thumbnails"`
	Accessibility ContextMenuAccessibility `json:"accessibility"`
}

type LiveChatPlaceholderItemRenderer struct {
	ID            string `json:"id"`
	TimestampUsec string `json:"timestampUsec"`
}

type ItemLiveChatSponsorshipsGiftPurchaseAnnouncementRenderer struct {
	ID                      string `json:"id"`
	TimestampUsec           string `json:"timestampUsec"`
	AuthorExternalChannelID string `json:"authorExternalChannelId"`
	Header                  Header `json:"header"`
}

type Header struct {
	LiveChatSponsorshipsHeaderRenderer LiveChatSponsorshipsHeaderRenderer `json:"liveChatSponsorshipsHeaderRenderer"`
}

type LiveChatSponsorshipsHeaderRenderer struct {
	AuthorName               SimpleText                                        `json:"authorName"`
	AuthorPhoto              OrPhoto                                           `json:"authorPhoto"`
	PrimaryText              TextClass                                         `json:"primaryText"`
	AuthorBadges             []AuthorBadge                                     `json:"authorBadges"`
	ContextMenuEndpoint      LiveChatMembershipItemRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	ContextMenuAccessibility ContextMenuAccessibility                          `json:"contextMenuAccessibility"`
	Image                    CustomThumbnailClass                              `json:"image"`
}

type LiveChatTextMessageRenderer struct {
	Message                  LiveChatTextMessageRendererMessage             `json:"message"`
	AuthorName               SimpleText                                     `json:"authorName"`
	AuthorPhoto              OrPhoto                                        `json:"authorPhoto"`
	ContextMenuEndpoint      LiveChatTextMessageRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	ID                       string                                         `json:"id"`
	TimestampUsec            string                                         `json:"timestampUsec"`
	AuthorBadges             []AuthorBadge                                  `json:"authorBadges,omitempty"`
	AuthorExternalChannelID  string                                         `json:"authorExternalChannelId"`
	ContextMenuAccessibility ContextMenuAccessibility                       `json:"contextMenuAccessibility"`
	TimestampText            SimpleText                                     `json:"timestampText"`
	TrackingParams           *string                                        `json:"trackingParams,omitempty"`
}

type LiveChatTextMessageRendererContextMenuEndpoint struct {
	ClickTrackingParams             *string                            `json:"clickTrackingParams,omitempty"`
	CommandMetadata                 ContextMenuEndpointCommandMetadata `json:"commandMetadata"`
	LiveChatItemContextMenuEndpoint LiveChatItemContextMenuEndpoint    `json:"liveChatItemContextMenuEndpoint"`
}

type LiveChatTextMessageRendererMessage struct {
	Runs []TentacledRun `json:"runs"`
}

type TentacledRun struct {
	Text  *string      `json:"text,omitempty"`
	Emoji *FluffyEmoji `json:"emoji,omitempty"`
}

type FluffyEmoji struct {
	EmojiID       string   `json:"emojiId"`
	Shortcuts     []string `json:"shortcuts"`
	SearchTerms   []string `json:"searchTerms"`
	Image         Sticker  `json:"image"`
	IsCustomEmoji *bool    `json:"isCustomEmoji,omitempty"`
}

type LiveChatViewerEngagementMessageRenderer struct {
	ID             string        `json:"id"`
	TimestampUsec  string        `json:"timestampUsec"`
	Icon           Icon          `json:"icon"`
	Message        HeaderSubtext `json:"message"`
	TrackingParams string        `json:"trackingParams"`
}

type AddLiveChatTickerItemAction struct {
	Item        AddLiveChatTickerItemActionItem `json:"item"`
	DurationSEC string                          `json:"durationSec"`
}

type AddLiveChatTickerItemActionItem struct {
	LiveChatTickerSponsorItemRenderer     *LiveChatTickerSponsorItemRenderer     `json:"liveChatTickerSponsorItemRenderer,omitempty"`
	LiveChatTickerPaidMessageItemRenderer *LiveChatTickerPaidMessageItemRenderer `json:"liveChatTickerPaidMessageItemRenderer,omitempty"`
}

type LiveChatTickerPaidMessageItemRenderer struct {
	ID                      string                                                `json:"id"`
	Amount                  SimpleText                                            `json:"amount"`
	AmountTextColor         int64                                                 `json:"amountTextColor"`
	StartBackgroundColor    int64                                                 `json:"startBackgroundColor"`
	EndBackgroundColor      int64                                                 `json:"endBackgroundColor"`
	AuthorPhoto             Sticker                                               `json:"authorPhoto"`
	DurationSEC             int64                                                 `json:"durationSec"`
	ShowItemEndpoint        LiveChatTickerPaidMessageItemRendererShowItemEndpoint `json:"showItemEndpoint"`
	AuthorExternalChannelID string                                                `json:"authorExternalChannelId"`
	FullDurationSEC         int64                                                 `json:"fullDurationSec"`
}

type LiveChatTickerPaidMessageItemRendererShowItemEndpoint struct {
	CommandMetadata          ContextMenuEndpointCommandMetadata `json:"commandMetadata"`
	ShowLiveChatItemEndpoint PurpleShowLiveChatItemEndpoint     `json:"showLiveChatItemEndpoint"`
}

type PurpleShowLiveChatItemEndpoint struct {
	Renderer PurpleRenderer `json:"renderer"`
}

type PurpleRenderer struct {
	LiveChatPaidMessageRenderer RendererLiveChatPaidMessageRenderer `json:"liveChatPaidMessageRenderer"`
}

type RendererLiveChatPaidMessageRenderer struct {
	ID                       string                                            `json:"id"`
	TimestampUsec            string                                            `json:"timestampUsec"`
	AuthorName               SimpleText                                        `json:"authorName"`
	AuthorPhoto              OrPhoto                                           `json:"authorPhoto"`
	PurchaseAmountText       SimpleText                                        `json:"purchaseAmountText"`
	Message                  HeaderSubtext                                     `json:"message"`
	HeaderBackgroundColor    int64                                             `json:"headerBackgroundColor"`
	HeaderTextColor          int64                                             `json:"headerTextColor"`
	BodyBackgroundColor      int64                                             `json:"bodyBackgroundColor"`
	BodyTextColor            int64                                             `json:"bodyTextColor"`
	AuthorExternalChannelID  string                                            `json:"authorExternalChannelId"`
	AuthorNameTextColor      int64                                             `json:"authorNameTextColor"`
	ContextMenuEndpoint      LiveChatMembershipItemRendererContextMenuEndpoint `json:"contextMenuEndpoint"`
	TimestampColor           int64                                             `json:"timestampColor"`
	ContextMenuAccessibility ContextMenuAccessibility                          `json:"contextMenuAccessibility"`
	TimestampText            SimpleText                                        `json:"timestampText"`
	TextInputBackgroundColor int64                                             `json:"textInputBackgroundColor"`
}

type LiveChatTickerSponsorItemRenderer struct {
	ID                      string                                            `json:"id"`
	DetailText              DetailText                                        `json:"detailText"`
	DetailTextColor         int64                                             `json:"detailTextColor"`
	StartBackgroundColor    int64                                             `json:"startBackgroundColor"`
	EndBackgroundColor      int64                                             `json:"endBackgroundColor"`
	SponsorPhoto            OrPhoto                                           `json:"sponsorPhoto"`
	DurationSEC             int64                                             `json:"durationSec"`
	ShowItemEndpoint        LiveChatTickerSponsorItemRendererShowItemEndpoint `json:"showItemEndpoint"`
	AuthorExternalChannelID string                                            `json:"authorExternalChannelId"`
	FullDurationSEC         int64                                             `json:"fullDurationSec"`
	DetailIcon              *Icon                                             `json:"detailIcon,omitempty"`
}

type DetailText struct {
	Runs          []HeaderSubtextRun        `json:"runs,omitempty"`
	Accessibility *ContextMenuAccessibility `json:"accessibility,omitempty"`
	SimpleText    *string                   `json:"simpleText,omitempty"`
}

type LiveChatTickerSponsorItemRendererShowItemEndpoint struct {
	CommandMetadata          ContextMenuEndpointCommandMetadata `json:"commandMetadata"`
	ShowLiveChatItemEndpoint FluffyShowLiveChatItemEndpoint     `json:"showLiveChatItemEndpoint"`
}

type FluffyShowLiveChatItemEndpoint struct {
	Renderer FluffyRenderer `json:"renderer"`
}

type FluffyRenderer struct {
	LiveChatMembershipItemRenderer                       *LiveChatRenderer                                             `json:"liveChatMembershipItemRenderer,omitempty"`
	LiveChatSponsorshipsGiftPurchaseAnnouncementRenderer *RendererLiveChatSponsorshipsGiftPurchaseAnnouncementRenderer `json:"liveChatSponsorshipsGiftPurchaseAnnouncementRenderer,omitempty"`
}

type RendererLiveChatSponsorshipsGiftPurchaseAnnouncementRenderer struct {
	AuthorExternalChannelID string `json:"authorExternalChannelId"`
	Header                  Header `json:"header"`
}

type ReplaceLiveChatRendererAction struct {
	ToReplace   string      `json:"toReplace"`
	Replacement Replacement `json:"replacement"`
}

type Replacement struct {
	LiveChatRestrictedParticipationRenderer LiveChatRestrictedParticipationRenderer `json:"liveChatRestrictedParticipationRenderer"`
}

type LiveChatRestrictedParticipationRenderer struct {
	Message HeaderSubtext `json:"message"`
	Buttons []Button      `json:"buttons"`
	Icon    Icon          `json:"icon"`
}

type Button struct {
	ButtonRenderer ButtonRenderer `json:"buttonRenderer"`
}

type ButtonRenderer struct {
	Icon              Icon                     `json:"icon"`
	TrackingParams    string                   `json:"trackingParams"`
	AccessibilityData ContextMenuAccessibility `json:"accessibilityData"`
	Command           Command                  `json:"command"`
}

type Command struct {
	ClickTrackingParams   string                 `json:"clickTrackingParams"`
	CommandMetadata       CommandCommandMetadata `json:"commandMetadata"`
	SignalServiceEndpoint SignalServiceEndpoint  `json:"signalServiceEndpoint"`
}

type CommandCommandMetadata struct {
	WebCommandMetadata FluffyWebCommandMetadata `json:"webCommandMetadata"`
}

type FluffyWebCommandMetadata struct {
	SendPost bool `json:"sendPost"`
}

type SignalServiceEndpoint struct {
	Signal  string                        `json:"signal"`
	Actions []SignalServiceEndpointAction `json:"actions"`
}

type SignalServiceEndpointAction struct {
	ClickTrackingParams      string                   `json:"clickTrackingParams"`
	LiveChatAddToToastAction LiveChatAddToToastAction `json:"liveChatAddToToastAction"`
}

type LiveChatAddToToastAction struct {
	Item LiveChatAddToToastActionItem `json:"item"`
}

type LiveChatAddToToastActionItem struct {
	NotificationTextRenderer NotificationTextRenderer `json:"notificationTextRenderer"`
}

type NotificationTextRenderer struct {
	SuccessResponseText SimpleText `json:"successResponseText"`
	TrackingParams      string     `json:"trackingParams"`
}
