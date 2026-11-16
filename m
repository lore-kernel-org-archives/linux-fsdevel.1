Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843495;
	b=vCS9/Qb9rSMukFz8Esp30sdS63Sz07I6GE/Pjum2OhLZhrCn/6bOeK1N+OqdTYFthJiO
	 oOlYM4DQSrnH476GVCFNpqbfwqQDgWa9Mgdeh7Oa9ErCIVuV7UIMQH11SyXUWCDUgX+F1
	 y11iv/aMdW2cSYalXP2B6xTPy0DAOnATqROK06F8E60LUR+7Gp35CvPB6RE8cSUB3sVuu
	 8XvQCqRYughn5HfgKse/yC0Fyfi/xpPENEaZu6UtZBAOlk9xWKsjwITUE0EMxoVr+1JqM
	 V8Wsxo8zJMexdQroKjruNXrZ7DApJprlh5dnh8lgPOy9tB3Ccl5lMDdl94enAmJzQYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843495;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8QkY1AswMgCW3uvRS9sHBimGtyREBTePXz0XOhfcgI8=;
	b=2AMZp28Jscc6oEn7u9xJI7ZzXNXlv/kJ1nVEmxLx8JAOPn61dgFiuVwFPbWNNeRXJMPK
	 tt42di+FqQvsXRCvpQZbX5k4nkY6jTD65vl+tutbA7ES5XiHFuZYA/5ZI24V/8uLUheWz
	 wcOSq2lwY9bNBZNOwx+YfgGOn49ceYES7qJbK9TnqEz+6ZPzc0+QxoieOUlRKjfhYl3F2
	 6pKTTeka+taqub1ZmTpzYbqk5+BrWYElOjGUIBYTphf+VCB28ju2IeQMfQKKC1iwNgDrF
	 wcQEPpLWP/vhlxVNS7nEGkjIox7XJfjLNNGqICmlzpueMGGN/O2xqWR7mUJE7H1JZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB6kz+8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6584606A323;
	Mon, 16 Nov 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB6kz+8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7701F000C4;
	Mon, 16 Nov 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843495;
	bh=8QkY1AswMgCW3uvRS9sHBimGtyREBTePXz0XOhfcgI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bB6kz+8oa0cYXQEup1eywQV9GIotHoHhj0TCZxw5Z5uZIvRYwj8u0leZfYPPcrOyU
	 AzVbMT/Rr8flKtmEum7ALt7bnAbChM96pxXi+w+QRzjPqhE/odtISJItpK6WKsQBjU
	 QWfVzwSCx44ye/9kP3jQsmM1xUoJWdFiCriSAoKxWtcO/RWMHKpS+Vf97RaZ/J6Acd
	 DbnWAVl+VyvF3ZmcS+o96CtFg5c/FKngm+uFONmX0wwLQbH1Xq84PfWf2p27FrxaM/
	 z0XcI9b4jmfU/IF+/+WGju8aCUrngJbnqJo6okt1xbtwKCVLll14DvkCwMV+VWt80k
	 YV8/m26jD3EUw==
Date: Mon, 16 Nov 2026 15:38:09 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Matt Salsamendi <matthewsalsamendi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix stale walk_end after a completed
 scan
Message-ID: <avsjPSUup6pnsZrR@gremlin>
References: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
 <20261112203351.7d5bf7d0f78d652d@chrisdown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112203351.7d5bf7d0f78d652d@chrisdown.name>

On Thu, Nov 12, 2026 at 08:33:51PM -0800, Chris Down wrote:
> Hi Matt,
>
> This patch doesn't apply as sent, because your mail client mangled it. It
> wrapped long lines, including the hunk header and the Fixes tag, and took
> the leading space off the blank context lines. git am rejects it as
> corrupt.
>
> Please send the next version with git send-email or b4 send rather than
> through Gmail, or set your client up as
> Documentation/process/email-clients.rst describes. It's worth sending it to
> yourself first and checking that git am takes it.
>
> Matt Salsamendi writes:
> > +	/* A completed walk may follow an earlier full bounce buffer. */
> > +	if (!ret || !p.arg.walk_end)
> > +		p.arg.walk_end = p.arg.end;
>
> While this fixes the refill case, ret being 0 doesn't always mean the walk
> got to the end of the range. pagemap_scan_hugetlb_entry() can't
> write-protect only part of a huge page. So with PM_SCAN_WP_MATCHING, when
> only part of a written huge page fits in what's left of max_pages, it backs
> that page out. It sets walk_end to the start of the page and returns 0 on
> purpose.
>
> Before this patch, the caller got walk_end pointing at that page. With it,
> walk_end comes back as end, so the caller is told the whole range was
> scanned. But the page was neither returned nor write-protected. From a
> quick test with a single written 2M hugetlb page, PM_SCAN_WP_MATCHING and
> max_pages = 1, the ioctl returns 0 with walk_end at the start of the page
> before this patch, and at the end of the range with it.
>
> Maybe it would be simpler to clear walk_end before each walk_page_range()
> call, and keep the existing check after the loop as it is? Then that check
> only sees what the last walk set. In the same quick test, that fixes the
> refill case too, and the hugetlb case behaves as it did before. It would be
> good for the selftest Andrew asked for to cover the hugetlb case as well.
>
> Thanks!
>
> Chris

Following on from Chris's comments, I think something like this should work
OK? It's also nicely simple :>) And obviously avoids the hugetlb stuff.

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..1b87cc635a34 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3160,6 +3160,7 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 			mmu_notifier_invalidate_range_start(&range);
 		}

+		p.arg.walk_end = 0; /* Reset partial walks. */
 		ret = walk_page_range(mm, walk_start, p.arg.end,
 				      &pagemap_scan_ops, &p);



--
Cheers, Lorenzo
