Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790262;
	b=THzO102mXznikJQ7vBV6oua4hDlh6vHXauQuL5JpUGR/MOxT/JgF3sjtFc8F4QaxLACR
	 FO1HxFlPnESRcB0wCVc1dHhhOfrJA49TYi2qIwZ67soNcvf3Z++JtHahITR8s61IRdQJr
	 lkxccb7gglvKq+7YsO9zVnp0PX1OtyqzOtASBatytthT/8JnDB9zedH2lwm7hhoD14Zbn
	 RibOqE/YwATL6HQ9uJrOCaZFEGFspIaQnemN6Qw1blhhUp5bGFAsCj2whrRIwxcedMtC0
	 Cll77HMn9Uo1ESe71l+oK22pxV2V99MbjO/PbngLeHIXk93Ptd7iHUBjcoNuT3oTfSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790262;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nD6SyMNSR2wmKuVmykzouI91+zaNsR76Cs02DlXyRR4=;
	b=EM6nBmj26fY0h48OfnIVBykjIwedMPWr6e7mXY0jpFtYcQdMIJ6I8Ed5f7fIvO3d41xH
	 tNPTeQ9FNlSC3ZkCVsfd2RiMlIHHLwVaXMn2qKUTUKJlY4kX5Mw/ZP4RxJXYl+c4Hz8lo
	 72I7L89iJKEjboOwXAzVGFarxGWJd00NCLJLMW7kY/jquL4ovg0DEvYjJJxgMoK8KA1+x
	 zgVtUB0DwKRsMcf8O39maBNtmceGZuMU+Hw6TLTGWh2j9vR6X2+pP1AIrfWOWPe61qH/7
	 7hiqNisS3LPxVbeKZywYkGiYeJXMNn8wsxSR4k/2rU84y2YBuuTtJGiTj9l0WQnkFKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=NMNl5aQk;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46C606A31E;
	Fri, 23 Oct 2026 21:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D46C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=NMNl5aQk
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id BE61F120357;
	Fri, 23 Oct 2026 18:17:27 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792790248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nD6SyMNSR2wmKuVmykzouI91+zaNsR76Cs02DlXyRR4=;
	b=NMNl5aQk3WkZZI7qnvmQJXejWLZfUZVu7cW8eL4f4P05vW2rn/vg2d8SNKtuoWfA1nrSRt
	3Y7l45i8AXfm8VXLIVnw4XpZtoYvC0era5pPS7lhx52+0c4tR3ovvorFa25oli8+J+MZex
	pDSYiYyP8/miOb8wbtqHMcCJJuHBVvO8bPLTTSLYKTNqM3M3Bs5IbsWTowJRVsKptu4t0M
	UgxG1aX9x9PiqviAzgnefNbKRF0HmDSvVRLr3wxTZnWfoR3ZSsJF2FX95q2jicF+Of+6ro
	m4xIbxJlv8EzUmd84yb7Kv+5YpCjttDG/uh5IDGjW2jExGTRXMAvx+KNURCypA==
Date: Fri, 23 Oct 2026 18:17:23 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
Message-ID: <atvObRziUKEbNdUK@DESKTOP-PJTTJ93.localdomain>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
 <87se1wj2et.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87se1wj2et.fsf@mail.parknet.co.jp>

On Fri, Oct 23, 2026 at 04:34:34PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
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
>Which race this prevent?
>
>Thanks.
>
fat_write_failed() can race with the users of fat_aops.bmap(). bmap()
eventually reaches fat_get_cluster(), which assumes the file's cluster
chain will not be truncated concurrently. fat_write_failed() currently
truncates without holding truncate_lock.

For comparison, fat_setattr() correctly holds truncate_lock during
truncation:

down_write(&MSDOS_I(inode)->truncate_lock);
truncate_setsize(inode, attr->ia_size);
fat_truncate_blocks(inode, attr->ia_size);
up_write(&MSDOS_I(inode)->truncate_lock);

Thanks,
Matheus
>>  	}
>>  }
>
>-- 
>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
