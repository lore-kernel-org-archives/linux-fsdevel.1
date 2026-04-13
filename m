Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F740DFAC;
	Mon, 13 Apr 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049594; cv=none; b=RreGHhK7AxwXri7x2RRRH3UMhN/jtPtygGHeLuiQRPgbsME6CKezDip5uRUuwgfYFHREswzANxyF70hiYINWdb2XtiDf9ieBKLE5AAs6l/XmU3K183RGu3PLzMK44YIVGGgI7Ww8uVWoWXqCtwtGbJS/MOhbjJx+mnpeA3qhrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049594; c=relaxed/simple;
	bh=+2JRl8xDuf4Nre+/kufJVQfy+GigkEdIL7MdbWXRXJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwIJT+E+0zH1KwyXG0BZ1JD+jxAiIsNjxTkdtdn/ghqrX5+1jhOpuOQz/jvy/5vB38rDX68C7GqGmZkBbJUp4lMYxU9Tfdhhc14K260fSw4GOGld83gKI1P7g7xD4lBZY214hxxUgcu9Bxn4m6Pp5kF1HAK3iui6q958VL7QMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=MD0vMWkA; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=tYdXQ4dW; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="MD0vMWkA";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="tYdXQ4dW"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A2FCD2096798;
	Mon, 13 Apr 2026 12:06:23 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1776049583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVkxsvDNZZ/6hMZFcuU6ezDCIK/Fw98fh0XXxB6tcoU=;
	b=MD0vMWkABEEDBa7bkOFbAK2a7CixUAscjEXusNUPLzxGNVva4mv0i2frB1CHLKwWUBGOaO
	Nu8O9WEaSf8+LHhbjttPOElo9swTzMYUp3qU0fStw6tx/B9VWc8WVCepRP55ECkcVaSC0j
	z7WrHmPfy7i7IKHrwbiq48pDJWyDQ88ubcunz3Am2/agFR14XVXfuCPKKpRw4ItYVuV/I7
	xCwN4Em8lJdeBMbPmV7oKCXymBaY53SZFIPCTFNsHvrZdP4RyDyMfLwXYjipjWVzH2h5jg
	hoxceS96Let+lMQgahYuR1ooLFbGHdp7HioDpKAf8h3pkiFYe9QQBJBPn6uORA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1776049583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVkxsvDNZZ/6hMZFcuU6ezDCIK/Fw98fh0XXxB6tcoU=;
	b=tYdXQ4dWx40XBlnWNQMvWs/NVaRfacHs2q1Jh1IQiLST2GszKl0r3iGsHL4U3Sq+QODVrF
	oyqsNeO2/3aOjnAA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 2DA4DE00134;
	Mon, 13 Apr 2026 12:06:23 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 11EA3220014E; Mon, 13 Apr 2026 12:06:23 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kunit: fat: test cluster and directory i_pos layout
 helpers
In-Reply-To: <87y0j2m1d0.fsf@mail.parknet.co.jp>
References: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
	<87y0j2m1d0.fsf@mail.parknet.co.jp>
Date: Mon, 13 Apr 2026 12:06:23 +0900
Message-ID: <877bqbeez4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

Hi, Christian. ping?

> Adi Nata <adinata.softwareengineer@gmail.com> writes:
>
>> Add KUnit coverage for fat_clus_to_blknr() and fat_get_blknr_offset()
>> using stub msdos_sb_info values so cluster-to-sector and i_pos split
>> math stays correct.
>>
>> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
>
> Looks good.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Thanks.
>
>> ---
>>  fs/fat/fat_test.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
>> index 1f0062659067..add44178f28e 100644
>> --- a/fs/fat/fat_test.c
>> +++ b/fs/fat/fat_test.c
>> @@ -20,6 +20,37 @@ static void fat_checksum_test(struct kunit *test)
>>  	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
>>  }
>>  
>> +static void fat_clus_to_blknr_test(struct kunit *test)
>> +{
>> +	struct msdos_sb_info sbi = {
>> +		.sec_per_clus = 4,
>> +		.data_start = 100,
>> +	};
>> +
>> +	KUNIT_EXPECT_EQ(test, (sector_t)100,
>> +			fat_clus_to_blknr(&sbi, FAT_START_ENT));
>> +	KUNIT_EXPECT_EQ(test, (sector_t)112, fat_clus_to_blknr(&sbi, 5));
>> +}
>> +
>> +static void fat_get_blknr_offset_test(struct kunit *test)
>> +{
>> +	struct msdos_sb_info sbi = {
>> +		.dir_per_block = 16,
>> +		.dir_per_block_bits = 4,
>> +	};
>> +
>> +	sector_t blknr;
>> +	int offset;
>> +
>> +	fat_get_blknr_offset(&sbi, 0, &blknr, &offset);
>> +	KUNIT_EXPECT_EQ(test, (sector_t)0, blknr);
>> +	KUNIT_EXPECT_EQ(test, 0, offset);
>> +
>> +	fat_get_blknr_offset(&sbi, (10 << 4) | 7, &blknr, &offset);
>> +	KUNIT_EXPECT_EQ(test, (sector_t)10, blknr);
>> +	KUNIT_EXPECT_EQ(test, 7, offset);
>> +}
>> +
>>  struct fat_timestamp_testcase {
>>  	const char *name;
>>  	struct timespec64 ts;
>> @@ -181,6 +212,8 @@ static void fat_time_unix2fat_test(struct kunit *test)
>>  
>>  static struct kunit_case fat_test_cases[] = {
>>  	KUNIT_CASE(fat_checksum_test),
>> +	KUNIT_CASE(fat_clus_to_blknr_test),
>> +	KUNIT_CASE(fat_get_blknr_offset_test),
>>  	KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
>>  	KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
>>  	{},

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
