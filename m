Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691980;
	b=EZZLpjNsO/RCwy9snHNUa7MpvZN6G/Q6ytTFf3/45KnGScWrtP9aj6WHsZBiL3lTMDN1
	 3m+8YVh54J+ZEQOLZxoS7q6ODia7DzrohOott+RX1oV4+hIaNFJ9qhg/lHeUYdjU5DODM
	 cTZYj9lz1ztF/SXdDGl97XUWRY94X9cX6JnKRsbc63+bg0rVktxsDBVG81OIVtHFVo5Rq
	 NTifbVF47GneJ2trK9YP0Mf2+Oscs+ztAb0lzlZ2DZBALFiaKGhBBRwrev8w1dBK44Njz
	 s+OR4cpmaE0e410dMBuoHzdWrAP+cU1uEX/L7nEnOkqTgCec53gqgAyJucAP6MnJLGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691980;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=lfLkFAIpMOIjQkftZDpEqyQKWV/8c6VI/LLjbcxJUas=;
	b=Ou01isA6sqqNRgyptETQ1UP3az+WWHQ9BtrDOYBKhuvaclXQ7OcxvQ6CCwCzqwBe/SsR
	 M3vleT44sVYZ/UXg6FCloyVFdkbpbZA4oBXRMTxzlXuky7rTcP/HiOE6cxB6Qclk1tONn
	 H+oVdr1FMBd2LLxx6B3oKzvXPutaIjZDpIg8pqQowMv7tniCtJVR9BD9o5Tow7k94jAJm
	 8OSdffW+yS/nxrkscWy27xEVDVSo9ZPmIJcOTXS8uhLO4xuCO28w9hZ+bltYkK9Sh+ox4
	 ZtoxFcd2pWITDSJTMle02IF8einultm4NeTcKL+a5D+rBJyc31oFHGWSJwIJAi2RW0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eFMU1KUi;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B179606A324;
	Tue,  3 Nov 2026 07:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B179606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eFMU1KUi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lfLkFAIpMOIjQkftZDpEqyQKWV/8c6VI/LLjbcxJUas=; b=eFMU1KUitggkjJ3qg4iX2hO3/6
	OBHDdoARdJtgV1pBhTdVNmjrGWrtxbuk+GWCsTmFUY1wsWwfbZzjGQSP1Pr9OWVRVD78CdUGPvqoW
	4SrTIHzczAM7J6tSn0vlGRi6mK3p0/LQNKBiHvV4/h38TvaALHbgYpKW8ZrcvxP0Y84ALYDyMO+l6
	LPKwJFVRs4KjmN94AuyGAs4b43motTnK1eXhXVC/jQBoDjEXHr3Z+sT3Ul/CK0hJ02s6wHuutSdv4
	Ekm00Y4vcw027OmHI65p7pbQsN9bwR0UTw8g1YUE3Q01xHiY3yTzwnnd3aLS2/U6MVRyeg6Vx+hOT
	dj7SxP+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9Dl-00000001QHb-0VG6;
	Tue, 03 Nov 2026 07:46:17 +0000
Date: Mon, 2 Nov 2026 23:46:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
Message-ID: <aumRSdyFm9WY56e4@infradead.org>
References: <20261029-statx-v1-1-9600cdb896b3@kernel.org>
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
In-Reply-To: <20261029-statx-v1-1-9600cdb896b3@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 29, 2026 at 12:20:27PM -0400, Jeff Layton wrote:
> STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
> from stx_attributes but copies attributes_mask verbatim, so it leaks to
> userland on filesystems that advertise it (nfs, ceph), e.g.
> stx_attributes_mask = 0x8000000000b03000 on NFS.
> 
> Mask it out of stx_attributes_mask too.


This actually seems like useful information, any reason it is not
reported?  We'd probably want to renumber if for that, though.

>  	tmp.stx_blocks = stat->blocks;
> -	tmp.stx_attributes_mask = stat->attributes_mask;
> +	tmp.stx_attributes_mask = stat->attributes_mask & ~STATX_ATTR_CHANGE_MONOTONIC;

But if we want to keep internal only flags, they should have a mask
defined next to the attributes intead of open coding specific ones here.

And please avoid the overly long line as well.

