Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61C472791
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570341; cv=none; b=UjAKAz7bUlXQCZ4bha8gOfP4QmJq9IjGZkLXGsubvwOoybl/l9JsvnORalpP6MAegVRNZeGmYznPHPZsL1D4yH3hMUiWtzgtF7XR3V4n0YSDvTNqcoXiJFSj1HuQl7fwbjSFVvGW8GCf3/3kow8Ctzzvp2Kn7NedcOzeJB3GjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570341; c=relaxed/simple;
	bh=/z2dfsiewleT4H3vufvuHwkNgRf73/8VV1Mqn0MMJ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF3QJY/ZVjSj76YCezubT5uwwUCGdBqepipzOTUT90lOOqSzI3rm/vLJNwJ29aIFNF3bg4VpWaM5TDh2oN1lgl8x7iKUcpIG+7fLUZl9LwYaxHpzKE53fsLD+h5l24Amh+SZhNHAYJdSi6xpPfO+w/lftBKejQXjYcuBxwpiyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hUKMZLvC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hUKMZLvC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so10377455e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777570336; x=1778175136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsoSAi6z9KmFSkS32vV+nxgnnZuvTLBZtnjA13t2Cbc=;
        b=hUKMZLvCmBgyPHp9zPWSg+MGJVCZ47SLkhovodD1GusBhOaVgoAylWOkDtlMreto9x
         Rm9akPqi58gtNZBKGDIWJlglybefn13CPb9SG0JH+EXHssk/EUCQBsSsuFJqDxB1677N
         M/w5f/+yu3idvQOwJq9ha0qOJ4BVibv728k4shUcub5Xcw24u6YYyorHp8tKI0RByBYk
         yc1RxAYM6FESPkzIHxQVC57MFKw3cV+jdJPbeUrjstU3ZWd2ni9Z9zmcte5FrJzaZitD
         gM64C8emvH5sk/WRORL+19w2nSZpixFt2vtDZTyZZVP/VbZ4EhXM9mZpAffsXkqDE0zl
         ZBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777570336; x=1778175136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsoSAi6z9KmFSkS32vV+nxgnnZuvTLBZtnjA13t2Cbc=;
        b=YNHLzt485HxVev9zxPBkzzve6Ncb2N32u6FF7/ZNsz61pqI/v//PSAVJmGqyrljCjM
         cvnN4mQRTcX6vM9JmknPRPgnGDc6XzMF8v+S3Fgy32uWxb39CqCxPpxNj8PTw9TFPzCD
         ncZMv+zrEVkRt5au8T9a8urnE9TMwmAH8lk/x6QoEz0b3wSzUCuJs3lG6tUclFWVtdxD
         DHcUL4XTiVB+fLvwGm5Uy8g1KxqETcrwGgerKWM2O87YMyZKWzhZHM108SfCXW0YCYJU
         maNXPSu3rzgCqNvtt/iOlKSyK5jij5oi6o72h5IhtUZWbDefeMBueV2J54y69n4srMQi
         o+7w==
X-Gm-Message-State: AOJu0Yxn4MYjB2fSfn1j7NqO4p2kBgpPc3Ine2jrZnfS1W2tfSQdGlpf
	Bed9k0zevGbEMYPgagExNpp7vtCb5+1JOJrGHrZPVWlY3e49I9DQ9U7lLEdW9MpcRc4=
X-Gm-Gg: AeBDiesnoWg/rG3RLQvC2leSD9/v7XBY2tQhTMPG9JgZhA0YpL8e4lPGss+OoAaj5rG
	L7O2tAIGMskHWM8voMD6ZdmsGxlZCNYuE651rKQImqzJAr1T3sLVAXYv1+Fvv52KO7VwaqZ7m3l
	gMrU5bbvIfeWOnrwMTZhs85AyGboe+r8Y4Uf1ECHZR0IQcUJjLQCcnIbv1hPIJWbvDhQGq9pnjQ
	MckKWxs85Wmfl5R79jabBzdD42Eq2x/onznnwQhqVcQf8ekjvnzaePd+ap2crTxmpZ9J/Qf2YD8
	TVufy9DOhH1rW9aL3QobX8g0EI3flqBy2r/U4wn5k2dYbkGIHCXxssB5m7kY6jshB57qKvcebZw
	mX6dDEKmIa0HCOUuoOhZexuK4p1ON8rQOCJADF5q9RRKr7qxFHf+9G+geRQtTkzsnYJVr1uLXEA
	BUfTmY0OemmhN9ETFZUaQxXiGWLIkNlHsxQ1/S1IDIKA==
X-Received: by 2002:a05:600c:5254:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48a844640bdmr66440065e9.28.1777570335923;
        Thu, 30 Apr 2026 10:32:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:c95f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c32afb0sm45223615e9.35.2026.04.30.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:32:15 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:32:13 +0100
From: Gregory Price <gourry@gourry.net>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache
 Pages
Message-ID: <afOSHX3U_0F5kKQY@gourry-fedora-PF4VCD3F>
References: <h5ossmwe.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5ossmwe.ritesh.list@gmail.com>

On Thu, Apr 30, 2026 at 05:03:37PM +0530, Ritesh Harjani (IBM) wrote:
> 
> Linux already supports memory tiers

Allegedly. (TM)

In practice, and in working with such support, the support is incredibly
nascent and in fact causes LRU inversions by design, is missing unmapped
page cache support (as you note here), and just overall does not work
well out of the box for any reasonably complicated system.

> and there are ongoing discussions around
> promotion of unmapped page cache pages, which lets kernel do the right thing
> for userspace page cache pages on a tiered system.
> 

I like to think of this more accurately as:

"Lets the kernel nudge the trajectory of the distribution in the right
direction".

There is no objectively "right thing" here, and chasing that is a dead
end.

> Userspace, sometimes is in a better position than the kernel to know the
> workload's access pattern and whether it makes sense to drop page cache pages
> once the I/O is done.
> 

At the expense of an increasingly complex maintenance burden on the kernel.

> So the question is:
> Do we need a userspace interface for the placement policy of page cache pages on a per file basis?
>

To the extent that you get something like:

MADV/FADV_HOT (promote and read-ahead)

as an extension that mirrors MADV_WILLNEED (read-ahead)

... maybe.

> 1. Is there a need for an interface that allows userspace to do per-fd page
>    placement and maybe per-fd page migration?

Maybe as MADV/FADV hints, but beyond this - no.  I agree with Willy that
the kernel should simply get placement right.

Building the assumption that userland will do X and *then* the kernel
will get it right is just a road to building a bunch of random
interfaces that eventually get deprecated when the kernel does it
correctly.  We should just do it correctly or not ship it.

> 3. Even if applications may not need this today, should kernel developers start
>    thinking about it now, before users start abusing some not-well-defined
>    existing interface. e.g. the story of echo 1 > /proc/sys/vm/drop_caches,
>    which became a production workload tool despite never being intended as
>    one?

We have a public meeting every 2 weeks on tiering topics

https://lore.kernel.org/all/8a622c4f-0774-96a5-2d2a-2151e0bc2367@google.com/

> 
> Let me know if people think that this discussion qualifies for a BoF discussion at LSFMM?
> Or do you think it's a bad idea altogether, if that is the case - Then
> please help me understand, why so?
> Before starting to jump on the implemention of any of this - I would
> like to gather feedback on what do others think?
> 

Always happy to discuss.  Just need to figure out timing.

~Gregory
