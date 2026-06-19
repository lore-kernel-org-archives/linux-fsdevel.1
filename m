Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA932ED32
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872334; cv=none; b=gORKZJzkx8o271nsGJbW/+e+NdilclDwwJQJXlgHyBrzTiwsU+KY090WL1Mwc5cJW5zDE3gRGyrXYXFikDKPFOxR+fSSJFWmAUoQv8CdrD8KMaaI3+K/8+TDNxEbeD0f0GUsAgzZ+kzM+KUL9am+ARcS4uW0s9F+UAoOiOK8eWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872334; c=relaxed/simple;
	bh=j7paI+dBkaIDU/IeX574vRzwUw7u87K/qklOPHPQ9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofqoU7AahN0eiq6IfElOc08S09TDuTPEERmHm6PTd1JBzQ86Tx5DdP8w2O8xtY5oH0XLaiIwOcJi66D3PWcvSoeIHZgLdgsejA2D5is2mv2iP6BabcWJ44KOv1kCwWEVFCHUZ05litfgCMwcDM6B16s87wY/hsEVRuAgwMXb7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+TsZ8cP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+TsZ8cP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c6a4eccab1so37905ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781872331; x=1782477131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zAgRJPG/x/HKYBdMFy6t9gS0SW7lI2ALodBm8Z0F2FM=;
        b=a+TsZ8cPo9DlfKpk1KZbrFHdabGUKtN/sYEFbYnjwMHxj0nEUq/L1FxhMf9eOv0s0x
         GtdoOyJ5Cqjn4gA56d2jFnmlGT09bzJQY2QEOSc06SUwWQH5SVz7yGotsWAn7PiAKj9o
         JmaVXG3nqW0dp1BFYEuad84MtD+md8KtGJ0OzQk8fqJMFyIbD97Eh/uk0zV4Tqn1Rrhs
         zg3/yz385ljiS0Q6JtgzQ4qHvvldv29B1EfXS1wvwt2vXHQ2sLGB9KXsKkz3f1KKDNzO
         g9mzBLILFGwNv+BhB6whmqNyOknYVnZOwRym0ORt/iz23ekVyGbaLobkNSNU6fWrPeOI
         dc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781872331; x=1782477131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAgRJPG/x/HKYBdMFy6t9gS0SW7lI2ALodBm8Z0F2FM=;
        b=DJP+X4qmAcncYQtTYlWzOXdQju1A5fcSrEwFMCWBEsSQH4iOMvgHHcLW3B5PU1ELtg
         o4UPhnevJkNoTE8ErtXeiCo13y00SvfpJr+rrCGjUrDRkd3z0k5sYDxYIm3znRtOdyl6
         XHARUEbBAF5HQxbTtRJ7iOed9Lg0TuqbXkWm0UpO9yLqoD3KMgs+Vve6Mskm/UKaYaG7
         FVNuYook1y2KoaIiwsSzbv9EcqkG0ee26XuetFfTtNKP3lP39UU6JWcw1+OIgB3KaSbZ
         +uHbdmPl7Ee3pUHouvAPRTM2O1pGTenZeMCWmnI4zHkGnkXIYO3p50QiicqOPZeNoNIC
         Z3QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iSJaNBYI9J+6nujkHDmZVkdQJZtZdI/Ph8N14IBTwOlFPDy77qgQksi7vTcMnQcPSd4Ht3CM7Z2hihnCH@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzwiLS7mpbiHs+sY4g/2SXXPSVaZu1gVFPSPF2F1SNjRDhAMF
	HAcnKBCiLTOk1qaaEcKs41Tt6gksvPUqZeZTaOzH9P0YtQAumBnm8Pam019g4jBQRg==
X-Gm-Gg: AfdE7ck9JGoYQre0I4QesjuHludgzG0LQeY5q9luai93SpXAYbkjaCQFRd5esWWDB0l
	KbTzXvjZyXcNu2MkaLZDi5mkoW08xXm6iFZSZOShFzT5rKut9ZPXI/EdL77XbVBo5nwiUqQJBeU
	0GecG3ZxiB8oLf9X5GYHUtMbszmXiLgtIOLW9CWE8oYfcIpmIQJWRhXBcOjLQyZuJ9/bnHxT2MX
	WN9ShhSRknt2UJyD/8c3Cn0I+J4Q+iNaZOINkCZfFhXo15waTtIj3jHL6pgfWcfehlTir+JbAa8
	Nq6fZjxo4wSWFkn12rHOmTPU5L9VRZRWxrH75+fstu9CxafiwCRcTFGBh5yHAapvSrrPU4FHaZC
	NNIpWdGjzwbzeCzM5iG1y8/T0TT34HhT2rsjzBcEUtrNbSU7xCfu2IW7msp3dwqG7n9w4D+M5LW
	XvroEMeaSLClL6HICY/JbaefQEd7msYXVK5EvqLxnGHfZMBCDC5Q==
X-Received: by 2002:a17:903:1a45:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2c718f8d692mr1926525ad.2.1781872330656;
        Fri, 19 Jun 2026 05:32:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845534d42b0sm2382315b3a.0.2026.06.19.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:32:10 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:32:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ajU2xJ1BAqqtog8T@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQ21kH1ZVajS2Y7@casper.infradead.org>

On Thu, Jun 18, 2026 at 07:20:06PM +0100, Matthew Wilcox wrote:

Hi Matthew, Christoph, Trond,

> On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > > is part of a folio.
> > 
> > It is definitively not what the vision for the folio is, although if
> > I'm not mistaken it actually is still true right now.
> 
> It's not true, eg, for slab.  While there's still a struct page there
> for slab, there's no refcount and flags like PG_locked have different
> meanings.  You'll get into a lot of trouble trying to treat slabs as
> folios (and that will include assertions tripping).
> 
> > This whole
> > area is a minefield unfortunately, and we also ran into it with
> > iov_iter_extract_bvecs and the earlier block code it was extracted
> > from.  Adding the relevant people and lists, but for now your best
> > bet is to stick to what the block code does or even better reuse
> > as much as possible of that code.
> 
> Yes.  Fundamentally, it is no business of the filesystem what the iov_iter
> refers to.  We can do direct io to slab memory, vmalloc memory, memory
> that doesn't have a struct page (eg iomem), or whatever we choose.
> 

Thanks for the clarification. I understand the larger vision of keeping
filesystems agnostic to the underlying memory represented by the iov_iter

The documentation for page_folio() [1] mentions that "Every page is part
of a folio," but it appears there are important nuances regarding slab
and other memory types that I was not aware of.

However, I am a bit confused on one point:
Looking at iov_iter_extract_bvecs() [1] it relies on 
get_contig_folio_len() [2], which calls page_folio() on the pages 
extracted (via iov_iter_extract_pages()) without additional checks for
slab or vmalloc memory. 

I am happy to refactor the NFS Direct I/O path to reuse the same helper
(get_contig_folio_len()) from the bvec extractor, but I'm a little 
confused as the bvec extractor seems to suffer from the same risk?

Is the recommendation to keep these details abstracted by the iov_iter
lib and eventually hide things like iov_iter_extract_pages() and manual
folio conversions from filesystems entirely?

If that's the case, would it help to export get_contig_folio_len() (or 
introduce new helpers) in the iov_iter lib for NFS and other fs to use?

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/page-flags.h#L291
[2] https://elixir.bootlin.com/linux/v7.1/source/lib/iov_iter.c#L1849


