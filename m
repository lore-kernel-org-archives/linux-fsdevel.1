Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513747DFAA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572957; cv=none; b=GqY3gofS4yOxDzDH9iySzQgPBcTw8NmzuMYqyj3mbaEpZUyOQJWb/edHTQDYbT5YA6QtQD7QXZgTIl+cb+pOvgUcF6DuRm61k8HcUHdaiBM6rxwEWLYkELJJGHYmIvBj2AHHMyoZB76Ax9IukSSsowYKu9HooRdxZyEYv/pAHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572957; c=relaxed/simple;
	bh=VR+q0DFaiAqBsEjuXbpXoAptjSvweVDv+3Uou/jgT+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVdKdprzL2IoVitynQetlILqLnMykdbWGR+0ZApBZZcBDWu1SMiUiGE5xHbN/82NAMMbxo4tDZZnFT2uy/6OI4oqCaz5KgA1ZBhs/RT2yG2OkUAYQQn1wHb2LvBj9eKgp+XVCyWG28k8EoGKi9wf4x1d2QpC0mlw1Jt8HzuMVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7H5OZIj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7H5OZIj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so4440319f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778572954; x=1779177754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfRcnEmG4L1C60ic4jCNkQQaD5s9vtpkTF7+A4mU6Uw=;
        b=U7H5OZIjztGIuXhVYqbOP+y7sB9gJCqBJzj/eqsNAar856Q+dF287lsB/gx30xHlEm
         f0CaPdr5DcA41DSca+bYcx7KLyrUw/evP5/BGQf2e/OG4S81Tdgg5lN2kfO/tsVnP8+e
         X60bWKejW8ms3S69566b8K+WPzB3A+LfKjlH7CDXJpCkRquQ3nwzch7GHCPJFA9zuNbm
         /zHtfla0/QPbOIVZP5hgwfDznIuxqtvGUilYFq0cHonfgrujlTkspcckB9HBrzi7ZYWc
         uMQfI8jBUjyc21T84dYY0jeE/HfjK0z6JszlEGgojeMiWT3zqRBtEoR0VsAfkg3LMcI1
         pFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572954; x=1779177754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfRcnEmG4L1C60ic4jCNkQQaD5s9vtpkTF7+A4mU6Uw=;
        b=lV32dCsKNCoDmanV2m0Do8HiHmul0Mr12BppHgNq74WmIOnDMqXNoRAtmBJe2fHpvr
         b8nUSoXAiPHy0tDTo9ADvJtUaWUiYEK77vP7ZrvOckVnbFCOlgA8OtvQZOtOTOwUStaU
         u6hqxGSgE9BfqK5D3wRMVtGjwHCrStCiD6ofRPuwKZu0mFCN1gzstbJ9Od/4N8OjtWPR
         Q2dni0kkO1NELyu94HlmcKdBy71/BpdFBbD3BaVpJSNLzfHLk0PfJW2aA0JaGMW86KWX
         5I2ybphI+EOxOAXiSX6n4vCsLnSmlplRst7f8v0R/apZYbUO+H0AGS3Q9QcM1ZXcClic
         AFpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gFAkM4XZSYGGwQl4B6K+U8cwGjqeXOV9gzo4EKGDQDWglIxY0eoAPNXa3S0RUAQDHYh0zONVrEGGSg+/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyRd7/RIthKmkYWLrdT2p2Y1aADjUbCzmpJ0yujljtK2f5rzSur
	ENCMrMDNGS8I7RtUx+ySEPyDk836IJYm/tHXQRct5OUGVkG6nLA8rxlbI8ltwccl
X-Gm-Gg: Acq92OEaRmaZIj4TKliWnPZR6wi1ZTCp2+G4vF9lGPWjt4ugivoBJ+sMpaoILB9Motl
	7uLv48mqVaywspmMhn+6tfH5tcZP1ft9Gsfw1vr4AUxI9khLaX17a45An7rpAivdO0CBzfLuIFi
	2SW0Sd0SHqIHfXOvQZ43GdmLTxVtMfKG7zdK2BOtn3+rIQKPas2TLcp8K0O1SCfmp1g9AKD3uj3
	oia4K6Gq7Y/UfMyE4oUlAFmbSDj038K+UomKaLZ2finNP0tXBM7cv5n0huzDxTQgYgKHTaAgywy
	QJnRccLFazOTVTPuuPTEq6k3v/M4FM76iUnjyb/P0guKgUMBYWk2GXOw3BVfVWk/FPAWm9yQ0yU
	hUoT6kxtVzfeLjBz3VTGEvHzea+Km9nvLeNAYx9n41oRc7jfFz/OH7Hudk6iBlKoTi6fI8nVRkh
	kUiBnlO1avgGZJIZmU6+Ic7vdI5hiErKVOLTSTlzPJvLO/wy3w+OQN7p6u27fPFABgSDbj/QFq8
	zYdZ3HTnmMvJPKfRctBJR1ezSZ7BLJfrbQdLAeMtC2y
X-Received: by 2002:a05:600c:4695:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48e706c0662mr199733775e9.10.1778572953433;
        Tue, 12 May 2026 01:02:33 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906a06d1sm30409515e9.1.2026.05.12.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:02:32 -0700 (PDT)
Date: Tue, 12 May 2026 09:02:30 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Message-ID: <agLellX0pB1IZZlE@fedora>
References: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
 <agHPIcZHHyzBjcGN@fedora>
 <s6hnqm4bbi5j2ergudihydboj3uw7gsu7te4dfmjgv2qeosfbd@yvhp5oy3r3b6>
 <5280b6f9-e6d7-4854-bbdc-ed5349a478ed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5280b6f9-e6d7-4854-bbdc-ed5349a478ed@columbia.edu>

On Mon, May 11, 2026 at 02:15:41PM -0400, Tal Zussman wrote:
> On 5/11/26 12:26 PM, Jan Kara wrote:
> > On Mon 11-05-26 13:44:17, Vishal Moola wrote:
> >> On Sun, May 10, 2026 at 05:54:17PM -0400, Tal Zussman wrote:
> >> > page_cache_prev_miss() is documented to return a value outside the
> >> > searched range when no gap is found. However, the no-gap-found path
> >> > returns xas.xa_index, which after a successful loop is the first index
> >> > in the range. As such, that index is misreported as a gap.
> >> > 
> >> > The sole caller, page_cache_sync_ra(), uses the return value to estimate
> >> > the cached run preceding a sequential read. In some cases, the buggy
> >> > return value can undercount the contiguous range by one, shrinking the
> >> > readahead window or pushing borderline requests into the
> >> > small-random-read branch.
> >> > 
> >> > Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
> >> > page_cache_next_miss() when no hole is found"): preserve max_scan in a
> >> > separate variable across the loop and return `index - max_scan` from the
> >> > no-gap-found path.
> >> 
> >> IMO, this way of fixing it hurts the readability. I'd prefer something
> >> similar to the fix in the original commit. Or...
> >> 
> >> > -	while (max_scan--) {
> >> > +	while (nr--) {
> >> >  		void *entry = xas_prev(&xas);
> >> >  		if (!entry || xa_is_value(entry))
> >> > -			break;
> >> > +			return xas.xa_index;
> >> >  		if (xas.xa_index == ULONG_MAX)
> >> > -			break;
> >> > +			return ULONG_MAX;
> >> >  	}
> >> 
> >> If I understand this correctly, couldn't we just do something like:
> >> if (!max_scan)
> >> 	return xas.xa_index - 1;
> > 
> > I think the easiest to understand would be to do the above two explicit
> > returns instead of 'break' and change below to:
> > 
> > 	/* Return start of the range - 1 when no hole is found */
> > 	return xas.xa_index - 1;
> 
> I can do that, but I think it should be consistent with
> page_cache_next_miss(), which does index + max_scan. If the xas.xa_index
> approach is preferred, I'll change it in both functions, and also get rid of
> nr.

I prefer Jan's suggestion, and making page_cache_next_miss() consistent
with it sounds good :).

> The nice part of 'index - max_scan' is that the kdoc describes the range in
> terms of that already.
> 
> Thoughts?
> 
> >> > -	return xas.xa_index;
> >> > +	return index - max_scan;
> >> >  }
> 
> 
