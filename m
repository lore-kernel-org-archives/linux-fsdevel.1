Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F92264CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782423233; cv=pass; b=A+MQylxXgmOOHiYIeC7tvP5BxCg6bib9DyFWjEHWiNDjxGG49foYaR45ol2GXxUB2IeWvKTMikdgeG3eSdsa9AbB2loZKzCSqqhWDcVyEFFNnnnAZnMo+mr5a4ykzu6POf2ATqvsgWwSj0GjcsNNtRwTh862mlXEq6GSPUcNXfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782423233; c=relaxed/simple;
	bh=S4igp3JHJHcIWp4Y5RSvAKMTZ8iNbcZFgwBqxXO5LG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0Lq023q3d/HvkPxl2w0O5Wm6kEnaNBZBajvdC6zwu5Zt8Vk++KsxFNxRdeUpKLwG8ZpYXm/uB00acWZFujfeJXO1NDGeC5U1MxdRJ6Ctb81XIW2hiY2blk0crU4OJzdCLUqYdKErNZttltxwt+Ab3l6UJZ0bZ+BxQHOSYmXpNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNroZ2/G; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNroZ2/G"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46e30429b10so137006f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782423231; cv=none;
        d=google.com; s=arc-20260327;
        b=NjHZuRX4U/LtlClPpRUvoFxZfHOBuTjb6JGFw5z1E1pZSnrYVt9/XdPjB62M2d9Og7
         90CB+H6m24L4asRMY1hLj+FQ5YQe2eZoB8MjO6JRHpttbrrgcUiPo8A7FocQ7R4soeEg
         /RrAqZxURvgxy7GcJh1u2Ejtv0vX8X/ZPyCPc+WCCkouTZCEvE3GcVEdQZwjdwP6DTfs
         OmMNpdHPKUmsdso0YU9PuYbLz8CsSEIgN3amLN/TtD+gJ0L3Sz3d0u0KA4rlpL/FvGbv
         A5bpCAVXTLJncyqNfpNbFnJNGBBF0K3RI+a2qYU4BKV+GlrZrIVf5qiILjUeQh0bSFq4
         obDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ss8xuaZoLxesr69wdJovU41A9sFovOVmo9NuMCBc6/g=;
        fh=3ThVNFtCeLym4lI5M7QrhQKgFy+Kw1qw+CO2zO+gEjA=;
        b=CRgRfc69f0fNMqEYMS/mdKF4AAsrGCP6qRegWBJLBs+UE/VvuVXkGYkfRYLtXFiEJ3
         rkZlVT+X9McwAi4pfDgHfNknqn5brqRE5/GPoEB3jJ1SxYY/dd2OyDKqcEmWBihZD4dJ
         HXfTYMOrxA5hHEC5qoF5QO2VhSxixjH1keBHb4CpbVEy9zEhDLD174lLyEo6cLOCvW52
         +DqcnDSyb1G327xZhFyTzyegIKIfkR0JRGAaC+zPo5iEGDNxDduymQ5eKv6ZwpDTryCm
         WkIay+wVthiMbpAz6gOp/djiG+qgXg4U4Eala0aVID1ILm9mtt8j7KpkosOsAZFKmedn
         4Y1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782423231; x=1783028031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss8xuaZoLxesr69wdJovU41A9sFovOVmo9NuMCBc6/g=;
        b=bNroZ2/G4jbUjaPa2mehdvSpMMF5h6mdtxo21HPGyK4L7WkAvnBOCZOzGTEbBvsqRa
         wQXduo25ZeZ3NZNZXfwPrOMZ0jsYIo6iDYkaRM8lfty97+8+WQawkMjFhCyZU+I8fwla
         FxaZXOGOniZZGwjCcN1oItTRB3/3FvnAygJlbKm6gfxJx1bl5RCpWR6FKJDQpYUIvvob
         ojo4c3MuuSUbQXUTKE46r34WoIhVwgP/A96Nr1Sk69iUBURyrjAEyZ5cyV3YIz7IWZwM
         raZ/Ebq2JpZqnO7gwzKFAChZzCgOTC7TufaPvBvfOSuqFAZxW9w5XpE13NQnjBkQuGlu
         E3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782423231; x=1783028031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ss8xuaZoLxesr69wdJovU41A9sFovOVmo9NuMCBc6/g=;
        b=fOSQ1m584V3rDuhNwhBR2t4W0gRYTC2uHumyz4Ut8kP/+eR/Yeux8G5nhUUp1SEtEQ
         qsAem/qpg9Y8tUDgLJ6peFS+DAzLqWfQbiYlGebot+8HHY/EhrpSPiOZgtgOvYj2R6TN
         oREsoscWeqCVuwx8ACvTh8X7mvxssQFVd/UpE0qnn/4b6pbvaF7/HrTkM0r/3XhLmvBY
         hJXjvxnQ5ZYH/og3DwTfBy+rdyAP6zirYaVLe9aF1UBAbjeiMhilniHA07y90KzIUw1Z
         CbdZeQppxwPiheSJDouMEZbZ6MhQaPoPeVLmoOVHPmtV7VJLrVaSwHofFZe5iP5SpYWO
         XzOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlDd1l602V2nUJLwLI6amn0dAS+6G50ViYIlz69zjmez9AYUJ0B/ssc/Hy67YCmHrTrC0VXUeUxTO9bw+a@vger.kernel.org
X-Gm-Message-State: AOJu0YynXHe1MfPbJHnGfoXnXNP88PRkHiLwG1Qp84IevNWfaujzc4IM
	wNsmyEaeVJcoIE79g0ipsbW3ZsfuikN72uHwrU20aB3yaotnRitnXfukUnffiNUnFqEUSOe4m7g
	kzC90GvdYIJ1oMYPdxFRlyjlNaGPiaE4=
X-Gm-Gg: AfdE7clwy+qLWBQcwZ8uVqGEvJ2heth/awUOsYDLUJmV30TKI7FXKqzX1mhLLj5JcJD
	oEc+fXzZO3cuskJsbEsmlymvCaazOqpLBtr16kAMumKcluEiwtGjzAkj+qnyH6BA72aRU5eXgnj
	45iFThp6bC+Q2viTDOauN/CFRxMkB5+O4XVhLB3zT2Qk4XKrIZol2jSF7XGdwqn4R84T7e3i32n
	8Nfvbaomp+aFdF7mDn9yiL5qStXVeuqHBpON7KiVH8FC7TTeBUH4MhVrTfdhUFYGWAKvHNm8Z9G
	sKoRwkUVYcM9QaCykO+2BaPDBF41hKoL4kaP0SDHTgHt14RxJsUq
X-Received: by 2002:a05:6000:4308:b0:46a:44e6:6f0f with SMTP id
 ffacd0b85a97d-46dc2b0b567mr6540830f8f.35.1782423230929; Thu, 25 Jun 2026
 14:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625024723.1611000-1-joannelkoong@gmail.com>
 <6446cb94-a005-4e4c-8034-d7bf2a4b402b@linux.alibaba.com> <20260625130206.GC22620@lst.de>
 <4da9a5ac-2a53-4fe2-9283-2e0f6181c248@linux.alibaba.com>
In-Reply-To: <4da9a5ac-2a53-4fe2-9283-2e0f6181c248@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 14:33:38 -0700
X-Gm-Features: AVVi8CdNemQaFUguNE4nKazKE0uUNBLjMBd_9DPfVmLHpGfTqrGSFlhGwIv-bTM
Message-ID: <CAJnrk1Y_RLezfBq7sfgErGq3uT1t3czA+EWHg44zEXp9VrYF=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] iomap: convert to in-iter ->iomap_next() model
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, willy@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 6:21=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2026/6/25 21:02, Christoph Hellwig wrote:
> > On Thu, Jun 25, 2026 at 11:25:54AM +0800, Gao Xiang wrote:
> >> As I mentioned a year ago, I really hope this way can be proceed
> >> to avoid iomap iter-callback models:
> >>
> >> https://lore.kernel.org/r/20250905152118.GE1587915@frogsfrogsfrogs
> >
> > Oh, I guess this is where passing the iomap and srcmap separately
> > from the iter come from.  But for this to make sense we'd have to
> > be able to pass a const iter.
>
> ... anyway, I hope iomap folks could consider my humble
> suggestion, since I'm afraid that this callback model in
> the long term won't scale well in very slightly different
> details (along with more and more iomap users), so rather
> than just converting more callers, I guess it might be
> better to consider non-callback model as a direction
> anyway.

Thanks Gao. I don't think the callback and helper models are as far
apart as it might look though after the ->iomap_next() change. Once
all the callers have been converted, there'll be no iomap_ops
indirection left and callers can just pass in the direct function
pointer for iomap_next(). You had mentioned something about having
callers own the iter and drive the loop to get rid of indirect calls -
I think the inline patch in this series does what you had in mind.

I think the difference is that under your proposal, the loop body
logic for pre/postprocessing the read/write/etc ranges is also moved
out into helper functions, which each caller would then have to put
together / reassemble. It seems like a lot of duplicate code and I'm
not sure I see the benefit of open-coding that when none of the
callers right now need special logic interjected between the
fine-grained helpers and and their callback. imo it seems more
advantageous to only add that in the future if there's a caller that
has that special need, where only that caller would need to do that,
instead of making all callers have to do that.

Thanks,
Joanne
