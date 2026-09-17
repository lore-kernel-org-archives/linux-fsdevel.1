Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0BC385D69
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617369; cv=none; b=GkNC5tGCm4RyFWpeTZidrlErOZGkZd8MYBBP9FeeBUVqp3E9Pv7qSMX2q8R786vBZckQwyrrF9z+at/fZ478WOGsDQyOKWaN4tP+PLEZ5NWGJL5KBCRdXrVm/5ekdgYiMfNCX/JygT06NoX/1A0samNaRXYieWcxF7Oz49hhR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617369; c=relaxed/simple;
	bh=HUl8bRaU0gbRRqk2r/mBcfDPY8VXOzcdedIQhAftkok=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r/ZxlJy1SrIjO7LCoXcXHzlxm4t96GwTnhUo0hF4Wu75K1nLSuRMfg45g+/9Doc4j1nbyu14QpUKQaby8kAhi0qeSiRQRev5fI3Xn0k8dZdXRQj+Rs6PZpqD4byCA6ox3deWJ+aoqnnu6XO2/264YPVTC4lRczc5HfGkyZp6ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=riX5qEG3; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="riX5qEG3"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HUl8bRaU0gbRRqk2r/mBcfDPY8VXOzcdedIQhAftkok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789617364; v=1; x=1790222164;
 b=riX5qEG3NAfL/qYOy2XvUhmnk0yL9gBz+Z+3bjqu5Rqfl43d2rrXgKhM7zol0bYkNTkYJ0fY
 Fi2BaEg+DnvrpX5g2/2Ijj9R4jL2e0VOMDaajzb198DyXFvFq/GB9wRFy1OcMl6Qz8sQwYnV55o
 jjjUPDgHlNWc34FKJL2cKb6I=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2f3142f7717fb54d;
	Thu, 17 Sep 2026 03:56:04 +0000
X-Mizu-Trace-ID: 2f3142f7717fb54d
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] mm: filemap: move lruvec accounting outside the xarray
 lock
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260916125122.2696271-1-usama.arif@linux.dev>
Date: Thu, 17 Sep 2026 11:55:47 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 jack@suse.cz,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 willy@infradead.org,
 david@kernel.org,
 hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 riel@surriel.com,
 shakeel.butt@linux.dev,
 kernel-team@meta.com
Content-Transfer-Encoding: 7bit
Message-Id: <E7CB9AC2-059E-447E-B248-DC383D346457@linux.dev>
References: <20260916125122.2696271-1-usama.arif@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 16, 2026, at 20:51, Usama Arif <usama.arif@linux.dev> wrote:
> 
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

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

