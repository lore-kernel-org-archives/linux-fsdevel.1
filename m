Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB03285417
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780262505; cv=pass; b=dj8e0ulMZtWsoH1ywZN+Gegw2DWsOx2dWKMn4F6RD+8evBtC/1otdPMvI5jPeMFkL30G8JS2DvBfK/CAFb6yTMmNsXVA+c3ISh7KIWp64F6NqpzgFlWJXIrMMxJ/JO2ygPIWGemvwIZtU4rd7Bxu52MURS1eC5qu37QzzI1nq6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780262505; c=relaxed/simple;
	bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+286nYQCZn0I0xUImLC534e1M38mTds7uKIyflGxP8atP4e8aJsMConasSjM1R2XSAFZ/izU3mFYMMmhrJZZ51u4g1dSmvfFGxgQJaCHm/jIzcxH/onRu3nGcqoheI1poGD3YYqa/pZnWEBI39Tjdri+pztUOKGah02/1LO69k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7aI7eRe; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7aI7eRe"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so2360708366b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 14:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780262502; cv=none;
        d=google.com; s=arc-20240605;
        b=hWyk5RdxurS4UMu8Ut32FWqoYq4pckCKerRWF70MZIcok9ydoshzf76q/GFoBke+C4
         2HURzQkTsxVGTc61mRSV7xRaILiIDQUilM99kEgXu4XqOckSvYQAvWElm3dNZZ/3gSST
         5ogTgHTTnm2WC1ZF+j7SZpNP00Ouv3ETiGCI2+CQIrz9VyP2aod4Dpi8ZxXvCuZG0K9N
         rhy/IgR+SsJTRuygZpOpdTTOukIC+6vpTITzmo7hpfpwnd9Rv5/VRT2nfWhKIeQ/KiqI
         W/b9CpROHkqycOd3I0wEpcQs1Y1DdGLo/y9wgVi7YqTSkI6t2KW70Wrlef810bUhi63q
         eDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        fh=+GnvgyvG6Lk0RyzFVLfb/NQaM9cEnlh+enys3Z9+qrY=;
        b=DJZpT+zgLFapuIbGa/8VJ2BjV97vbT1qXubS8xhktFPw1AohjsUXdQCHiFOudxrlVU
         IXhlGuFVeUEu25dxMLtqXfBm0RMvzwW3JQXK/hcdboyzMT1TzLDlrdGjXj9uiRlUaQsk
         si+3HDUTwCDpucqSxgKM6a1eWcGGZ8ffXIf+5V0R1MlRsdCrCPo8hZ07cu7xMFQx6WIi
         Ua+DUI8I5evNPq0JcBy29YugRQ69vRNqcbLXz8iaatKbWTbtpHxC+JeGiI4048rk/s2F
         xrco5BQL2K2Sw9S+j976uPwHYiN8Ix3iW7//8740YDkjrSNpDc9M8Am3UVdzGjj7xc37
         76LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780262502; x=1780867302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        b=c7aI7eReqdU1bZ24Z6s7RvCbQwwtVX44prOGcDqWiqy9Y0iDoa0G83zXG1PCdg0Z9s
         3XbBx+KIXoVsTPBvJh3iz2u0nvMJso7cLGZLUM8emH1pe8YmZlwWFDwcryvxqZv9RBx8
         9GSILqSeH5g6YEO/tih6sVlw9kqeREYbU/eg/i7KXHYjzxsmkKi/tEtWXFkAwlRKIT4F
         wGafQicielYAh4rwHgHAeCm+sMdpFDFYtUvN0WBTYY4QR8N22HEllf6YlB/oN15gFkgo
         p087LJ4RX9YNGRnfZUgKwK3ZV0v7ctdDROLPpC0lyJvNMY5VjbLmQZw5n2I0lngwalub
         rgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780262502; x=1780867302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        b=o4BQ0l5oo2/L81Z81drzR0PEK7qJ6bDyZOP95o5A5xD6sHGl5duscNoruK8ItQqqpk
         FBXlZsS6xuhRmh3g4jRgkzd6IofeEx8NZI0nyo6xe6rkVsUWh1Trd4LCqWNqtbvTUZn0
         SpEgGxAYboBVpLXsslPQ7pZhjV1lQoxmeCDsBBCKVfmWX10QJye4zXR03dOmRSB003VR
         7/PEWGA47UjpuvTC3jUEULTdiDCTpKRoGavPdepjWMb2rr/WdukUmM/iVTV1+uBLclyn
         ms+3CQGfiM7j88JkRGg2SR0Y+lMBCZ/eBMn8PJLll+PdPK6YOPzRDoaxu3I853Aq/jf8
         aAVw==
X-Gm-Message-State: AOJu0Yyjl3cx+2ayZRH5MZ2RUIPM3HY86Yh6+rL0kehFqfgPRI740Wc3
	TvU2TBfwhT+u1gvCjaksrmf7M+6XW2enLAXVVNv0XmLfdwmvBV+nnM0xFvwMHVBrWq+l7uE5sIV
	bG8XqQ04YEEbil+HOE6basj7opu2FVfE=
X-Gm-Gg: Acq92OElLvDi+Nnx+UB7KwXKj2YwNq8Xj9DaJ/Oc9KWQE4N03Sf+oyVfL1LQOSTJmJN
	BvStqzH8tVu7DWYjEgvwtYJsXGFTVTOF/4j2x0cAnhFoMR7S+0wSpKegDh3aM6+GLneqwYfupyj
	x9RlZqUChrA4NpVM/UN1pAUoPduG9Hv3FXV28xjix87Fd9NASXz59hAt0nv6Sc34DK6hvolr5MM
	LZnfg3cXPS8f4sxaensReobWGArpqrVvqLM1QOXoDQl2W3uAXAeNDFuJRnGWk6ksphUIjJ6VjZK
	OuEJ8BwZKKMNyEzVkw82hUneuq7f
X-Received: by 2002:a17:907:d02:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-beab4339068mr455362966b.20.1780262502221; Sun, 31 May 2026
 14:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <ahv16ogY8Zx3Rtox@pedro-suse.lan>
In-Reply-To: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 1 Jun 2026 00:21:06 +0300
X-Gm-Features: AVHnY4IV40jpJJDRQFbdKVprCBGPqL0nWYb_1HSlt6FzSI1F6gq0u1bXknLpLA8
Message-ID: <CAPnZJGD5QR5jrNMAem7FjMRTtw+Ue+jm7Dc2Kp8Lcjj+9TDw_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:54=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
> So, you took an ongoing discussion with an ongoing RFC patchset, and you
> decided to reimplement part of the idea on your own, as a concurrent patc=
hset.

Yes. But I propose an alternative solution to this problem.

Brauner said in discussion for your patchset:
"So I'm not very likely to pick this up as is".
So, I decided to submit another solution.

Pedro, I'm not trying to insult you.

Other kernel developers will decide which of these two solutions they like =
more.

Many people in discussion of your patchset said how they
dislike splice/vmsplice, and especially vmsplice.
Hellwig said "vmsplice is the worst".
Brauner, Hellwig, Horn said that they dislike vmsplice.
They said that vmsplice in its current form should not
be used, and that it is broken.

Despite all these problems nobody managed to fix
vmsplice in all these years.
So I propose just to effectively remove it.

You may think that I just saw a recent discussion and decided
to jump in. No. splice/vmsplice is my topic of interest for many
years. You can verify this by searching "f:Askar splice"
on lore.kernel.org . I simply decided that given
recent vulnerabilities now is the perfect time to solve
all these vmsplice problems once and for all.

I explained my position here:
https://lore.kernel.org/all/20260523204100.553125-1-safinaskar@gmail.com/ .
Nobody answered, so I just posted this patchset.

If my patchset is applied, then I will try to deal
with splice-pagecache-to-pipe somehow,
probably by removing it, too. :) I decided first
to deal with vmsplice, because it seems to be
easier problem.

> > vmsplice(fd, vec, vlen, vmsplice_flags) will
> > be equivalent to preadv2(fd, vec, vlen, -1, rw_flags) if you have
> > readable pipe and to pwritev2(fd, vec, vlen, -1, rw_flags) if you have
> > writable pipe.
>
> This does not work. https://codesearch.debian.net/search?q=3Dvmsplice%28&=
literal=3D1
> There are users.

Yes, they are. But my solution is compatible. vmsplice is simply performanc=
e
optimization. vmsplice will work just as before, but slower.
And, most importantly, vmsplice design problems will be gone
(nobody managed to fix them anyway for all these years).

--=20
Askar Safin
