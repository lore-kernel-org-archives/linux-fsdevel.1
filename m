Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD137DABE
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222544; cv=none; b=WUkO0A1CLHuSBtqkU75lUV4JBvZvI2wmcGfzEkK8k/Sb/WmlZvS5dDJt5vUGr7dnJTvoMc46X0XV2FWWWBxpLs2SnSsooIyL8Pb1zrrovEUzWTaMzprqur8sJjibW7ccgaPOk3mhAYHfegxfMNxm6ZnJ49N+8hhRqjxKmcx+9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222544; c=relaxed/simple;
	bh=5hLTP/P3XdYQeS/UhWLe3ABB+t7RBU6H2JU83DltA94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjfJWV2k37WIZ+LeDKEfIljflorF8BMBfuAj2Qe9u7Zd+RaSXOFMItedglYx5boAvNbQ607rDr97C4bz8/Sjzq5Z79VBSKxqAzfQg64xDeffWc1nRLOSeVYpBjRQ3JuCehY2oCsTq8jZoCAL+xC1f/KRcpMfEoeGkgq+WOLONT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=fheYhx6S; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="fheYhx6S"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dc09919aa2so92557696d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782222540; x=1782827340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UEwlhtuIKP5YrGqIec3n0T3lOyC4o/8ZKXq4ZbpQow=;
        b=fheYhx6SeSSPtx0N/dpQ1pQ+Uy5ypC2tNB7EZnI7vpYZhfyzhn8Rpo/0P2nheWPjbu
         nZhRIJhH4Pu00DrCqMSouGVlKMUsQ29ITggaYGnZ426JK27mja7TxhgZRbF1C9BaNskf
         VIT+8+zYS6HOv64X9qqjvFfZCALVKPU0lvCFJL8JQic7+g29d6QC9UDDoECBBufirdZU
         FlkqUK15CvthvbAAi3sElrVApiEoizM4k1u2sP3tV7bvwC5og4QIM9I8DR2y0Pd5QZjX
         iU6qBCCX8lU92l/h7fyaKc58/iH6xb6MKoMkUVGK42/WD2ijiX2r/GM1iH+roIwCmg8F
         ikrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222540; x=1782827340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UEwlhtuIKP5YrGqIec3n0T3lOyC4o/8ZKXq4ZbpQow=;
        b=V2KOk0RHpZi7juPZMQy13KoB7dxriac0MempZFBUD6k/tZlX3yfxyQNg2PL1kfEATE
         7b1k0SfiBA/R4UwIpXULcV//4ICYcuzMocTiMGZljFld4+4K+UEBV/OOFnUYY1NTU3lC
         M5So3Dk0WLgjPIXaWFQqUj2smuJhGiBN9J3y+q+Ks225JbAes9qhKH9PuW+VfTZXIv/q
         GMNsp8uU2uemw5o+7iyVpl/FZXgdG9PU0NlsnuREGJOqkTaG/KBq4z2hUbCuA1xFdesa
         R34btvWmEw7qECNr5WlXC8V/exqw4kQeldh168497kLWfmwPeKERE6i9RPlqiPIWPAfr
         4q2A==
X-Forwarded-Encrypted: i=1; AHgh+RoroOfBPfbdzde40e3W+roS6BKj3TyU00Sq3UGrwSXJMpRM+Yn5/+/etNkQooIYSfpD43v8+6TUkxlvsV4J@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcwbf/fu0cNqqwm6Te/5OaO9BwtroCdyyPVZkDcEGj6ILKLzID
	xocmBu3OgngD2TAv6s8LDhp7f0r/wlBBP9OzyEHwNPkSc8gzgEeX2EYfUroQ+JG9E7Y=
X-Gm-Gg: AfdE7cn1SSJcxc49cXw3JFYOebGwPMr9u1uBBSinpMxH6G7vm5dIIverezUiEXGPAni
	MPPvG3ul/KAF+u+R+W9j9h4Acgv6MwxYSYG95i795ZniJYlAC5Ucu8ZrLbx9o+zPlHJQ4B1zikr
	5glRCGEpO88xMtWzTPRk++hFFRL95XU+djP4VCotojnMM8Ha1uyRj5zRVtfqPYSRu6gcHoNGShC
	y2phdbRnDUoy5QG+eP6Q/bn5yr/lyVaeImaevpZbGzVZ62frmNUJk66VAmsSdk9I10ynZvY2dlG
	OITs9j94eISsdO8pzGbKPAM5uFiLCSXq9XpmcCNVmA1+KkOZJgJJAqYZIhA6V2yoOurp0UIYUj1
	lFjYCabIifUjHaoe/xjlpuoLlQqnd9IzbdgE2Kvz9QOqRM2o3d/xr2FXH/dbSh648IgGYd7OI1X
	BoBE0rzUF8/dA=
X-Received: by 2002:a05:6214:300e:b0:8cf:9bd:744 with SMTP id 6a1803df08f44-8e433ec929amr44182646d6.12.1782222537871;
        Tue, 23 Jun 2026 06:48:57 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82692405sm125810356d6.39.2026.06.23.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:48:56 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:48:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] fs, mm: add ->cachestat() file operation
Message-ID: <ajqOyIA8tPQsxfz6@cmpxchg.org>
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-2-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623111533.2285005-2-ptikhomirov@virtuozzo.com>

On Tue, Jun 23, 2026 at 01:14:48PM +0200, Pavel Tikhomirov wrote:
> The cachestat() syscall reads page cache statistics straight from the
> file's f_mapping. Stackable filesystems such as overlayfs keep the data
> pages in an underlying inode's mapping rather than in the overlay
> inode's, so cachestat() reports all zeroes for them.
> 
> Add a ->cachestat() file operation and route the syscall through a new
> vfs_cachestat() helper that calls it when present, falling back to
> file's f_mapping otherwise. This lets stackable filesystems forward the
> query to the file that actually owns the page cache. No behaviour change
> for regular files.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
> Note: Memset change might be a bit tricky, I moved it to no
> ->cachestat() path to avoid multiple memset on nested overlayfs, that
> means that ->cachestat() is expected to be able to handle unitialized
> cs.
> ---
>  include/linux/fs.h | 10 ++++++++++
>  mm/filemap.c       | 43 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6da44573ce450..966b6564707e4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -53,6 +53,8 @@
>  
>  struct bdi_writeback;
>  struct bio;
> +struct cachestat_range;
> +struct cachestat;
>  struct io_comp_batch;
>  struct fiemap_extent_info;
>  struct kiocb;
> @@ -1963,6 +1965,8 @@ struct file_operations {
>  				   struct file *file_out, loff_t pos_out,
>  				   loff_t len, unsigned int remap_flags);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	int (*cachestat)(struct file *file, struct cachestat_range *csr,
> +			 struct cachestat *cs);

I suppose you can't just have it return the real file because of the
with_ovl_creds() scope you need during access? That would make things
a bit easier. But short of that, this looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
