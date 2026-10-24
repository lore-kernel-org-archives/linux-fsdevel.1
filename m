Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800399;
	b=ChhnrSaMFCUVg0bRYb2sOvtmv6RNJaKMDkuhtoDIqzvcHKzdEn8WBMzYSb76YUu3kTuy
	 wt4ajdyKPfw+eVVNc/wIsQCShCR+1g1depcg1MxZ+S6/ttOJ+sDRYpMM/ZHyO9nFydyLh
	 FcaRUE6ryEhlboaICWefPxJEFrddXFzJmNZ8LdZTJnmxGGFxq+EMv+0I9+Y+KmbRXO9an
	 o9T6vLK0P9eamDs1D2f42tw5X16QN2mq7Bxw/Rz8sEZb+3yXX9SXNbEcN8jpEhbDKahGT
	 K074vx9eWtSm6TYJALShIcAuNTa5nUOsovKGvO3H9wK3+mmH2X3WuEirWIbllg5p6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800399;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=g/FsAaW0AkvetNdniR3rKpNT8FlLHkuJIvhVHN7TT80=;
	b=GCz0c6ziE71nY+c31jFsSlTmUia/IvecPLu/r2jqJ8+Aiwi72M9rfVSlr9rU7HDF3Xgc
	 aQE6x49avQEux9Le6M2jbyknQKNrLCbFLX6KZ+6h0+xZzD96/Jylf2GOZQr0pxUb25y+d
	 IOsRDySgkyXK/7nXWJQ1BHl/NN+fS6pT82/8xcApC5hbVVGeq6MZfa38T3v3MNACQQ5a5
	 oTIVQlig4MfHsLxe3YPWiQwtxN5KDIG0kH79kDpnVPmwmMQmgM0HTUPc2zVrGQoH422vS
	 rXj7qMcirkx5qOsKNaXkchaarff/wePEUONmL5rfc6lEM2u9EL29mWJKDYMpLqbeUBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=znn0iOTU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=TOd9WEIj;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAF606A320;
	Sat, 24 Oct 2026 00:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EAF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=znn0iOTU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=TOd9WEIj
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 368BC26F7694;
	Sat, 24 Oct 2026 09:06:36 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792800396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/FsAaW0AkvetNdniR3rKpNT8FlLHkuJIvhVHN7TT80=;
	b=znn0iOTUuWSnSH4V+QnSwn64eLNjkx+F+uoW/Xey7w7iBMJsZaDiEMXPzv+IFacSLTUVEE
	VT+2gJmuVOU/6QX4PvSYA+7OjGh9HBkTkWH2Jf3SoQDFhkbw/Jp4p4gh/U6ktEK0bbDAQ2
	qvPSU15RRIm81pa1vQXXsbMRf089+2Jzsjxhe8vwYkKLeeXyyGryIQKdOJuM7GfXz0GvAq
	fdpFIUdOOu0eRVJU9YfgCaamJFVZzaEj5fEA9IglzK7nA2Hg8VbvJcPstjR4lSDUZu8KYd
	n+qIXO/PjUKuxNLwAIceOxEMIRT2T8XFDBxr8Jt5xYQaAQsP1eWkdE4RslsfTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792800396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/FsAaW0AkvetNdniR3rKpNT8FlLHkuJIvhVHN7TT80=;
	b=TOd9WEIj+OVUzjyxuZWvgdZzblZNybkkI1uLKRlltuJyjubl+Q87ykicmMQciPzAFpGawM
	LbiH585vPYE17uBg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B64B7E00135;
	Sat, 24 Oct 2026 09:06:35 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A4E3422000A7; Sat, 24 Oct 2026 09:06:35 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
In-Reply-To: <atvP82ca9Gl0DiAG@DESKTOP-PJTTJ93.localdomain>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
	<87wlr8j2gs.fsf@mail.parknet.co.jp>
	<87ld7oqv5n.fsf@mail.parknet.co.jp>
	<atvP82ca9Gl0DiAG@DESKTOP-PJTTJ93.localdomain>
Date: Sat, 24 Oct 2026 09:06:35 +0900
Message-ID: <8733twq7w4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> On Sat, Oct 24, 2026 at 12:44:04AM +0900, OGAWA Hirofumi wrote:
>>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>>
>>>>  static int fat_cont_expand(struct inode *inode, loff_t size)
>>>>  {
>>>>  	struct address_space *mapping = inode->i_mapping;
>>>>  	loff_t start = inode->i_size, count = size - inode->i_size;
>>>>  	int err;
>>>>  
>>>> -	err = generic_cont_expand_simple(inode, size);
>>>> +	/*
>>>> +	 * Preallocating space here is more efficient than during
>>>> +	 * generic_cont_expand_simple() because of batching.
>>>> +	 */
>>>> +	err = inode_newsize_ok(inode, size);
>>>>  	if (err)
>>>>  		goto out;
>>>> +	err = fat_preallocate(inode, size);
>>>> +	if (err)
>>>> +		goto out;
>>>> +	err = generic_cont_expand_simple(inode, size);
>>>> +	if (err) {
>>>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>>>> +		fat_truncate_blocks(inode, inode->i_size);
>>>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>>>
>>> Is this fat_truncate_blocks() really required?
>>>
>>>> +		goto out;
>>>> +	}
>>
>>And maybe this will change the user visible behavior for ENOSPC. (I'm
>>not sure if it is ok for now)
>>
>>Thanks.
>>-- 
>>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> The behavior on a fallocate() ENOSPC failure seems to differ across
> filesystems, some (e.g. exFAT, NTFS3) keep the original size while others
> (e.g. ext4) keep the partially extended size.
>
> If preserving the current FAT behavior is preferred, I can look into that
> for a v3. Maybe adding a new fat_try_alloc_chain() helper that allocates
> as many clusters as it can instead of failing the entire allocation.
>
> What do you think?

fallocate() or expand truncate() path. Hm, well, we can try to change
the error behavior (if failed, revert then).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
