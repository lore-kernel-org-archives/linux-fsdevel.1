Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68935221F2F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082826; cv=none; b=Hf7KhvmnH+BUGW/hfyy4J+3ATUcywFHC8vanMrIpDz4MXZKpTOLkZfs/uLKMSL+kDz5afCVdcV6RYvet1vOgE74PFeKN0SKobQxFMov6quL36KkupjmlYiD5FPnQQfR7AeIDU9LQZhTIBqw16k9o9Y/giuSyXBWxWLWhn6RMkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082826; c=relaxed/simple;
	bh=2jYG6Xf32+cEtSY72Mc1PL+l5rCSf2q04Wdaw1jcsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H57AcCu3+Lh2gduemsskEh08WgzfttTCvGOuaLTpX1SH+GNyIWIHkCT/E/GwmkYJJ1VMbQINqe94JNehJVHCccS+UXoweWwUHN/fXNfb/iAe717ytXRSpNzZOhWYdhr/BBHw6qYSMHQSCUAD9qEA+VHlbBggrksb5rV824BqZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOfnuRGT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOfnuRGT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9b1db4964so281695ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783082824; x=1783687624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I4FlisNClq+WLU9VmGBotriJLcRO/uQKg32SCiTN5SY=;
        b=kOfnuRGTIe3RuyAyUsHbaPXc6stAIb40rnHVNsNA0HssJkwcDQo+qgk8mfgK45QsPi
         mOH9EHBey/G+l62zaFImJpU2g5ttzK6pyEDiNwTytn0yhBpyJoWSnsld3rm82R+gNbLj
         nqjdpMXdI9HHG8xWyW2y3yuNzYtlDAc9rnhVtm68SPcFIbuj13mglKzdbkN99GyJ7Ej9
         z8ZBypR2NdsSAXzXiE+znRWopG2mqhmGJzInL22fUtjdhX27EPU+VWTIJApzQmABVR8o
         ZoZyRSrHOesWW9O7UYxdt7WSjh7DqW/9RDCHe0nrVkd1nDKcLl1J2s3LNQoH/bLXh9FW
         IxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082824; x=1783687624;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4FlisNClq+WLU9VmGBotriJLcRO/uQKg32SCiTN5SY=;
        b=JyeN5dTepiLvsMbTs5LxPqAIg8EW24H8Ui6CXNJjyvDLhjQD053rnHr6tue8swZwYy
         0T+sNMuk+kVG0er42UB+ADJD4rnDXpWlTv1QxxZZS4LzWeDKJx/UqlkFjsCsL0FLIgiH
         V8NscvAHQcfzIGJE2yagtlC5nbub8X/j7J/La+cL486t9+kaAaF7yxq9xxyojnjeffhm
         KI12DpqjMI4ATt7O5W5N/5C2Mc0jrggGvkXNPjw3iRQcdl6yF5rNUA+VLNi+flxRliZr
         qmb8CzOwwfQwUJGeoNrxwwVlkBp5TiYKAoAZm7u+dfs1QpH7p681o/0IWklWslP2oE8T
         unHw==
X-Forwarded-Encrypted: i=1; AHgh+RoXBmQMETLvca1rUUmcYe1HGUr0SprVGm3Et6nMxzMHmJqd8giENWuBLbxO4h5Mbql91UQ6WpQFhgPfQLgH@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsJ9Ny+YPqO57yCTbJkbWw5Qre88o0uDMtaiARuAp8ZbCvUG6
	9YwiiewqM3s7HYZ3Idhe9ZpV1wshAwuv3FMTJrveMLTxFYtTqDCM4KiHjrT4btlhIQ==
X-Gm-Gg: AfdE7cmazOw8Z+ujg8v1sD965g4EeJiloNFPxHOFtNMctjF5sFbH4Ba5DIZJIIX1Uds
	40L+DRlBnGH80rj+MPjV0r9NNL/AQGOU7MPav9a22MtAHfN/kCgEM6BTY8dLFMlk11jQanEmU0Z
	0bc0CFImG04VXD1/kEJXp5DP8kweZo0fpN3Q6Bq6L7YIikgCUEhRi1CwuqFU1lJURor6BEoo3JH
	f6bl6aKbUznmONCV+j/DNxT0c0OM5p8lTj8LbYXoyBI3s9iL/Gqe26HdxLoWzYy59o1pnWlT7vV
	WCOucljuo1L5HIU4wjS39RMu4HPRzin+dwDszaZDoAA/g40aOMpv6pWdV4VUdigL0wdjkcSFJoH
	co6PhNnYg2aKcQwA+CiZfbefzON9ZLJVWr4frggNcjBcGh8mVDyPcF7qt+JIFahVKb7EiG8tZqZ
	MKTviWCyJSXVDlkd4TzIZh1cfpnUlB9NEGm4EsNqYI75mrgMI=
X-Received: by 2002:a17:902:d581:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2caa3942d30mr5410005ad.14.1783082824027;
        Fri, 03 Jul 2026 05:47:04 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2728907a12.9.2026.07.03.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:47:03 -0700 (PDT)
Date: Fri, 3 Jul 2026 12:46:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <akevQfFVteCOD6LM@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj4iiD5C_yyLeb3U@infradead.org>

On Thu, Jun 25, 2026 at 11:56:08PM -0700, Christoph Hellwig wrote:
> [sorry, dropped the ball a bit on this due to overload]
> 
> On Thu, Jun 18, 2026 at 07:20:06PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > > > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > > > is part of a folio.
> > > 
> > > It is definitively not what the vision for the folio is, although if
> > > I'm not mistaken it actually is still true right now.
> > 
> > It's not true, eg, for slab.  While there's still a struct page there
> > for slab, there's no refcount and flags like PG_locked have different
> > meanings.  You'll get into a lot of trouble trying to treat slabs as
> > folios (and that will include assertions tripping).
> 
> True.  But also not relevant for direct I/O user pinning.  If we stopped
> having valid folios for anything mapped into userspace,
> iov_iter_extract_bvecs would run into problems, and we had the discussion
> before that at least right now it would be hard to fix.
> 

+1. I see that extract_bvecs also rely on user memory to have valid
folios even if we were to re-use parts of it (get_contig_folio_len) it
still relies on page_folio() as detailed in the other reply.

> Also if iov_iter_extract_bvecs was used on kvec or bvec iters we could
> run into the slab problem.  The block usage currently makes sure bvec
> iters are not handed to iov_iter_extract_bvecs, but there is no such
> thing for kvec vectors, although no one is using them for direct I/O
> right now.  Not that I'd want to rely on that in the long run.
> 

Do we have use-cases for a kernel user for direct I/O ? (Just curious to
know if there's something on the horizon).

Thanks,
Praan
