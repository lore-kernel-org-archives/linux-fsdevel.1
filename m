Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881023;
	b=40riiPcXEPvMGy5b3ZGAWrw8lLkG93NiPyN5QYd3ZbHsP/ZI834TnQuNcLMNQpIciBgk
	 AixsdzrTPV78AqP5wm+9uPYrPFla8yBVysAOgSqug9GXbHbUFdneokeCm5Hk2eHR5CnfI
	 WQfyr729vQC4ATlvr8s/C6poAglS3UfkCFhTWNLYKquxVS3ldVUYdIYitzqyZCUkm8IOU
	 0fOnENtvVRAfNQZ895/UyEkCJG2u6I8B4VspfDpeUKF2mtcb4E/L56paj1UDclAt+1zbR
	 J4ROIYqSrxPiAgLaH5i5RXBFV2DghBiu2orrwcmiFPC390/3DEB+beibWVLH5gpIowQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881023;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vJgzqHcBsfs4faDREqkt6EK1r4wJAxa4ufgaTxHf+T4=;
	b=WyGrgZLTaLYLTeOa2F6f6eUjHSpqGP6c9kuTOGQkZvYhkzUx9n/wPH22s2jduDRualZ/
	 JaDJqLKMUGYV6j1BOrBEDz8bJwVb1pExNM2Tfrqoo1PiCSWe6PHBpcdhP68M6X3KaWv2t
	 66FG8RJ17hRZsXWtzhfhvUUYjwPJv9RqJSZiaPQ0bJVRlQmrBb+Zjzp1lhO0ONzG2KOaf
	 v+96V3NGDBwnNQXbggRFHm206OtKxOvHwpX0kTOgfhtYAGP9izO9Yuae5NgcOlVGKdOCt
	 ffQ+Fb8LWcAABYvN97yPfteCgftcwneX3XPud+gLnoD7nw8bAkuW1/bPzgdnlE0c+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=mWL1i5ul;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835A606A31A;
	Sat, 24 Oct 2026 22:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2835A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=mWL1i5ul
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 2EFAE120590;
	Sat, 24 Oct 2026 19:30:11 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792881011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJgzqHcBsfs4faDREqkt6EK1r4wJAxa4ufgaTxHf+T4=;
	b=mWL1i5ulK/dXg4fcOfJtBOpgIApoywQQ3pBo9/IdGEduLJoP27seAmwb8DIKSS7djPC6Js
	l7vsUd5Fq0O2EmXmzx+1Bt5qGFR6hMr3zKQbdc4mx7qaL+vqI+AErOxmTH2lrwVpSsJ9kX
	vtil/hivYfq4/gPPCWyGveEUl1cocZjPqcq3XcZSm5rsbqaKg6Coc5PZFt8s1zglODz1D9
	Mg70+ZbPDD97c7BJAWut9ZGt0pReUnBj9X6X7NeYk/Kmz+3ja44xK9dtn5cVavvGiWvztn
	B2SFWJ47coW+jRUNBivjAnCqcux4eKdHFT4sLeHG7a5cGOieuWwBSJlt74p2Cg==
Date: Sat, 24 Oct 2026 19:30:05 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Pedro Falcato <pfalcato@suse.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
Message-ID: <at0v6ghpGLC5VO_h@DESKTOP-PJTTJ93.localdomain>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
 <at0kGRzkfLeqD7yq@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <at0kGRzkfLeqD7yq@pedro-suse.tail5790ac.ts.net>

On Sat, Oct 24, 2026 at 10:39:30PM +0100, Pedro Falcato wrote:
>On Wed, Oct 21, 2026 at 01:21:04PM -0300, Matheus Alves de Almeida wrote:
>> The current fat_write_failed() implementation calls into
>> fat_truncate_blocks() without holding truncate_lock. Make it so it is
>> held exclusive while truncating.
>> 
>> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/inode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 141276fcf8db..2a16ed415631 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -216,7 +216,9 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
>>  
>>  	if (to > inode->i_size) {
>>  		truncate_pagecache(inode, inode->i_size);
>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>>  		fat_truncate_blocks(inode, inode->i_size);
>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>
>Hmm, I think there's still a race here. Nothing's stopping a sequence of
>events like:
>
>1) truncate_pagecache
>2) concurrent pagecache look creates mapping for out-of-range blocks
>3) fat_truncate_blocks() truncates the blocks out from the inode
>4) page cache has stale pages pointing at stale blocks
>
>-- 
>Pedro

The read/fault path eventually reaches fat_bmap() with from_bmap = false,
which does not return mappings for blocks at or beyond i_size.

Do you have a specific path in mind that can cause this race?

Thanks,
Matheus
