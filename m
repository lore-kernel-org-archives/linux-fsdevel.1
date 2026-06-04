Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0729CE9
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583915; cv=none; b=YOWaMy3tzaPCMf5ugdK8NtjeLab4ot/3dSP0WEL2/VMGOLZC4SJy2ASjbillqiUI0jTcg+nn2CKgL9l/e93bssxDS7wSXiDQhm/Xu82Dde1MsSEuUx7d8U16CEXVLio0w0hBaiDu0d+dcYadskvk9mgvkIYTzenf0xGCp0N9iO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583915; c=relaxed/simple;
	bh=+HiAUq8B9doNx03/+UK5dzZU592ZQOyFYQ50hXTQNq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTucAly/FvE4MxtgCWLCsikEuL0l0siS6PvGCcm9QOaDlD1OUSxTeaZYedqSHmUhdcIkYKTikLCPjpwPPHHfRzr440RmTd0atl1oeeNBgTXEw0cfKHiBQTim3YpsSSjS7DTB2wRmRJIzKmJT3byH5HhckvShMULud74p8X58LXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FbStviAo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FbStviAo"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so1206041a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780583912; x=1781188712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=FbStviAoGKX/jJHzwarD5rzWd/aaMsIlrbH1+Pg8xY2pFW6w1nlsZ9tG9b+smHxJ6i
         kKPWF/N6Y5HFItJ6PWvFzhr7HU67wYSj+XCPCacg6MIxCvCkExn/L1f2AzlD9fp41rbW
         vltZ/NHdqUqFb6frot40lBO+0crAXlPyzT8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583912; x=1781188712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=sKchh1/M8lZV3/CvGhDat+M9IAdVUcNiSmz5Cqgo6jj9NQPDAy5RT/WLa68tdpgG73
         +IbxaOjfmnq1oW5zRa3e5rnLfvDHyMkorJkAPL7pfWcfUOKLhBNaVGaP3A2n6blOA+7T
         rvsFk/Fyt5l6SNt8X8CJ51hXdiKjmuJDKKo0ZZzYjp/3jj0JoX4xO037Jeg4g9m63uCg
         /lxkUsqNOKZ4SUca7qKk3UtPeAP7pn5T2r2yL2E9yMGqSlz4YUi5r00rupiofGhbKNjC
         hcUtogq7XXkdHqmmu6bd25W1skezvfL0/sKmw4EUvcHoRVx6yRtI1CHphHEhhJxk+nRe
         HUsw==
X-Forwarded-Encrypted: i=1; AFNElJ8eDxwAFFR8COGTCn23CB+oSmHAb7B6sEtw3Qapu4k65ARzbzfvj2xwxMJ1AcJUF9ZSllv5r4x30uTvyZr0@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvEh2+zkqEguU/+N244ZrFsYGOc/YNgmsJGzj3SjtTfdRt+fu
	e/PNjjhyEfDCxYvE0nByHyAN2l3CzQJKKrvnNDlIblYHKRcU1uAsIgQYxz74gUgxsFc3VNzzlcv
	D6RvCWSrENA==
X-Gm-Gg: Acq92OG3O99QmHjtgbdk5Dl3Yw4C4u7ysRluds5gqDaCeHi5UAI1JlNFs4WAw7+t2uA
	cBmAg5zH2lGXF8pJ+R843LE4pYhSE7V9xhlQfeIbzYtJAR+dY33wLD6RxOXvK8h06azM48wxRtJ
	uUmfwruXi3hzhpHqBdTsfC7DpK4eJesjd5xbkAuTR7QxDK/4WICcfKR6wFOTdeIrB9Ki9DCjm26
	sHNxAOeK04tpl36ClqTgSdWSrTLgQWah5HL6y2ieaezUzpBx8D4mwkWwG2WyPtdOBSH7i8eafgr
	sHwAbYeS4LMJO+JKAp35AH3rFGwgkcTvzXP5efM6HeG96IYg80hLHo0Drgfu5Kw/GWNGfv167pn
	ajQDqGL+1mUB/uIqKEgKLb+lifTOj3W1O367pJMNbYwJOCJYIRGO8wybMLuY+yDBNBxNjfdrVAK
	zMxKIKGbmKr4xswytmop+aOgqfbCHPApq30jggMY9fsRgIoxg2xqrO29cJXz3OqA4J8AlLqnNlz
	hEtCNzQ5Qo=
X-Received: by 2002:a17:907:1c03:b0:bd3:7c7c:b817 with SMTP id a640c23a62f3a-bf0ac40ae05mr479263766b.1.1780583912353;
        Thu, 04 Jun 2026 07:38:32 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05228a16csm314626466b.28.2026.06.04.07.38.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:38:32 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bebc80100efso82418666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:38:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+1LvayTi2Bj7GkpsR+WSyKGU6v4obQttOcL6qU5NiHytHXQcDPu6ATpRQNhoOvbD8qEjmp624fX/bqulaK@vger.kernel.org
X-Received: by 2002:a05:6402:43cf:b0:688:12fd:789c with SMTP id
 4fb4d7f45d1cf-68e70412737mr4177929a12.9.1780583507075; Thu, 04 Jun 2026
 07:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org> <aiEb8CTM-ovMIq7-@1wt.eu>
In-Reply-To: <aiEb8CTM-ovMIq7-@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
X-Gm-Features: AVVi8CdMcH2Yi8zy-bOiW7jRaCCsKof-RnAg4JQ3nwUYFdve2Wu3l5Vz6H4KhIU
Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 23:32, Willy Tarreau <w@1wt.eu> wrote:
>
> I'm using vmsplice() + tee() + splice() in high-performance applications,
> load generators to be precise, and soon a cache. This is super convenient
> and extremely efficient:
>
>   - vmsplice() is used to prepare a "master" pipe with data to be sent
>     over TCP or kTLS
>   - then for each request, we do tee() from this master pipe to per-request
>     pipes.
>   - the per-request pipes are those that are used to deliver the data to
>     the socket via splice().

So most of those would actually not be affected by any of the existing
patches: the pipe->socket splice would remain, the tee() code would
still just take a ref to the page count.

The vmsplice() would change, but looking at your haterm.c sources, it
looks like it's mostly a fairly small thing ("common_response[]" being
16kB).

That is typically *faster* to just copy than look up pages.

HOWEVER.

It looks like you're actually doing exactly the thing that I thought
was crazy and wouldn't even work reliably: you change the
common_response[] contents dynamically *after* the vmsplice, and
depend on the fact that changing it in user space changes the buffer
in the pipe too.

So that would break *entirely* with the vmsplice() changes if I read
the code right (which I might not do) simply because that looks like
it really does require that "wrutably shared buffer after the fact".

Interesting.  Because the vmsplice() code uses get_user_pages_fast(),
and honestly, it never pinned the page reliably to the original source
- it breaks COW randomly in one direction or the other after fork()
(and I thouht even after a page-out, but thinking more about it the
swap cache may have made it work for that case).

Uhhuh. That does look like it makes the vmsplice() changes untenable.

But I may be reading your haproxy code entirely wrong.

               Linus
