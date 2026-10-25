Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889581;
	b=sxWdamG+u5BGJhOFOQPM2EYrvYRGNp60cq3DrNs8BdLQU9uVXvKArLJ1ITnRSXH0ki9p
	 Lt1OiqBUO9PWZMfw3gxmEDHaW8U+QjaEmmZU54Z8Y5uqMf8oB27qlS+QGi0JBgtk9AiCs
	 VmgKRF+U8s8IOHEYHTNt2IGhlF7KvaiKBArI//D/06a8ATI0milBoYGZw98KAQJR0+I2v
	 x1/lYxlEjhSZUOgQeIIsnXkU0B8ICW+9UJttTO1MwZOsV/T2MrRMTAR/gylWGjOlYDljE
	 HZ658/vXifFFcgK1jnjQVYt50yIiikHcp7n4dCdN5jhR/h+oyemBRBfmPLNZUVKkcRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889581;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=YaX+sI/DwNoBwPQgjA/5L3YFRe1IIDktH8yT6+Oi2iM=;
	b=4VjmP/sKFytA+Qe1yPPvt4FkyGgN797Z0Vw7a9lcFaHu4nLE9wG1QeuUS1jWwd9Xhulg
	 NPevFzJD1K4Um+Da9EbMlOW4ke9/rDbMB6gEk/ZFZwsa6y0x3ANQcQ8vunWU/46hCraM4
	 onDqgdZFPsrymnheiUQO0vGwllCbveJgIaexQXK+3xwzAJPASnTFG55J+PIiM9sLycQI/
	 Q3pFjS83ikETm/bysu0BC2lQjFp0sUV+pOHsm1KhK5rCrdLITqFcJpxhdfpWHdR8WvoMQ
	 fgQDtySHhq34srRgvTcWuvHfgIgpCamVffNxP3A3+XypnL/OJhqt4kc/iFw7EkE0m2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=cphf0yPf;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB0606A31A;
	Sun, 25 Oct 2026 00:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=cphf0yPf
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 7DBCE1210A2;
	Sat, 24 Oct 2026 21:52:54 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792889574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaX+sI/DwNoBwPQgjA/5L3YFRe1IIDktH8yT6+Oi2iM=;
	b=cphf0yPf8RbIafHVAg+S1iJpsvoahdXOXXbVfuIa+1u911K4FJ7IEyEH7thFTlQOdiaypx
	lC1MxCL6+rFs7LWsQM1pyNqIha1d7T1Z4x6Dad7Lmlsp/qC0FHngHPxfvDB3SAi00n2X4u
	JVrBj90Mxu5pe2ysVo9umON4oF5bIC7RinUYyTe/LIaidAE8wDTi8aglCZHx5dLqGwkJoj
	zl/yEvwH0lvam9WgHcW2Wh+R0hrYVEudciHly7a3Z2s0F/FYLg0P6B2xKkMHCsHrckuV6f
	eZ6BZgbVEjjfG8412iy5UNoBx8XMRGdKTLKi5krAx8yz/H1O233U9QXthhScbw==
Date: Sat, 24 Oct 2026 21:52:45 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
Message-ID: <at1Rz0hY0BkT9HH-@DESKTOP-PJTTJ93.localdomain>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
 <20261024172458.48c825a7a36a3802313a0ed3@linux-foundation.org>
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
In-Reply-To: <20261024172458.48c825a7a36a3802313a0ed3@linux-foundation.org>

On Sat, Oct 24, 2026 at 05:24:58PM -0700, Andrew Morton wrote:
>On Wed, 21 Oct 2026 13:21:04 -0300 Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> wrote:
>
>> The current fat_write_failed() implementation calls into
>> fat_truncate_blocks() without holding truncate_lock. Make it so it is
>> held exclusive while truncating.
>> 
>> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>
>Thanks.  My AI reviewbot said:
>
>: Please expand the changelog to describe the failed/short extending write
>: racing with FIBMAP. The mapper uses i_blocks, so it can walk beyond i_size
>: while fat_write_failed() is cutting that part of the chain. That can
>: produce a bogus "request beyond EOF" error and make the filesystem
>: read-only with the default error policy.
>: 
>: Also, please change the Fixes attribution to 16fab2015099:
>: "fat: permit to return phy block number by fibmap in fallocated region".
>: That introduced the beyond-EOF FIBMAP lookup. Before it, the lookup was
>: bounded by i_size, so the removed clusters were outside its range.
>: 459f6ed3b8c7 introduced the helper, but not this failure mechanism.
>: 
>: I don't see a need to move the lock above truncate_pagecache(). Ordinary
>: reads are bounded by i_size, and the cluster containing the partial EOF
>: block is retained. FIBMAP is the case which needs this exclusion.
>: 
>: This looks like a stable candidate once validated and merged upstream.
>: Please consider adding Cc: stable@vger.kernel.org. I checked the source
>: and a reduced TLA+ model, but haven't built or runtime-tested the patch.
>
>So I made some changes and ended up with the below.  Please check.
>
>From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>Subject: fat: hold truncate_lock in fat_write_failed()
>Date: Wed, 21 Oct 2026 13:21:04 -0300
>
>The current fat_write_failed() implementation calls into
>fat_truncate_blocks() without holding truncate_lock.
>
>A failed or short extending write racing with FIBMAP can spuriously make a
>FAT filesystem read-only.  FIBMAP bounds its lookup by i_blocks, so it can
>walk allocated clusters beyond i_size while fat_write_failed() is removing
>them.  If the chain is shortened during the walk, the mapper can report a
>bogus "request beyond EOF" error, triggering the default read-only error
>policy.  Hold truncate_lock for write around the block cleanup to
>serialize it with _fat_bmap().
>
>For comparison, fat_setattr() correctly holds truncate_lock during
>truncation:
>
>	down_write(&MSDOS_I(inode)->truncate_lock);
>	truncate_setsize(inode, attr->ia_size);
>	fat_truncate_blocks(inode, attr->ia_size);
>	up_write(&MSDOS_I(inode)->truncate_lock);
>
>Make it so ->truncate_lock is held exclusive while truncating.
>
>Link: https://lore.kernel.org/20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br
>Fixes: 16fab2015099 ("fat: permit to return phy block number by fibmap in fallocated region")
>Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
>Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>Cc: Pedro Falcato <pfalcato@suse.de>
>Cc: <stable@vger.kernel.org>
>---
>
> fs/fat/inode.c |    2 ++
> 1 file changed, 2 insertions(+)
>
>--- a/fs/fat/inode.c~fat-hold-truncate_lock-in-fat_write_failed
>+++ a/fs/fat/inode.c
>@@ -217,7 +217,9 @@ static void fat_write_failed(struct addr
> 
> 	if (to > inode->i_size) {
> 		truncate_pagecache(inode, inode->i_size);
>+		down_write(&MSDOS_I(inode)->truncate_lock);
> 		fat_truncate_blocks(inode, inode->i_size);
>+		up_write(&MSDOS_I(inode)->truncate_lock);
> 	}
> }
> 
>_
>

Looks good to me.

Thanks,
Matheus.
