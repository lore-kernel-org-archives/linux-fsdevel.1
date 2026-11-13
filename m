Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534122;
	b=i0aqtcWc8p2AUUrSTB62XEcB3szHq1Anhtt9l+wG1fAJXwqISRmqsiITK1Q45ErqaML1
	 WhonIjj5S+zjcj75o3D+FrbKjhkNmisL02adZpcE1oJETVrnN++aO/x3zWHR/oL0tl6yo
	 bXMFbYyci+q++9lhlwqXlyF+HzWCWPuoRwcLyZCZHF8ZOURPuUPXlKHCAtpm6iucBXEp8
	 nCzb+Tq18BxoG3oEznUbL0raY9sQMAnTGLSWTCn10yVhYz3bViOYEXI124yX/14g6CDuE
	 dLSFO58vHjGTL+LWz8yZgqqcNHw8Y3dob4pwscxLD2bh2J16tj3h/nqpr8rUZjAWujw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534122;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KDwwklYe33EzWMSHF4Ad0iaKalV4NE49Bz6sRigU9Sg=;
	b=ltSIXjmleci3QblVvX0+BC+3pmLJNcez5owrxwNIkbiVvysjn0yUhjgU7J8BpXfsDRs6
	 5oMl9KtS+cIqL4kGDozQS4HbFxP8As8kbemtvf0suB4ay0pga6gJfkb5AcsO24hqxbyZ5
	 tdj8se2NT7VCCrkRUAWXjR+BHSMIF3aHaJkuuw8zNW68VfM5Su4m+IlnaXrTX8EZtM1ui
	 4AE/JZRBV4H17fBoXVKgsGlrvriy7xdifJcV7vpj4GK1f5xt8NGuIn2xbjirxXpahRPr1
	 Y0EnBQAHh0DV5we/YZTQTGwCjLJxWesCdruvdw/t2rzL8W3LS1Ad0xJmRst8IvgqRFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=FbPFMVuw;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAE606A323;
	Fri, 13 Nov 2026 01:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CAE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=FbPFMVuw
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 49275120368;
	Thu, 12 Nov 2026 22:41:57 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794534117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDwwklYe33EzWMSHF4Ad0iaKalV4NE49Bz6sRigU9Sg=;
	b=FbPFMVuw6AwZQWAxS1RwrpSzw2176yo7/8d5rwQiOJs77vyA6pDDaG5n+vw7OEVEifEZ/N
	wvtDzyOZr1zE+wsjxzagZUXoPubHaEvzj7zIq6XeyhlV6X2/ujtre+drH8t8ZexEzX8Efv
	Zd20ccD85lca7tukxEAkeZrKZLfcJVj4mYhCKfMv4CGkjoheahf62TreHjwxVaGS21YqkI
	Q3oIA5EG24Q+yQLI652shAtKM3uscN+/lZYn+iRJ8oWl5Oi3z4XsjNy0I9igyHNBtcCizb
	cCZmKMd9E3zKQKIv98mNFe4BsqqaBCM0+Ux6bUCOwOZPT5I03g9Qq9tmtSCHbw==
Date: Thu, 12 Nov 2026 22:41:51 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] fat: support FIEMAP
Message-ID: <avZoxGZC5VxiPJtV@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
 <87tslrtlyu.fsf@mail.parknet.co.jp>
 <avU3IRmswObU2pH6@DESKTOP-PJTTJ93.localdomain>
 <87cxsaabf2.fsf@mail.parknet.co.jp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cxsaabf2.fsf@mail.parknet.co.jp>

On Thu, Nov 12, 2026 at 02:03:45PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>
>[...]
>
>>>>  	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
>>>> -		/*
>>>> -		 * dummy, always not contiguous
>>>> -		 * This is reinitialized by cache_init(), later.
>>>> -		 */
>>>> -		cache_init(&cid, -1, -1);
>>>> +		/* Cache the contiguous prefix from the known first cluster. */
>>>> +		cache_init(&cid, 0, *dclus);
>>>
>>>Doesn't this add a needless cache? 0 is cached in the inode itself,
>>>isn't it? (and can be waste small fatent cache slots?)
>>>
>>
>> This is mostly for caching the number of contiguous clusters starting
>> from 0. i_start only really tells us the first cluster of the file. I'm
>> not exactly sure of the best way to approach this, though. I guess we
>> can skip caching when its a one cluster range in this case?
>>
>> What do you think?
>
>Ah, sure. I think because it is fat_cache_lookup() and stuff are
>implemented for nr_cont == 1. So I think better way would be supporting
>the range lookup in whole cache stuff. (however, it can be relatively
>complex)
>
>Thanks.
>

It seems like exfat had to solve a similar problem a while back:
https://lore.kernel.org/linux-fsdevel/20260114121250.615064-1-chizhiling@163.com/

Maybe I can work on porting some of that to fat. Would you rather it be
in a separate series or just add it to the iomap series?

Thanks,
Matheus
