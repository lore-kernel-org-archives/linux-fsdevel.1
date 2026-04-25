Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CF54774;
	Sat, 25 Apr 2026 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139858; cv=none; b=bPQIJ/jy9oxMN66TWcxdj2ssNi3PRPuV56yjR+XehAvGoNnOoMuopIllBCyYZ2fD7P0cDRZ+8Jwl+TFc1yA52QCRh74ygWuciudL8DOpXTw+1oM6+doPZ22FBjpmvxDY2jLy3jGUmzc+9qfu3Mgz5z2bDG7Q82ZKTgemGGWJpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139858; c=relaxed/simple;
	bh=GnzOu9SH2TbOyx/Ph/gQaFOtG6McerbWyTNYV4GLHic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvKdKH3U66LIYHsg4nZJJMaZshwukOGLPJldsNFpRkgxAvhW4ZPbFE8BhtTDmcZaIJuikdE95n81mYUmbAdT7vyZT2GEf8+bK0l1L5VmIbiG9c/L+2Kw71nAec9S+1Pw+KBnHGk5D5lH/pLHVQrLEYz+lpSarP/Bu6C6F9sFPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=tNgWr6Ac; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ZkyjhkBv; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="tNgWr6Ac";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ZkyjhkBv"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 0653826F765A;
	Sun, 26 Apr 2026 02:57:34 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1777139854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLxTrWkBszbrrZBTImfkaBbyPNCVgTJf2HVt7EOUddU=;
	b=tNgWr6AcG4dENJ0/emFHMzX/12jmcmeiHmZVuJ8SEm08eU4137NczmOnd2K7oU9vXyvFxL
	3dBUW59BRB21w81/hL3SROy0UiqIb8yHm1FRVVJ+RPwekkAhdeRHnM8yVZokbcD02f680a
	uyaz2TmeZzsSrcnr1lFthppNrc7ZRnl863MZR1C7tr6+W3w0eO45sqHU55mvN82hEaNATM
	OV4VRZD6j6u5fZghjacmS9vs/UPZzUVxCpbGqDwwkI3/QM0hYQBEhAidaTvx7XmVMR6g9V
	lHP3LkV0M2bJZUizyz3tJ7PnYLRUiCjB7Ea5YZuK4NaFEej0A9Iooa0fBYlF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1777139854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLxTrWkBszbrrZBTImfkaBbyPNCVgTJf2HVt7EOUddU=;
	b=ZkyjhkBvdmqLkQEWjDJqzcw0bxYK2kC3Zm2dGl8gNiO8Bw2tgZhjqbBkakVktVeGZAU1Uv
	kSJYhjYsYfin1oBA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 8B6B1E00097;
	Sun, 26 Apr 2026 02:57:33 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 7EE5122000EA; Sun, 26 Apr 2026 02:57:33 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Ziran Zhang
 <zhangcoder@yeah.net>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] FAT: Allow 0xE9 near jump in fat_read_static_bpb()
In-Reply-To: <87se90ljcj.fsf@mail.parknet.co.jp>
References: <87wlyclmvr.fsf@mail.parknet.co.jp>
	<20260412070109.5197-1-zhangcoder@yeah.net>
	<87se90ljcj.fsf@mail.parknet.co.jp>
Date: Sun, 26 Apr 2026 02:57:33 +0900
Message-ID: <87pl3mc48i.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

Please apply this too.

Thanks.

> Ziran Zhang <zhangcoder@yeah.net> writes:
>
>> The fat_read_static_bpb() only accepts a short jump as a valid
>> bootstrap code signature for DOS 1.x volumes when the dos1xfloppy
>> mount option is used.
>>
>> However, according to the Microsoft fatgen103.doc, the BS_jmpBoot
>> field has two allowed forms: 0xEB 0x?? 0x90 (short jump + NOP)
>> and 0xE9 0x?? 0x?? (near jump). The specification explicitly states
>> that either form is acceptable.
>>
>> This patch relaxes the check to also accept 0xE9 as the first byte of
>> the jump instruction.
>>
>> Changes in v4:
>> - Add original commit log
>>
>> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
>
> Thanks.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
>> ---
>>
>>> Could you add original commit log, instead of changelog?
>>> 
>>> Thanks.
>>
>> Done! Please ignore the earlier erroneous v2 v2 and v3.
>>
>>  fs/fat/inode.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 28f78df08..0e7d106ea 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -1479,8 +1479,9 @@ static int fat_read_static_bpb(struct super_block *sb,
>>  	int error = -EINVAL;
>>  	unsigned i;
>>  
>> -	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp code */
>> -	if (b->ignored[0] != 0xeb || b->ignored[2] != 0x90) {
>> +	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp or near-jmp code */
>> +	if ((b->ignored[0] != 0xeb || b->ignored[2] != 0x90) &&
>> +	    (b->ignored[0] != 0xe9)) {
>>  		if (!silent)
>>  			fat_msg(sb, KERN_ERR,
>>  				"%s; no bootstrapping code", notdos1x);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
