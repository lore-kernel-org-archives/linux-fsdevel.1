Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BB18DB2A;
	Sat, 29 Aug 2026 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788027384; cv=none; b=gbVyh/LyIbEVITZSp452zML6+XdRD5CcoImHzfoxYjCS5ogWMHc9bfYTZs5dbv4e8Wx+Y6iZ9MPI411Aoxr8JHH9Qfep1lWLvH3dwmr2jQ0fwmXWBd6DCr07hvgLcDBpYmjt/jlPX1I68aksM4WRC/CXzFFgW+kIizdb+RoiKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788027384; c=relaxed/simple;
	bh=04l/zhWJykGHMBGVJtSh3BFqCClk3KPCcUczODLkXYA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KIq4CwEQEAukMbzXJmjCWk2vOFhfJjpxaekvHDEWNsJOm789QC02EC7zKy0oVvHVvst9w+OohmKN44qOzGNFg35jKCEkbF6MObv0/tyEhup5UCpa58/suzNF9Q6GUmAMrqHvMbC12y2mSHykfHlUb4QcMcPhNuGG1lFE53iseCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s8FkMU0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s8FkMU0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477AE1F000E9;
	Sat, 29 Aug 2026 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788027382;
	bh=ANn3dkxv4l6tBre7EfHFtYBd4s+4pMK21CPn4TKtlP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=s8FkMU0eJdSVnxI8pv8KuXVh74oqlbwsnk0swYPtcopCFCTbk2lXUb4VJJZpx0pwB
	 bEej4Qq0i3wF5woKSp6muVsHDepUyvumzR2Z06v5GkGb5ZNz5UaARYj78Y8ORXPvGk
	 KMFH4Nhj/BptQJMt/ZH5RoQVpFUKV4ewlqV1ZKhI=
Date: Sat, 29 Aug 2026 11:16:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
 axboe@kernel.dk, trond.myklebust@hammerspace.com, tz2294@columbia.edu,
 qiwenjie@xiaomi.com
Subject: Re: [PATCH v3] mm: filemap: retain mapped dropbehind folios
Message-Id: <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
In-Reply-To: <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
	<3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
	<4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 01:36:12 +0800 Wenjie Qi <qwjhust@gmail.com> wrote:

> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> Fault-around can map ready dropbehind folios without going through the
> normal page-cache lookup that clears dropbehind. A mapping represents a
> competing cached user, so retain the folio instead of forcibly unmapping it
> when writeback completes.
> 
> For a mapped folio, folio_unmap_invalidate() can call
> unmap_mapping_folio(), which takes i_mmap_rwsem and may sleep. Retaining
> mapped folios avoids this path when folio_end_dropbehind() runs in
> non-preemptible task context.
> 
> Unmapped dropbehind folios continue through the existing invalidation path.

Thanks.

When fixing a bug, please always provide a very clear description of the
userspace-visible runtime effects of that bug.

From the above it appears that the current code can trigger a
sleeping-in-atomic warning?  Has this been observed in any situation? 
Is there a report?

chatgpt easily prepared a reproducer for me, which I haven't run.

If I'm correct in the above, we should backport this fix with a
cc:stable tag, do you agree?

