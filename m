Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66F51C048;
	Tue, 13 Oct 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897434; cv=none; b=Rs31CnazYtvfH7higwGXqwEXGdrEEQqEn9PNmFfCCZtPCletQduKA7ZgrA40vkVmG8FtBHPoBJzmM+VTRnsytThodpFK/3yvpomAZNZFne4GSM8oeLH02CpZbqtCCmaTwby6b2jcomVD6RAYjwGPar1URiBNSkNanom00VKWQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897434; c=relaxed/simple;
	bh=Dq2alZjO3ENVzgTwaL2ZiF2++t9OWlnvMI32a9UPa8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umU5CzUDk6S7+bB4HLLnSqLQhc1RX1hvNjUgfT8IigR9Nl4cspY5yEp7uQPAEKeUyMUsbj7RH4nFwKxkUUaO091Sjvd5FpIiY7smB7+/3ba8WxqVW0UpCV21RC7JjCH1MgkKSCB7AJPqs6f1qqpxqJkLeJ4WNh7T+TtWBtryEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Uq47VpUH; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=drm2DVe1; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Uq47VpUH";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="drm2DVe1"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 107F326F7697;
	Tue, 13 Oct 2026 22:17:09 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791897429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0iHM5W//S0gNFt+uA6PYxA+9Kd/ML1/sCR80793UNE=;
	b=Uq47VpUHjOJqq2zfqnlg9qwpYSPqyiN4I9+/BSYQ5BzqwIOXEBkLKt3bOVkOSKFu6BjFnC
	/TbaOy+a1k02u/H5ElVx/VlUsntxRh4CUyobV9VOKpA87VRbTE8sq2Wc9r555OGZBQKURr
	QfW8gXP8trnuRn1CjOKxWGK8jNFXA/d769m2y2iqFTaw6r/ReBKKvwnQzthWoLmpIVboDq
	hPV7Rmmx/Rdp68lTPO3T4XjingknC7cPUyGhmRulK7QDliSx7Zh/JsAhc39x//gWW4ammu
	0ennt2F+CS+zCbx+Ndf/tYXKt6/ZZyovLXirQSPh20v/qedqqzdqSjxcI1erxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791897429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0iHM5W//S0gNFt+uA6PYxA+9Kd/ML1/sCR80793UNE=;
	b=drm2DVe1Zjs6m9Ll6v+uP3ICMM2X3hqqY2398nMX02MC/8NTXO7CibFvZ537LLbSzzGKMH
	BjDPCeN39CSJR2CQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 8D639E00149;
	Tue, 13 Oct 2026 22:17:08 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 85ADB22000A7; Tue, 13 Oct 2026 22:17:08 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fat: remove cluster allocation size limit
In-Reply-To: <20261012171106.146243-2-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
	<20261012171106.146243-2-matheus.aalmeida@inf.ufrgs.br>
Date: Tue, 13 Oct 2026 22:17:08 +0900
Message-ID: <87ld81n3jf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> fat_alloc_clusters() currently BUG()s when asked to allocate more than
> MAX_BUF_PER_PAGE / 2 clusters. This limit comes from the buffer_head
> array used to defer syncing and mirroring.
>
> Remove the allocation size limit by doing buffer_head batching like
> fat_free_clusters() does.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Looks good. Thanks.

> ---
>  fs/fat/fatent.c | 44 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index f0801d99d..bfab8eab5 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -468,6 +468,26 @@ static void fat_collect_bhs(struct buffer_head **bhs, int *nr_bhs,
>  	}
>  }
>  
> +static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
> +			 int *nr_bhs, bool sync)
> +{
> +	int err, i;
> +
> +	if (sync) {
> +		err = fat_sync_bhs(bhs, *nr_bhs);
> +		if (err)
> +			return err;
> +	}
> +	err = fat_mirror_bhs(sb, bhs, *nr_bhs);
> +	if (err)
> +		return err;
> +	for (i = 0; i < *nr_bhs; i++)
> +		brelse(bhs[i]);
> +	*nr_bhs = 0;
> +
> +	return 0;
> +}
> +
>  int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  {
>  	struct super_block *sb = inode->i_sb;
> @@ -477,8 +497,6 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
>  	int i, count, err, nr_bhs, idx_clus;
>  
> -	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
> -
>  	lock_fat(sbi);
>  	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
>  	    sbi->free_clusters < nr_cluster) {
> @@ -509,14 +527,21 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  				if (prev_ent.nr_bhs)
>  					ops->ent_put(&prev_ent, entry);
>  
> -				fat_collect_bhs(bhs, &nr_bhs, &fatent);
> -
>  				sbi->prev_free = entry;
>  				if (sbi->free_clusters != -1)
>  					sbi->free_clusters--;
>  
>  				cluster[idx_clus] = entry;
>  				idx_clus++;
> +
> +				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
> +					err = fat_flush_bhs(sb, bhs, &nr_bhs,
> +							    inode_needs_sync(inode));
> +					if (err)
> +						goto out;
> +				}
> +				fat_collect_bhs(bhs, &nr_bhs, &fatent);
> +
>  				if (idx_clus == nr_cluster)
>  					goto out;
>  
> @@ -606,17 +631,10 @@ int fat_free_clusters(struct inode *inode, int cluster)
>  		}
>  
>  		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
> -			if (sb->s_flags & SB_SYNCHRONOUS) {
> -				err = fat_sync_bhs(bhs, nr_bhs);
> -				if (err)
> -					goto error;
> -			}
> -			err = fat_mirror_bhs(sb, bhs, nr_bhs);
> +			err = fat_flush_bhs(sb, bhs, &nr_bhs,
> +					    sb->s_flags & SB_SYNCHRONOUS);
>  			if (err)
>  				goto error;
> -			for (i = 0; i < nr_bhs; i++)
> -				brelse(bhs[i]);
> -			nr_bhs = 0;
>  		}
>  		fat_collect_bhs(bhs, &nr_bhs, &fatent);
>  	} while (cluster != FAT_ENT_EOF);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
