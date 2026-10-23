Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740814;
	b=L0ikiMCm0ZvRIktoOO7oba3qTzawtt/QGZ20+upvVdsxzHNWGmcV5iPf8iMzRacNITwc
	 0rs7mlLoF8/l/HywlqfLQdLy3nxpKEEe9CKCK72tY80TuyP4j6B8XCa0B5Nbvznwaj6Gv
	 LzQFTnpIGIgUk6mNS8jqal2a4mXdRMHQ3lyn4iCujkCipJafbOvuaOIpG3pd5Bj2AzIvQ
	 qUp64XomFTQAz3XsAX7Cq0R0h4iw1TB5+6ZUl6F850UZsg4EIBM8pHi04dByugDw70jI1
	 tAbxrq3S3gdkzYXAa6Av875rIPbW4mgBCNKeTOYRP9O4BN6cncqBebDxVyjLnWFDsLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740814;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1/NRRK81574aL6qQ/dopup5TpwruAbTpWIAIiVBAlxw=;
	b=OcJrNQMSlFyObJaTKzIkO2iT8T1qYmYfZTU3QSoCn1VvvyuHiFX46MkL3PTEfgeesVf2
	 MEZ5VjdAuzcZ8mlhFBrdcikAcZyBYVPN6LKpQxTZ915q9KDfWesXVPYZdDnWO8W+3mMMx
	 +hGSsDxIoe/o4y9i9HaD+P7xe0pjuWU3UhmSPH5jKL9KGZX4+Bcd/9i1PkgFkvy3AH7EW
	 1ErAFdL4zXNndh2KIc/b7kRHjE/VT26rVig32EE26UOFkBF6rvTPDlwH1bdxFssTzRPuN
	 ihaUlQ0Xo7H1yOMpjYw5GjRS7tOm6lDwvB16YnYjzg3r7+TEmTB1/megsHWZ+iSVJug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=QTn4KsBP;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+BEsDf3C;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309C606A31F;
	Fri, 23 Oct 2026 07:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B309C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=QTn4KsBP;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+BEsDf3C
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2DAE326F765F;
	Fri, 23 Oct 2026 16:33:24 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792740804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/NRRK81574aL6qQ/dopup5TpwruAbTpWIAIiVBAlxw=;
	b=QTn4KsBP0on5ZmKclXA31zOlDbIaUFt32mA0Hn6xuVA/7f1MJv33PbMLnzgzzbxgyLAB/5
	p1p6wpZ3s5M9y33Nmnv8WrqXSj0NZPpgv0DXfb9eNMVU0pTxYxW8HO2huXYJwKsNZeg3u8
	bWza2p83yjG5lC5qvGovsweGKpI4cVohIOSfigDEHVBfpNT3O7x7R6ExaNgHFVUbL68sim
	I/GvJdNYKMQe/IPl4r0tGfzKM7B0X0DPK063MmuwYAl9Y6FYBEnvBKfo/Ty2aPiC1CqC8B
	+FSY/NBLLiQmNWmTRBG64zOKBbIXUIm3SXu/DiEBF+l4SQCLXOzWOht0dCPtlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792740804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/NRRK81574aL6qQ/dopup5TpwruAbTpWIAIiVBAlxw=;
	b=+BEsDf3CxruFE2gABrGnjCp+h/7//gawp/3mJzAT91QbjN9tOy1AW97VQaDBQV90QY3wsy
	dacZxMb4M4Z5ZhDw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id A781CE00A37;
	Fri, 23 Oct 2026 16:33:23 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 9FCBF2200179; Fri, 23 Oct 2026 16:33:23 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
In-Reply-To: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
Date: Fri, 23 Oct 2026 16:33:23 +0900
Message-ID: <87wlr8j2gs.fsf@mail.parknet.co.jp>
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

> The fat_cont_expand() implementation leaves allocation of new clusters
> to generic_cont_expand_simple(). This path does many small cluster
> allocations, harming performance.
>
> Preallocate cluster space in fat_cont_expand(). Move preallocation to
> a new fat_preallocate() helper used by both fat_cont_expand() and
> fat_fallocate(FALLOC_FL_KEEP_SIZE).
>
> Benchmarking was done under QEMU/KVM with a virtio-blk device using
> cache=none. Each result is the arithmetic mean of the listed samples.
>
> start = now_ns();
> for (unsigned i = 0; i < count; i++) {
>     if (truncate_mode)
>         ftruncate(fds[i], bytes);
>     else
>         fallocate(fds[i], 0, 0, bytes);
> }
> elapsed = now_ns() - start;
>
> 16 files, 512-byte clusters:
> length    mode      sync?    before    after    improvement    samples
> 256MiB    ftruncate no       9.576s    5.345s   1.79x          10
> 256MiB    fallocate no       9.634s    5.640s   1.71x          10
> 1MiB      ftruncate yes      58.66s    0.362s   162.15x        5
> 1MiB      fallocate yes      61.36s    0.390s   157.15x        5
>
> 128 files, 512-byte clusters:
> length    mode      sync?    before    after    improvement    samples
> 512KiB    ftruncate no       0.433s    0.352s   1.23x          10
> 512KiB    fallocate no       0.446s    0.393s   1.13x          10
> 64KiB     ftruncate yes      31.32s    0.429s   73.00x         10
> 64KiB     fallocate yes      29.59s    0.410s   72.42x         10
>
> 16 files, 4096-byte clusters:
> length    mode      sync?    before    after    improvement    samples
> 256MiB    ftruncate no       5.181s    4.417s   1.17x          10
> 256MiB    fallocate no       5.166s    4.442s   1.16x          10
> 1MiB      ftruncate yes      9.294s    0.111s   84.06x         10
> 1MiB      fallocate yes      8.710s    0.110s   79.36x         10
>
> The biggest improvement is on filesystems with a small cluster size and
> on synchronous mounts.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>
> Changes in v2:
> - fat_cont_expand(): Hold truncate_lock around fat_truncate_blocks().
>
> This patch depends on:
> https://lore.kernel.org/linux-fsdevel/20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br/T/#t
>
>  fs/fat/file.c | 56 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 3aa541c6b127..dd0ae795dc14 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -217,15 +217,50 @@ const struct file_operations fat_file_operations = {
>  	.setlease	= generic_setlease,
>  };
>  
> +static int fat_preallocate(struct inode *inode, loff_t new_size)
> +{
> +	int nr_cluster; /* Number of clusters to be allocated */
> +	loff_t mm_bytes; /* Number of bytes to be allocated for file */
> +	loff_t ondisksize; /* block aligned on-disk size in bytes*/
> +	struct super_block *sb = inode->i_sb;
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +
> +	ondisksize = inode->i_blocks << 9;
> +	if (new_size <= ondisksize)
> +		return 0;
> +
> +	/* First compute the number of clusters to be allocated */
> +	mm_bytes = new_size - ondisksize;
> +	nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
> +		     sbi->cluster_bits;
> +
> +	/* Allocate the clusters. We are not zeroing them out */
> +	return fat_add_clusters(inode, nr_cluster);
> +}
> +
>  static int fat_cont_expand(struct inode *inode, loff_t size)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	loff_t start = inode->i_size, count = size - inode->i_size;
>  	int err;
>  
> -	err = generic_cont_expand_simple(inode, size);
> +	/*
> +	 * Preallocating space here is more efficient than during
> +	 * generic_cont_expand_simple() because of batching.
> +	 */
> +	err = inode_newsize_ok(inode, size);
>  	if (err)
>  		goto out;
> +	err = fat_preallocate(inode, size);
> +	if (err)
> +		goto out;
> +	err = generic_cont_expand_simple(inode, size);
> +	if (err) {
> +		down_write(&MSDOS_I(inode)->truncate_lock);
> +		fat_truncate_blocks(inode, inode->i_size);
> +		up_write(&MSDOS_I(inode)->truncate_lock);

Is this fat_truncate_blocks() really required?

> +		goto out;
> +	}
>  
>  	fat_truncate_time(inode, NULL, FAT_UPDATE_CMTIME);
>  	mark_inode_dirty(inode);
> @@ -263,12 +298,7 @@ static int fat_cont_expand(struct inode *inode, loff_t size)
>  static long fat_fallocate(struct file *file, int mode,
>  			  loff_t offset, loff_t len)
>  {
> -	int nr_cluster; /* Number of clusters to be allocated */
> -	loff_t mm_bytes; /* Number of bytes to be allocated for file */
> -	loff_t ondisksize; /* block aligned on-disk size in bytes*/
>  	struct inode *inode = file->f_mapping->host;
> -	struct super_block *sb = inode->i_sb;
> -	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>  	int err = 0;
>  
>  	/* No support for hole punch or other fallocate flags. */
> @@ -281,19 +311,7 @@ static long fat_fallocate(struct file *file, int mode,
>  
>  	inode_lock(inode);
>  	if (mode & FALLOC_FL_KEEP_SIZE) {
> -		ondisksize = inode->i_blocks << 9;
> -		if ((offset + len) <= ondisksize)
> -			goto error;
> -
> -		/* First compute the number of clusters to be allocated */
> -		mm_bytes = offset + len - ondisksize;
> -		nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
> -			sbi->cluster_bits;
> -
> -		/* Allocate the clusters. We are not zeroing them out */
> -		err = fat_add_clusters(inode, nr_cluster);
> -		if (err)
> -			goto error;
> +		err = fat_preallocate(inode, offset + len);
>  	} else {
>  		if ((offset + len) <= i_size_read(inode))
>  			goto error;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
