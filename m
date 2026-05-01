Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545324E4AF;
	Fri,  1 May 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641108; cv=none; b=OQVXpvwSgGjcuCS3afg0YSY8GtwhKifcp7FpfX4SjvbvzcMLi9ZxoLXn9IIup3frBLopGTw35plqanQvrsgeIbCbtPVTRR+kuE9rVc8mvQgCGXH5kjG2AgOURc9/A0RT+GcmBcoNg2Jj/RaFPPqmoazIzR+qWx/yowfZqiXIUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641108; c=relaxed/simple;
	bh=8SKkSzZgrAa+ZpppgM8vJNeBTw3pwJOHyXuYiFX1uCg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gwQo07ucn7Erjt/py0cfyRbmL3pPRsW9flajegXmhdwE/t2R46rp3GRTp3b0huCinFPfdM3QCNYOxsvBFgIavVOQu5l9FEtchBqw3lMdfPMM1PUAClRQ8x6uv55L25cmFovgw0hwht88IcqSn98IOEhNn1uTIsgXgjNhxJEYHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mf7Gn80g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mf7Gn80g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1694CC2BCB4;
	Fri,  1 May 2026 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777641107;
	bh=8SKkSzZgrAa+ZpppgM8vJNeBTw3pwJOHyXuYiFX1uCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mf7Gn80gA7H4Gd455riWj8Pblnwt++fG7P7xV82SSfaPlYei2kIpQsWJyHxW8EgI1
	 UIsg7idtTxfLCcffyeXo4BjDylh4cwoc9qTcX3Nw8oNujrTUYiG/v6vv071gCfoMdZ
	 sFjZLS4DEz4disHye+Dd6MK4Nk4vWIQTKbFMDIv0=
Date: Fri, 1 May 2026 06:11:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frederick Mayle <fmayle@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, android-mm@google.com,
 kernel-team@android.com, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/readahead: simplify page_cache_ra_unbounded loop
 counter reset
Message-Id: <20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org>
In-Reply-To: <20260501011908.3630802-1-fmayle@google.com>
References: <20260501011908.3630802-1-fmayle@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 18:19:07 -0700 Frederick Mayle <fmayle@google.com> wrote:

> Minor cleanup, no behavior change intended.
> 
> `read_pages` ensures that `ractl->_nr_pages` is zero before it returns,

So it seems, but depending upon this might be a bit fragile?

It would be better to make this a more explicit/formal part of the
read_pages() contract.  kerneldocifying read_pages() would be a
suitable way.

> so the `ractl->_nr_pages` term in these expressions contributes nothing.
> This seems to have been true since the statements were introduced in
> commit f615bd5c4725f ("mm/readahead: Handle ractl nr_pages being
> modified").
> 
> The new expression has an intuitive explanation. When filesystems
> perform readahead, they increment `ractl->_index` by the number of pages
> processed, so, after `read_pages` returns, `ractl->_index` points to the
> first page after those already processed. `index` points to the first
> page considered in the loop. So, `ractl->_index - index` is the number
> of pages processed by the loop so far.
>
> ...
>
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -270,7 +270,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 */
>  			read_pages(ractl);
>  			ractl->_index += min_nrpages;
> -			i = ractl->_index + ractl->_nr_pages - index;
> +			i = ractl->_index - index;
>  			continue;
>  		}
>  
> @@ -286,7 +286,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  				break;
>  			read_pages(ractl);
>  			ractl->_index += min_nrpages;
> -			i = ractl->_index + ractl->_nr_pages - index;
> +			i = ractl->_index - index;
>  			continue;
>  		}
>  		if (i == mark)
> 

