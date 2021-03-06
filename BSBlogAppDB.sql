USE [master]
GO
/****** Object:  Database [BSBlogAppDB]    Script Date: 21/10/2020 10:38:36 PM ******/
CREATE DATABASE [BSBlogAppDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BSBlogAppDB', FILENAME = N'D:\Mehedi-3203\DB Files\BSBlogAppDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BSBlogAppDB_log', FILENAME = N'D:\Mehedi-3203\DB Files\BSBlogAppDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BSBlogAppDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BSBlogAppDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BSBlogAppDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BSBlogAppDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BSBlogAppDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BSBlogAppDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BSBlogAppDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET RECOVERY FULL 
GO
ALTER DATABASE [BSBlogAppDB] SET  MULTI_USER 
GO
ALTER DATABASE [BSBlogAppDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BSBlogAppDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BSBlogAppDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BSBlogAppDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BSBlogAppDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BSBlogAppDB', N'ON'
GO
USE [BSBlogAppDB]
GO
/****** Object:  Table [dbo].[AppUsers]    Script Date: 21/10/2020 10:38:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 21/10/2020 10:38:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[CommentedBy] [int] NOT NULL,
	[CommentDescription] [varchar](max) NULL,
	[CommentDate] [datetime] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommentStats]    Script Date: 21/10/2020 10:38:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentStats](
	[StatId] [int] IDENTITY(1,1) NOT NULL,
	[CommentID] [int] NOT NULL,
	[LikeCount] [bit] NULL,
	[DislikeCount] [bit] NULL,
 CONSTRAINT [PK_CommentStats] PRIMARY KEY CLUSTERED 
(
	[StatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 21/10/2020 10:38:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[PostTitle] [varchar](500) NOT NULL,
	[PostDescription] [varchar](max) NULL,
	[Author] [int] NOT NULL,
	[DatePosted] [datetime] NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AppUsers] ON 

INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (1, N'admin', N'admin', CAST(N'2020-10-21 19:19:48.607' AS DateTime))
INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (2, N'user1', N'user1', CAST(N'2020-10-21 19:19:54.810' AS DateTime))
INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (3, N'user2', N'user2', CAST(N'2020-10-21 19:19:59.783' AS DateTime))
INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (4, N'user3', N'user3', CAST(N'2020-10-21 19:20:04.140' AS DateTime))
INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (5, N'user4', N'user4', CAST(N'2020-10-21 19:20:07.930' AS DateTime))
INSERT [dbo].[AppUsers] ([UserId], [UserName], [Password], [DateCreated]) VALUES (6, N'user5', N'user5', CAST(N'2020-10-21 19:20:12.260' AS DateTime))
SET IDENTITY_INSERT [dbo].[AppUsers] OFF
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([CommentId], [PostID], [CommentedBy], [CommentDescription], [CommentDate]) VALUES (1, 1, 2, N'Good article', CAST(N'2020-10-21 21:08:23.273' AS DateTime))
INSERT [dbo].[Comments] ([CommentId], [PostID], [CommentedBy], [CommentDescription], [CommentDate]) VALUES (2, 1, 3, N'Need eleboration', CAST(N'2020-10-21 21:08:43.437' AS DateTime))
INSERT [dbo].[Comments] ([CommentId], [PostID], [CommentedBy], [CommentDescription], [CommentDate]) VALUES (5, 3, 4, N'Good one', CAST(N'2020-10-21 21:38:25.533' AS DateTime))
INSERT [dbo].[Comments] ([CommentId], [PostID], [CommentedBy], [CommentDescription], [CommentDate]) VALUES (6, 4, 5, N'Bad', CAST(N'2020-10-21 21:38:39.330' AS DateTime))
INSERT [dbo].[Comments] ([CommentId], [PostID], [CommentedBy], [CommentDescription], [CommentDate]) VALUES (7, 1, 4, N'Not good', CAST(N'2020-10-21 21:38:58.317' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments] OFF
SET IDENTITY_INSERT [dbo].[CommentStats] ON 

INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (1, 1, 1, 0)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (2, 1, 0, 1)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (3, 1, 1, 0)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (5, 2, 1, 0)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (6, 2, 1, 0)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (7, 2, 0, 1)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (9, 5, 0, 1)
INSERT [dbo].[CommentStats] ([StatId], [CommentID], [LikeCount], [DislikeCount]) VALUES (10, 5, 1, 0)
SET IDENTITY_INSERT [dbo].[CommentStats] OFF
SET IDENTITY_INSERT [dbo].[Posts] ON 

INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (1, N'Top 5 new features in the Windows 10 October 2020 Update', N'The Windows 10 October 2020 Update is here! It''s a smaller release, but that doesn''t mean there aren''t new things worthy of note to talk about. Here''s the top five new features and changes that are included as part of Microsoft''s latest version of Windows 10, rolling out now to users on supported devices running version 1903 or higher.

If you''d prefer a more in-depth overview of everything that''s new, make sure you check out our Windows 10 October 2020 Update review!', 1, CAST(N'2020-10-21 20:39:05.507' AS DateTime))
INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (3, N'Surface Laptop Go vs. Dell XPS 13: Which is a better buy?', N'Ordinarily, Surface products would compete directly with the Dell XPS 13, but the Surface Laptop Go is a little different. It''s a budget device that starts at almost half the price of the XPS 13, and that lower entry point isn''t without compromise. The XPS 13 remains the best Ultrabook you can buy, and even though both of these are extremely compact computers, they''re really for different people.', 1, CAST(N'2020-10-21 20:39:44.980' AS DateTime))
INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (4, N'Starfield reportedly features a completely new animation system', N'Starfield is the next Bethesda Game Studios title and while it may still be a ways off, it looks like it''ll feature completely new animation work. As spotted on ResetEra, senior programmer at Bethesda Game Studios Eric Braun wrote on his LinkedIn account that he rewrote the animation system for Starfield from scratch.', 2, CAST(N'2020-10-21 20:40:28.370' AS DateTime))
INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (5, N'Second Extinction on Xbox Series X: Everything we know so far, trailers, beta, and release date', N'At the May 7 Inside Xbox showcase for third-party Xbox Series X games, one game was revealed that''s all about gunning down dinosaurs. Titled Second Extinction, this game is being developed and published by Systemic Reaction, a subsidiary of Avalanche Studios. This first-person, three-player co-op game tasks players with hunting down mutated dinosaurs that have taken over the Earth. Here''s everything we know about Second Extinction so far.', 3, CAST(N'2020-10-21 21:06:17.140' AS DateTime))
INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (6, N'Microsoft Edge Dev channel takes first step to major version 88, Beta moves to 87', N'The latest weekly build for the Microsoft Edge Dev channel is here, and it marks the browser''s first jump to major version 88. It also has the honor of being the first public build that''s available for Linux. Beyond that, the build introduces a new screenshot inking feature, along with the usual bunch of bug fixes and performance improvements.', 1, CAST(N'2020-10-21 21:06:49.970' AS DateTime))
INSERT [dbo].[Posts] ([PostId], [PostTitle], [PostDescription], [Author], [DatePosted]) VALUES (7, N'Microsoft Edge for Linux preview now available in the Dev channel', N'Microsoft Edge is now available for Linux. Microsoft announced the launch in a blog post today, noting that testers can now try it out as part of the Microsoft Edge Insider Dev channel. With this launch, this also marks Edge''s availability across all major desktop and mobile platforms.', 2, CAST(N'2020-10-21 21:07:28.410' AS DateTime))
SET IDENTITY_INSERT [dbo].[Posts] OFF
ALTER TABLE [dbo].[AppUsers] ADD  CONSTRAINT [DF_Users_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Comments_CommentDate]  DEFAULT (getdate()) FOR [CommentDate]
GO
ALTER TABLE [dbo].[CommentStats] ADD  CONSTRAINT [DF_CommentStats_LikeCount]  DEFAULT ((0)) FOR [LikeCount]
GO
ALTER TABLE [dbo].[CommentStats] ADD  CONSTRAINT [DF_CommentStats_DislikeCount]  DEFAULT ((0)) FOR [DislikeCount]
GO
ALTER TABLE [dbo].[Posts] ADD  CONSTRAINT [DF_Posts_DatePosted]  DEFAULT (getdate()) FOR [DatePosted]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Posts]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([CommentedBy])
REFERENCES [dbo].[AppUsers] ([UserId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[CommentStats]  WITH CHECK ADD  CONSTRAINT [FK_CommentStats_Comments] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comments] ([CommentId])
GO
ALTER TABLE [dbo].[CommentStats] CHECK CONSTRAINT [FK_CommentStats_Comments]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([Author])
REFERENCES [dbo].[AppUsers] ([UserId])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
USE [master]
GO
ALTER DATABASE [BSBlogAppDB] SET  READ_WRITE 
GO
