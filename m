Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998911B808
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572158; cv=none; b=R/QNT12LpA0tjriFDs2BSCWM0i64wKWq/RjtpeBVIrKAvzbcjQhFNvG/bB5G+aMKyk4KId3zH993OSLjM54jMSPIW1z/zvkhZyYgzSQBpMyGk13Rt4/pXTVmfnEGKlFxyVx+JBt2irFpflbIY5w2ekT9eRMWryGsN0tYeUoko/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572158; c=relaxed/simple;
	bh=1oTRYaaDGtL88x3nFZWM19mGdEaN35XXt49N44uFQhk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rZkvv98luqD7aSsI4rrN6nttEOaIy8FhgJRfPpm7cJ/bKbe6mA5MDsLaxvqY/1KF+cm9lyiVeFP6J7VAIREQDCfKKcnrpdxKTLWYh5O5AEK0s3dom5WOganyAvjfaZvH1z4yIHOJEHkihV9Jk5PNJQoulDHFsxKsaSSse+BUX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uPiIgOz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uPiIgOz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEE1C116C6;
	Fri, 27 Mar 2026 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774572158;
	bh=1oTRYaaDGtL88x3nFZWM19mGdEaN35XXt49N44uFQhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPiIgOz2EKjU20I92IZN1kKK3Tu84i391v+qGEZo3cNDi430ZInilKOPBX+90XFFs
	 oBkIixFaIIoSXX8vHNqCMvxTlJ3Nvp2jCtp7rIchdtb+kRg3I/luit48SLiQNzgkHg
	 1WHSYOt1FSeiBXzq/CMDM/77MUwsUWFhao3FwCS8=
Date: Thu, 26 Mar 2026 17:42:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: jack@suse.cz, willy@infradead.org, miklos@szeredi.hu,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm: start background writeback based on per-wb
 threshold for strictlimit BDIs
Message-Id: <20260326174237.0ad75b578219aad36f137e4b@linux-foundation.org>
In-Reply-To: <20260326234629.840938-2-joannelkoong@gmail.com>
References: <20260326234629.840938-1-joannelkoong@gmail.com>
	<20260326234629.840938-2-joannelkoong@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 16:46:29 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> The proactive nr_dirty > gdtc->bg_thresh check in balance_dirty_pages()
> only checks the global dirty threshold to start background writeback
> while the writer is still free-running, but for strictlimit BDIs (eg
> fuse), the per-wb dirty count can exceed the per-wb background threshold
> while the global threshold is not yet exceeded, so background writeback
> for this case never gets proactively started.
> 
> Add a per-wb threshold check for strictlimit BDIs so that background
> writeback is started when wb_dirty exceeds wb_bg_thresh, which drains
> dirty pages before the writer hits the throttle wall, matching the
> proactive behavior that the global check provides for non-strictlimit
> BDIs.
> 
> fio runs on fuse show about a 3-4% improvement in perf for buffered
> writes:
> fio --name=writeback_test --ioengine=psync --rw=write --bs=128k \
>     --size=2G --numjobs=4 --ramp_time=10 --runtime=20 \
>     --time_based --group_reporting=1 --direct=0
> 

Thanks.

Your v1 patch's changelog had useful information showing the
performance impact on fuse.  I've pasted one sentence from that
changelog into my copy of this changelog, but please don't be sparing
in describing the importance of a fix.

Also, we lost the Fixes tag.  I've added

Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") 
Cc: <stable@vger.kernel.org>

to my copy of this v2 patch.  Please confirm that this is appropriate.

> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1862,15 +1864,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 * Unconditionally start background writeback if it's not
>  		 * already in progress. We need to do this because the global
>  		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
> -		 * doesn't account for these cases:
> -		 *
> -		 * a) strictlimit BDIs: throttling is calculated using per-wb
> -		 * thresholds. The per-wb threshold can be exceeded even when
> -		 * nr_dirty < gdtc->bg_thresh
> -		 *
> -		 * b) memcg-based throttling: memcg uses its own dirty count and
> -		 * thresholds and can trigger throttling even when global
> -		 * nr_dirty < gdtc->bg_thresh
> +		 * doesn't account for the memcg-based throttling case. memcg
> +		 * uses its own dirty count and thresholds and can trigger
> +		 * throttling even when global nr_dirty < gdtc->bg_thresh
>  		 *
>  		 * Writeback needs to be started else the writer stalls in the
>  		 * throttle loop waiting for dirty pages to be written back

My copy of balance_dirty_pages() doesn't have this comment block.  I
assume you're patching a different kernel version.  I dropped this
hunk.  Please check current Linus mainline and see if there's somewhere
else where you'd like to add this information.



