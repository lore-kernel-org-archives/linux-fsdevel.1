Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792887900;
	b=KFeeBpJbKKwqmqmFpn3uSQ69jqG7oTdExzvfTeatGgK9+rTtS42LD7h2pmde35NXzeUt
	 +L2iKpAvlXk7EYZ9lzutAJ4FZ8Rg3ocGzt5qfld93KHC5B3Nx2i4GsaVeiEtY/JPCTHtc
	 CmLWMwUM6uDydEdE0k88Oa/qlQNwy5JczvdHgmTFQFkL/GmftL9FOLgYtvx32wLfAN/ue
	 4wvWdHlt3EhhLjsoXsjFdNn5cDR8BZx/qwpOPn+efsFkXJ47+JERglvZgjBMq7Bjm3zgT
	 g1nGnTyDonoOjJo/wGrJZMB7n9/4yxtIlujtwFfchyraSXg+E+l0DN4uj21ra89hn1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792887900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5lWlaiiAmnWQZRyAcYV8DoDniVOniM3DV7xr7qTGKSY=;
	b=iEs9q4pMec18KgbsMOKxPvN24jXFVFRMKtJelRrJm/flvwJhpWAxxErQClQLe54kpcMs
	 nQ9o5d1qf10PR4grTxa/RSV++qsLX6ZjEm86lVJitk833/SkYM659RSJelupWk5wbrrIj
	 WeMzkaJMUkuIPYCZCSDNFfHAyjbb0z4FJfvLD+jPubIx8Fv3vf4ESJaAcogkZ5b2q15yh
	 RFbcELbjxKWvc0iw/wXGJsPqA45zrvedDiokk/xWhL/9YPpWDk/1YcoHR7dk7ce6Nwxpk
	 FPzIHKebxg7Pmto+y4loPx+18ejHDIpLvyNJJlYvwQerrR11hwgd+afkt+qqMnLLG4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=T2ij2Vys;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C5606A31A;
	Sun, 25 Oct 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=T2ij2Vys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC81F01825;
	Sun, 25 Oct 2026 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792887898;
	bh=5lWlaiiAmnWQZRyAcYV8DoDniVOniM3DV7xr7qTGKSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T2ij2Vys887yvaz1gCcsnJ2SUxdjMlZiaGsYXK1dkTtOhpM00qtn2430nO4sf3C8c
	 4EW3+J91a82CCYSw9U7/nEohJCPBNbNhmk3t7YZ6XOvutHv45Ubp5R8/VjKnLnbuML
	 w8JI2zRZwuQOU9ituJH8g9BfeyYrmig5ODPrM/Go=
Date: Sat, 24 Oct 2026 17:24:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
Message-Id: <20261024172458.48c825a7a36a3802313a0ed3@linux-foundation.org>
In-Reply-To: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 13:21:04 -0300 Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> wrote:

> The current fat_write_failed() implementation calls into
> fat_truncate_blocks() without holding truncate_lock. Make it so it is
> held exclusive while truncating.
> 
> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Thanks.  My AI reviewbot said:

: Please expand the changelog to describe the failed/short extending write
: racing with FIBMAP. The mapper uses i_blocks, so it can walk beyond i_size
: while fat_write_failed() is cutting that part of the chain. That can
: produce a bogus "request beyond EOF" error and make the filesystem
: read-only with the default error policy.
: 
: Also, please change the Fixes attribution to 16fab2015099:
: "fat: permit to return phy block number by fibmap in fallocated region".
: That introduced the beyond-EOF FIBMAP lookup. Before it, the lookup was
: bounded by i_size, so the removed clusters were outside its range.
: 459f6ed3b8c7 introduced the helper, but not this failure mechanism.
: 
: I don't see a need to move the lock above truncate_pagecache(). Ordinary
: reads are bounded by i_size, and the cluster containing the partial EOF
: block is retained. FIBMAP is the case which needs this exclusion.
: 
: This looks like a stable candidate once validated and merged upstream.
: Please consider adding Cc: stable@vger.kernel.org. I checked the source
: and a reduced TLA+ model, but haven't built or runtime-tested the patch.

So I made some changes and ended up with the below.  Please check.

From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: fat: hold truncate_lock in fat_write_failed()
Date: Wed, 21 Oct 2026 13:21:04 -0300

The current fat_write_failed() implementation calls into
fat_truncate_blocks() without holding truncate_lock.

A failed or short extending write racing with FIBMAP can spuriously make a
FAT filesystem read-only.  FIBMAP bounds its lookup by i_blocks, so it can
walk allocated clusters beyond i_size while fat_write_failed() is removing
them.  If the chain is shortened during the walk, the mapper can report a
bogus "request beyond EOF" error, triggering the default read-only error
policy.  Hold truncate_lock for write around the block cleanup to
serialize it with _fat_bmap().

For comparison, fat_setattr() correctly holds truncate_lock during
truncation:

	down_write(&MSDOS_I(inode)->truncate_lock);
	truncate_setsize(inode, attr->ia_size);
	fat_truncate_blocks(inode, attr->ia_size);
	up_write(&MSDOS_I(inode)->truncate_lock);

Make it so ->truncate_lock is held exclusive while truncating.

Link: https://lore.kernel.org/20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br
Fixes: 16fab2015099 ("fat: permit to return phy block number by fibmap in fallocated region")
Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: <stable@vger.kernel.org>
---

 fs/fat/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/fat/inode.c~fat-hold-truncate_lock-in-fat_write_failed
+++ a/fs/fat/inode.c
@@ -217,7 +217,9 @@ static void fat_write_failed(struct addr
 
 	if (to > inode->i_size) {
 		truncate_pagecache(inode, inode->i_size);
+		down_write(&MSDOS_I(inode)->truncate_lock);
 		fat_truncate_blocks(inode, inode->i_size);
+		up_write(&MSDOS_I(inode)->truncate_lock);
 	}
 }
 
_

