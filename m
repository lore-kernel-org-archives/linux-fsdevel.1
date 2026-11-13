Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542004;
	b=4fiauxfg49Y+joaC4nQypmZYzm4wlr+bDbwgvFEgmowUGLPmlPf9J7pbv2CeGNoBMbhC
	 lAbbDA9EtG6ygLhgt9ivHTmHTi30xfNpo6fH9Gqx3rwsSgbr/yqEoXsHpazDtWFKhzhsf
	 x4nEC/l45I1qLKsveydLLYmNxGrlhnZAbyW6T55BRu/nj1GwiF5Y9DkeQlaqKxUC2ZRor
	 kgRs9/fUT6c/8jQpnL0sz0q6bbYNVLN/IQIOJImzl9k6MhxRIntWev6CKGoDYn02rXBcd
	 SwVSxfLc+Bz8pZk3MSnJUnhT85UOGw8IAuPpzT5ClztaxHqYmZsFuqsjfBFXwR351JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542004;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WOL1Pzs+vLk1dTn0v2qm2WPGTBXeQlLGRYfNPm6pFlo=;
	b=BfQuUkw28vg39tUphWT4FYq/9L0En/hHKMCanT5+vhk3pslklKtgAcf6VT/5yTiuEPl8
	 F3V0lgVWw1/gRL95FNfFzh5AsuBt4CUQnBbV6yzOxLhr0yZg5GZ99u56ynzWXczxMdDk6
	 OiOCaZ6t1RQK760SfFSW1Csxpoj3e2QztlfQDZLKs7AWNlr9KTwVdXQNb5cfG5EV9anSd
	 oCCoq4ZGAJa4KK+out5lFNTi4Rjuuf3Alf6Bg/OPbTwBN4hyMevbIxbU7qljv/duaue9G
	 ZL8AXv0NvdEh3g7A8VoC9vkVjDJ66YiFjumtJIfuCIxL08HAjj6alA8rEsFifXMEndw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Zj7U1TY4;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=EX7627Bj;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F70606A31C;
	Fri, 13 Nov 2026 03:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Zj7U1TY4;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=EX7627Bj
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E6C9120BD282;
	Fri, 13 Nov 2026 12:53:20 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794542001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOL1Pzs+vLk1dTn0v2qm2WPGTBXeQlLGRYfNPm6pFlo=;
	b=Zj7U1TY4mcGtqkcsA0dYLXeO3Utxj8CpUyvyaOWTpj0MBnWD9ehYntofMvk6BeigSK9keN
	3Z8wnhnZEyW23oWlDXhT7hbieYa1EuDjPKCPFuh/tV3LK6E/2RCmdE0iAR8+px7s67niPi
	DCF6/DMYOEWX6VH8g0X7zPj1U3nyJa9RFBUNFOpC6mn5js3iOv5ArRqHlFmqZ9vN3h0gRt
	1f/dvQE93QMU3TaWIKmgVOgzUkz7rkQlZwjl8bYEKPj3h6NhsxraBmIfR5irX/DVgUT6+G
	8JM5z1KFyrTYo0wUPG/jBybC2y966ZemarntKHeOhZ3hL/F7VKgxTqK16xr2Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794542001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOL1Pzs+vLk1dTn0v2qm2WPGTBXeQlLGRYfNPm6pFlo=;
	b=EX7627BjwPXS/UEqZjjR48ioBHGAkRUpmYFw5boXP5eGG8UH1Dg4VH2d0ZFg0GsHpOrZY8
	fPE6og3/H6rfZgDw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 73733E0007F;
	Fri, 13 Nov 2026 12:53:20 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 652CE2200082; Fri, 13 Nov 2026 12:53:20 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] fat: support FIEMAP
In-Reply-To: <avZoxGZC5VxiPJtV@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
	<87tslrtlyu.fsf@mail.parknet.co.jp>
	<avU3IRmswObU2pH6@DESKTOP-PJTTJ93.localdomain>
	<87cxsaabf2.fsf@mail.parknet.co.jp>
	<avZoxGZC5VxiPJtV@DESKTOP-PJTTJ93.localdomain>
Date: Fri, 13 Nov 2026 12:53:20 +0900
Message-ID: <87h5hl75fz.fsf@mail.parknet.co.jp>
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

> On Thu, Nov 12, 2026 at 02:03:45PM +0900, OGAWA Hirofumi wrote:
>>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>>
>>
>>[...]
>>
>>>>>  	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
>>>>> -		/*
>>>>> -		 * dummy, always not contiguous
>>>>> -		 * This is reinitialized by cache_init(), later.
>>>>> -		 */
>>>>> -		cache_init(&cid, -1, -1);
>>>>> +		/* Cache the contiguous prefix from the known first cluster. */
>>>>> +		cache_init(&cid, 0, *dclus);
>>>>
>>>>Doesn't this add a needless cache? 0 is cached in the inode itself,
>>>>isn't it? (and can be waste small fatent cache slots?)
>>>>
>>>
>>> This is mostly for caching the number of contiguous clusters starting
>>> from 0. i_start only really tells us the first cluster of the file. I'm
>>> not exactly sure of the best way to approach this, though. I guess we
>>> can skip caching when its a one cluster range in this case?
>>>
>>> What do you think?
>>
>>Ah, sure. I think because it is fat_cache_lookup() and stuff are
>>implemented for nr_cont == 1. So I think better way would be supporting
>>the range lookup in whole cache stuff. (however, it can be relatively
>>complex)
>>
>>Thanks.
>>
>
> It seems like exfat had to solve a similar problem a while back:
> https://lore.kernel.org/linux-fsdevel/20260114121250.615064-1-chizhiling@163.com/
>
> Maybe I can work on porting some of that to fat. Would you rather it be
> in a separate series or just add it to the iomap series?

It would be good to add with introducing nr_cont, so iomap is fine.

Maybe looks like exfat implementation doesn't handle rare case. It would
be assuming next cache is not contiguous. Actually next cache can be
contiguous.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
