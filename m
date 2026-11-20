Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212995;
	b=wlpwurkixcFFTr7N8WoVF5Xhl6sTRJG5zpGEFevb80JbgAspy+/d1xUXnfliikwO+cPc
	 FL+Zh/iQ0zFSFpIX2vyoyHgDK66MaRFTpZzDVfYQy0YHWsqaF9xeqiZ6NWNVuWbkJJZMT
	 5C3I7lxrAN9+xV3N6qxaxptOPdp4frax8cxLYYv5sma7+5Td6O/yU5oQuiwlxkRUMQZFz
	 75vNJuyGTD17U8FQ2/ts8O7zgppxSs6sf6S4RYLwFyqkw+K8GXoKDuu9cmqgsFnAx8gO3
	 5xyM8iHimvg1iDM/YrHuALup9mm7ioZ9SjI9/ouCEB6kUWXNlF52GIbVUHuNmTnG6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212995;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tWQrNtFyfIXnHGI2fRFmH9GGodaYvK+4ToZmzZlpeLU=;
	b=Tr8ocZ4XdNf7L4cINFOC3B9zKVH+bVyjss8kUofIpRX9484Rj6ZvBjTtXRAJWNKURnN6
	 KaNRgYDvaHx70pzJUs2LElvrJEjQbGS0Z2y+kJKjMn20IP50y91FUvSOlbRXBAP1WVdO3
	 wC5MdDAEYP2pA06xYBme79oQou5KW5dg+g/Fe8TSk5MaOtqnNjqWI9ws94+dlnVgeyzhD
	 ryPyR3dN/JdAZBFs0ft4/bdOohSkSSD5AGjgKLfYtalvlYm6DWLS6RdFxg4b5kobumdgb
	 z9LUzmLws+mAojBxNkWYNMvtDGB/lZBWe8n5psmyYaaE582huxE/nboWY1sLyJiUaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FQkQmRsM;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACA606A698
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 22:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58ACA606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FQkQmRsM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tWQrNtFyfIXnHGI2fRFmH9GGodaYvK+4ToZmzZlpeLU=; b=FQkQmRsMZzJVVSot5NtT3VpROy
	9IYHajkK2iNAP0E44KiGPStuPGv/oU9aQRsIikSD9/8OzUDBp41S+XZBWKFUIEvlEvq+g3ye+X0Sb
	3Ie3KEmgLvsC03wA7MT61P/wiXuZ9aIfm7IllWctx4Hk6TaudOeuw8+WK8Z3edhZuxLvV+x2B3HN1
	6OmXWZ/hdHhzwieWL8XtYZ/Z/RsJ1sQc+cbjMtL7oaAttwrzfDAqXxgJPVIej6ldnfzdaGrnIKUhO
	ANqtjLDihyjUBnzaviLMdHNfrph5loPAshN0YPmlXezfUrirKby3HXXywH7bAV/XAjv/zLx0kyAEv
	5WyKOspw==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUWu2-0000000DBrk-2nDY;
	Fri, 20 Nov 2026 22:16:18 +0000
Date: Fri, 20 Nov 2026 22:16:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Tianyi Chen <hi@tychen.cc>
Subject: Re: [PATCH] mm/filemap: only drop dropbehind folios on uncached reads
Message-ID: <awDGsqkIaasAjaNB@casper.infradead.org>
References: <20261120-filemap-dropbehind-read-v1-1-a373ac3fd993@columbia.edu>
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
In-Reply-To: <20261120-filemap-dropbehind-read-v1-1-a373ac3fd993@columbia.edu>

On Fri, Nov 20, 2026 at 02:51:17PM -0500, Tal Zussman wrote:
> An RWF_DONTCACHE read marks the folios it brings into the page cache as
> dropbehind, and filemap_read() drops them from the page cache once it
> has copied from them. Readahead can bring in folios past the end of the
> read, and those stay in the page cache with the flag set.

I like your patch, but now I'm wondering whether RWF_DONTCACHE should
trigger readahead.  Yes, I'm sure we want to use the ->readahead entry
point for filesystems, but I think that an uncached read should not
bring in pages that weren't specifically requested.

Something like this, maybe?

+++ b/mm/readahead.c
@@ -590,7 +590,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
         * readahead will do the right thing and limit the read to just the
         * requested range, which we'll set to 1 page for this case.
         */
-       if (!ra->ra_pages || blk_cgroup_congested()) {
+       if (!ra->ra_pages || blk_cgroup_congested() || ractl->dropbehind) {
                if (!ractl->file)
                        return;
                req_count = 1;

