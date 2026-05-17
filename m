Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16335359A70
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009317; cv=none; b=B1om0EN8xsAbmEUkhR3qGyDLtHzZ8J8an1zwsgQsldrjjUN8SmZin5Q7tgt/w9FyMxRjQl9CTf14Fealy6Cb9yMi8oL7dg7NYca+fgeYN4cXm3T1wyrD8ThS1oWehEKb8PBX0UxsJMx2lmlPIHMiONPM7Sl1hSPswuIyPhZGcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009317; c=relaxed/simple;
	bh=61Z1Wd1LuFtHc0CWXwDXGlmkcFLquQFVca5tQpsQg6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnKMyU3UcHqitEcW/qzDbxSYMehfUH5zxtWqsGRVXFcZAyyIFrrBsf7kJ+Uons5ijwkk1MtSITNToUiDHaTskE17Aow1/jh6qLeJomhCM2B0wQxTkcn7lrOXrjp62VFJeF2pJfHjGamvbC7MRdyy18Yox9r89IHwg1jnPMUgQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuS7fwfu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuS7fwfu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso12753375e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779009314; x=1779614114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XN1c+TmyGX2w/UYxycY7xEq81VHA1tvYN2TkPmssO/0=;
        b=FuS7fwfu6dkS/ipWEVMkYQKsYDcoZ2qo5nlpj5PPmgk3N8qyGJAvfusmwngdwzdy+X
         FtlG+TLXe39qHh3pJKHTACE65y1NHicKfPHnzC9CYfJ0NstBMTiyYBCSYJDSlVOpOqCh
         EsH2LONZE8zImsxzqkTbO05aGnabdlN3gfji+eIDukoIfgfdOiv+hfLbh0fDvEjyd1Ow
         178VJDQ8MsUjxwXV3XCtbQ7zEOuDU/SnfXq1VmPZF4t/gmkXMMBjk4/QewfQ/JsEHz+j
         lOrTvypH/+pM0UphjjdQvKLmkSaDpOVGAGCbl59gCeRS6Q16nNwk25gHHE2CH34oZ58r
         rl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009314; x=1779614114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN1c+TmyGX2w/UYxycY7xEq81VHA1tvYN2TkPmssO/0=;
        b=AD124L5eMH6cZ1WidVlHluj+S/Uz1T0PA2Hl9f5dSi7udRl17DeoOmM9q8aIlpvfNM
         ehR6o4trBKs0u70ydB/vNdgdQAJKGvW+Qw2tJAOrV5oK9Yq9bunqgsi4lJ3UsZn4zVT6
         XQwdKijBLfJhW1acPWXUOcahU6kRu9VgvXtulazffdK6p930qb0gFEXR+gZ3c/k5x67R
         6IGJqHmcRYJn1jmBpcOoGCoXL72hMfQ8cQ2gh0pN6VcbNuxKozYpUKfT9mi1IvlnkIOS
         gkEWPq+doXVzl06nz3XhQiRwJ9sg5mmtBgDvwt3zR69dxpUaJPHWUleRrmObXiV58d/F
         GRww==
X-Forwarded-Encrypted: i=1; AFNElJ8Rkm2qbQWaujoRYoVlYnV9zgWhiTnrvyrmgtLoUoDZ7TgbUxqPcJ9LFTf8LaYTKKI2R5Pq3vQD9rJnZD5K@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvoF+EoHsqnD1sMnDaUIEg9ulSRv60yMasoulN8Jq1pnfBnkd
	O/Y+neOk8a16WEoTKcRZVuhNulk0TDNJBC4/MV3DQxp+nj5sMpl5WRQC
X-Gm-Gg: Acq92OFUvH/GqF1ZfhWOcByB4xZYWCGxIrG2a9ePbtAw9EqHBxxyVnw/5FRJ9IedZx4
	qeCYt2iVY11dBAWz/c85Bz6/ytaL5OT66FKcLIq3zImYFAu86QDrYD2YWKd0Ngly7YMiNoCLIyZ
	An+UYWYmvfmFceKjtl1Wqo6VzsCZfEsGZFBWZxvN+EF6V9ciqrPyuTLsZurrXjF80IkLyUphIK1
	UVseo1btVgYhClf4aA+0dGHEme8dvgVkSFf2Bepbxh67qXc9aU3VHRD63IDPqhdZ0vpuSo6lwKm
	Bc6oJJpL4FkgPWWpSt6Larj7RyS1Ycs88cPvaSYGfCmomCxyzU3Exdzqk8zl4/btJsNTBsxHLMz
	mQu/5OQ8459w1lDayoBGqgzExpjc22S16la1L5hqBMPzeJBYpj0WfpFB1Ifo+AzKQ8s6W8nwuSV
	SRITXUae3gxvBfg/46rrBs7hRm2bE0aReD1jvhGHQ1gCYEtruCFnhfBSyVP+6tev6HpmuZ7r3HW
	0ZErPfC3Q==
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48fe6325978mr150764275e9.20.1779009314306;
        Sun, 17 May 2026 02:15:14 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm98809525e9.9.2026.05.17.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:15:13 -0700 (PDT)
Date: Sun, 17 May 2026 11:15:04 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <5afacskoalmd2u6s525dosvyrtr3j66ajd5m4p2ylymtlgytkz@excrdfpndx37>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>

On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> From: Horst Birthelmer <hbirthelmer@ddn.com>
> 
> The dcache only shrinks under memory pressure, which is rarely reached
> on machines with ample RAM, so cached negative dentries can accumulate
> without bound.  Give administrators a soft cap they can set,
> and a background worker that prefers negative dentries when reclaiming.
> 
> Two new sysctls under /proc/sys/fs/:
> 
>   dentry-limit             -- soft cap on nr_dentry.  0 (default)
>                               disables the feature; behaviour is then
>                               identical to before.
>   dentry-limit-interval-ms -- pacing for the worker while still over
>                               the cap.  Default 1000, minimum 1.
> 
> When the cap is exceeded, a delayed_work runs in two phases:
> 
>   1. iterate_supers() draining only negative dentries from every LRU.
>      Positive entries are rotated past so the walk makes progress.
>      DCACHE_REFERENCED is ignored here on purpose -- an admin-imposed
>      cap should evict even hot negatives before any positive entry.
>   2. If still over the cap, iterate_supers() again with the same
>      isolate callback the memory-pressure shrinker uses.
> 
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
> There was a discussion at LSFMM about servers with too many cached
> negative dentries.
> That gave me the idea to keep the dentries in general limited
> if the system administrator needs it to.
> 

I wrote about the negative entries problem here:

https://lore.kernel.org/linux-fsdevel/f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43/#t

The mechanism as suggested here will end up evicting *useful* negative
entries. Granted, they will be recreated soon enough so it's not a
tragedy but it still is an avoidable perf loss.

What is needed in the long run is a mechanism which aggressively
recycles stale negative entries and recognizes which ones should be
saved for the time being.

Below some magic threshold you just allocate a new negative entry.

All new entries would get a grace period where they need to get hits and
prove useful OR get whacked. If you are at or above the threshold and
are allocating a new entry, you can whack the oldest negative one which
did not make it.

This is just one idea, what is not up for debate is the discrepancy
between small subset of negative entires with tons of hits vs the ones
which get virtually no traffic at all.

Whatever the mechanism it will have to take advantage of it.

> This is somewhat related to [1] where it would address the same
> symptoms but in a more unobtrusive way, by just garbage collecting
> the negative and then the unused cache entries.
> 
> The other effect I have seen regarding this is that FUSE
> will not forget inodes (no FORGET call to the FUSE server)
> even after the latest reference has been closed until much later.
> 
> In a FUSE server that mirrors the kernel cached inodes in user space
> because it has to keep a lot of private data for every node
> this puts an unnecessarry memory strain on that userspace entity
> especially if the memory is limited for its cgroup.

I don't know anything about how FUSE works. In this context I presume
you have a mount point backed by FUSE and the problematic memory usage
stems from inodes created against such a mount point.

This would suggest you would be better served with a mechanism which
allows userspace to cull some number of dentries for a given mount
point, maybe even with an optional preference for negative entries if
that's considered better for given fs. 

Or to put it differently, I would look into exposing sb shrinkers to
root instead of rolling with a global scan.

> +static enum lru_status dentry_lru_isolate_negative(struct list_head *item,
> +		struct list_lru_one *lru, void *arg)
> +{
> +	struct list_head *freeable = arg;
> +	struct dentry *dentry = container_of(item, struct dentry, d_lru);
> +
> +	if (!spin_trylock(&dentry->d_lock))
> +		return LRU_SKIP;

If anything of the sort is to land, you definitely want to pre-check
d_count and d_is_negative without the lock.
