Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DE1E32CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257412; cv=pass; b=pzftm2+Cqs0SSQ5L7CabcV6eFwHGDYr/N7W7kXVS4qpq6cWgPc6drGFjMpZY9Nwo0O8+VPC3z99aTnTh3LnBKhq6hHK/w/kcN9r7KOjN9OI+steAmwvr+4zGhKGdVB7cf9khiux+UgmFS7kEAXgSM0zxhkEqZeqs8kbLx4vucmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257412; c=relaxed/simple;
	bh=ZP4vSTi237WM7Shkp/cJXygtdRvJMxuMDi0qZjIwYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3CboVJFcRG7P/McTjGJxVBWgmEzmi3sdKNHrSyzstCzs5i9Q3rwtnChAhBe8cBZQHTMuzebP6CdMQQ/sbq9+fUyCPAiCokwe1yNBBTlhJlj20qKqQXE5GBHtx42aNLXQl6qTuaVxQKBanzD0O7G/7f7LRLbdhUCOUW8E0D6A0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5iWKqd9; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5iWKqd9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8dfb9139008so314213285a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 05:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257410; cv=none;
        d=google.com; s=arc-20240605;
        b=W1DqKKOAIuAB+4nkS/VTu3DJxMmUMgRdiNxqFsSbZL2g+JE4Kcd871PdvBKqZ5rHK1
         nWujOiO5Jh+HhACPZ60HBALsxQo8JxVkMrWJhkAhL3h0hviQFrI4kkNqlSQZaAnp8DJc
         8dcMOLVd1POtwlEb8NapvLIvzsdML66+KBrl+2Xz1eu9TcKzfEwumNg8PmjXw816+Tv6
         tFlEvW0jo8WgRTd84LkrvjOaQY70ILYk2lw2XeRraqGUQesugXNu78uhF6jgpGtBj6zT
         PYZ+BihcbmsOwMAcmfgI3Giv9qujIfMvZn2EXFuRiRwlgbl4XyKQtQL2ywfzNg7RvLcV
         DbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        fh=scfUiBnGpmLoIt7jcdbJQJMeSva4IXoxsn3+UUU02jU=;
        b=aesAux7vTDzRCjM1dXffA5woPUgxSmBjLfkh7Te5NVvQh6kDhw80+EJN89M0TVWm6W
         BZ2O4lyMVHpNFJDa9T8yaw7FT74+C6moCS5KLLYlFu79dNtyZvlo82lQKa0hvi1NQzWK
         kx7XH0ZuLfD8i+UvBsrYCTKS/slok0oZbxO/aZxFOqnhJkTBAb6FKgnUxsQWuLF70XvN
         krbO7/2hPf5b9nR5t+LPstsWbKs3uHRSeYvwTSMzTFmG/rAQO0yQVfIooclxO8pQRoHD
         e3YFTgVLE1ZXQe8f5QoO66TzZIdlsVzvNen3YefawfCTWGo2VGe561d5VeUiSqHjjYfZ
         r+zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776257410; x=1776862210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        b=U5iWKqd9C7K17mIJA9DrwIPET8xAgSIjI2Dt80xmicSUiKIzaYpxe+gAPBNblAuSWZ
         DfS+CTLbbUiRFEe/2OIJCdvbn6JwJnQ7g6nGwaiMzvYG92hq04dXUiQCOK0Eoykb2HLd
         +Lf49ORPa7Evp4kGLefWinL34LJAzskx2Z6snitX1Rv6AVyFHdge0ezE9QLgSPx9zXod
         FVeuIF7O8omcL+i2V4/a4lCBxO602uRsOUg5W+g+9Qi7EjUTXQTmpBqrC7Sqpf72WvLE
         bqo3c0owFzf9VVKtgZOxhriAdcbn/sj3rIAfY1XpB/TmMXUbfvX+qQp5Kw3NsVVjO3x2
         HWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257410; x=1776862210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        b=WQcOMw8ydEJ0LaMZh59QCkX8vi4dL866592XZ4/bsyFvY3DUsbHkwCgYRk7j+ZK4Et
         TF/2dO89EzuxYNk6tnSO+2D9yuOg2aXodx89qZge+ty9UrSOWLaZq1jt9v1EOa33Q+7Y
         EoZk2pZ/4iVJ2GsrT5xPZHW+adNwSRmDr2pLqQ9JAPWRLo/TUDe6ZeT4x3/PdT/cgVD2
         wojYJ+HdL4/vqbsfpvsnVHOxPub97KtKatAy1llWzhxQ8R5wnAUKZ4VUhuSt5q5l566D
         lXGiKyzkAgwDg+Y8Mxvcfv4hRECBhoLK/f43xCqopB8pGJ4fGAo/x8QPqK9XwjnU/y4B
         JxBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v2JsOXjTHrK6KQRj0NJWTiweLDsLHiZPp567aX14vxLR/wL5/ZaNS5Y/uKwXgyLmw3sWohMfs8rUfty3r@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYXEVFNBVOGJ/PjOg7Vn+2qTPp2dRsh/XD8JaNqMOesU5cZ0U
	l5qr0IMO6KQDyGsznhSocnChARgc+1irEsuW7nPeTxaBA31hqZGknCR1DWDpMO0a6HWSYEDXIFU
	61zIqfRs8B97CrM6RAG3Rfk1p9589AHTiYOzefLWw
X-Gm-Gg: AeBDievmwrQy54XhPD1OjKz0znsZnQnLbMKcpmhOUzgAYZz7hxwq2L+9SfHEvUXfJb9
	5wehfosT0ZOl+iQ675nvPQSTkOeeg0RLNo6hJNjpSPtkOtjDRpx1CNVpNNOUYeTFv/K/jPVAgFo
	Q6BK2cQGNEtgVhMfpbiBwbHozBmUEbWOc1QNVewuksEhVYEIX6XotUnjRJ6RwVvdHYxBUHEavHQ
	I5geF5kGVtKU06ozxMFi9MBYHNKUM+R2TmAXb/PAwaAcrHfxnts+hfgiO9T3RfbLdgLgfDRhsBU
	YKdaNv0HCSqyPWxv3CoiMTfnwE4k
X-Received: by 2002:a0c:f40e:0:b0:89c:ede4:ea35 with SMTP id
 6a1803df08f44-8ac8613e90bmr340193926d6.24.1776257409637; Wed, 15 Apr 2026
 05:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409160243.1008358-1-hch@lst.de> <20260409160243.1008358-9-hch@lst.de>
 <adl1iqhldFvJwSw-@dread> <7f0d072b-97a7-405f-bff5-d3819de2e3dd@linux.alibaba.com>
 <ad2RKNo2FGhpzJQp@dread> <a7a74185-df02-4906-a0ec-f87e2394aa5f@linux.alibaba.com>
In-Reply-To: <a7a74185-df02-4906-a0ec-f87e2394aa5f@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Wed, 15 Apr 2026 05:49:58 -0700
X-Gm-Features: AQROBzBdnyNeg6M7eBa34eLrstKbL-D014vWbc0uebEOU17jGRgdz997IpSMUAE
Message-ID: <CAB=BE-SObq4hSO9s36H06eVtZzyj5OBPKJSOOYGJDDD38URN8w@mail.gmail.com>
Subject: Re: [PATCH 8/8] RFC: use a TASK_FIFO kthread for read completion support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Dave Chinner <dgc@kernel.org>, Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> Basically what we want is to get a non-atomic context instead of
> using the current softirq context for read post-processing and
> switch to the task context immediately as you said, because:
>
>   - Our post-processing needs to work in task contexts since
>     advanced features like compression deduplication need it;
>
>   - Even regardless of our specific requirement needing task
>     contexts, using a dedicated task context for read
>     post-processing is much better than run in the original
>     softirq context:
>
>     - Algorithmic work could take extra time (especially slow
>       LZMA algorithm could take milliseconds on low devices
>       (however, we need a common workflow for all algorithms,
>       including fast algorithms like lz4) and verify work for
>       example); and long processing time will interfere with
>       other remaining softirq tasks like sound-playback
>       / network softirqs;
>
>     - If it is then deferred to softirqd, it just makes this
>       latency issue _worse_.

Yes, this was the reasoning when I narrowed it down to per-CPU
kthread approach. Patch has helped reduce app launch times which
has a direct user impact.

>
> But anyway, I think nice -19 can be evaluated if Sandeep have time,
> but such nice value should be set by the filesystem instead of
> the userspace since the reason is as above.
>

I will find some time to re-do this again, including setting nice -19.

-Sandeep.
