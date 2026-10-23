Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790631;
	b=31hf44LC5PdhHqO+p6YVm59YjtofKCgL6p0smLWJv0i+84DD33WOY6E3dWXXyfx2uuFu
	 GEq7PN90UhQvQH6rIvjoqUOEDjeYwtAwMLA50a/2R9INMPpF7L0oboEWh6mhy49uqsbVA
	 bGuDqIZQasTu/chAIj9thY4/gpz+oq3r4cxQnizW97d7E0XbgIHOiq8yOqD3N3lbv4qF8
	 Fn0e1ryBqZMjU5rSg/7Lf4btcIoER9WE3dw/qC5xHhqKwrteQ1DyQxkGCZNomcCjbwLjZ
	 iQ0rngOVtJ8lH31/Fdnx0inBr6uO70jSqgEHxHT4C4D2FkhsY+j5nm8wQ+nWmA0hpMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790631;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uKNq1msWpEbhg9s+tTL/ikKHTKFpOaGVgqPoQcsclJk=;
	b=yY7Mfe3QdXHJjXtqQfzNRIB3pONWti9/vQdPImlZifUPVYj+JIpmpK+bMnrvKBrsZili
	 TY17HIuzEYW0XhpWxCzKC6wyE8dftDYMm8CFDhk6EmlAoENaE9Qi+pr0NH9pFLMQ4KyWO
	 P9T77qKAPmrn/m+exsCuzvZRANtLXaKeSUYzmSsmIzcWE9QfUxNX2Rg7BhMH25JLdQw81
	 1s4rGFwmMp1F0YGHasaPYKG0wCJ/0g81LIA3QF/MbwPexj/oPr2vkAhAk3WWjvjI0AwHB
	 bcrpWZ5yMimDlJjS+Eud9XCLMB0kqOs8j4RqIuoqeG9n0oFPxGW9Pb41KK0vy1HihxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=gHv+Jd3g;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6991606A31D;
	Fri, 23 Oct 2026 21:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6991606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=gHv+Jd3g
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 35238120357;
	Fri, 23 Oct 2026 18:23:47 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792790627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKNq1msWpEbhg9s+tTL/ikKHTKFpOaGVgqPoQcsclJk=;
	b=gHv+Jd3gaLDQVZv4vtBLWDS2uv+kUSFaskope7Pd5kVnMatxI198267LmBaRXue+V5zTJD
	MVMKcvxZ/4zS0a8Zwqa6Z/p3/nJgLHkAitK1th+ZjcgVVjJPJWlqC/VAQJ/jsKlLzOtAUl
	CoWNDKBlUXTJAB0f9aXsYOsFE2mu0/F47GuTyKjx3mAaeJc1XCBeHU5mSOsmuom3rIifm1
	FASwpuu7alj82nBP2HImbzs8FJ8KU966PX/3n/Id5KfCJYcOEUVNUZyNye8RlSLaAN1iWq
	/0jLbrAvZFh1FNdpHKxI5kC9WWV0HhmmFcW5GoOw7/ErHEBOlGxNxE3QXU2y5Q==
Date: Fri, 23 Oct 2026 18:23:43 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
Message-ID: <atvP82ca9Gl0DiAG@DESKTOP-PJTTJ93.localdomain>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
 <87wlr8j2gs.fsf@mail.parknet.co.jp>
 <87ld7oqv5n.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87ld7oqv5n.fsf@mail.parknet.co.jp>

On Sat, Oct 24, 2026 at 12:44:04AM +0900, OGAWA Hirofumi wrote:
>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
>>>  static int fat_cont_expand(struct inode *inode, loff_t size)
>>>  {
>>>  	struct address_space *mapping = inode->i_mapping;
>>>  	loff_t start = inode->i_size, count = size - inode->i_size;
>>>  	int err;
>>>  
>>> -	err = generic_cont_expand_simple(inode, size);
>>> +	/*
>>> +	 * Preallocating space here is more efficient than during
>>> +	 * generic_cont_expand_simple() because of batching.
>>> +	 */
>>> +	err = inode_newsize_ok(inode, size);
>>>  	if (err)
>>>  		goto out;
>>> +	err = fat_preallocate(inode, size);
>>> +	if (err)
>>> +		goto out;
>>> +	err = generic_cont_expand_simple(inode, size);
>>> +	if (err) {
>>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>>> +		fat_truncate_blocks(inode, inode->i_size);
>>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>>
>> Is this fat_truncate_blocks() really required?
>>
>>> +		goto out;
>>> +	}
>
>And maybe this will change the user visible behavior for ENOSPC. (I'm
>not sure if it is ok for now)
>
>Thanks.
>-- 
>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

The behavior on a fallocate() ENOSPC failure seems to differ across
filesystems, some (e.g. exFAT, NTFS3) keep the original size while others
(e.g. ext4) keep the partially extended size.

If preserving the current FAT behavior is preferred, I can look into that
for a v3. Maybe adding a new fat_try_alloc_chain() helper that allocates
as many clusters as it can instead of failing the entire allocation.

What do you think?

Thanks,
Matheus
