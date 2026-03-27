Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150B1D5160
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572874; cv=none; b=O9EyqHRhN9g8JFQvrgaSo9YCC9BEQ94rn2mWoHyVQejlbmLZnB/sQQf0/9lMU3sds9kartKs6KYevFJxzpzE/q6xqBej5nxhzRRx3e6Gz5f+sizOhot4+UjKNFqBCKRFcULHZfY02u0OO7iN2iMD57DKjcefmKDbsi5/+jJ9+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572874; c=relaxed/simple;
	bh=A1uSR7ZMVXc9+x0Vd/fZJiBYrJDicq9K19jaALu3MLM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p9iaDEcug5zkfK2sACIV5keGzrGAj43v7y0nlJ5Eo3cs13xJCfZm9iddqrh3qUcWH0FzQbeZPi2f7MEl9GoIlMIR1UYheGqc9ccr7oaFhxgmJa3Eir6kfsU8ThoHfYufJG1LukHk6mJgyPmzzfmXlR9qiqZAc6t+QJwV2L5JlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RCUN1u2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RCUN1u2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB864C116C6;
	Fri, 27 Mar 2026 00:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774572874;
	bh=A1uSR7ZMVXc9+x0Vd/fZJiBYrJDicq9K19jaALu3MLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCUN1u2PKz2KarhxjiCebWq0+7ynRrjL4dRmllJbwPV8Bl1Bm627qws56257wmWR2
	 YyNI0a8eWA/rq73gbyfbyYqaIAtsxeMiOl2OfLerfmDvIkZgTJc3yf70qCuXivqY09
	 Klmpoj6Wr98tH177GxCRsghsIEU7p5sbMV+89YzU=
Date: Thu, 26 Mar 2026 17:54:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: jack@suse.cz, hch@infradead.org, hannes@cmpxchg.org,
 willy@infradead.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: reinstate unconditional writeback start in
 balance_dirty_pages()
Message-Id: <20260326175433.5cddde03a0eb201042a1ed55@linux-foundation.org>
In-Reply-To: <20260326215127.3857682-2-joannelkoong@gmail.com>
References: <20260326215127.3857682-1-joannelkoong@gmail.com>
	<20260326215127.3857682-2-joannelkoong@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 14:51:27 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> unconditional writeback start from balance_dirty_pages():
> 
>        if (unlikely(!writeback_in_progress(wb)))
> 	       wb_start_background_writeback(wb);
> 
> This logic needs to be reinstated to prevent performance regressions for
> strictlimited BDIs and memcg setups. The problem occurs because:
> 
> a) For strictlimited BDIs, throttling is calculated using per-wb
> thresholds. The per-wb threshold can be exceeded even when the global
> dirty threshold was not exceeded (nr_dirty < gdtc->bg_thresh)
> 
> b) For memcg-based throttling, memcg uses its own dirty count /
> thresholds and can trigger throttling even when the global threshold
> isn't exceeded
> 
> Without the unconditional writeback start, IO is throttled as it waits
> for dirty pages to be written back but there is no writeback running.
> This leads to severe stalls. On fuse, buffered write performance
> dropped from 1400 MiB/s to 2000 KiB/s.
> 
> Reinstate the unconditional writeback start so that writeback is
> guaranteed to be running whenever IO needs to be throttled.

Thanks, I queued this in mm.git's mm-hotfixes-unstable branch for test
and review.  This starts it on the track to mainline before the 7.0
release.

I assume we want to be prompt with this because the fuse regression
sounds pretty horrid.
