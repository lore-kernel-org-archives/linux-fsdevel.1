Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7F37FF50
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511255; cv=none; b=rydTMacftt1u8sAygTTQplQ7xkPkKSbAPdf9+fy6NZ2CgQMlNUlJIGTRpA9+/bsN6MruylINpoGYdYo5FdJ8p62vQS0EOs1IZw4+LQHBTEdnaAeZYkI3Iw6cGjgnSBp0mpr0hgM24gssjveC81sFuMW3azBfhwhc+TnLRJbD44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511255; c=relaxed/simple;
	bh=dmyezYiM94/XAuJXZ9HTsToNSTAmeUiFhmIQmDV4w3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVfzCt+9wFeAdKjd5/FxH1TsFQP7kGQa7ue8U7lBhRRml6mP61uEa1xowg4yvKu9Yma+zXRfmO0FPSMru8HhgHDSeZ0E+MWcheuY1WSK0IPPUbXhPQmOwnyUbESaq771qyOQOsvOV3sspnolXRv4vbd3AVu1tcj61kBY+5YiXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVhszoYd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVhszoYd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab97c86bdso76735ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783511254; x=1784116054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQthvAmb6mZfzW7rEXSGGNwecmdXpDNmUVxAWD35bFk=;
        b=FVhszoYddlNQ5Dova5wWmhtq7wxg0kzL2UxwHQvr28N0IS3vXiXhyufPPAOOfOrAUs
         zv5sfJdxRFcjkVvgUERn75vR2hboCW850YLxs2h1E7pHT9K/zB9NBmK53OfTXPdPEpB7
         L7mPt+kfUUyuT+pdLomMBfki/McgV6BIzFYtriA+3oyUCp8xpVaTPaJlRXEZyeVXy8yU
         FeUaJvfL1qf5PI/piyWImXGgXGTfDPIMBi2rDaQGaf0mU7gWkc3umnKxBS5QWwwqkRSG
         xJDLQVScOqgEeEjD2L3ATpy7yciKkAAHiZsVgndQGIGCwJS/RAuVJ/TpGMJXkzSzYTHg
         V1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511254; x=1784116054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQthvAmb6mZfzW7rEXSGGNwecmdXpDNmUVxAWD35bFk=;
        b=m1yv6O91SPMGEip52jhe/3PP5jxfXFL9CRejxdL9zlIgVOo6cgYtUj74SknMVcI9D3
         JBnjO70kNqjDAzngznL8eqrdRhfRewLOKpFBaEFHdfy2vpEh6/W9UkWDZYrsxZFWkzZq
         bx75KiY1K5yB2wN9ufFH1jNrLRSiMdEKAdUKfumhVU1b2+KTMLUdd5i21yf+NFDpKMXh
         Yoe9c4w0+BwsxvFB7PytbecdUW/tus7VzYm7nuJlmQ9gsGSLajFScNAiNh27VVCdoKSA
         XiecLBSF150GKMT00irWZVFdXTwIrsQVoSQxM2YRyZ6KMqfUCJovFeNGFTtWQXok7y4d
         oj9A==
X-Forwarded-Encrypted: i=1; AHgh+RoweDU53nQkdObSnElk/BY7sn+4AlFwhGPdyvJmig4Celu3KLZBrj0A4Ldlsd2zYmwKzYoUe33uvmIHFFzt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9E/vFrWhzi5njElGrJRhctH0HIqS5IuiirHq9nXUlQUYn/790
	9ajn10AOjKcAvHypP798YzGFKwDjcXnOfQ0BL4T3TRu32sNCvqsSq40K4kQqnFVk2twhkOq/I5m
	5V123qg==
X-Gm-Gg: AfdE7cnvH/7Dey1X/w/mD6IYazqAdneNaRCJziI79DiWGhwkIb/fwu5ZSuUCAPu7cMx
	fP91VH0DgC1QOhYKlP39fdczdi4M910GefJd6Omg0CmhnBmdm1nDhG6IbV0o8pPELn5e7v8xpzN
	8AOJ6H5l9UjiBNrvJjADN/D+j6lT6aS+XwwsARwKuqSFY+3McDoGWcmSiG2sDTZC8n9zifhjVQV
	fejmWDAJEmrrHk5lr/GwnwKDPZtzAhNkteoMqg9zBKFlbwyg77Wwsx5YPXFdDgKXzMbk9aTHOf4
	usRUzVkYIhY1UDSu4NfB1A7MIIqr+RvvI7BWuH/MinpQFn8mg14B6KUmRpXxJo8nwx8AZLLfsPV
	nByo4ZmHCO9C6EFX9E2tdKc244UISeE+ActoiOi43f//gBQObpg/0n5TMQ74PFdiBAMQKjUg7Py
	8ZaoQF/LxVTAwDbS2TSb4++tW4Pj+dL4rhDLFRwbeGtOnEU60=
X-Received: by 2002:a17:903:2442:b0:2c7:a13a:7fe6 with SMTP id d9443c01a7336-2ccc9c48162mr6446945ad.10.1783511253251;
        Wed, 08 Jul 2026 04:47:33 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676easm2656833a91.9.2026.07.08.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:47:32 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:47:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ak44z-X-SKKhkBkg@google.com>
References: <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
 <akfAgy52s_Gch2KG@infradead.org>
 <akzsO_vmYX_7Umjd@google.com>
 <ak4A6IEmWNi27I2d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak4A6IEmWNi27I2d@infradead.org>

On Wed, Jul 08, 2026 at 12:48:56AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 12:08:27PM +0000, Pranjal Shrivastava wrote:
> > Ack. I see! Thanks!
> > 
> > Regarding the page_folio impasse, how do you suggest we proceed? Should
> > I expose and use get_contig_folio_len() from bvec? Or should I move the
> > NFS helper into the iov_iter lib? (or both).
> 
> Sounds like the best way forward for now.

Ack. I'll reuse get_contig_folio len and move the nfs extractor to
iov_iter for v3.

> 
> > Also, do you suggest sending the Folio move as a standalone patch if it
> > is blocking the rest of the series or do we prefer keeping these in a
> > single series?
> 
> Sorry if I'm thick, but I'm not sure what "folio" move means.  In doubt
> if you think you can get a series merged quicker without a later part
> I'd split it.

Apologies for being unclear. I meant I could post a standalone series
that moves NFS Direct I/O to folio, i.e. break out Patches 6 & 7 to
another series, if that makes sense?

Thanks,
Praan
