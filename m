Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB922D838E;
	Wed, 15 Apr 2026 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221906; cv=none; b=EEUUktSFkHwJjvuiHfWy+jyIFSkB8SN5OWgxcz4PBpYAPyUuW4rSvlyhkfsDMkS/bH3dfhzuebOi33jvP6UUvENlR65ZVcI6qdbD/NagGy3PXGp/DWWWRt4PmFsxBapcQ/7XYAWlVeWhkqLGG0fXqtZJsGrM0hX6MA/0i2BCqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221906; c=relaxed/simple;
	bh=6M/sAdW+9G5R+hwDDE20ol7QiRqAeANDRQH6XMJ92Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HX6YWX1bwSoTzoMmlVJohE49sfNwTtyRMNQiyycO9D+AOQvPdl37nWnEHFCLCgWK6jlSw7Y2mDQEanGjszG4G+qVqlAaVrAGkBGooOR6NHKzP9WlV+vaqtwNQVsEfucgJkuWqky/vxzSj6h7drz2sFkaybdsWXHtm0vOnEjpqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=CUJjsgQL; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=nIVri6hc; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="CUJjsgQL";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="nIVri6hc"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 269BA26F765C;
	Wed, 15 Apr 2026 11:58:17 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1776221897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxQlHcqZxZbErS0d/bsw83U9/zolydbv+FDCOT2YcKM=;
	b=CUJjsgQLwXOA8iXxTSKk2SAM/C+VXT6NP34JwTTqidjw6o8Q7LNyLibC2iaS1TZ48oz4bt
	tdQF3DFPBqHpUCWSSDj4opyzBUJLzgdbgUFPOk1tJ963mFZJkbRjLa+3b39TAWYJD6yVBX
	JpKpdCCovsGn1OoyHq3JOwaUAaDak+SMjg8RlPvvWN7IgA865HWltNiMZhsYAchdJz497f
	hDq12rX7N50pfN6RE8ltLgymg7anuW3eu/Hr8wmn0uBGQ6TRNCsOGZa7iiMU49NaRxvuLv
	DkqhDsJLXQ+Xm0ZsHEZwRWuJ50XTvruSFCtJR9yXI+dW+1Lwbw75PhkcrqbD8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1776221897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxQlHcqZxZbErS0d/bsw83U9/zolydbv+FDCOT2YcKM=;
	b=nIVri6hcM8qIvO1oc108EFl6lzaUsAvnG521Katdjqt5Z3a2N6kN3gCb5NQm/GwtAfPpiG
	9LUBz7FSd8x3S+DA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id A14A6E000C8;
	Wed, 15 Apr 2026 11:58:16 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 992802200152; Wed, 15 Apr 2026 11:58:16 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kunit: fat: test cluster and directory i_pos layout
 helpers
In-Reply-To: <877bqbeez4.fsf@mail.parknet.co.jp>
References: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
	<87y0j2m1d0.fsf@mail.parknet.co.jp>
	<877bqbeez4.fsf@mail.parknet.co.jp>
Date: Wed, 15 Apr 2026 11:58:16 +0900
Message-ID: <877bq9lyk7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

ping?

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
> Hi, Christian. ping?
>
>> Adi Nata <adinata.softwareengineer@gmail.com> writes:
>>
>>> Add KUnit coverage for fat_clus_to_blknr() and fat_get_blknr_offset()
>>> using stub msdos_sb_info values so cluster-to-sector and i_pos split
>>> math stays correct.
>>>
>>> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
>>
>> Looks good.
>>
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>>
>> Thanks.
>>
>>> ---
>>>  fs/fat/fat_test.c | 33 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>
>>> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
>>> index 1f0062659067..add44178f28e 100644
>>> --- a/fs/fat/fat_test.c
>>> +++ b/fs/fat/fat_test.c
>>> @@ -20,6 +20,37 @@ static void fat_checksum_test(struct kunit *test)
>>>  	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
>>>  }
>>>  
>>> +static void fat_clus_to_blknr_test(struct kunit *test)
>>> +{
>>> +	struct msdos_sb_info sbi = {
>>> +		.sec_per_clus = 4,
>>> +		.data_start = 100,
>>> +	};
>>> +
>>> +	KUNIT_EXPECT_EQ(test, (sector_t)100,
>>> +			fat_clus_to_blknr(&sbi, FAT_START_ENT));
>>> +	KUNIT_EXPECT_EQ(test, (sector_t)112, fat_clus_to_blknr(&sbi, 5));
>>> +}
>>> +
>>> +static void fat_get_blknr_offset_test(struct kunit *test)
>>> +{
>>> +	struct msdos_sb_info sbi = {
>>> +		.dir_per_block = 16,
>>> +		.dir_per_block_bits = 4,
>>> +	};
>>> +
>>> +	sector_t blknr;
>>> +	int offset;
>>> +
>>> +	fat_get_blknr_offset(&sbi, 0, &blknr, &offset);
>>> +	KUNIT_EXPECT_EQ(test, (sector_t)0, blknr);
>>> +	KUNIT_EXPECT_EQ(test, 0, offset);
>>> +
>>> +	fat_get_blknr_offset(&sbi, (10 << 4) | 7, &blknr, &offset);
>>> +	KUNIT_EXPECT_EQ(test, (sector_t)10, blknr);
>>> +	KUNIT_EXPECT_EQ(test, 7, offset);
>>> +}
>>> +
>>>  struct fat_timestamp_testcase {
>>>  	const char *name;
>>>  	struct timespec64 ts;
>>> @@ -181,6 +212,8 @@ static void fat_time_unix2fat_test(struct kunit *test)
>>>  
>>>  static struct kunit_case fat_test_cases[] = {
>>>  	KUNIT_CASE(fat_checksum_test),
>>> +	KUNIT_CASE(fat_clus_to_blknr_test),
>>> +	KUNIT_CASE(fat_get_blknr_offset_test),
>>>  	KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
>>>  	KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
>>>  	{},

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
