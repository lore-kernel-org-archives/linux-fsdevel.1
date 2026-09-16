Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC38495AE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601807; cv=none; b=sHkaaWwbapC5y5OPIqOAkNkW71jvK7XcGA0txeu+YsdEG7t5+TTbiVGa7oNnAxwjRhQwJZ+fC0xLH529Fy6UXw3QTyElqTmVeQ2nvWr5RwY8bmTgk5ZT4Z73lFyFVlmxbFf+f5TzCFmSOd3PN7suqbk0b3O41LnVbv5XwNt06h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601807; c=relaxed/simple;
	bh=aIdtu2I76j/DiWgc8Qm/F+IYAetiKvaeuxEq+WvqmeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTv+2nAyFKI6CoVSoie3N4MIpMrbR1EUEX3CdSTY81kB4pawiUKE9We9MaTvP9EPq6Xg+7dz4vCvgiJGc+bJvNNorg1F/HKFthsCayA/bRh7FkBiVGfKHb8zUjO/mB0qGy0TqrmdwMVHP19NZG1BBiUI6Io9rbpvBcHJzH86TEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CSYKYSSs; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CSYKYSSs"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aIdtu2I76j/DiWgc8Qm/F+IYAetiKvaeuxEq+WvqmeQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789601802; v=1; x=1790206602;
 b=CSYKYSSsHDrr/1LEPdYZWXPkx2B4IGIC3rTUCrNaLWzQkZaEPaVLoInHtvBnH4WsFYIiSUiM
 prnewEIAExPf10/owxuXNg/NELT8M59C4CLsbV7E75+wLIGddNmtXxnjQu+L7Jnd65Wf7xPrQIN
 DO/fmpr5rPWxnsC3u4wRT3RU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4af75b0470ea2add;
	Wed, 16 Sep 2026 23:36:42 +0000
X-Mizu-Trace-ID: 4af75b0470ea2add
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 16:36:41 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, david@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] mm: filemap: move lruvec accounting outside the xarray
 lock
Message-ID: <aqsn7pG3UTECs3N9@linux.dev>
References: <20260916125122.2696271-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916125122.2696271-1-usama.arif@linux.dev>

On Wed, Sep 16, 2026 at 05:51:22AM -0700, Usama Arif wrote:
> __filemap_add_folio() inserts a folio and updates mapping->nrpages
> while holding mapping->i_pages.xa_lock with interrupts disabled. The
> XArray insertion and nrpages update require the lock, but the lruvec
> statistic updates do not. With CONFIG_MEMCG, those calls also update
> per-CPU memcg and lruvec counters and notify cgroup rstat, extending the
> critical section.
> 
> Move the lruvec accounting after a successful XArray insertion and
> after xas_unlock_irq(). The page-cache references pin the folio, while
> the folio lock keeps folio->mapping stable and prevents removal until
> accounting is complete. This moves one lruvec update for ordinary folios
> and a second for PMD-mappable folios out of the serialized section.
> 
> In a 30-second system-wide perf lock contention -ab capture on a
> production host, the hottest caller-stack record attributed to
> __filemap_add_folio() had 20,867 contentions and 557.930 ms total wait.
> That was 14% of the 3.998 seconds of aggregate lock wait in the
> capture. Moving lruvec accuting outside of critical section should
> help optimize it.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
