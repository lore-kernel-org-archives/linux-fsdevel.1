Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246430BB84
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383295; cv=none; b=HHKChTayD/03x6gIIsGClSh7lAAZwg7mEmz+7ndyJ+p4emmk1j+KHRtIP0sJZc+kTd7eV7WK8elo9Tmw7yiwLRR22/qRTwP5KF2xFybadeZnXOAXeS+ih6CVo4UogCwoUTJfHAD3Sx2KwhS9OXJZ2vve0qtPculT8YTLqMZ58cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383295; c=relaxed/simple;
	bh=xrHJ8FLoyrKO+TvdGBpvglHNIdNnYNfrnT1rl9a+Uf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVEJdFTRD2d5vgulBtw3eqvPAPLR3vs59XEGhND8KyP6WBdhI3ocNrhz/6qvmECPkh4D+BBglcnnOkj0JzxJ+a4mVUjzTpgMTXRZWB661YA+0hEVbfKRkSdUDJkIPIoE6vOcro126G9Du6LSPwb6TVe+uYhoyR3aP7y3SqE4+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYvwkb+G; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYvwkb+G"
Date: Fri, 6 Feb 2026 14:07:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770383283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciy2P1Z176PpXYoHYQyk79cSli5pb9EG5H+by8rz7gY=;
	b=OYvwkb+GqpBDGAVzHLhxNOVgS7wLbirSOLHDbLfTtLL61UP0DVOJIWENM3oVO921gs6v3n
	p4H9WAnOLJ9KNS+699BOJWVTBFLOIm1JhChnrJ0affE1ooaMPrfkphBX1pFVtO0eZLGg8C
	jri76vZD12E5Ykw6p+fKrn4qYJmWbUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <tq3nyswm72gackesz6v476qqvin5eaa67f4hf6lg52exzv7k7p@tczjh5n777tc>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

> +static DEFINE_SPINLOCK(xfs_healthmon_lock);
> +
> +/* Grab a reference to the healthmon object for a given mount, if any. */
> +static struct xfs_healthmon *
> +xfs_healthmon_get(
> +	struct xfs_mount		*mp)
> +{
> +	struct xfs_healthmon		*hm;
> +
> +	rcu_read_lock();
> +	hm = mp->m_healthmon;

Nit: Should we do a READ_ONCE(mp->m_healthmon) here to avoid any
compiler tricks that can result in an undefined behaviour? I am not sure
if I am being paranoid here.

> +	if (hm && !refcount_inc_not_zero(&hm->ref))
> +		hm = NULL;
> +	rcu_read_unlock();
> +
> +	return hm;
> +}
> +
> +/*
-- 
Pankaj
