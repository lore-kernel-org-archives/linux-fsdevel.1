Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149518;
	b=aW04BasyD6K/5fH2caOD38VaT8pHLjpqnPJMF3QTuULZEC1KqVJ0tcDnNZrCfaOsMKvL
	 l/01V8UD4ATLQPD7ZCCdWOo/VJceRYHHoe7zbGwbt9nam9VDdVa3fmYh0KRqrlbzRN/bh
	 YQEIWBlSO5UtL3FWY93sjKo+3HPJGYgkLP27Qcby5W7g1UHVinXYLjk3cy+2bQIvSWsvS
	 25Xmy+RmiVp31ovwo7sFdj0vVIlgwpPN8Yujml8CeSwfedzyT0Gm7Px25wx0EnFDHKU3v
	 Ppz+HBKaY/JIk0YAfDoVSnexV/dz9P3hlgWi/DqFBe5vYyybc8HlHknI2i+4X1DUl/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149518;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WONswms66s3HZCvWD+0Jqvaby7J3ztSziSaEhqsuQBA=;
	b=a4lWJPWYGl3bqdPN3J5R63g8MkKE/pN9g6eTiMdtYT3Il8KwBJX1tLVD8jXtet0l7CpI
	 8JFzKv4cQ7VqkfNgv538n1f+2gX98jT6QyjmYj8583SBYKtdc+/DtvXzji+hEZjXmD7+D
	 BEuHeehuQSPw6ybB3BnMhx2Ob5DZbmOC2qLt7O/RvBgaAVuxPCR1l6Btu2IhzIGM+4mF2
	 NVjnj6dMx2TThE0jizPaUjUP7nHSygq1LoErfWrFXknn64P/PAdbgd6RvszPqrKrhDO1l
	 Wq20/idMeG4jaeQ2R46Uu/BoX/rzJUkb7/sJM5IqtwR8tBvsl6Pllj6vY8+IhJIzbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=NAZp4rXC;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=3St+wpOf;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8782606A31C;
	Sun,  8 Nov 2026 14:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8782606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=NAZp4rXC;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=3St+wpOf
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 50B5C20BD288;
	Sun,  8 Nov 2026 23:51:54 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794149514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WONswms66s3HZCvWD+0Jqvaby7J3ztSziSaEhqsuQBA=;
	b=NAZp4rXChn3kGJ3reAMs1SbdcogH4hjSlx39nNf0OSMBEFbPrplXkOHgOVPWzBNNF3JFl3
	HfnUJdx7vcPdEMMmjGtKHo0zRKxtJCKKs2/CSC/Ev/gZsIYHINrLFImETu4Cmkse8lBaXd
	8eXhk3xTWfhT1B0PmfFfDysFLhHuAJUOFbaBI3CWfQvXB4VH0QJxJXyi8138NqOsdsc3Ce
	sJPRno0hj1d0VDDagmJK/rJldJ8DJ8a/rES4Ku+Rq/P71eTlq0BqR/BCI5sLFnQmy9sBaW
	MTjno3UUwA8GiHFmOMzNkzTljtxrO5XcpOCnGYRcbNyA4YIqtQVSJK3FWpICEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794149514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WONswms66s3HZCvWD+0Jqvaby7J3ztSziSaEhqsuQBA=;
	b=3St+wpOfDwhq+j2ebLpNLQkRwKYemtd2rrBWAzMi4oDmOUsiyRy60V4LkOpVmIWkOlyiMu
	A00+Ppf2jKqJ2tCQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id CAC50E00042;
	Sun, 08 Nov 2026 23:51:53 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B61FD22001DF; Sun, 08 Nov 2026 23:51:53 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] fat: support FIEMAP
In-Reply-To: <20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 08 Nov 2026 23:51:53 +0900
Message-ID: <87tslrtlyu.fsf@mail.parknet.co.jp>
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

> Implement support for ->fiemap() using iomap_fiemap(). Add a read-only
> fat_iomap_begin() and a fat_get_cont_clusters() helper for finding
> contiguous clusters.

Not fully reviewed and I'm not understanding iomap fully though.

> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/Kconfig  |  1 +
>  fs/fat/Makefile |  2 +-
>  fs/fat/cache.c  | 80 ++++++++++++++++++++++++++++++++++++++-----------
>  fs/fat/fat.h    |  5 ++++
>  fs/fat/file.c   | 12 ++++++++
>  fs/fat/iomap.c  | 71 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 152 insertions(+), 19 deletions(-)
>  create mode 100644 fs/fat/iomap.c
>

[...]

> diff --git a/fs/fat/cache.c b/fs/fat/cache.c
> index 1b87354e24ba..f545e1db1d47 100644
> --- a/fs/fat/cache.c
> +++ b/fs/fat/cache.c
> @@ -76,7 +76,7 @@ static int fat_cache_lookup(struct inode *inode, int fclus,
>  			    struct fat_cache_id *cid,
>  			    int *cached_fclus, int *cached_dclus)
>  {
> -	static struct fat_cache nohit = { .fcluster = 0, };
> +	static struct fat_cache nohit = { .fcluster = -1, };

Maybe this change is pointless?

>  	struct fat_cache *hit = &nohit, *p;
>  	int offset = -1;
> @@ -217,14 +217,16 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
>  	cid->nr_contig = 0;
>  }
>  
> -int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
> +static int __fat_get_cluster(struct inode *inode, int cluster, int *fclus,
> +			     int *dclus, int *nr_cont)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>  	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
>  	struct fat_entry fatent;
>  	struct fat_cache_id cid;

[...]

>  
>  	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
> -		/*
> -		 * dummy, always not contiguous
> -		 * This is reinitialized by cache_init(), later.
> -		 */
> -		cache_init(&cid, -1, -1);
> +		/* Cache the contiguous prefix from the known first cluster. */
> +		cache_init(&cid, 0, *dclus);

Doesn't this add a needless cache? 0 is cached in the inode itself,
isn't it? (and can be waste small fatent cache slots?)

>  	}
>  
> +	fcluster = *fclus;
> +	dcluster = *dclus;
>  	fatent_init(&fatent);
> -	while (*fclus < cluster) {
> +	while (fcluster < last) {
> +		if (nr_cont && fcluster == cluster && cid.fcluster != -1) {

cid.fcluster == -1 is possible with this patch?

> +			fcluster = min(last, cid.fcluster + cid.nr_contig);
> +			dcluster = cid.dcluster + fcluster - cid.fcluster;
> +			if (fcluster == last)
> +				break;
> +		}
> +

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
