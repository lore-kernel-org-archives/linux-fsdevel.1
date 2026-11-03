Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698146;
	b=yTqtc9z48NWv/n/dVwWu7awO7R9IlWxCQ0IS4+fq72ooc9GA9QOomyhErUcW29MtudFa
	 BtFnxG74/T4JTtPu4nJz/gf7YC/wDTu60UrxtZEwgRSE7kDTxu6ztLG+ZUNA9mjJMexJQ
	 AXEL3I7SoeQspfIrQF0SORjX16fxDvCYDLgB2wHJvmPZ8vwMVPVrP/nVS+nSPUCtvftF4
	 r0euHd4pGmKUOqDJls+wH9svfOzce9KtZYhqc07F0voOQ5j6GYC1sYoiF+vtylu7W9ygU
	 zGbymfjuaUqwSegOrFvhuY0aqUNNCqJGoP0m6FrDzw0HK9EbxGfMCBADWu1hszH09yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GC4ATzK3IxZRvi3Ei+hKSqTD4en8xH1y2tp0UQprNBM=;
	b=2PLXhq1k7j5vjP808yXYJ6sMRShwrOFDVkadz3v+XbdfMKPPzdKJ0nFn3hRYNgoVS342
	 QV4ooC3ejxnh8r5Gbrdpxf+30zzevg/E6Ehjt0v+zc3TxhqOvzps5SIsWb+qGwzEin/nc
	 sZht3lQ51ZgqHmDc9iPLqFGMMQE6gVzhBa9J9AM7Pe8pCE7CnpI4InbTUNWXZLBkejiYM
	 fegqoiwfLvPNgyN66MH6hamKDMRtv6La0EbInF5dXGKhmmPcqyE55sDrcE1o/uIaRdv2m
	 BTi6TfDmlUq6YHS7A7kWXuQVKxHRl+5+5Zg/oESdWkIf/W9B+ypa4UHK6n5ocAEB5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7gUoOx3;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D7606A33E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 09:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8D7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7gUoOx3
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so2096286f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793698145; x=1794302945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GC4ATzK3IxZRvi3Ei+hKSqTD4en8xH1y2tp0UQprNBM=;
        b=z7gUoOx3NaMBfXF4kv1BjI+0IIZ1dFQohmKAPaBPyKi/Z+iQQEuHWo9+uJux+DJg8h
         KMTRoHyFkNHla1d50xqcN0xmH6Vtcw0gLO0xnYWYJ4bJAAZQ8PHYF6jA6qTeyUAu2nyF
         hlxRxjBKbcPpHWEB2J++Uz2qvDdF8Rk7Ym+G59K35qhS7+Vig4RGNpkykljPwgTqto7S
         3fGsdFy70xobCXsdkeMLp0KZn89JXITqogVzkFZtssW1oZ6j7f5zt0xrlFa3wcqDUmU1
         XRig6zfKTCK/pIlchXbA+h5Wh6j/wF2uUTdHtS2ExtVmzwTz49pWo+a9eS1BoKlLJwBG
         fXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698145; x=1794302945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC4ATzK3IxZRvi3Ei+hKSqTD4en8xH1y2tp0UQprNBM=;
        b=kS6RLWi0fnr9s7FGpIB0lGNImqDBiRczLuGIewMU5FDLHYFH+48BlQ4Jyn4Wdny8Kf
         n3v5DhqH6Wc3HCtq474iAE3e0BFPqoeYWB0m+Lp+pNv9qTSd8YCfqJdzV/v77ZXP8+Se
         14wJ5pyL+yatejBPhPF7oLeM70zENQKrKS87eF31fLiepZEYCrDepCIujtQXuCmFSGot
         OXAt54rVcV2iEx/k4LQrBoiwLG5Mn9FUYFW6Ib7DwxLmDTO3Nchjo2mtwP+MP8zhOnwt
         ygtZnzHISB4PXOXayw/9dFiiLeZsDDRNIM4/MMxLzUh5IOgaKut/2YZNN3uEQpKMNmz3
         I9pQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzKwRWjP+f4zPI3fN/Qre8PzRwu55LmtsK5M47YiRfjSHg0QcsiEFqWzBjdtggCp7//WW6ZcAuA/ZKdnCy@vger.kernel.org
X-Gm-Message-State: APuU4Z+G6m0S3Ab4az8IdjHjly8PL45/Ec5pNqRRtZ6DvSRnc91VY5iX
	ax7EBnvYhmrA4jyOBVrTW57ONI1MrBWYFV/03o2sNbe+rQPRFLaOFtcs
X-Gm-Gg: AYBFou0FLJuCYcG6SDr7YJRxQ6qkIqCGBR79ubO8SZDC1eAEygySVN2SjDm4Hc/R7Ta
	y3dj7izrB49blA8dvI9VLoxK4t/qeKOyR/XvR/e93qxKYHxCzVeH1tyNoGA3rewQwlGHdkQodLm
	DtrEjBnuAjQeqtK4jkbTTeGMv0gWYmIYugzfF+8Hvjn/MzyzMDtKUp2yFtgttH0sELk0trxRfwC
	qMQUPHx1M4ArGyHllcshCnfTESeSi2XmVPvTJRuMumTa8pmblvq8pHj4VXc/nUMrtqApjl5wJym
	vv96S+5Wa8cWR3udSQ8qsnVxvhyrmlTQQzdPfvi7iOCP3BgEl/n0yC/r+dO7wWYB21VWgFGIkjV
	V6gWCV8KTh8stGj4wXpAvYpTuTYLYhEdRvkmBDHi/uy77Sisw65KT9LQat89hTt1d/Dv7/98Wxv
	zmFkdLneErhCjcS7jlf0clZUYKl9WijdgLbYPSFr1lJ24k9s0cP/ejT/h4f5MgBFE3aKCiXmi5x
	65t7Hpqr5RCEqqpVR5hxDIt/J6zfGfgeIB3uHxHbAD2NhxVC3cnQApfjUUVMfRtUDUbWgn9pUg3
	2UFpv6ehf03aPVgwgv46OR3HFSHgnh0CWR9YU41G2kU8InARiwHb6pLrxa8DNkJIb/cvtqyp+u0
	UBkpntBPUTuY=
X-Received: by 2002:a05:6000:4014:b0:48e:5071:420 with SMTP id ffacd0b85a97d-48e6e2bc75fmr27335389f8f.2.1793698144786;
        Tue, 03 Nov 2026 01:29:04 -0800 (PST)
Received: from C422HJQPQG-Fractile ([150.251.170.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b727c6sm26134262f8f.16.2026.11.03.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:29:04 -0800 (PST)
Date: Tue, 3 Nov 2026 09:29:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Tal Zussman <tz2294@columbia.edu>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>,
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
Message-ID: <aumpXjTMlZhV0PSh@C422HJQPQG-Fractile>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102175605.a0d9caee8279ffb5f6fdf15f@linux-foundation.org>
 <aumjF5peb2vyuncA@infradead.org>
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
In-Reply-To: <aumjF5peb2vyuncA@infradead.org>

On Tue, Nov 03, 2026 at 01:02:15AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 02, 2026 at 05:56:05PM -0800, Andrew Morton wrote:
> > >  9 files changed, 8 insertions(+), 110 deletions(-)
> > 
> > Tal, you obviously haven't been following along ;)
> > 
> > 
> > This development cycle is not the one for cleanups and new features,
> > but this one sneaks through!
> 
> Given that this is purely dead code removal I'd actually vote for
> fast tracking this into 7.3-rc.  Unused API better be removed ASAP
> before people start using them again.

I agree with this sentiment.

Although given how long the folio equivalents have existed, I don't
think it should be too much of an issue. AI is decent at catching
this sort of usage of "legacy" apis. I'm not sure if sashiko checks
though.
