Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5416358379
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043937; cv=pass; b=DhbCBD0e7P4QwVzpzhsV2hSNbZ5C7Zl5t8iA7N7qQoPG3fjw2E7DRwfSYQOUTJqHiX6v9puR668x8tQSixbIP4TkPmRRo798W5PDswuGIlQNvNwg9P/72fWDLr3jPyqipK+9X48hUDeN8JBvjIEDC6Raj7LHylnQQKtOTuP1JgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043937; c=relaxed/simple;
	bh=taGryygV72CTK+0z5VvRQSXY37kHg1eywRtjZPhowxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGvj01KoMlPkTgwB7CfIFhpVfLDff3tDghfMHBdQLaRKocKlr0375z+ALOnV3RZPLMOM/s+kzsM3NUVtGJkO4/2tpoX/KwJgdEGF9Zs2OpbZ9lokd1XwF4IA+BBij3t2uw+TEtdREvWEKI98l+QL/dOp86F52wx81ZWpreXGWpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLI8XUSp; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLI8XUSp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b9675d36so18109945e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774043934; cv=none;
        d=google.com; s=arc-20240605;
        b=hhRW5inl4qdQJZwWiy+0/ZPHRMoj9gRhxT5vtSCfp0h6MY6gQQvxSmijbRvrxeZJCf
         Pf+wCp2qoJIqC0EF6Tjj/nLtVbO8szcigGpaAeEGFaburBCrB2FjoUjfADz3f8KoKRe5
         I3i74zF98II6e4OrkZg5nF/RT9VT3aeCR7D4cG6pDyRgTnk9Eepq+KpqtYfsyqNlRR1l
         tl77+tqifsvw+OqMfNJ3dJSw66HTGip0M9gJ3wUWjwgwNndu+AxSvlPgV7lxtzBD0nND
         7r9OHohiawEnH2vsOFd9TAXJlHjaTJikcIqc15P04sd1dMEkkmz9KE3+GFEXEgle/TOR
         +sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taGryygV72CTK+0z5VvRQSXY37kHg1eywRtjZPhowxM=;
        fh=kUF/j8oY52LdS6MtpiAGyZOaD92Tp3ZxXYkOpuCq5p4=;
        b=WmQRCFwQiueJOieQXbYSP9cK1pfYkYiW7qxqz8o2/rc+pk5i0rnlYi4UaKju3VylXE
         p81+v1+t+c7jf0LTWOHwoGu5FqefN7At4STgRDAov4aLg+wgwlx6AYEjTUxRGtOKQV2J
         pchg9cp/MxaqW8Cq9K2zHJtV5IgiZ9k/TOcr0rGf933SiGfUZUyaYHeSINW43Wfuior7
         UW7q59Xwn594ZISE/2NeCcIZ89V24i5qfTDOrsENhHBpAzQBhvU5vUfO3h/QwM46dEaD
         Vi52ZpD7l7bc0hl8QV8fcHLUMjCFoO7e2YziuCPvxXS1dKIR8BFkz4D4AaEnkwnrOd4u
         SCNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774043934; x=1774648734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taGryygV72CTK+0z5VvRQSXY37kHg1eywRtjZPhowxM=;
        b=WLI8XUSpM7s+cuUliawRZzDsDb4r+IA1ryuw0qJy5eLr/eYV26Vbjia2lKwpk7gynU
         yorU5I4Lmurc0pTKsllqwvXA1yhrEiO2+MdhKMocLpR+r69RTheJHXB1shaOwaT8EucI
         DiYxIBz282aSkg3RQpkrYVRz1WI9JaK9YloUYwTaqDxBS0ofz5qnzs+YtdL9iyMxszo6
         QabpI+L2sfUfouJP34WJ522dskeqWzQ+yCIE+hCnkw4KWhIfaNB9C0FanePcdAg2skNd
         ytYFX2SAKPylysRSKV8pER3JEi/Gcv+YqWDsObBDHqprhBBkCR4+GjJK51lh/iBBB4I+
         0CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774043934; x=1774648734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taGryygV72CTK+0z5VvRQSXY37kHg1eywRtjZPhowxM=;
        b=Kawi64aIRWfpu3zxHWYfP8UTw/dbbs3otZw+wVHgxBS0VOAEynaRfJ7pkNe74jEGgA
         czsAMRw+HcPTAeubVWvERYLSnOq7UPOvm5okEbglFSFKV1JSSEs6Yw3aQK7fgx3mEzR+
         EeFSsjg16UFU42nEqNJTO5ykkrmF00bBltZ0O/bSNvRw8aeUGJG12fDyK2S7NbQbaKSp
         ewi5eI8ARaekOD3i20/aXRK4G3eEyrISv/oFtDjCOEo5dRDmX4n2CalxOH7V8A0v+4sA
         tGdiPAE6FVYkKYizlD6YewOlwQFeBONwT1JTG0LR1TPlQYQZ/O067HVtrf2C1vDmsjU/
         Q9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUccDFCmm4QC4QVCAN6MwOCIP/8uob4F8qCzdUsQGxC/zJKEkcoGcDJnWA/Y8+K/Uq1n4UD5xtCB6HFKW38@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv85Wi3fnPDv6dACIKMyaafGcA0uTqMmaegwQyq9T34KkyZRMQ
	aWyBN/fLe5bb1+DvhrUsKnJ79l6iggdyKu4pLc9mFQEJQJJSUalnlQDz84CNDurKtcA/OszxZNP
	A3mIpAQ2CoREKwSvYOWl52z0QdhQ2DMI=
X-Gm-Gg: ATEYQzw9AqChne0x0PRz/EzpqseflZkO8TBuZvdM9cB+5wt+kWqwSL7vOmNDiRm51Jg
	qyJlZfbkSrxcZj5C8hjkhsJt7/JvsatNs9WBLG5IOdUFH9NYxtfdgZ7B7K6xwFxfWm8TQE3tb3w
	ElrjVLrALSO78KT9JV2Y3XEK06LYoP7Un+TTUJrEZzbBJ40H1HmEzzgwpKSqQswifY5KNZ7um1F
	RvDO4PvtD4QSta3HTqyH5603XxvkOvVjTuyq8GCEQKcYFMS19lVtpj42TL0aQijvBKReCc+awpU
	N4y27g==
X-Received: by 2002:a05:600c:4e8e:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-486fee049fdmr65279645e9.17.1774043934007; Fri, 20 Mar 2026
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
 <59dcb27f-875c-4a2a-82dc-63b832f8eb1e@bsbernd.com> <CAJnrk1YLtQF=SF-GoG4irKYzzePNewNgyTeU7VLvUN6Ub_NFVw@mail.gmail.com>
 <d9aae2bf-b81d-42c8-b919-5e64292323e8@bsbernd.com>
In-Reply-To: <d9aae2bf-b81d-42c8-b919-5e64292323e8@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 14:58:42 -0700
X-Gm-Features: AaiRm52AHv_3nF2I3TUKZMaIl27ed6hAdjzjKQ-cJFY4iQtxORQMs2VLo42mB3w
Message-ID: <CAJnrk1bYLwHpZsW85XiyWfM=gXXXS6pHg4=p9fcbDOwpca8UXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	csander@purestorage.com, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 12:45=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
> On 3/20/26 20:20, Joanne Koong wrote:
> > On Fri, Mar 20, 2026 at 10:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>
> >> On 3/6/26 01:32, Joanne Koong wrote:
> > Hi Bernd,
> >
> >> Hi Joanne,
> >>
> >> I'm a bit late, but could we have a design discussion about fuse here?
> >> From my point of view it would be good if we could have different
> >> request sizes for the ring buffers. Without kbuf I thought we would ju=
st
> >
> > Is your motivation for wanting different request sizes for the ring
> > buffers so that it can optimize the memory costs of the buffers? I
> > agree that trying to reduce the memory footprint of the buffers is
> > very important. The main reason I ended up going with the buffer ring
> > design was for that purpose. When kbuf incremental buffer consumption
> > is added in the future (I plan to submit it separately once all the
> > io-uring pieces of the fuse-zero-copy patchset land), this will allow
> > non-overlapping regions of the individual buffer to be used across
> > multiple different-sized requests concurrently.
>
> That is also fine.
>
> >
> > From my point of view, this is better than allocating variable-sized
> > buffers upfront because:
> > a) entries are fully maximized. With variable-sized buffers, the big
> > buffers would be reserved specifically for payload requests while the
> > small buffers would be reserved specifically for metadata requests. We
> > could allocate '# entries' amount of small buffers, but for big
> > buffers there would be less than '# entries'. If the server needs to
> > service a lot of concurrent I/O requests, then the ring gets throttled
> > on the limited number of big buffers available.
>
> I would like to see something like 8K, 16K, 32K, 128K.

My worry is that for I/O heavy workloads with large read/write
payloads (eg client access patterns reading/writing MBs at a time),
the limited number of big enough buffers becomes the throttling
bottleneck.

>
> >
> > b) it best maximizes buffer memory. A request could need a buffer of
> > any size so with variable-sized buffers, there's extra space in the
> > buffer that is still being wasted. For example, for large payload
> > requests, the big buffers would need to be the size of the max payload
> > size (eg default 1 MB) but a lot of requests will fall under that.
> > With incremental buffer consumption, only however many bytes used by
> > the request are reserved in the buffer.
>
> Doesn't that cause fragmentation?

With incremetnal buffer consumption, there's not fragmentation in the
classical sense (eg scattered unusable holes). The buffer gets
recycled back into the ring as a whole once all the requests in it
have completed (tracked by refcounting).

I think the concern is that if the server is very slow to fulfill
requests and the workload pattern has it so that slow requests are
packed into the same buffer as fast requests across all the buffers in
the queue and that queue has all its buffers saturated, then the next
buffer is available only once the slow request has completed. We can
mitigate this by assigning the request to a queue on the nearest numa
node as a fallback if we detect that case. We could also do the same
thing to mitigate the variable-sized buffer scenario where there's not
enough big buffers for the queue, but I think that logic ends up a bit
more complex.

I think overall we're able to support both incremental buffer
consumption + variable-sized buffers if there's a need for it in the
future where the server would like to choose.

>
> >
> > c) there's no overhead with having to (as you pointed out) keep the
> > buffers tracked and sorted into per-sized lists. If we wanted to use
> > variable-sized buffers with kbufs instead of using incremental buffer
> > consumption, the best way to do that would be to allocate a separate
> > kbufring to support payload requests vs metadata requests.
>
> Yeah, I had thought of multiple kbuf rings, with different sizes.
>
> >
> >> register entries with different sizes, which would then get sorted int=
o
> >> per size lists. Now with kbuf that will not work anymore and we need
> >> different kbuf sizes. But then kbuf is not suitable for non-privileged
> >> users. So in order to support different request sizes one basically ha=
s
> >
> > Non-privileged fuse servers use kbufs as well. It's only zero-copying
> > that is not possible for non-privileged servers.
>
> Non-privileged cannot pin, at least by default mlock size is 8MB. I was
> under the impression that kbuf would be always pinned, but I need to
> read over it again.

The kbufs get accounted to the user's mlock usage (this happens in
__io_account_mem()). If the user running the unprivileged server
doesn't belong to a group that has high enough mlock limits, they'll
have to use regular fuse over-io-uring buffers instead of kbufs for
most of their queues.

>
> >
> >> to implement things two times - not ideal. Couldn't we have pbuf for
> >> non-privileged users and basically depcrecate the existing fuse io-uri=
ng
> >
> > I don't think this is necessary because kbufs works for both
> > non-privileged and privileged servers. For how the buffer gets used by
> > the server/kernel, pbufs are not an option here because the kernel has
> > to be the one to recycle back the buffer (since it needs to read /
> > copy data the server returns back in the buffer).
>
> I was thinking to set a flag or take ref count and to disallow pbuf
> destruction.

I don't think we can prevent the buffers from being freed by userspace
except by pinning them but then that would need to attribute the
buffers towards the mlock count.

>
> >
> >> buffer API? In the sense that it needs to be further supported for som=
e
> >> time, but won't get any new feature. Different buffer sizes would then
> >> only be supported through kbuf/pbuf?
> >
> > I hope I understood your questions correctly, but if I misread
> > anything, please let me know. I am going to be updating and submitting
> > the fuse patches next week - the main update will be changing the
> > headers to go through a registered memory region (which I only
> > realized existed after the discussion with Pavel in v1) instead of as
> > a registered buffer, as that will allow us to avoid the per I/O lookup
> > overhead and drop the patch for the
> > "io_uring_fixed_index_get()/io_uring_fixed_index_put()" refcount dance
> > altogether.
>
> I will try to review ASAP when you submit.

Thank you!

Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>
