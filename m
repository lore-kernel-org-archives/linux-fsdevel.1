Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8058316199;
	Thu, 28 May 2026 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000051; cv=none; b=ne6VFFMzS1P78Y7H68+ZbpODq1wp3jflhiT3V4qeD7+q+GnlznNQr7mQ5PHHk5tA5ZZr1r8h4ZHpGgAtvzlGq9mYK+aemXmN1/1JnzmlF3GNOvbERMkyNYP2UHHiXsQxJG9c9W27ddahCKfjwmWR2gl05h2bnWRZ64BwwDmVryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000051; c=relaxed/simple;
	bh=NA3VjbmtOyh4mQpwEPSas/aV1ctRPj++yS71zbI9HxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NOvfdiY5zr7JIWUebV/0z4e1FbOZR9JcCqFBCDxM0asMu+NJN9EIsEC24bBOgOZbqguENZnNjSIukIhKZyrS1bmgdqg10OLTq0gghNKAO0mxUlDeN+wjxE70Byd05YZeS+EzLA95h/fyK+u/c6URcMitQVebYaCZwoI6IPhqeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1406wq47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1406wq47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF81F00A3A;
	Thu, 28 May 2026 20:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780000050;
	bh=qbT0AxMHd2QIhEY5Y8KbM/8oDNJsPUw1xw7s/5tIMDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1406wq47Wcf6v+Jomv5SSsDRc9sK3PYzAg2jEi/qCqCBwndSK+M0IH8esUQRaSajU
	 IZjBlqJ0yuDguYb94FYgbWgCi2qWVBPpYjx+jDUO1JyPig1a59QYvPaCKh3e3bi5+e
	 655V9UOtGqlAqlXZi7itKsgs72CgC0PU2LKyJMSw=
Date: Thu, 28 May 2026 13:27:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: david@kernel.org, willy@infradead.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, r@hev.cc, jack@suse.cz, Andrew Donnellan
 <andrew+kernel@donnellan.id.au>, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam R.Howlett <liam@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, wilts.infradead.org@hp2.hsd1.ca.comcast.net,
 "linux-fsdevel@vger.kernel.l"@kernel.org, ziy@nvidia.com,
 hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
Subject: Re: [PATCH v6 0/2] mm: improve large folio readahead for exec
 memory
Message-Id: <20260528132728.c47a38e7506483d587f64eb7@linux-foundation.org>
In-Reply-To: <20260528165635.2068012-1-usama.arif@linux.dev>
References: <20260528165635.2068012-1-usama.arif@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 09:55:18 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> Two checks in do_sync_mmap_readahead() limit large-folio readahead:
> 
>   1. The mmap_miss heuristic is meant to throttle wasteful speculative
>      readahead. It is currently also applied to the VM_EXEC readahead
>      path, which is targeted rather than speculative. Once mmap_miss exceeds
>      MMAP_LOTSAMISS, exec readahead - including the large-folio
>      order requested by exec_folio_order() - is disabled. On
>      configurations where the mmap_miss decrement paths are not
>      active (see patch 1) the counter only grows, so exec readahead
>      is permanently disabled after the first 100 faults.
> 
>   2. The force_thp_readahead path is gated only on
>      HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always drives the
>      readahead at HPAGE_PMD_ORDER. Configurations where
>      HPAGE_PMD_ORDER exceeds MAX_PAGECACHE_ORDER never reach this
>      path, even when the mapping itself supports usefully large
>      folios well below the cap.
> 
> Both issues are most visible on arm64 with a 64K base page size,
> where HPAGE_PMD_ORDER is 13 (512MB) -- above MAX_PAGECACHE_ORDER
> (11) -- and where fault_around_pages collapses to 1 disabling
> should_fault_around() (one of the two mmap_miss decrement sites).
> However the fixes are architecture-agnostic: patch 1 reflects the
> nature of VM_EXEC readahead regardless of base page size, and
> patch 2 generalises the gate so any mapping advertising a usefully
> large maximum folio order can benefit.

OK, thanks, it's getting late and [2/2] hasn't yet been reviewed.  I'll
add it, just, because I'm a sucker for speedups.

