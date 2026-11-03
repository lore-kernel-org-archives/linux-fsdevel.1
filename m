Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697282;
	b=IBJ2fhUE/gAUHJSBptxDWXPn0n0Wz+IJejmnnGF1+GJpCKI3BQW77+BiSn2cfrgIcXWw
	 UPceOD6Fqh+bkYk47muUTBP2LpEnJo4yfcUgctobLgguzd0oMrQU6kHlTM8OlZv7zjcbr
	 3AD6e0umdgtlOwtt1g2iPyVYPxxdD/p4aoVgP6LKkpRD5cdWIKUBxnuA4xd8tEqDQI94H
	 zfOS0z/W9eB3z98IoHhEo0WkbxkWw3R6MsfwSrFN0qpZHwlhpqk502UIdzJolHIX7REoJ
	 Z3mXhv3WRd9vopGMybj/Z9jI1e3wv+Jy47zBtWHLf5RZURyCbsgIeUSa4/zQzqvRn5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S1WYfRKraltmcSelSSDtbEGSqHwpRq+KEHeQXK3+6sc=;
	b=ESY+QAslk6GDbq8jgepPJ8EIHu+qCmhoqpNU9ICvn0Mm6KITaNwCmiCYRChLFBL9Ospq
	 xZCGcsy2nkmSaeL2Un34kjIHM5nBYxsO6QYoLsSbtHQQnxNpIMQ2XJZjcci/1ak2jzZcE
	 Sm+Rj/pXvEAybTAR4P9Je17ga/0Ijy1yu/AIvewl8xHV+VwAfrOJHMmaKgvtjdAFCaKPd
	 /EgbcJvc25Q3oi7LgOkIgzhqY8KgEdpcK/edA0zxK0+h/xZ0jUd3lFnq0AYglzAKbqYVh
	 jBPHpmKAzFME3LFydgDjH8PZ6mMpTX0qUAC9zU6zaBFYnyv/SC6QvfVW12E20VX5LBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhqWLKDZ;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63347606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 09:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63347606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhqWLKDZ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2671881f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697281; x=1794302081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1WYfRKraltmcSelSSDtbEGSqHwpRq+KEHeQXK3+6sc=;
        b=bhqWLKDZDtkKOF+hAmvEMOGGJ1M155EtY2J1yjU9vJ1UJLT97cPPeiwnWGRp7ISYoy
         Y7uijpQyMc/G1CJfA32s0bWs2pNur+oZqO6IVPij2znRjxnMirrJ0RE8DhPxGiCQon4a
         oQnhsTISBEL5NZGxzg9OKS/bsHdzEzNhGJ6KS61eW8dFsMHHNMrvfIS4XX9ZC9weP8bN
         CUx6ymx+1MYhJuS1awYIJGvM1dFlClkYMHWpvm8L98lgOZMJOnaVAFY2qcCBfwxoKbpl
         QDsKkRPOzUYr0x05iB828Cf+ZAdAPqFces1SamympChtXbEOLxFvLARXG/C9Uu6rPPl3
         N6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697281; x=1794302081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1WYfRKraltmcSelSSDtbEGSqHwpRq+KEHeQXK3+6sc=;
        b=dDpLCEVGoz8OKOl9g9LBRmpyuMDQrQALkCEQXBDxPZ8A7Ua73gM80LqQiDpmRmUgaZ
         BMCenT2vPpFnMYm/U4U2cpBrbHzdaaeVefJ8+OoX7sKNCqk5+Ft2pumqiX+H9/XHg3Pi
         879MKbARsbMoGqot3HruAJCtZr3tWUX2L8BtVBMpHuzqOkbnRIGbCdKHSbdbjJA8q2XE
         w6UZ2hpDGjFIVEo99y33a0o0EITaQ4IZXPbSa/CF3jKuiZ9qxo2aUU2+Y0lv1QISuLyO
         g7yx+Axyg4cuRHcgcABUV4anHCa0OTveaR4McIs+as8fiRX53bPhE0mdkJmbF5VuXvce
         wUCA==
X-Forwarded-Encrypted: i=1; AKwUvBzRHEo3iuwfu3nVnycxMO90nVXT3UT//ABKv4M6FFG60B5xzFQ/zIa6qm2w/maGXrvI/+lNWFgSthTgrr+p@vger.kernel.org
X-Gm-Message-State: APuU4Z8JzZ3GLj5z+JwoiaWYf3neyFJTERaOjESogNWfzlCxUXj6PuCm
	GIsg1kqgWx7uxcsYtvy0X62SZDl6JV5HUDPPyK9uRpZQsmxDLL18OwDA
X-Gm-Gg: AYBFou0OgT4u+KRRm6RBGewcXsE5+CbszyHEDsWksLajBhzhEBlK/J/nwmIxvQFim5e
	bcj/QqbDT8NC+PCCKjvN0JZh0SBefwMJijNz0ObwLcBEaYG/0wHqW6WmgBTAlYwaaNPSO1j1NkT
	WPoDieuB/QpI8dQzEIEo+bc5u80klu3gp+eqTdeUcsjAVu8iLjs4lERmp/q3A/Cs05PsAEbGMrk
	M2IgmDBlx90mQYXa8rdL7pC5KZ7JXapZ/aa20tNh4ASqYJBQwY7+vuUKxpkpAdtohqWBkLnLBE2
	osLr/uhVxoOlfcVergLxd78BntqHIT6p/sB0w0viGJe1YxGjqbKuTsDCBXmkBO85q1VgGtyl59L
	NIwQ2B9m+pyFXqlLKlDhYH4/XtWSMECt+mCMozhkn/chq7zbFSMF99dvYqvf64KKDUp3CUzmSVr
	mhMjH0i1qSDHC/LrpPZ2hC9pcv4GrePyRkvvX7wuIgnJYBa47dPv/ToUt0/l+NKxDRezhUdMY41
	yxGvW0MV8G+6aM9GmRUbyeuPnV1NdUpNohYZKfSSQCDn0fJFQLEUcPc7VXga8ejPxu1ToUHS7GG
	gJ7iSI8UYn8Oc4rFeYaneIHa+1PEdOCOYErTNLkcIlxuwVmSABjj4RoZSboUVuouNLPJiSuHH5w
	9SAq7gL/hkjk=
X-Received: by 2002:a5d:584d:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48e6e50b5f4mr26190523f8f.45.1793697280601;
        Tue, 03 Nov 2026 01:14:40 -0800 (PST)
Received: from C422HJQPQG-Fractile ([150.251.170.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm23473758f8f.47.2026.11.03.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:14:39 -0800 (PST)
Date: Tue, 3 Nov 2026 09:14:37 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: remove newly-unused page wrapper APIs
Message-ID: <auml_evm_m2C6zUM@C422HJQPQG-Fractile>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
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
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:05PM -0500, Tal Zussman wrote:
> After some folio conversions done last cycle (namely ceph, f2fs, btrfs,
> fuse, and page_io.c), there are a number of newly-unused page APIs.
> Let's remove them and update comments as necessary.
> 
> Patches 1 and 8 are taken from the ceph writeback folio series [1],
> along with tags.
> 
> [1] https://lore.kernel.org/r/20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu/

For the series:

Reviewed-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
