Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33935111BC;
	Tue, 13 Oct 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897474; cv=none; b=BRmM/a4VcTq95N8R9/1yl2ReX7ymcZfDbmpn0AmKZFpcniycy3f2lML0Hzk2Za3Fz4QGUgC81Rkh4nAQq1rgmauj5xlfPSH0yiSKPYtinulaxJBVnzNDOae2NWZjF4PRJ+1Kx5BeGAReWyRXKjymlOfw+r8ds9SfLqAOBObQO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897474; c=relaxed/simple;
	bh=zRKJ0Yiw7bNadRDbKt6zuimuE0I5/BUEbr8eEqaW3sE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ctg60zVSLe87vt1Z9CQaM9hmfwFLuj6BuR4TYA6eEYBSl2ZC3n4tRLD5yswlPnfqCfftlBOfAUldrkoQlflqC2jkbYk5ici47iHmpCXUUqFkAIwQdDs7o4siONk0iLIPiLskNIqwUyQb8HlMCZNCIisGV/MTq+2OtW8IRUPRKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=zS/njdgW; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=8stvFBLN; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="zS/njdgW";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="8stvFBLN"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 5203D26F7697;
	Tue, 13 Oct 2026 22:17:51 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791897471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMwVLew5mvVnVvExhiUsbrBRHIiIZrNcbKYVNjQWJ+k=;
	b=zS/njdgWijXA0/uHIjoZ/eDeT8NRVkLykjaubvLT1Z8wcDIEBYDDzDnNz0xvLF2imsWOPl
	SpcVtbhS9AFQFBexQiFJAcjlpprMhDsSh6gZCT/6jjcgiOffaBnpgOboHf32ZoeohiDUCc
	7BQolN/X2Z9lUzS3AcOoyFhdON91if7NNuzoCijWP48v3ZWKV02no+hVnvbi0BkgUED5HE
	VFnduTQeZchjZqifO8tCSgFq5RAFf1Z5XxGma3Y3Ow2NKaAbFIveLOex9ETLKJDQ88WWXI
	tfwDIvAinZg7rRC6oxGbxnugetqw8KFB2rfIDnQxG5moJXGbiXGniFDpGSo6xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791897471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMwVLew5mvVnVvExhiUsbrBRHIiIZrNcbKYVNjQWJ+k=;
	b=8stvFBLNHVLZIsZxCnla2qRLNuPJwRPHOXgJiaEdK3JypLEjH61Nszi9KeIW90QU3F3d7n
	bt480RmFSRGRA2DA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id DEB98E00149;
	Tue, 13 Oct 2026 22:17:50 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id D182022000A7; Tue, 13 Oct 2026 22:17:50 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fat: allocate multiple clusters in fallocate
In-Reply-To: <20261012171106.146243-4-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
	<20261012171106.146243-4-matheus.aalmeida@inf.ufrgs.br>
Date: Tue, 13 Oct 2026 22:17:50 +0900
Message-ID: <87cxtdn3i9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> The fat_fallocate() code currently does many 1-cluster allocations when
> growing a file in the FALLOC_FL_KEEP_SIZE path. Make it allocate
> everything with one call instead.
>
> Benchmarking was done under QEMU/KVM with a virtio-blk device using
> cache=none. Each result is the arithmetic mean of the listed samples.
>
> start = now_ns();
> for (unsigned int i = 0; i < count; i++)
>      fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
> elapsed = now_ns() - start;
>
> FAT32 with 512-byte clusters using count=16 files:
> length    mounted sync?    before    after    improvement    samples
> 256MiB    no               2.328s    0.175s   13.2x          10
> 16MiB     no               149.659ms 14.036ms 10.7x          10
> 16MiB     yes              747.993s  3.445s   217.1x         3
> 1MiB      yes              46.63s    0.333s   140.1x         10
>
> FAT32 with 512-byte clusters using count=128 files:
> length    mounted sync?    before    after    improvement    samples
> 1MiB      no               90.873ms  4.686ms  19.4x          10
> 16KiB     no               1.287ms   0.241ms  5.3x           10
> 128KiB    yes              47.284s   0.350s   135x           10
> 4KiB      yes              1.98s     0.144s   13.7x          10
>
> FAT32 with 4096-byte clusters using count=16 files:
> length    mounted sync?    before    after    improvement    samples
> 256MiB    no               295.392ms 24.733ms 11.9x          10
> 16MiB     no               20.509ms  1.404ms  14.6x          10
> 16MiB     yes              92.489s   0.348s   265.4x         10
> 1MiB      yes              5.837s    0.048s   121.3x         10
>
> The improvement is especially large on synchronous mounts, where the
> new code can batch FAT updates instead of synchronously handling each
> cluster allocation separately.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Looks good. Thanks.

> ---
>  fs/fat/file.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 41d49e9de..3aa541c6b 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -290,12 +290,10 @@ static long fat_fallocate(struct file *file, int mode,
>  		nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
>  			sbi->cluster_bits;
>  
> -		/* Start the allocation.We are not zeroing out the clusters */
> -		while (nr_cluster-- > 0) {
> -			err = fat_add_clusters(inode, 1);
> -			if (err)
> -				goto error;
> -		}
> +		/* Allocate the clusters. We are not zeroing them out */
> +		err = fat_add_clusters(inode, nr_cluster);
> +		if (err)
> +			goto error;
>  	} else {
>  		if ((offset + len) <= i_size_read(inode))
>  			goto error;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
