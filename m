Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB83630A7;
	Fri,  8 May 2026 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284426; cv=none; b=Ah4iTdDG2gaXny+uZQqlaesUbrlhOBbSOJwh+liqNWWtoZi4GCqJTf/kgQr89XR24v95FIkArFety0Ey6bWToNsECOH6KjkXdj+01MogLleMDPbMrKviVm648URe8nz3U0GjTOPQb1EkP/4GOowEnX5vyDWUU7u/q5h1Hb3M1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284426; c=relaxed/simple;
	bh=VWosNBs3YnxgmEDyU8/Ih9kX3QO9bATo1LcNhVdrsvc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jlOVZV6z70ZBm464NeMkkmSoWrvBdZoYzR9/0EvrK5uP6Q3RcRwQMXbEOVHKpeGTLwBgtL+92iBnAFAowrT2brHi7tSDl52tZ/HCx3/5GXYYuZk85lQ7LzuH5QxlYY3qsK6FMPaRWFgDy2DL0hNxH9RHa2+sJpkPTfukz4CwrSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FyXfE1Bw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FyXfE1Bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A107C2BCB0;
	Fri,  8 May 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778284425;
	bh=VWosNBs3YnxgmEDyU8/Ih9kX3QO9bATo1LcNhVdrsvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FyXfE1Bw17tGd84Y1nB23Z4B842vomjgd0qwV5ygZ3GLhlA47c6eItIXl4WWJDTdN
	 s+U4YbcPMwY4QUDuBJwcHVVV8x89mBrzJTtzzv+f2R/Fo1rc4wnG3wUFzhx7NZlrGC
	 pB6Vh+khkAmXJXplPLimbtqRIox/coQg0jO2CrRg=
Date: Fri, 8 May 2026 16:53:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, Kalesh Singh
 <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: no PG_readahead on EOF
Message-Id: <20260508165345.b40a73da1dbb45a95c55c0c1@linux-foundation.org>
In-Reply-To: <20260508181237.670645-1-fmayle@google.com>
References: <20260508181237.670645-1-fmayle@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 11:12:31 -0700 Frederick Mayle <fmayle@google.com> wrote:

> When readahead pulls in all the remaining pages for a file, setting the
> readahead bit is counter productive. The async readahead it would
> trigger would almost certainly be a no-op. Additionally, for mmap'd file
> IO, the readahead bit limits the fault around [0],

There is no "[0]".

> causing an extra
> minor fault when the page is accessed.
> 
> This was discovered when looking at /sys/kernel/tracing/events/readahead
> traces for a simple program. With the patch applied, fewer
> page_cache_ra_unbounded calls are observed.
> 
> [1] do_fault_around calls filemap_map_pages, which finds eligible pages
>     by calling next_uptodate_folio [2]. next_uptodate_folio skips pages
>     with PG_readahead set [3].
> 
> Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3921-L3939 [2]
> Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3721-L3722 [3]
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Frederick Mayle <fmayle@google.com>

AI review found a little race:
	https://sashiko.dev/#/patchset/20260508181237.670645-1-fmayle@google.com
