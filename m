Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900637;
	b=gygm+l/4ff6WJZg3es6f3ZOHY39BAnULsabqHrQeLVHwxD3IxNKdSpPujpX41U1OAyIz
	 CqB2yQnSKg5rHtKt+Ec2qZlLNKU0+D4yXHszMuBuSEhfRV3BG7yY4bUtZTI8H8TG+mHav
	 yNGppR8cZFS/kdQlY2D8PHRDN2jTpySkIaPn+GGJq7XE5L/J9AicAJDSoFbJQBAXTNGq/
	 XxL5CjefCAPVVxcaSTqxT7JwCo4IiV0XiGxGoQlun+plnVAV8Lt9MuOneQxZlgen02mPg
	 x1F4DHsNl8bsCQQUp9q9jeQe7ATKGpb+OksuPNjTZ7WvcC6crrhGgcbc+esTVQjcsIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900637;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NNFR6FJKi6I9EGLzIHV/Jr57n48wyxeld8lJYI4FqTY=;
	b=xOtxGEDK3VQfII8nE4J5jli6s951N1/rF1di1NiAMwNKH8HwgfJ53trLwO0Otjc3CSa2
	 i0fW9rSnEHx5oPBQ1vYE4J0vfs8yHSX+nf/WvDHP12GkZ5WT1/irAtOgj1Gl5Rxu/pTvI
	 ZJ7pArOW0ERTeHN5gB27E7OEf5QbDYrCHM0jNUd56AoN0vyaS920oOnHr/ykGG93gUKQ3
	 aFyLbq8YnOQsfUpMkfuVaORHpqfS9GdQ6EYJfMejfwtdd0WXWbftD5jmLjp2K6+MSaIji
	 8K8i93mtX/bFahsFtbhXnKm9Se5+aFERiyIWyEeSRjIPCxiMfUkL0wUSDVrYR8MGR3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=nQZzq031;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=JIory6u6;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391C606A31A;
	Sun, 25 Oct 2026 03:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8391C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=nQZzq031;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=JIory6u6
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 64C1826F768C;
	Sun, 25 Oct 2026 12:57:13 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792900633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNFR6FJKi6I9EGLzIHV/Jr57n48wyxeld8lJYI4FqTY=;
	b=nQZzq0314uWY8R5x9cHFSpiejQnL1UQWDFj0KMQx+w/Vv26oyRzlwMJZa1AQPzAO9H4xBB
	P6yEnkQNzDNxWebNSy4P+8II0uaadqlzJugLgV7JS7teQk2U57pSKTWOe+nC1S8pUZ+sLh
	TC1xIMkrlAjjaU5U9/HPPaURsKJ6nS9eQ1NEvsdpQF+1fi4BEIqpKNDsNQoUWsAG6epe5y
	3nq1ZmsKWuPeq5zkihhPgW+9hEzC2BdmUkujIn1/KbIHIDLOYf+HytghHVoZ6ht++P1MT9
	1OVrP+ExfrQq/sZVOH/z21nCxzIDW+Mg2aeRdtjwLSclBRqP1cnb5ZzVsxFQkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792900633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNFR6FJKi6I9EGLzIHV/Jr57n48wyxeld8lJYI4FqTY=;
	b=JIory6u6Nvzq3BJaETR2UNGhwRZw6xJDMMayds/jsG/2mDSXYs9os7QjZ200lFWRjQn1fm
	49GsZVPUvF/DpEDg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id DBBFEE00A4D;
	Sun, 25 Oct 2026 12:57:12 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id C33DB220019D; Sun, 25 Oct 2026 12:57:12 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
In-Reply-To: <20261024172458.48c825a7a36a3802313a0ed3@linux-foundation.org>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
	<20261024172458.48c825a7a36a3802313a0ed3@linux-foundation.org>
Date: Sun, 25 Oct 2026 12:57:12 +0900
Message-ID: <871p9ecu07.fsf@mail.parknet.co.jp>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 21 Oct 2026 13:21:04 -0300 Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> wrote:
>
>> The current fat_write_failed() implementation calls into
>> fat_truncate_blocks() without holding truncate_lock. Make it so it is
>> held exclusive while truncating.
>> 
>> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>
> Thanks.  My AI reviewbot said:
>
> : Please expand the changelog to describe the failed/short extending write
> : racing with FIBMAP. The mapper uses i_blocks, so it can walk beyond i_size
> : while fat_write_failed() is cutting that part of the chain. That can
> : produce a bogus "request beyond EOF" error and make the filesystem
> : read-only with the default error policy.
> : 
> : Also, please change the Fixes attribution to 16fab2015099:
> : "fat: permit to return phy block number by fibmap in fallocated region".
> : That introduced the beyond-EOF FIBMAP lookup. Before it, the lookup was
> : bounded by i_size, so the removed clusters were outside its range.
> : 459f6ed3b8c7 introduced the helper, but not this failure mechanism.
> : 
> : I don't see a need to move the lock above truncate_pagecache(). Ordinary
> : reads are bounded by i_size, and the cluster containing the partial EOF
> : block is retained. FIBMAP is the case which needs this exclusion.
> : 
> : This looks like a stable candidate once validated and merged upstream.
> : Please consider adding Cc: stable@vger.kernel.org. I checked the source
> : and a reduced TLA+ model, but haven't built or runtime-tested the patch.
>
> So I made some changes and ended up with the below.  Please check.
>
> From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> Subject: fat: hold truncate_lock in fat_write_failed()
> Date: Wed, 21 Oct 2026 13:21:04 -0300
>
> The current fat_write_failed() implementation calls into
> fat_truncate_blocks() without holding truncate_lock.
>
> A failed or short extending write racing with FIBMAP can spuriously make a
> FAT filesystem read-only.  FIBMAP bounds its lookup by i_blocks, so it can
> walk allocated clusters beyond i_size while fat_write_failed() is removing
> them.  If the chain is shortened during the walk, the mapper can report a
> bogus "request beyond EOF" error, triggering the default read-only error
> policy.  Hold truncate_lock for write around the block cleanup to
> serialize it with _fat_bmap().
>
> For comparison, fat_setattr() correctly holds truncate_lock during
> truncation:
>
> 	down_write(&MSDOS_I(inode)->truncate_lock);
> 	truncate_setsize(inode, attr->ia_size);
> 	fat_truncate_blocks(inode, attr->ia_size);
> 	up_write(&MSDOS_I(inode)->truncate_lock);
>
> Make it so ->truncate_lock is held exclusive while truncating.
>
> Link: https://lore.kernel.org/20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br
> Fixes: 16fab2015099 ("fat: permit to return phy block number by fibmap in fallocated region")
> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: <stable@vger.kernel.org>

Looks good. Thanks.

> ---
>
>  fs/fat/inode.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/fs/fat/inode.c~fat-hold-truncate_lock-in-fat_write_failed
> +++ a/fs/fat/inode.c
> @@ -217,7 +217,9 @@ static void fat_write_failed(struct addr
>  
>  	if (to > inode->i_size) {
>  		truncate_pagecache(inode, inode->i_size);
> +		down_write(&MSDOS_I(inode)->truncate_lock);
>  		fat_truncate_blocks(inode, inode->i_size);
> +		up_write(&MSDOS_I(inode)->truncate_lock);
>  	}
>  }
>  
> _
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
