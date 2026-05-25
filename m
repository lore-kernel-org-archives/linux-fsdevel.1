Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D92D3727
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721428; cv=none; b=q+EeqHEpX7+7zPxQt9V65KfsCN6WxFfkN7l34edK3HNqkxgol5tEOZ+tozaBSmR/lrXYWIuzuD49bQB7mMrmTThKbOeDSgFqj2bD8JhTgaO2oYguF7Ee+sqbARxesovKyTFluGjtbBE+tEcskaJ0gkgB8kBy1x0r9xW0SwAg1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721428; c=relaxed/simple;
	bh=z+yGGcn+y5IWTnwjgdMH2sLcl4N9qf9foYc5Chdq4IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMXTbT0JGl+hYPjj8iejNrwP5458wRETJWOkS1f/AL+HZvqOK7+a9hxd3EXMo/XC08yIcSjEK0Rv5WrzdyZhHqBv8ODWuCFqJx3E/yImIv7sJFh2uweWC83x4PDVDLFTBc16PNB2Iza9xh2AkNGNxZ/8qI897UNPeQI/TCUw24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTveyExv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTveyExv"
Message-ID: <094015d8-00d7-4f8c-bebf-593ff76b5e4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779721423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG2htbyr2bmaHj2ORzyR7CVTQQkB7de80vpx4poZg64=;
	b=jTveyExvhUic+GTcPDHxJN57hAlSx7wUUIeHKYMlP5MmKyBYsaGj8aWkM3VDAbDDEid2Jv
	Xv1hIW0NWuulEKDVlWEXa7DfzZNPFSEPSZFEQj+D5pMkdh4j4Ii+2GQR9grJ8YEczKNCl6
	UcVY04GOOe17fefYJtpQp16fLfGk5nM=
Date: Mon, 25 May 2026 16:03:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: make mmap_miss accounting symmetric for VM_SEQ_READ
To: Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, david@kernel.org
Cc: hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260525145751.2671248-1-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260525145751.2671248-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 25/05/2026 15:57, Usama Arif wrote:
> do_sync_mmap_readahead() skips both the mmap_miss increment and the
> MMAP_LOTSAMISS check for VM_SEQ_READ mappings, since sequential access
> is non-speculative and should always read ahead. The two decrement
> sites in do_async_mmap_readahead() and filemap_map_pages() do not
> mirror this skip, so concurrent faults on a VM_SEQ_READ mapping can
> still drive ra->mmap_miss down to zero through the decrement paths
> even though nothing in the sync path ever increments it. The counter
> itself is per-file (file->f_ra.mmap_miss), so it can be moved by any
> VMA mapping the file, not just the one currently faulting.
> 
> Skip the decrement for VM_SEQ_READ in both decrement sites so the
> counter only moves for mappings that also participate in the
> increment side. No functional change for VM_SEQ_READ users, since the
> increment-side gate already prevents the counter from being consulted
> on their behalf, but it stops a VM_SEQ_READ mapping from biasing the
> counter for other mappings of the same file.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>


The patch is a result of review from sashiko on another one of my patches:
https://lore.kernel.org/all/8edc8cd0-f65c-4456-9b3f-362e744c9a96@linux.dev/
