Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B5517BAA;
	Mon, 21 Sep 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028106; cv=none; b=H9lmc0RfqAOaQwwkUzAqkZ6xcmH+jf9iT/SWIPhEi73j7nX0bk68BKZtunHJ3+YUULDjWIipy/sqHNpfpswVBurHEwtj79YiwYW3deYPKFWXrr0tPKjFri7Dbu9LilFD36bLbKpIshP5+HeYwsVgNexUyf9BTF1CsGFSPymG8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028106; c=relaxed/simple;
	bh=g772JZu5Ugt62u3TwjLFm2h33jZ8NQVOl1wKG2ANzPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZ56vI+Kc8npNMkpbSUJuocOxrbs0NNQg+OkafKMCdibyPeTTmlYCREvJJj6oColtf03zch3USoqGlMtHbtZMKEqfkHTU3Nhz6+scva4GaXiJbxxhQPOXKVF5Xd2i4DQYKHMHzdMiAILrne4G4QmXeXHtqjcL2ADSw6spRe/rMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ/HLKSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ/HLKSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6287C1F000FF;
	Mon, 21 Sep 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028102;
	bh=JP1mJjwKrY1zm80E+e1Ejj6Y1oTsfyKHyqpS8mqGfzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OJ/HLKSu0E20UTtT7OaCbUHb8xih6+CzoNIYw8Ta6Pt4ee6G2hFWetr97NQeJqXKg
	 vnOk7e1Adn5T2Ax0Y50EULK19ATfYO5/qsN4dXBQTQJ09nhJBSZrGaX+1/iXUl9H+C
	 6XXwFp+SK3Wamjss4B70VsZLmmAEM812AvSWIvTs0xwZuCTHqnIXAXt+2b/aw8KgMd
	 YOSIotScIEoSP0vMH9mo0Bm0On87t6SsI197vN1zM/lQGCbuKXuVIV47Kf7bnhwZkQ
	 zvV5OkBy+0WMfLzNkeasoJMuKIz+IklkCw2AhetRQH6Re0gdlSLLIoV/wii/fikWKj
	 3KQkRX6LRqjpg==
Message-ID: <e8b51a7b-a2fc-459f-81d8-49d6b0235829@kernel.org>
Date: Tue, 22 Sep 2026 00:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: validate drAlBlkSiz and fs_ablocks in hfs_mdb_get()
To: Viacheslav Dubeyko <slava@dubeyko.com>, Hui Peng <benquike@gmail.com>,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919222605.3794529-1-benquike@gmail.com>
 <1164821496f54d2fe03af44283d48db707a5e391.camel@dubeyko.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <1164821496f54d2fe03af44283d48db707a5e391.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/09/2026 23:33, Viacheslav Dubeyko wrote:
> On Sat, 2026-09-19 at 22:26 +0000, Hui Peng wrote:
>> In hfs_mdb_get() (fs/hfs/mdb.c), reject images with allocation block
>> size (drAlBlkSiz) of 0 or not a multiple of HFS_SECTOR_SIZE (512), or
>> with fs_ablocks == 0, preventing a divide-by-zero trap and out-of-
>> bounds
>> bitmap scans on crafted HFS images.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Assisted-by: LLM
>> Signed-off-by: Hui Peng <benquike@gmail.com>
>> ---
>> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
>> index 277de712f9d4..9e78c561a3f1 100644
>> --- a/fs/hfs/mdb.c
>> +++ b/fs/hfs/mdb.c
>> @@ -204,6 +204,11 @@ int hfs_mdb_get(struct super_block *sb)
>>  	/* These parameters are read from the MDB, and never written
>> */
>>  	HFS_SB(sb)->part_start = part_start;
>>  	HFS_SB(sb)->fs_ablocks = be16_to_cpu(mdb->drNmAlBlks);
>> +	if (!HFS_SB(sb)->fs_ablocks) {
> 
> This check doesn't look like checking that it's "not a multiple of
> HFS_SECTOR_SIZE (512)". Could you make your check more accurate?

In case you were not aware of: this patch is result of huge AI
semi-autonomous work, basically close to spam posting style. Whatever
you review you might be actually talking to an slop-agent, thus wasting
your time.

Best regards,
Krzysztof
