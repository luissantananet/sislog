USE [master]
GO

/****** Object:  Database [DBsystem]    Script Date: 19/09/2016 02:04:32 ******/
CREATE DATABASE [DBsystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBsystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBsystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBsystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBsystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [DBsystem] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBsystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DBsystem] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DBsystem] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DBsystem] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DBsystem] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DBsystem] SET ARITHABORT OFF 
GO

ALTER DATABASE [DBsystem] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DBsystem] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DBsystem] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DBsystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DBsystem] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DBsystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DBsystem] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DBsystem] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DBsystem] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DBsystem] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DBsystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DBsystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DBsystem] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DBsystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DBsystem] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DBsystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DBsystem] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DBsystem] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [DBsystem] SET  MULTI_USER 
GO

ALTER DATABASE [DBsystem] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DBsystem] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DBsystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DBsystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [DBsystem] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DBsystem] SET  READ_WRITE 
GO

