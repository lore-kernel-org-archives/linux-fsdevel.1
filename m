Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD39242D70
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011059; cv=none; b=AsK94S8AC8ixYod7dpU8cDO/iSNgQdI7IeKrqWPHsojNIqab/nxnNFpRcwpENF9GEq71CKGd24GQEHfKqNiY9Kt41Ijyw3DllJV7Hf/Bj5GpKE+JplCSL/G1Zil6LCdq1jQY+8ispW6nnWsYSETyRMLtgbSOPvYUesQavIexlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011059; c=relaxed/simple;
	bh=PEtr/nYBsyF6LXPViv+Hww+MhlKG6EKj4ZY0X6tbHi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0v2BKiolqftcqy7gUILmVSYCqWNwhBZIt6iW2AYmRkO0DTw6fh5s4/bsSMhHmor9niW8Ty2w8d2zPUKayiYRRCSlEUjMiYAbWCvFeBWQkG6i/PBjwZ00hWUu5PEes1WOdNDRKgPgrGbkbPNpNZR/WQwgSs+2x+WwXqdrPHEwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qzP+LsnB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qzP+LsnB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781011055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxMQll+O4+monLTew5Xz8Mca5BpahKZtkIXA+xIMBkg=;
	b=qzP+LsnBgX4txxd4qwDdGOWpue6NIQ2xu4zq3Q53ScsMs68zGHRKaMkY2OjNMz8ldO2oQT
	av/+QwPfsorh2XYYZ2ykQM//QUQ8V+BIwg7KuNtgsHJz/dqqmY0/sSYeWG3aKqQqNsSxYs
	F3TbbT+4EU5Ng2I4idh0G+xY574FQgc=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
Date: Tue,  9 Jun 2026 06:17:23 -0700
Message-ID: <20260609131724.3114804-1-usama.arif@linux.dev>
In-Reply-To: <20260608210618.3437216-3-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon,  8 Jun 2026 22:06:12 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Nobody is supposed to use page->__folio_index.  Use page_offset()
> instead, and simplify by working exclusively in loff_t instead of mixing
> up loff_t and pgoff_t.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ntfs/compress.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index c904858dff3d..b279f38636d6 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -105,13 +105,14 @@ void free_compression_buffers(void)
>  static inline void handle_bounds_compressed_page(struct page *page,
>  		const loff_t i_size, const s64 initialized_size)
>  {
> -	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
> -			(initialized_size < i_size)) {
> +	loff_t pos = page_offset(page);
> +
> +	if ((pos >= initialized_size) && (initialized_size < i_size)) {
>  		u8 *kp = page_address(page);
>  		unsigned int kp_ofs;
>  
>  		ntfs_debug("Zeroing page region outside initialized size.");
> -		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
> +		if (pos >= initialized_size) {

Ah should have raised my comment in patch 3 here.

>  			clear_page(kp);
>  			return;
>  		}
> -- 
> 2.47.3
> 
> 
