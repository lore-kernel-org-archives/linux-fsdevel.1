Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38440DFCC;
	Sun,  5 Apr 2026 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366310; cv=none; b=ldBJxmWXr5nfbu9Y4yZc89dyA8SIcCYrZEIZnGGhcZCOGwn+KmI0S8JJ9qtWtNj+sY7pk8ICsc7aVxa1dD4FsomcXPwo5JW+dgX12y/HipX5Kldlw7gFUyplnVHn55+OBzSwqMUWtUmnNBntU2gJoPiyUANN3zD0T1/RWhmGpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366310; c=relaxed/simple;
	bh=hMGO7JMW8UtRgI7dScpThnaEipmUQw5mUPcOu8UU6Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B/7vr4JimXSUbNriG3Tl0KzJen/m1Xu7ZIRgu/6eXck/6Ro/W8sUQHarKkbnQN8P2663wxXiVu5SJcEwRxKsNdRMrcTmXNaKEDdekVWfvs5/5sZVTWOPjhFHerX7Lwgoo6wmUYBOEpmDWz2nMKpqUR7VZKI9YIHMHzI0oRpiDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=M8tybM1/; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=d4xnGPYu; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="M8tybM1/";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="d4xnGPYu"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id CDCED26F769C;
	Sun,  5 Apr 2026 14:18:19 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1775366300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDnGld1vNME3obnEnU0FDyy2MkvJK5vbJeYHt90wLY0=;
	b=M8tybM1/byPad1Cmis8PQ4Jhtu+u8oh/LYkRLtFvsobcSKBVvLPzQD23O5WdcTuYao6xEN
	dZ5GLTer6/BVehzzsMKLH3zIzgSsSJ269Fk9TSPJFxZW6iTu+rkI+JOZakbhnZixxCgIte
	M481c3F2fP6j2V0Etar1UowrwEaOSmxPyXbmLQFxzwOqpXWg1qAKZ8ESOy6Q6l1NUUUcv9
	00Hoh8pYx1mWE5eFb/AZyD67OEmjPDP2WOs66ey2DdiJqICbDXZZgVZeARuZLBJI3jscg/
	ZVKqfREVJFXfWt2XMe8/mOZQCnNdcEIeUvqVv2la2UEMx3LQ/e1GG4adPAzrvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1775366300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDnGld1vNME3obnEnU0FDyy2MkvJK5vbJeYHt90wLY0=;
	b=d4xnGPYuPjFAVzb2UyobQ9JJSnFIF8Ez5CFXHAQKgPRuIFwtWvcLUuarUw06Um1nhvXeTt
	V0iAerPYW0Q3I0AA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 5C33EE00216;
	Sun, 05 Apr 2026 14:18:19 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 4CDDF220029A; Sun, 05 Apr 2026 14:18:19 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kunit: fat: test cluster and directory i_pos layout
 helpers
In-Reply-To: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
References: <20260405011920.28622-1-adinata.softwareengineer@gmail.com>
Date: Sun, 05 Apr 2026 14:18:19 +0900
Message-ID: <87y0j2m1d0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adi Nata <adinata.softwareengineer@gmail.com> writes:

> Add KUnit coverage for fat_clus_to_blknr() and fat_get_blknr_offset()
> using stub msdos_sb_info values so cluster-to-sector and i_pos split
> math stays correct.
>
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/fat_test.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> index 1f0062659067..add44178f28e 100644
> --- a/fs/fat/fat_test.c
> +++ b/fs/fat/fat_test.c
> @@ -20,6 +20,37 @@ static void fat_checksum_test(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
>  }
>  
> +static void fat_clus_to_blknr_test(struct kunit *test)
> +{
> +	struct msdos_sb_info sbi = {
> +		.sec_per_clus = 4,
> +		.data_start = 100,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, (sector_t)100,
> +			fat_clus_to_blknr(&sbi, FAT_START_ENT));
> +	KUNIT_EXPECT_EQ(test, (sector_t)112, fat_clus_to_blknr(&sbi, 5));
> +}
> +
> +static void fat_get_blknr_offset_test(struct kunit *test)
> +{
> +	struct msdos_sb_info sbi = {
> +		.dir_per_block = 16,
> +		.dir_per_block_bits = 4,
> +	};
> +
> +	sector_t blknr;
> +	int offset;
> +
> +	fat_get_blknr_offset(&sbi, 0, &blknr, &offset);
> +	KUNIT_EXPECT_EQ(test, (sector_t)0, blknr);
> +	KUNIT_EXPECT_EQ(test, 0, offset);
> +
> +	fat_get_blknr_offset(&sbi, (10 << 4) | 7, &blknr, &offset);
> +	KUNIT_EXPECT_EQ(test, (sector_t)10, blknr);
> +	KUNIT_EXPECT_EQ(test, 7, offset);
> +}
> +
>  struct fat_timestamp_testcase {
>  	const char *name;
>  	struct timespec64 ts;
> @@ -181,6 +212,8 @@ static void fat_time_unix2fat_test(struct kunit *test)
>  
>  static struct kunit_case fat_test_cases[] = {
>  	KUNIT_CASE(fat_checksum_test),
> +	KUNIT_CASE(fat_clus_to_blknr_test),
> +	KUNIT_CASE(fat_get_blknr_offset_test),
>  	KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
>  	KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
>  	{},

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
