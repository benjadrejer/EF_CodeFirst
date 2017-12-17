﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'VidzyCodeFirst_Exercise.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201711250840111_AddVideosAndGenresTables'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleaseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711250840111_AddVideosAndGenresTables', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EE336107D2FD07F10F4D416592B97976D60EF227592C2E8E6823809FA16D0D2D8214A512A4905F616FDB23EF493FA0B1DEA2E52B26423C8166D11209045CEFD703833FAEB8F3FC71FD721735E40481AF1897B343A741DE07E1450BE9AB8895ABE7BEF7EFCF0F557E38B205C3B8FC5BE13BD0F29B99CB8CF4AC5A79E27FD6708891C85D417918C966AE447A14782C83B3E3CFCDE3B3AF20059B8C8CB71C67709573484F407FE9C46DC875825845D45013099BFC79579CAD5B92621C898F830711F69F07933C56D975448F574B106E15309AE73C6284175E6C096AE43388F1451A8ECE98384B912115FCD637C41D8FD2606DCB7244C53A5469C56DB87DA7378ACEDF12AC282959F4815853B323C3AC91DE499E47BB9D92D1D882EBC4057AB8DB63A75E3C4FD11B840CB4D49A75326F4AE4E178F52C203A763F9A08407A248FF1D38D384A944C08443A2046107CE6DB260D4FF0936F7D12FC0273C61ACAE2B6A8B6B8D17F8EA56443108B5B983656EC12C701DAF49E7998425598D26336FC6D5C9B1EB5CA370B2605042A1E68AB98A04A0B9208882E0962805826B1E903AD3926EC8D2FF0B69883D3C4BAE7345D69F80AFD4F3C4C547D7B9A46B088A37B9060F9CE2D143222512B0845C9317BA4AF533C461402092AE73072C5D96CF34CE0EC2285D7A4A03871B2E4514DE45AC20C9DF3FDD13B102850A472D8BF32811BEA1CCD8AB40B5156A29A77DA09612FE0FB52F05354308020B888473D4B090A59FEFA9966D193714B6052AF7856D81CC56D816981E02DB3329239FA63AD4715BC86F9A73C103679B3259244A23301A884C1A231651F2C4FDCEF24F07C3F250560CF3C4BD95E1D8AB59639F4DBC6915A108B6CAD0CFE94B58AB96738A77677E54658E145377CD740ECA0869E5E7A6EA96E94DF2229159E4B92B0DF29AA5068F123AB52D6DD032CF7F4F704B7D2B55BD812C8A70D658143A9AE9A569560B7ECB2056759297154A4541E5755454E32B12C798236A1556FEC69967E5D5F4DD7CF79223CC7878BE6CA93C4A6D4B4998F1C80A8C55145DE479CC2D6441742A9906A1B5AD01D90E3C15A21AA8B42355A0ACD8AE9F1BE7A2BD043239555EBC44C3424CDCA98D60C6DAA64B2B5CC28868B941A6114B42DE750B6DA3CEEE843A7DF6C6E630F60CC54D1F7996930CB09A2E1F1490FCF0BC4640B2CCB07B403AE8BE7440BA38346EE03AA3C6C2DB07B899AB5AA25C66E281A12CF7B706ACF518E994DB56111BD9DBF6CDA04867ACDAE2AD7D530ADE51A7FC3AD853A794C98E3A99F78A1D4EEB7A31B794602AAF19E33A19E7A9BDBF8BB7727DB6C57550F7177414E6F9F9462A08477AC368FE2B9B328AF0AD365C114E97205556DEBBD8431F1B33807F4E3FEE4919B0214DF99B372854BBB4B705E92BF1B7F424FC8508FF99886F42B2FEB6CEC9EE3B76EC2AFFD3BE1AD4A305F8ACFA7BB4DDFCBE3750B724527B735786EB8F5725A61635ABB199F100D613F7B794E8D499FDFC54D01D383702D3CBA973E8FCBE73342BB577135ED0ED207CBF66B6F532347B96FE2EF6C8BA836FF83902508173E66759764AA44F02DB63FA82DA2A3D6F154D158634BF7AB20C4B10FA2C1286F79854026F32ABE8B91594FB3426AC61B57D190FC920DAA4929FB9720E31709D1A6C038748DB567B94AC0DF7F639A07340D0039CB68AA5163A3B6AAD01FB9701677828DF1638DB0AC457074EFB64C9EEE6078C8EBA2747597D8877DA42A7A72C2B760C505AA74ADD43A536CEEDD39D76CE5D8AD7173B657498D03BD92A4752DB075C1DBD8F9DF0ADCEB877B0D530DBECD086CFB406195B0CCF7A8C6D6FAAEC2465CD65DECAD81D067876278527B4F6D5143384A4AB8A85FE86CAC16F9CCD72CF8C2FA32249181A155B8C42E60A14C1F2919C094597C457B8EC8394E9E78547C212DC72112E2098F19B44C5894293215CB0C6E70A9D6AB6C94FA7944D9DC73771FA25E0354C4035A9AE806FF80F096541A9F7654B2DD5C142E7B0BCD6D7B154BAE65F6D4A4ED7111FC828775F997AEF218C193293377C4E5E601FDD1E247C8215F1374543DCCDA43F104DB78FCF29590912CA9C47458F3F11C341B8FEF037DF50EBE43C200000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711250843045_PopulateGenreTable'
BEGIN
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711250843045_PopulateGenreTable', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EE336107D2FD07F10F4D416592B97976D60EF227592C2E8E6823809FA16D0D2D8214A512A4905F616FDB23EF493FA0B1DEA2E52B26423C8166D11209045CEFD703833FAEB8F3FC71FD721735E40481AF1897B343A741DE07E1450BE9AB8895ABE7BEF7EFCF0F557E38B205C3B8FC5BE13BD0F29B99CB8CF4AC5A79E27FD6708891C85D417918C966AE447A14782C83B3E3CFCDE3B3AF20059B8C8CB71C67709573484F407FE9C46DC875825845D45013099BFC79579CAD5B92621C898F830711F69F07933C56D975448F574B106E15309AE73C6284175E6C096AE43388F1451A8ECE98384B912115FCD637C41D8FD2606DCB7244C53A5469C56DB87DA7378ACEDF12AC282959F4815853B323C3AC91DE499E47BB9D92D1D882EBC4057AB8DB63A75E3C4FD11B840CB4D49A75326F4AE4E178F52C203A763F9A08407A248FF1D38D384A944C08443A2046107CE6DB260D4FF0936F7D12FC0273C61ACAE2B6A8B6B8D17F8EA56443108B5B983656EC12C701DAF49E7998425598D26336FC6D5C9B1EB5CA370B2605042A1E68AB98A04A0B9208882E0962805826B1E903AD3926EC8D2FF0B69883D3C4BAE7345D69F80AFD4F3C4C547D7B9A46B088A37B9060F9CE2D143222512B0845C9317BA4AF533C461402092AE73072C5D96CF34CE0EC2285D7A4A03871B2E4514DE45AC20C9DF3FDD13B102850A472D8BF32811BEA1CCD8AB40B5156A29A77DA09612FE0FB52F05354308020B888473D4B090A59FEFA9966D193714B6052AF7856D81CC56D816981E02DB3329239FA63AD4715BC86F9A73C103679B3259244A23301A884C1A231651F2C4FDCEF24F07C3F250560CF3C4BD95E1D8AB59639F4DBC6915A108B6CAD0CFE94B58AB96738A77677E54658E145377CD740ECA0869E5E7A6EA96E94DF2229159E4B92B0DF29AA5068F123AB52D6DD032CF7F4F704B7D2B55BD812C8A70D658143A9AE9A569560B7ECB2056759297154A4541E5755454E32B12C798236A1556FEC69967E5D5F4DD7CF79223CC7878BE6CA93C4A6D4B4998F1C80A8C55145DE479CC2D6441742A9906A1B5AD01D90E3C15A21AA8B42355A0ACD8AE9F1BE7A2BD043239555EBC44C3424CDCA98D60C6DAA64B2B5CC28868B941A6114B42DE750B6DA3CEEE843A7DF6C6E630F60CC54D1F7996930CB09A2E1F1490FCF0BC4640B2CCB07B403AE8BE7440BA38346EE03AA3C6C2DB07B899AB5AA25C66E281A12CF7B706ACF518E994DB56111BD9DBF6CDA04867ACDAE2AD7D530ADE51A7FC3AD853A794C98E3A99F78A1D4EEB7A31B794602AAF19E33A19E7A9BDBF8BB7727DB6C57550F7177414E6F9F9462A08477AC368FE2B9B328AF0AD365C114E97205556DEBBD8431F1B33807F4E3FEE4919B0214DF99B372854BBB4B705E92BF1B7F424FC8508FF99886F42B2FEB6CEC9EE3B76EC2AFFD3BE1AD4A305F8ACFA7BB4DDFCBE3750B724527B735786EB8F5725A61635ABB199F100D613F7B794E8D499FDFC54D01D383702D3CBA973E8FCBE73342BB577135ED0ED207CBF66B6F532347B96FE2EF6C8BA836FF83902508173E66759764AA44F02DB63FA82DA2A3D6F154D158634BF7AB20C4B10FA2C1286F79854026F32ABE8B91594FB3426AC61B57D190FC920DAA4929FB9720E31709D1A6C038748DB567B94AC0DF7F639A07340D0039CB68AA5163A3B6AAD01FB9701677828DF1638DB0AC457074EFB64C9EEE6078C8EBA2747597D8877DA42A7A72C2B760C505AA74ADD43A536CEEDD39D76CE5D8AD7173B657498D03BD92A4752DB075C1DBD8F9DF0ADCEB877B0D530DBECD086CFB406195B0CCF7A8C6D6FAAEC2465CD65DECAD81D067876278527B4F6D5143384A4AB8A85FE86CAC16F9CCD72CF8C2FA32249181A155B8C42E60A14C1F2919C094597C457B8EC8394E9E78547C212DC72112E2098F19B44C5894293215CB0C6E70A9D6AB6C94FA7944D9DC73771FA25E0354C4035A9AE806FF80F096541A9F7654B2DD5C142E7B0BCD6D7B154BAE65F6D4A4ED7111FC828775F997AEF218C193293377C4E5E601FDD1E247C8215F1374543DCCDA43F104DB78FCF29590912CA9C47458F3F11C341B8FEF037DF50EBE43C200000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711250858282_PopulateGenreTable1'
BEGIN
    INSERT INTO Genres (name) VALUES ('Action'),('Horror'),('Comedy'),('Drama')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711250858282_PopulateGenreTable1', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EE336107D2FD07F10F4D416592B97976D60EF227592C2E8E6823809FA16D0D2D8214A512A4905F616FDB23EF493FA0B1DEA2E52B26423C8166D11209045CEFD703833FAEB8F3FC71FD721735E40481AF1897B343A741DE07E1450BE9AB8895ABE7BEF7EFCF0F557E38B205C3B8FC5BE13BD0F29B99CB8CF4AC5A79E27FD6708891C85D417918C966AE447A14782C83B3E3CFCDE3B3AF20059B8C8CB71C67709573484F407FE9C46DC875825845D45013099BFC79579CAD5B92621C898F830711F69F07933C56D975448F574B106E15309AE73C6284175E6C096AE43388F1451A8ECE98384B912115FCD637C41D8FD2606DCB7244C53A5469C56DB87DA7378ACEDF12AC282959F4815853B323C3AC91DE499E47BB9D92D1D882EBC4057AB8DB63A75E3C4FD11B840CB4D49A75326F4AE4E178F52C203A763F9A08407A248FF1D38D384A944C08443A2046107CE6DB260D4FF0936F7D12FC0273C61ACAE2B6A8B6B8D17F8EA56443108B5B983656EC12C701DAF49E7998425598D26336FC6D5C9B1EB5CA370B2605042A1E68AB98A04A0B9208882E0962805826B1E903AD3926EC8D2FF0B69883D3C4BAE7345D69F80AFD4F3C4C547D7B9A46B088A37B9060F9CE2D143222512B0845C9317BA4AF533C461402092AE73072C5D96CF34CE0EC2285D7A4A03871B2E4514DE45AC20C9DF3FDD13B102850A472D8BF32811BEA1CCD8AB40B5156A29A77DA09612FE0FB52F05354308020B888473D4B090A59FEFA9966D193714B6052AF7856D81CC56D816981E02DB3329239FA63AD4715BC86F9A73C103679B3259244A23301A884C1A231651F2C4FDCEF24F07C3F250560CF3C4BD95E1D8AB59639F4DBC6915A108B6CAD0CFE94B58AB96738A77677E54658E145377CD740ECA0869E5E7A6EA96E94DF2229159E4B92B0DF29AA5068F123AB52D6DD032CF7F4F704B7D2B55BD812C8A70D658143A9AE9A569560B7ECB2056759297154A4541E5755454E32B12C798236A1556FEC69967E5D5F4DD7CF79223CC7878BE6CA93C4A6D4B4998F1C80A8C55145DE479CC2D6441742A9906A1B5AD01D90E3C15A21AA8B42355A0ACD8AE9F1BE7A2BD043239555EBC44C3424CDCA98D60C6DAA64B2B5CC28868B941A6114B42DE750B6DA3CEEE843A7DF6C6E630F60CC54D1F7996930CB09A2E1F1490FCF0BC4640B2CCB07B403AE8BE7440BA38346EE03AA3C6C2DB07B899AB5AA25C66E281A12CF7B706ACF518E994DB56111BD9DBF6CDA04867ACDAE2AD7D530ADE51A7FC3AD853A794C98E3A99F78A1D4EEB7A31B794602AAF19E33A19E7A9BDBF8BB7727DB6C57550F7177414E6F9F9462A08477AC368FE2B9B328AF0AD365C114E97205556DEBBD8431F1B33807F4E3FEE4919B0214DF99B372854BBB4B705E92BF1B7F424FC8508FF99886F42B2FEB6CEC9EE3B76EC2AFFD3BE1AD4A305F8ACFA7BB4DDFCBE3750B724527B735786EB8F5725A61635ABB199F100D613F7B794E8D499FDFC54D01D383702D3CBA973E8FCBE73342BB577135ED0ED207CBF66B6F532347B96FE2EF6C8BA836FF83902508173E66759764AA44F02DB63FA82DA2A3D6F154D158634BF7AB20C4B10FA2C1286F79854026F32ABE8B91594FB3426AC61B57D190FC920DAA4929FB9720E31709D1A6C038748DB567B94AC0DF7F639A07340D0039CB68AA5163A3B6AAD01FB9701677828DF1638DB0AC457074EFB64C9EEE6078C8EBA2747597D8877DA42A7A72C2B760C505AA74ADD43A536CEEDD39D76CE5D8AD7173B657498D03BD92A4752DB075C1DBD8F9DF0ADCEB877B0D530DBECD086CFB406195B0CCF7A8C6D6FAAEC2465CD65DECAD81D067876278527B4F6D5143384A4AB8A85FE86CAC16F9CCD72CF8C2FA32249181A155B8C42E60A14C1F2919C094597C457B8EC8394E9E78547C212DC72112E2098F19B44C5894293215CB0C6E70A9D6AB6C94FA7944D9DC73771FA25E0354C4035A9AE806FF80F096541A9F7654B2DD5C142E7B0BCD6D7B154BAE65F6D4A4ED7111FC828775F997AEF218C193293377C4E5E601FDD1E247C8215F1374543DCCDA43F104DB78FCF29590912CA9C47458F3F11C341B8FEF037DF50EBE43C200000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711250902277_ChangeGenreVideoRelationshipToOneToMany'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [int]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711250902277_ChangeGenreVideoRelationshipToOneToMany', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED59D96EE336147D2FD07F10F4D416192BCB4B6BD833489DA4303A59102541DF025ABA768852944A52813D45BFAC0FFDA4FE422FB58B946CD998A5408B01060E79F77B7817FBEF3FFF9ABC5B47CC79052169CCA7EEC9E8D87580077148F96AEAA66AF9E67BF7DDDBAFBF9A5C86D1DA792AE9CE341D727239755F944AC69E27831788881C453410B18C976A14C49147C2D83B3D3EFEC13B39F10045B828CB7126F729573482EC0FFC7316F300129512761D87C064718E377E26D5B92111C8840430759F68F8613343B22B2AA47ABE5C8308A804D7396794A0393EB0A5EB10CE6345141A3B7E94E02B11F3959FE001610F9B04906E4998E6CA9C18D7E443FD393ED5FE783563292A48A58AA33D059E9C1501F24CF683C2EC5601C4105E62A8D5467B9D8571EAFE045CA0E7A6A6F18C094DD51BE251C678E4F45C1F55F04014E97F47CE2C652A1530E5902A41D89173972E180D7E86CD43FC2BF0294F196BDA8AD6E25DEB008FEE449C80509B7B58161ECC43D7F1DA7C9EC958B1357872F7E65C9D9DBACE0D2A270B0615141AA1F0552C00DD05411484774429105CCB802C9896764397FEBFD486D8C3B7E43AD764FD1EF84ABD4C5DFCE83A57740D61795258F0C8293E3D645222054BC90D79A5ABCC3E431D260462E93AF7C0B26BF94293FC218CB2ABE722E357228EEE635672E4C7CF0F44AC40A1B9B17DE7C7A9080C4B265E8DA8AD38CB041D82B38CF17F9C7D299C194A105540245CA085A52EFDF9816ADD967343315B40F230C896B0EC826C09E721903D97320E68664013B385F2B627973C74B65892E7A0B21FF38098A409A210F54EDDEFACC874CBAB1E632DAF88445BDEF1687462FAD8F0C67E97D86215A108B4DAD10FD921AC55C71BC5A6593C5359A0C4B45E0BF54135D38925A88E73DB7ACBF9367B59C12CF62298067BC3534346899B064507ACCC97BF3DB795B1B59DDE300965361B12CA409965A5ED520776AB04D6C391974F47E514E5F58C51936B9224581B1A635571E2F8F94C357BE3EF3F6744B90C2F901DE346656DA5092B1D5981718BAACBFA8E35852C882E21B330B2C85A70EDC152A9AA85483B5125C24A72FDB9F526BAE71E53521DC52B742CC2829DF90866AE6DBE6CAC258C888ECE318B591AF1BEEEB38D3BEF054DFEFCC49630F10CC3CD187956900CB09A211F9490E2ED7C8C84E45561FF84F4F07DE984F4496875DEA6A0D6C5E74F70BB567564B9ACC2033359920F4A972EB55DF36FBBE4DA311994E15C46579E754C2ABDFB9954F491034DDADB18AC9221CD469AB9D4E359359A0D71D46C4476FEAD7E649254E8ABFA92D17F26452FD8BDEB5BCD2127711DF4FD15238C8DC1DF4805D148138CFCDFD88C51C47B4D704D385D8254F91EE0E2A67D6A7C53F0EFD9DA3D2943366475FFEC9B0CD521DDB9ABECDA05B62C2FFC9588E085886F22B2FEB629C95E50F65C3FFFD3B11AB4CC85F8590D5AE6BA56B867C3736B9398F310D653F7F78C69ECCC7F792EF98E9C5B814F74EC1C3B7F1C96F3C3F6B74673DA6FC5B2E7FC43163F041A088D03C2B0864A25B08A5A1DFA0E97F9802684B56CB65BC810F4EAF855F2CC9B0B48806B58B6DC1AA2685BAFACA41ACF6897EF7B2EB1F6F230604BED5F52F3EE822F62A1139B83B1675FEB5C60FBF7D72EC9DDBBE427DC6D5BDE3716949DDBACBD027F9AFDD59E0B10318D5F0A10AC92AE6A117AD4E110B4B052D1CCF9322E416B58549218F5EC1A14C16248CE85A24B1228BC0E40CAEC5BB527C25224B98C1610CEF96DAA9254A1CB102D58EB5B3A0DFD6DFAB325BD6DF3E436C9BE01FB182EA09954D7F35BFE634A5958D97D65D7F33E11FA4D159D4BE752E90EB6DA54926E623E505011BEAA143C40943014266FB94F5EE110DB1E25BC87150936E578D72F647722DA619F5C50B2122492858C9A5FFFFAE5E99FBFDEFE03F85E12F8301B0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711250907071_AddClassificationPropertyToVideosTable'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [int] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711250907071_AddClassificationPropertyToVideosTable', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED59DD6EDB3614BE1FB0771074B50DA96527375B60B7E8DCA4305627419414BB0B68E9D82146511A4905F6863DD92EF6487B851DEA5FA4E4C846DA0ED850A0B0489EC3F3F39D3FE6EF3FFF9ABED946CC79022169CC67EE6434761DE0411C52BE99B9A95ABFFADE7DF3FAEBAFA61761B4753E96E7CEF439A4E472E63E2A959C7B9E0C1E21227214D140C4325EAB5110471E0963EF743CFEC19B4C3C40162EF2729CE96DCA158D20FBC0CF79CC0348544AD8320E81C9621D77FC8CAB73452290090960E67EA4E16FBB391EBBA442AA878B2D88804A709DB78C1214C707B6761DC279AC884261CFEF25F84AC47CE327B840D8DD2E013CB7264C53654A9CD7C787EA333ED5FA783561C92A48A58AA303194ECE0A037926F95166762B03A2092FD0D46AA7B5CECC3873DF0317A8B979D3F99C097DAAD7C4A38CF0C4E9D93EA9E08128D2FF4E9C79CA542A60C6215582B013E7265D311AFC04BBBBF817E0339E32D69415A5C5BDD6022EDD883801A176B7B02E345884AEE3B5E93C93B0226BD0E4EA2DB83A3B759D2BBC9CAC1854506898C257B1005417045110DE10A54070CD0332635AB71B77E9FFCBDB107B184BAEB324DB0FC037EA71E6E24FD7B9A45B08CB9542827B4E31F490488914AC4BAEC813DD64F219D7A1432096AE730B2CDB968F34C90361946D3D141EBF1471741BB392225F7EB82362030AC58DED3D3F4E45604832F56A44EDC559C6E8189C6584FFE3EC4BE1CCB804510544C23B94B0BC4BFFBEA3FA6E4BB9FDBCE68C4849D73428725B21BA46AAB9F51CE7DE6828C07E5C309480EF0A8632508605431A3542C1546E212F19D9D455E8F01869737CF16041888420D80E21D50473DB054B8856200A157DCAB08D709D8F84A5F839B11CD63AFD3E666175F674FFD91BED48B46775FECCF6416EEDE6E25B29E38066D669E6A3C2FDEDEB2E78E8ECC1420DD222A52DD1843441A3A1E767EE7796F8DDFCAA445BF32BB0D8E6371E8D26A6860D6DEC9C8BED93229457062BB0C0156C5507B6B0212AE0258B0C604AAF99FAA09A0185E5A5467A5B7A4BF93679599D2CF2C29806794353834719B98D131D816D66F5FDBEAD84ADE5F4867128BDD9E0501ACA2C196D953AB247E5C0BAF1F5F2CEB7EC90BD9E1679BA24498241DA68998B15C7CFFBE5F92BFFF01E32CA797881EC68252B69AB9BB08A910D18BB7875998EB05E9015D1896E1E46D6B1165C7BB0545ED542A4EDA81261E571FDBB1513DD3DADC9A9B6E2252A166131CE7404D3D7365D36B21046444757308F591AF1BECE621F755EE79BF4F98ACD61EA19829B36F22C231960354D3EC82145ECBC8443F2AC70B8437AE8BEB443FA38B4BAAA26A3D6C6707E6687D16469EE7D7ED8B433600776CADC3E101FE5F14120D009BC6B626A2772DB26837093F3E8428FB64975EF612215D5E948910E1606736F48B346692175DB5DB5A5431435CB9BED7FABCA99472AF455D5CEA86AD3A2C23CFF3A64959CFC88EBA0EE4F68612C37FE4E2A8846FAC0C8FF95CD1945BCD7079684D335489537C3EEE978726ABC2DFD7BDE793C294336E4B1E7B3CFBE549BF4D9E9F6C0E9B139EEF22722824722BE89C8F6DB26277BA43DF0C1E23F6DAB41E37F88BFD5CB8DFF99FE0772AAB351838735E92C7088DDCEDCDF33A27367F1F3434977E25C0B0CF67367ECFC711C7A8E9B2F1B65EEB011D09E438E194C11B22034A208C36C2C71FEA776ADBF1194073421AC25B35D8C86C481B65FC5CFDC790709700DF0965A432EDA57752BAE46403EA7FB8143B63DDC0C98A2FB87E8BC4E616CADB4637330F6CC939D0376FF7CDDC5B97BD6FD84B3774BFBC600F5ECB46D8FE89F66BEB63B0C444CE3AF5408564937350BDD3471085A58A9CE2CF83A2E416B48541E31F2D91214C1B44ADE0A45D72450B81D00E64AFDA25BBC7A5D442B0817FC3A5549AA50658856ACF542ACA1BFEFFEEC11A12DF3F43AC9DE485F42051493EACA70CD7F4C69E375EFD2CEE77D2C744C153550FB52E95AB8D9559CAE623E905161BE2A15DC4194306426AFB94F9EE018D9EE257C800D097665A3D8CFE47947B4CD3E7D47C9469048163C6A7AFC440C87D1F6F53F16E4E860AC1D0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711271622032_AddCodeFirstOverwrites'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.Videos_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[Videos] DROP CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[Videos]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[Videos]
    EXECUTE sp_rename @objname = N'dbo.Videos.Genre_Id', @newname = N'GenreId', @objtype = N'COLUMN'
    DECLARE @var0 nvarchar(128)
    SELECT @var0 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.Genres')
    AND col_name(parent_object_id, parent_column_id) = 'Name';
    IF @var0 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[Genres] DROP CONSTRAINT [' + @var0 + ']')
    ALTER TABLE [dbo].[Genres] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    DECLARE @var1 nvarchar(128)
    SELECT @var1 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.Videos')
    AND col_name(parent_object_id, parent_column_id) = 'Name';
    IF @var1 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[Videos] DROP CONSTRAINT [' + @var1 + ']')
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    DECLARE @var2 nvarchar(128)
    SELECT @var2 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.Videos')
    AND col_name(parent_object_id, parent_column_id) = 'Classification';
    IF @var2 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[Videos] DROP CONSTRAINT [' + @var2 + ']')
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [Classification] [tinyint] NOT NULL
    DECLARE @var3 nvarchar(128)
    SELECT @var3 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.Videos')
    AND col_name(parent_object_id, parent_column_id) = 'GenreId';
    IF @var3 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[Videos] DROP CONSTRAINT [' + @var3 + ']')
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [GenreId] [int] NOT NULL
    CREATE INDEX [IX_GenreId] ON [dbo].[Videos]([GenreId])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711271622032_AddCodeFirstOverwrites', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED595F6FDB36107F1FB0EF20E87148ADD841812DB05BA44E5218AB93204E8BBD05B47476885194465281BD619F6C0FFB48FB0A3B4A942C9192631B49D6014580C026EF1FEF7E77BCA3FFF9EBEFE1FB55CCBC471092267CE4F77BC7BE073C4C22CA97233F538B373FFAEFDF7DFFDDF0228A57DE9792EE44D321279723FF41A9F4340864F8003191BD98862291C942F5C2240E48940483E3E39F827E3F0014E1A32CCF1BDE665CD118F22FF8759CF010529511364D2260D2ACE3CE2C97EA5D9118644A4218F95F68F4FB7A8C64975448757FB102115209BE77C628417366C016BE47384F145168ECE96709332512BE9CA5B840D8DD3A05A45B10A6B9F2439C6EC8773DCFF1409F27D83096A2C24CAA24DE5360FFC43828B0D90F72B35F39105D7881AE566B7DEADC8D23FF23708127B7359D8E99D0549D2EEEE58C475EC7F651050F4491FE3BF2C61953998011874C09C28EBC9B6CCE68F833ACEF925F818F78C658DD56B416F71A0BB874239214845ADFC2C29C6012F95ED0E40B6CC68AADC6531C6FC2D5C9C0F7AE50399933A8A05073C54C2502F0B8208882E8862805826B19903BD3D16EE9D2FF4B6D883DCC25DF9B92D527E04BF530F2076FDFFADE255D4154AE180B3E738AA9874C4A64D062A1A5F58A3CD2656EB0A51F230489F4BD5B60F9B67CA0699119BD7CEBDE40E05224F16DC24A8E62F9FE8E882528B43F71F766492642CB9261B081D856E0E5820E015ECEF80D785F0DF02CAD08332012CED1E452B9FE7C47E3FD65E5307BDA65DB858C1991922E68684AA87188C6BFBD75708E99143A2CC5CA346A4BB132FD764BB12CAE25987DB889BC6464B9B9ECF6CFBCA6C4674F41045E0482AD11A8851D1FD688A16604A610CF419813CE28C366C5F7BE1096E1D7BE13AF06F5C7844515ED603BED8D8E23BAB3A23F71435038BBBE78266512D2DC39F52267A2DF5477C1236F0B1436183575728A1EA429FA0C033FF27F70CC6F975755EF8D3C03C5A6BCBE6F97BB6B7E8E89ACC03B0B8BC6654C6448223727D0135173052B24085DA208C35E4E62C029576E39A53CA42961DD565B2C3BD6606D5225DCDE398714B82E9FDDBEDF456B55975CD59506CB4B4F396518D4D0E35E9CC8A390A302A8493DAE60A55A5219DB5C93CDD294711B2D5AE80C54FD40D8236C0A4B132D0ED89AEC658BE1B01BF05AECB5935A32CA4259A368A9A3B6D3B7E75265ECC64E276CDBB3A726A174949D04CD23B514EB2A809B712628E69972EE093A069FE194A429D6C4DA206456BC5931058DDFCCF69F0CE2424610CA9601A1B2B6D284AD085982B58BAACBEA8F773C99137DAF8CA3D8216BC0B5034BA5AA0622DD4095082BC9F5E7464EB44F2A2D796D245CE2C1625D12F276CB8EB5CB970FA28411D1D2DA8D1396C5BCBB34757317CD5A9DBF5871250C03CB70A706394E722A76D3E53B05C4E4CE7304A4A80AFB07A483EFBF0E48978446275C17D4D8D85D5E75EBD465755E45DD72ECC6B02ECEDE7B65F839D5D226A9B45755D3AA8E4353A99E7E3B724A5741E27BE8AE47441A96ADD95A2A887B9AA037FB8D8D19C5F36E08A684D3054855F4B0FEE0B83FB05E9EBE9E57A040CA88EDF214F4EA8330D52E7D72D4DD73E8ABCFBEFC9188F0810877FADD2A74CF978C6F7EEB14DAF22410E167F50C4F02B9139CF677821DF86AE4FF91F39C7A935FEE0DDB91772D30714FBD63EFCF677A48C039719D5B7110980E1B194D97FCAA539DD5221F32A31E341876756F2F330BFE4FC63FB7EDDE61BEEB1EEF8A9B0FB372AEE35A80B863D2691DFDBA27BF36C9ED53D80B4E858DD3D75AFB27E74077787C99C9CFED591031B55FC510AB922E3722F46F641CC206562A9A095F2425662D8B4A12ABB04D41112CC8E44C28BA20A1C2ED10B0D4E90763F3FE7511CF219AF0EB4CA599C223433C678D07680DFD6DFAF3F1B669F3F03ACD1F4B9FE3086826D577CA35FF90D1DA3BDF654B29EE10A173CADCA43A964ADFA8CB7525E92AE13B0A32EEAB4AC11DC4294361F29ACFC8231C62DB67099F6049C275D97A760B793A104DB70FCF29590A124B2363C38F5F11C351BC7AF72F42900B641C1E0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201711271636090_AddTagRelationships'
BEGIN
    CREATE TABLE [dbo].[Tags] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Tags] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoTags] (
        [VideoId] [int] NOT NULL,
        [TagId] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoTags] PRIMARY KEY ([VideoId], [TagId])
    )
    CREATE INDEX [IX_VideoId] ON [dbo].[VideoTags]([VideoId])
    CREATE INDEX [IX_TagId] ON [dbo].[VideoTags]([TagId])
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Videos_VideoId] FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Tags_TagId] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201711271636090_AddTagRelationships', N'VidzyCodeFirst_Exercise.Migrations.Configuration',  0x1F8B0800000000000400ED5A5F6FDB36107F1FB0EF20E8691BD2284E50600BEC16A9930CC19A3F88D3626F012DD10E318AD2442AB037EC93ED611F695F6147899225FEB125C749BBA22850C424EF78BCFBDD1D79A77FFFFE67F8761153EF11679C246CE40FF60F7C0FB33089089B8FFC5CCC5EFDE8BF7DF3ED37C3B3285E781FAB7547721D50323EF21F84488F8380870F38467C3F266196F06426F6C3240E5094048707073F0583418081850FBC3C6F789B3341625CFC809FE38485381539A29749842957E3303329B87A5728C63C45211EF91F49F4C7720CCBCE49C6C5FDD9026721E1D8F74E284120CE04D399EF21C6128104087BFC81E389C812369FA43080E8DD32C5B06E86A8A42A0E71BC5ADEF53C0787F23CC18AB06215E65C24714F868323A5A04027DF4ACD7EAD4050E119A85A2CE5A90B358EFC9F31CBE0E4FA4EC7639AC9554E15EF17847B9E637AAF8607A048FEDBF3C639157986470CE7224374CFBBC9A79484BFE0E55DF21B66239653DA9415A485B9D6000CDD64498A33B1BCC53375828BC8F782365DA013D6640D9AF278174C1C1DFADE156C8EA614D75068A86222920CC3717186048E6E9010386392072E9469ECAEED25FFAF7603EC812FF9DE255ABCC76C2E1E46FEE1EBD7BE774E1638AA4694041F1801D7032291E5D822A1B6EB157A24F342606D7FB0104EB8EFDD625A4CF30792969EB15F4CDD2B089C67497C9BD08AA21CBEBF43D91C0B903F31E726499E859A24C36005B1B5C02B186D03BC82F02BF03E1BE069BB02CC30E2F81444AE36977FDF91B83FAF02669B55B69EC99822CEC98C842A842A8548FCEB535BFB9872A1ED5CAC72239B8B55EED755903B345FE7EAE5B42E861C7548514CD984E8ECE7C0611B2F07B2AF3EFE641F873F3BF9F8CE72C91A80D933490B7BDD0096C70D78E92E7CC1CF29B0AC0FDA1F796D8E3B0721A83EC2195D82A94A39DE2D2152B6F57F89E329CED4092784C295DCF73E229AC3CF8161ADD6EA9F131AD56B0FD7AFBD91460475D6EB8F4C1394CA6E0E9E709E84A4504E13152AC6B5B73B6391B726E0AD22B1BA0D5C8206490A3A03C38FFC1F0CF1EDFC6A64ADF8A980DBE637F07587BF66A790AE04F64EC2F27A3E463C4491E911A089A83D02310267D2491185170B07831326CC804258485244DD526B241DA39014A966AECF9CE214331940DCBAEFB26B9D7DCDADEB1D342D6D52CA3068A0A70BA88A78B21E03EDECF56448B563D58A5D91C7D632731EAE0C64A01001EAA8BD4FC51526F04258E214BC5455A8E22A4AEB724BA6132C9AD682D8BB8A9A6D57308EDD26AF22BB41AED4B881BC8CFB0671A1348DB4A1246DFBEA9AD45861B945E9605C1F636A41574734E0BC3EAA3438543AD68343FB489D8F5B2ACD755A13FA9BC0BFCD595B706F302865EB7CD02A5BD7205F556D82B26C53957702477D677889D2149262A3DEA346BC4959EC19BF9AF42F80C4258F20E4963A482D6DBD13DCC6D01C6BB3B07595FEE12983A6485E2CC6516C2C6BB9B4C361AAAD5A5E6B5AA972A46AB9FCBB1537EC05194B60571CCEE160B1CC09C58D5307B54957D4DB104599E5763B4E681E33776E725397F7D5267D39627218069AE04612329464A4ECB6CA3B194439CE2E0C5246CEFE0671D07D6A83B838B41EFC4D46AD89EEFCEA6B479397F32EE2E6A3BF0C9AECF4B9CF067E8EA0DF1F7C32F3F6879E95EA5303EFB94DD14E6A9670A01275478F57ABAD5E6DD1AFCCC8B657762BB59B3AE964918291FD06DFD8B59740CE574B278180453F71F42B876940E3E6A12FA9E153DF40B49BC65065FDCDED26E31A502EF13D90FD1174045780C9920B1CEFCB05FB93DFE9981200EC6AC125626486B9280B02FEE1C1E0506B567D3E8DA380F38876E91EBD785D8D48956EAC9CF5AC13374B69EC1165E103CACC82F95AA63D9B1F5FF5E6646AE92244F0B7D84117A15082F1DCBE60115E8CFC3F0B9A63EFE2D77B45B6E75D67E0B8C7DE81F7D78E7A0F82B06521C56EC06424952F0A4ADFC568F17D939359B1EEE7765BAACB9D4BCDB5D634B759BBF516FD80AAC89E04542571BF8D0BA21EDBBAECB45D4559158B5EB4E8AB554FB6A9376E553776BDED9FA754FCBFAA0E5BAFC8FD0DF59C3029AAA0BA009BEBC94F6A32BC1858EC0FCD3EF1F385F1627BC1342CA61BCB62A72F082B5DADF79248713E12778E137B63C62CF63A4A37ED8F3F5C8D97F28D08F7D7A90C436572743412AC4D19774FC6C6D95EF8B7F56B5CED1A1B576B37C02AAD9DF16ACA29B3758BE7EB15B58CD6A8836FEC98986D969DF683EA66CEBAB690A32CD45F5447FCB195AD767AC8AAE1B4F690F652931EAAB5EAE54B1CB047B3CB2C2D41B86A7CEF0C919293F98A85FCFA99E1B015A8EA35176C9654E15293A85AA25DEB2FB140F06E4627992033140A980E31BC48E56742EA9B8FB3788AA30B769D8B341770641C4F69EBB3231977D7ED5F74F4DA320FAFD3E2EBA05D1C01C424F2E97FCDDEE5A4F16DCBB9E57DE1602103BA7AA54A5B0AF95A9D2F6B4E5709EBC848A9AFCE4377384E2930E3D76C821EF136B27DE0F83D9EA370595508DD4C361BA2ADF6E12941F30CC55CF158D1C34FC070142FDEFC076618BFB9F62F0000 , N'6.2.0-61023')
END
