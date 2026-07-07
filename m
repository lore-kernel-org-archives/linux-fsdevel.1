Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A973FA5FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426121; cv=none; b=gRqz/xFAC3hpEz7pdfZ7WTazxEH0V57wa7j8go7igI8aqQ6+bW18Se/6vXPWhcUNlfrIpvVGtNa8Ga8FvFzzmDIOevOhYigmFLtHJM69KFkUWHCVD5Q3EKfJGs4igXkfu+Qn5GzfgT0u3W9qT+tBQUFcCBxQdveP3pQ0BExeYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426121; c=relaxed/simple;
	bh=tKdep5wfqWGXsqqgVoSBFgRw0T+jxm3tufE3mG6gaic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tihIwGV1PrXHPyxgt/qEjGHp2DupKRalajLM2LjO/As9SfjD5UdDFmYo3MhxpHmA8yJlZsfswJ0T4o2yd+GxKZMxJgN1gh+4rG6E0k5tA60c+yD6+CRa124HQeUQXwDVRIyxJk4t6BHx1fn3bigGuq4JGLxnWyD8okJ5KFwnxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMVztAxd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMVztAxd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cb59f6ba26so71295ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783426120; x=1784030920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4cV7wjZF91JZABaQ5nRkxwcAf75ivPZaWcSLuu/chBY=;
        b=gMVztAxd2Jfqy1RmjrW24cwvTf3F2LvNMJEX4HyIqR7zh/5nsqunTvWzWD23A5Nhme
         YmH0pDrXIJL8pDbAxWSiHT/HfNLdLPjrqQXjANDKiK3aqdeRs6qEy/SKa7yVC8jlZGda
         Ns5/cxuY62yGf1J3cIFqY/q+bjSJ3qDAq1t/wGK/CBsOdVYiukyKUElmG++oLBrY7Gda
         L0a/ISVVW9czicljMVhthdnz9ifHNziwHxUnLLbrrjV5aSgnsF1bGVSaRNowIEzllMvr
         mr7/sMYFfZOF41ckz/LnXbHZu3VnGv7BSIn/61RizU5BSpD7i2c5QcodR2AdTz9ClMy1
         Rkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426120; x=1784030920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4cV7wjZF91JZABaQ5nRkxwcAf75ivPZaWcSLuu/chBY=;
        b=HwTjR3/XtIpSgxmJtiLzb9uhb2to9+kry7k8Heu4PqF0XhTcf+uEDE2GjtVRiBfPSQ
         XSC5SGh6C7hFku/JKrqXx6cf9UZAaizNyECYepLCyJFtpg0EDHtcvrEQ3wgwECwav9gb
         JQzBUzH83+0ASPw5pf/oqMZwAX76OpdVfO5S+D1+SzoGD+d293LxOBheJphb4c4dCCWT
         8GchDFTbSYbXzSclyWFgJnmZ/OSAwWWJiaK5qWCvTK/y43K0TNXenDiX8+TQgcf4rjLd
         XrC4h8FhVoFjCriuGi+TcFjpmyD5dZ9mT6saDlAHdBSp0sMEZcr9xcSEFzpV4lW3RXmg
         Y//Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpcr1an4KADhLFfngTbwIk401UKziuPP0EVgFlBLTSqOwq7X/Zd1QXRMd3HTCgaNEx+tHek92SqMacjQjqD@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAodlDHRZhzJwbA7xBj/EXAfm39LoWvlFVVVsPU2jL81yq4VW
	+P1P9oDXIYJehW/qirS0lDvMmI4FTg6CfNOdPdR3gZq0z95mBlxtc7Un051VMKKoUg==
X-Gm-Gg: AfdE7clcbvQuFOhTy+pJRf5GrL3oHfu+0DTI/WWXJ0mWpJyTtEp9Bq0AAZ3H186cVCc
	dWhvtWP/H3ST5827vdq9eRwO4v7oQ+XUUODSxMLhRjrSGPCxGvdGM7E+7jjhzekVu2Qky+IcPmZ
	y+BPrYal8Gg7QKSe7zp7/y5UToWl8CCySvavbnta/l/RWTLS9OkgFs1CEUJZmPzwCmTk3xKX/Hy
	vNT3ot6I8hEhjcp7Ifs5rMZq6jm1PSGeexso8ie3hUUdp+oiDgH5HSpq6sUksmP0n/mrjdOyZfy
	3b4OxVPuQUhDOmClL+eTiBSaLDcXxCH1SOt/BIWQ2j4nqPrYxbmk4OfWHU+ONQRCDKo7H07aW/E
	GnCIXr5Bc3xCO5pY8TL3GgIO405HKbT0mZ5bG8VyOgBELHKGwbZ+wrl6ZPALvGOcPypSFyt/F6s
	ZijU2w1rER5kuc7hgYgAZ/WoizWY+LUUs63A+W0aZfDAaEFvg=
X-Received: by 2002:a17:902:e889:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2ccc9d7593bmr2658275ad.13.1783426119230;
        Tue, 07 Jul 2026 05:08:39 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d58f3sm853302a12.1.2026.07.07.05.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:08:38 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:08:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <akzsO_vmYX_7Umjd@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
 <akfAgy52s_Gch2KG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akfAgy52s_Gch2KG@infradead.org>

On Fri, Jul 03, 2026 at 07:00:35AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 03, 2026 at 12:46:58PM +0000, Pranjal Shrivastava wrote:
> > Do we have use-cases for a kernel user for direct I/O ? (Just curious to
> > know if there's something on the horizon).
> 
> Plenty.  Basically any storage on file driver, or storage / file system
> server:  loop, zloop, nvmet, scsi target and nfsd ar the ones I know off
> by head.
> 

Ack. I see! Thanks!

Regarding the page_folio impasse, how do you suggest we proceed? Should
I expose and use get_contig_folio_len() from bvec? Or should I move the
NFS helper into the iov_iter lib? (or both).

Also, do you suggest sending the Folio move as a standalone patch if it
is blocking the rest of the series or do we prefer keeping these in a
single series?

Thanks,
Praan
