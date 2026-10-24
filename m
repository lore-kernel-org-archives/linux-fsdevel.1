Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870027;
	b=RtVWL3PdF3eIpSCXtrF29qRxRewpyZPbUNyVBhLvB+i6664koL+oqDKm8zGXAJfnJZRQ
	 Bgdo3vKg0FSciP+clnfAMiv7BCiL24xX5D8XzSFFCmwvQgOMRJrOmNbRqn9xgnitUh6Mi
	 mmp9a571/0B1diX9RqfcemDpHfKeuPX1n+s0v+8Oi8HRZKE59OQhYxjjS5pi8ndJg1riz
	 iGLVzy5QOSlAEPNUzYGCcL4oaC1T9klhoJZbuT4mP4LKcfhPHfyLEXJc4+KNrUod3DNfZ
	 cZjdd9a+rOTgKpbajelM6Z2wdrCxT/jT02xsMC0ToLTsQlO+coaSX/ES113T2IgJZ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870027;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IoudTpnQUTJwPoVFKl0N7MQn0fubXyU9972/M5yWtg0=;
	b=WPwRtVM5UyJogBNdAxcCbtIQSuOa95gr3g/n23gfApIMc4nW/1gRRvpypFFT1Rb6VvOe
	 I9klw6lIYOGau6498JF8i5FZ1LBjoi0hCjTOO2Ipo70U2UW7aQvrDXS5DIZB8JbkLHGBc
	 dBB0aI1Pd0TqeYgD16VhMQOeoLrwuthUB+j+5xbUVoy5tNCAW+24mHz5phKZebMOYGXCQ
	 VkXFtfrefeGvbHELem+0RYm3JAaFnMaXf1p9k9JuEYQI/HO/rEBQPFRK5WEtLZkJnYwwb
	 tmUl7D1zebEdqXm3vDgFtsbcPv/z9AigajX6fTYG+nlHkEUoxXx8ZVzNbn9RVG89HPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=YTH9swQF;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=OjDgjSWT;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B8606A31B;
	Sat, 24 Oct 2026 19:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C4B8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=YTH9swQF;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=OjDgjSWT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 9AC8826F768C;
	Sun, 25 Oct 2026 04:27:04 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792870024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IoudTpnQUTJwPoVFKl0N7MQn0fubXyU9972/M5yWtg0=;
	b=YTH9swQFWeDZEKvY/dB7HIUmqY41YtlQ0sDMgaMOYaXmxYBlW9sMTaA3wZmRraAmkP7QFQ
	6CT0+q1brjU6KjvVQEWdcjy5hizVQIi4dJG22WnAf/Ry6BPC3Iw/2U27096XcyOt0lUGSG
	lB0sIQ0lKNK7u01HUMPHyS3ZxQtqICkvlwga+c6qQrvdSd+tEbvvVTVVxc9ZomjsdAS7vV
	2r98PM4stmpPQK3A3Rp3c+MI7sQOIqLbRgjuskoUCjclir3xWVs/QRqQEecbmeX3WSR+J0
	o3HLduuQBTZWjtIPlEx7oJrw8dI01BJ3GE05d+TTTduawLWz4Fs5tX8HE50o4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792870024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IoudTpnQUTJwPoVFKl0N7MQn0fubXyU9972/M5yWtg0=;
	b=OjDgjSWTLtyMdY5r0vR0yi8F6wWO5b7jDn6tencEdNXRHdhpkomD3+3UixGFEfjagN3m7d
	RQd1njq2ui/6cGCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 2FA7EE0008F;
	Sun, 25 Oct 2026 04:27:04 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 2361B22000A4; Sun, 25 Oct 2026 04:27:04 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fat: preallocate space before expanding in
 fat_cont_expand()
In-Reply-To: <20261024013021.251898-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261024013021.251898-1-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 25 Oct 2026 04:27:04 +0900
Message-ID: <875wyqdhmf.fsf@mail.parknet.co.jp>
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
> fat_fallocate(FALLOC_FL_KEEP_SIZE). Use a FAT-specific
> fat_cont_expand_simple() instead of generic_cont_expand_simple() to
> avoid rechecking the new size after clusters have been allocated.
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

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
> Changes in v2:
> - fat_cont_expand(): Hold truncate_lock around fat_truncate_blocks().
>
> Changes in v3:
> - Add a new fat_cont_expand_simple() helper that does the same as
>   generic_cont_expand_simple() but without the inode_newsize_ok() check.
> - Use the new helper in fat_cont_expand() instead of
>   generic_cont_expand_simple(), removing the now-unnecessary cleanup.
>
> This patch depends on:
> https://lore.kernel.org/linux-fsdevel/20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br/T/#t
>
>  fs/fat/file.c | 70 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 3aa541c6b127..a25531d9451e 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -217,13 +217,62 @@ const struct file_operations fat_file_operations = {
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
> +static int fat_cont_expand_simple(struct inode *inode, loff_t size)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	const struct address_space_operations *aops = mapping->a_ops;
> +	struct folio *folio;
> +	void *fsdata = NULL;
> +	int err;
> +
> +	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
> +	if (err)
> +		goto out;
> +
> +	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
> +
> +out:
> +	return err;
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
> +	 * fat_cont_expand_simple() because of batching.
> +	 */
> +	err = inode_newsize_ok(inode, size);
> +	if (err)
> +		goto out;
> +	err = fat_preallocate(inode, size);
> +	if (err)
> +		goto out;
> +	err = fat_cont_expand_simple(inode, size);
>  	if (err)
>  		goto out;
>  
> @@ -263,12 +312,7 @@ static int fat_cont_expand(struct inode *inode, loff_t size)
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
> @@ -281,19 +325,7 @@ static long fat_fallocate(struct file *file, int mode,
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
