Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC781E531;
	Fri, 17 Apr 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400480; cv=none; b=i8Ar9qTJbXM9Vjhte76CQql/6walzh2qlOOy52Nls/7QUzdY3aCJKc8NhgXVSpJ3qbPhXHxRo2Naxcqo6gTTATm6Larm5ZH/QrUZ0aBEVB1iqcriNUpWttd2PCmpk+ebKB3gUl4BcGgnxyGUziurc4UAJXq2eMl+5j+0FI+1yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400480; c=relaxed/simple;
	bh=dagQ6S0i1yQpLfDpdyFmyhlqwf1damBZTtng4/dDEuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnquaw5OrCNrpEO7R5Hv1sjLbUy06kRsdplXPwMGzZW2whpUQSVKCtrDtt2Rhn7dybrxQj5PlYPIHPUHm3g5UOK0JdQpvQRn9gdWUgSfNqo/yLbfPid966xqjwgC9PraKOIfwe8CGl2sBm7gk8ADL+TBuZ3WSpXJeLEtxMGF+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=AvFLHdiw; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=m8BJwqw/; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="AvFLHdiw";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="m8BJwqw/"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 8E5FF26F7658;
	Fri, 17 Apr 2026 13:34:25 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1776400465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QO3qfsoJUEfYPew2T8tSjN/8FJWVNRZPRU2EQd0KMow=;
	b=AvFLHdiwoBVyY7DDEimPUgqEWgozouCgnexXW8ceo0km0mOxOwFvKfqpZ2MT3ST/GZ+osG
	/fbpeucKJxhR7d1iIxvHAHNXM9vwYz0eZIKNk7JhZhOrGyzsATAq/J0uTp3bKRE69tA1rV
	tbi6rF5BewF35KiZdEmQD1gkUvnzIGC8wiI0Vv88oegCpj2AZulVpCgNRqGztEfNfcxWdM
	T7cL+tetN31oNMZIJRqcSXff/MtGSdzykfGzbOT+wkq+TqLx7MmXMb/vEoBuHIjnl57Yqr
	Xre4LT2YUfqs+J3PvkDL+TFW4DW4T3SrfRy5TArtvgzAQJhi5AVw1XFFzHeQGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1776400465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QO3qfsoJUEfYPew2T8tSjN/8FJWVNRZPRU2EQd0KMow=;
	b=m8BJwqw/cwFVZGnzXhSccfQW8zggc0/x9NmAK6UBdn2wFvhWJkyvQ4/G/evQPDEnvAn2Lj
	W5Du3Wsf1emu7eDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 9E527E00187;
	Fri, 17 Apr 2026 13:34:24 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 8FC1F22001B2; Fri, 17 Apr 2026 13:34:24 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Adi Nata
 <adinata.softwareengineer@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kunit: fat: test cluster and directory i_pos layout
 helpers
In-Reply-To: <877bq9lyk7.fsf@mail.parknet.co.jp>
References: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
	<87y0j2m1d0.fsf@mail.parknet.co.jp>
	<877bqbeez4.fsf@mail.parknet.co.jp>
	<877bq9lyk7.fsf@mail.parknet.co.jp>
Date: Fri, 17 Apr 2026 13:34:24 +0900
Message-ID: <87mrz25hnz.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

Hi, Andrew

Could you pick fat patches again? Christian's path didn't work for fat
(no response for 10 days).

Thanks.

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
> ping?
>
>> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>>
>> Hi, Christian. ping?
>>
>>> Adi Nata <adinata.softwareengineer@gmail.com> writes:
>>>
>>>> Add KUnit coverage for fat_clus_to_blknr() and fat_get_blknr_offset()
>>>> using stub msdos_sb_info values so cluster-to-sector and i_pos split
>>>> math stays correct.
>>>>
>>>> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
>>>
>>> Looks good.
>>>
>>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>>>
>>> Thanks.
>>>
>>>> ---
>>>>  fs/fat/fat_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
>>>> index 1f0062659067..add44178f28e 100644
>>>> --- a/fs/fat/fat_test.c
>>>> +++ b/fs/fat/fat_test.c
>>>> @@ -20,6 +20,37 @@ static void fat_checksum_test(struct kunit *test)
>>>>  	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
>>>>  }
>>>>  
>>>> +static void fat_clus_to_blknr_test(struct kunit *test)
>>>> +{
>>>> +	struct msdos_sb_info sbi = {
>>>> +		.sec_per_clus = 4,
>>>> +		.data_start = 100,
>>>> +	};
>>>> +
>>>> +	KUNIT_EXPECT_EQ(test, (sector_t)100,
>>>> +			fat_clus_to_blknr(&sbi, FAT_START_ENT));
>>>> +	KUNIT_EXPECT_EQ(test, (sector_t)112, fat_clus_to_blknr(&sbi, 5));
>>>> +}
>>>> +
>>>> +static void fat_get_blknr_offset_test(struct kunit *test)
>>>> +{
>>>> +	struct msdos_sb_info sbi = {
>>>> +		.dir_per_block = 16,
>>>> +		.dir_per_block_bits = 4,
>>>> +	};
>>>> +
>>>> +	sector_t blknr;
>>>> +	int offset;
>>>> +
>>>> +	fat_get_blknr_offset(&sbi, 0, &blknr, &offset);
>>>> +	KUNIT_EXPECT_EQ(test, (sector_t)0, blknr);
>>>> +	KUNIT_EXPECT_EQ(test, 0, offset);
>>>> +
>>>> +	fat_get_blknr_offset(&sbi, (10 << 4) | 7, &blknr, &offset);
>>>> +	KUNIT_EXPECT_EQ(test, (sector_t)10, blknr);
>>>> +	KUNIT_EXPECT_EQ(test, 7, offset);
>>>> +}
>>>> +
>>>>  struct fat_timestamp_testcase {
>>>>  	const char *name;
>>>>  	struct timespec64 ts;
>>>> @@ -181,6 +212,8 @@ static void fat_time_unix2fat_test(struct kunit *test)
>>>>  
>>>>  static struct kunit_case fat_test_cases[] = {
>>>>  	KUNIT_CASE(fat_checksum_test),
>>>> +	KUNIT_CASE(fat_clus_to_blknr_test),
>>>> +	KUNIT_CASE(fat_get_blknr_offset_test),
>>>>  	KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
>>>>  	KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
>>>>  	{},

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
