Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736009460;
	Mon,  4 May 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912996; cv=none; b=KVektXsEKPYpMdHXJJ03wzhxXCTLZRw1FHJ3CtmbJ8U2TyY3DHN/u3LI5pYc8g4fH0s8moeZa75R/7jL1wE+7M1i3CRuefG7W4rrtN8wgswXMSi4jvnB0+o28sIjuBUho262QzKyjqNjBRTZO4srqO45c6bVQwpSPWLYIx+dvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912996; c=relaxed/simple;
	bh=/3qj62iuMT4g3thDbRkectCZCvqVmue2vMlhbFIAF3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r81D+DhehkKgmPmxB9gQsy2bIn/XxTq7JViv/xQYKAWFgyPdrprk+42pAAAot4bu1r6LrMmOnDg9/cQ71pnhh6GijUlCLUXRNxg/HanHPI9WEGWn7spsxNd8H7DUe1hFAkiUklRP2PV5dEYTgY4EzHDSygQV83yZK/jEjXQeQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=vANRSmj7; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=6oXO+C+7; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="vANRSmj7";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="6oXO+C+7"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A9D492051576;
	Tue,  5 May 2026 01:35:26 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1777912526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diV3REbr1HiNX/9mWDnFPg9yTD3JWJ9kx/5dUYNShO4=;
	b=vANRSmj7CZVEcDocQxmE+4VxjZlZanmlWAOkloVMG5N3ItrCXP1UI7OSft9Td16Nb3pt3N
	2bwbTWGs8Ki3HR1m2cUCbOsY9reTc/zbk5CBsMNkL9WhqZilx+pwaAJ38HeWGihNdFY1Dp
	7oFBuuA+YgmGVmQi2YJG3dY8Is0IQzfoJr4D+O9Yd5uSqq2TVEFGiOonVYdlbhJWVB4jNJ
	hK15zeWJ1/WbdPehisRPppDuwQr9kUE6C+Pgoy/oNSxsuKH45fdCi4If/4/PBbjRze1QOr
	KoHW5acdl5Bilz5H+NLg6myWMnMh7piJ++DaypExYHwEpDcRXZfTTJqV/t3qaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1777912526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diV3REbr1HiNX/9mWDnFPg9yTD3JWJ9kx/5dUYNShO4=;
	b=6oXO+C+7WprjWcHZnxyG/M6x7PiHWWmBWYIKLLv2cedb9diyXLGFJH1uEBlEvpD3LQkN/S
	TSZYbshhrlHdg9CA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 3AA33E0025D;
	Tue, 05 May 2026 01:35:26 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 2EB1122000A5; Tue, 05 May 2026 01:35:26 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,  Ziran Zhang
 <zhangcoder@yeah.net>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] FAT: Allow 0xE9 near jump in fat_read_static_bpb()
In-Reply-To: <87pl3mc48i.fsf@mail.parknet.co.jp>
References: <87wlyclmvr.fsf@mail.parknet.co.jp>
	<20260412070109.5197-1-zhangcoder@yeah.net>
	<87se90ljcj.fsf@mail.parknet.co.jp>
	<87pl3mc48i.fsf@mail.parknet.co.jp>
Date: Tue, 05 May 2026 01:35:26 +0900
Message-ID: <87bjev2kvl.fsf@mail.parknet.co.jp>
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
> Please apply this too.
>
> Thanks.
>
>> Ziran Zhang <zhangcoder@yeah.net> writes:
>>
>>> The fat_read_static_bpb() only accepts a short jump as a valid
>>> bootstrap code signature for DOS 1.x volumes when the dos1xfloppy
>>> mount option is used.
>>>
>>> However, according to the Microsoft fatgen103.doc, the BS_jmpBoot
>>> field has two allowed forms: 0xEB 0x?? 0x90 (short jump + NOP)
>>> and 0xE9 0x?? 0x?? (near jump). The specification explicitly states
>>> that either form is acceptable.
>>>
>>> This patch relaxes the check to also accept 0xE9 as the first byte of
>>> the jump instruction.
>>>
>>> Changes in v4:
>>> - Add original commit log
>>>
>>> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
>>
>> Thanks.
>>
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>>
>>> ---
>>>
>>>> Could you add original commit log, instead of changelog?
>>>> 
>>>> Thanks.
>>>
>>> Done! Please ignore the earlier erroneous v2 v2 and v3.
>>>
>>>  fs/fat/inode.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>>> index 28f78df08..0e7d106ea 100644
>>> --- a/fs/fat/inode.c
>>> +++ b/fs/fat/inode.c
>>> @@ -1479,8 +1479,9 @@ static int fat_read_static_bpb(struct super_block *sb,
>>>  	int error = -EINVAL;
>>>  	unsigned i;
>>>  
>>> -	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp code */
>>> -	if (b->ignored[0] != 0xeb || b->ignored[2] != 0x90) {
>>> +	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp or near-jmp code */
>>> +	if ((b->ignored[0] != 0xeb || b->ignored[2] != 0x90) &&
>>> +	    (b->ignored[0] != 0xe9)) {
>>>  		if (!silent)
>>>  			fat_msg(sb, KERN_ERR,
>>>  				"%s; no bootstrapping code", notdos1x);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
