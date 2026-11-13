Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794539634;
	b=SrweTCc/LWDQbW69PxqcR4U2wwRVgdlA3oBWXR5aUqI2vVg/AN1aCXsG2vBzxg4Fmwsy
	 XRHhzV5hdhAX3wQy4AGrIFqtk4VKrU7Dj0MmqYg5QMexI1qxN7Di79+PHXnYiQaFaVIYk
	 3ASTONyG1NfFark9it+/ZkreSuc3lFtXMC/4cpHvAy+4dRvKPwXrTfmbHAOvWY09tC2wb
	 78rlzeBbUSICBMPzrOH1b+GO3JpIjvpCNzNKAhJ0TCOCD4cbe7OtP81M4z5Iw03aMkmht
	 DtN7hGLbIG3oY6Q9HjdU9489Dme2OIfDsfoRh1rfCX3BRhd3O2O105JVuVvEzkb4ftA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g7cNQ/YZaMN6lII1BbBbVlNBX/05rEUMzyowuYGYqyg=;
	b=fCwQx8SM5EbmecPiOLJrffRKlGRhs3I6KsmZKHm9h2idv3qAgP0HWe/FAKmdT8o5yK2l
	 nyDqKryPTXuxVr10mYWE+qbTl1MrA/Mc7UrwwQDyoujzP3mW7rh+kOctZZVNCKLjOLIQS
	 dZ9klxK8GwMynyoDqXjM4ToMqkThpBX54QkBx6So6PveUTwbdQvOfGJJgFjP4ewuGjnsL
	 LlFH8NxpN4yjwmFQheK2HSvCFHBkemW5y1VI5XHO6rs3NwXTMYXV4sxmI0LAhHlEjjesG
	 NpNM3MGbV0cemdAfN7qkWstPfpdxsf/bxPgUXcgW4cjh0EqbVWGNzBQ4kST3bDmXHLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gn1p5K4Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72390606A89A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 03:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72390606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gn1p5K4Z
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-54492d8a988so108381cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 19:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794539633; cv=none;
        d=google.com; s=arc-20260327;
        b=FYl/iQYTI/xRVKh3ndbx65s2m0G3hoJ/rslqYmQaU1Xt2SYCKu1+HKj3VyCLMXgWs6
         VMJwKaULsbapzkntJtI/2/Ksz0ulUAQWu2ZCXzmiYM+BvMHCeG+Zo/0EY8gJdSGmhtEu
         xnvtgTbMQcNLLPETT27YzVUB9VDIQ6v3P94V4ue32ta8fDf9e4sQXboKZo9sqGwEGj0w
         0Imvdc6hX4QEM65xIDAZpW6s1WZXUW0Zze32lGlTLjpVc2rvGB5phtrBp2ttIkv2x/O/
         WFj679UNa3zCN6dt4w8WprBHk2HEyDRlj8TT1YEO2pQg0ykNrIelVD1QE117hHA6Db2w
         kKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g7cNQ/YZaMN6lII1BbBbVlNBX/05rEUMzyowuYGYqyg=;
        fh=ITSQEWCdVop6rBKbeaeSfFoo4NdChYTADlPv91juWSE=;
        b=RavbGDI7noLjv0BLrKd3Ej6CpYGfOkGRaTNUlphY3wdRQmUBzjQV32tz9yQBjgN4N+
         o4ieyaC8VyqdYAtyHzJuwIudYTtU/78StXyG4tAalpFJOllCh4jtqPkdp1nK75U/+r7y
         zEgMgRXGbDs3nBY3aV33zcZ/yNhZy2qOvzoOSCxdWkj9EGTCZpk93GY3OjFa4Rl8dQbj
         T/C1DuUuH4AMltsAVvcktv7LYS1pYuchgbdcq0kvNfnEuwa0F3+164VCoB8kUE8GdSJe
         0O/2ysfyj15Yiw71vztzjFdlh8DvxToEKRx2m3e9SxHBGOAKagFKrJ4tM5R5gNFcw8RH
         tUZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794539633; x=1795144433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g7cNQ/YZaMN6lII1BbBbVlNBX/05rEUMzyowuYGYqyg=;
        b=Gn1p5K4ZjybcWZBBKpsNTTSMgs7PxThRDQfgQEfOEVCmj7rjZFMzxAyOe12eAn4uRy
         dMB9G9gZQ0yO0ShT2+nyOe6zrVZujsiRrbUllZvwPV7O+RF/4MId0urSV/LT9gT3mHjY
         kLpBRrCyqVlxHFhV0E3x9lLST1kLZfkZsIejcuAauq5tMd5zHWrReaUkau/X1RRY9DA6
         PKUF0AEL4thaLL3OZt3e0NbmplaTq9DeHHNQK8UJAG2x3Y7y5DznRwOqQhsONw+VCwI7
         ikEJgTUyMv/+KxVnwlMkl71pe4votoT4iaoRlUtpc46QRz2lwPYxW80LgGKgvwXqL5um
         B00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794539633; x=1795144433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7cNQ/YZaMN6lII1BbBbVlNBX/05rEUMzyowuYGYqyg=;
        b=qQlKxXbzYTl3L9/AaXQctM1FE+lRimA+rqauKWTu10hPxyH8FR0ITlWlectXwGe6YB
         BeNs5Ar0k9RlwyxzXEHYhUsl5XFv6TZzkGpCjq/yIqvDYyuKcFWjbvCWTUYhEOnmlpqP
         HHxd9u+hXy4BbQUhndt95OZiX/HT4fGqvwJY6PlBGBqr0Pyr+NjN4K12ednt41YmGsgP
         n7CmttNcgZ7s0SZG8f0NXFRRrUwPHLCIjqnht3wyHKPlMChfYjZLvolgfMviBq+I5LTA
         ybaoAMl5p8RbMF3yYbpj3mQNN19+wlc+yCW6pVqbUeMfFlI7/1tAutLSc6MoXd+KMObh
         +EKA==
X-Forwarded-Encrypted: i=1; AL+hErEDaWa8C27Y8l8JENPHIBg4u5Mm6/rM4Myyy9QJPgU73pGzvqFOdHDlWTuxwFXMktFA5hNZmZqGHgOfzFob@vger.kernel.org
X-Gm-Message-State: APuU4Z9LpBIMB4YciJIGnJ6z3bWQE/UIRGaHLdsQB+dg89V8Z4FDdXtO
	rFrgxKTyutALAEbCkICGLOCFJKZms3GUquw4B4l1+LcNPXZacNa5hplBN75QYk/4IY+zcaY/1vi
	+ad6cFE/HMbKRMeM5xu4A5LFXW2A79LfxuF3tDflR
X-Gm-Gg: AYBFou0kFvIsT3APaz6cgbFjI22EeI9cMfO7Qhs0H7wMoodCwUt+skA3aR+I5Sn1ptz
	hFSf1wdatqPEW1o1zFHm5nRl+l8ujGe9yMYrqlRFVlWR0lnWY1FkQo1fLG1eTXtstUp6TGhv9lP
	vuHN1lbly+mMIteLSkpi8xkyux4TPL6S+SSuzr5PqcxOXd5iwb/wAMJfHL/nch2V8TVnfkHYkwN
	7vk1DeQ2qWDGzNEF+nX4SrUYZId2Se/bH8yH+fvD4UpQzMcKxWeVhiGV/TwwDqDyugKU/44NG7+
	I4KujnpAO0veB4AIDkNobC6ut7NyMGI/bItdAucsXBokn77l2ErnD9f8zrlWyJGJjSnD8KndE7G
	3BLyDv/0VGtz8xAQnhkji0HumK/KdMVXH0yjl76mkZr2dHAnGjRqa4eQKHjYjUrXEKyEVY8k=
X-Received: by 2002:a05:622a:4c06:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-55b32ae7d17mr2934621cf.14.1794539632682; Thu, 12 Nov 2026
 19:13:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112140101.647-1-adrianhuang0701@gmail.com> <20261112183727.68afda9533aff699eea12cdd@linux-foundation.org>
In-Reply-To: <20261112183727.68afda9533aff699eea12cdd@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 19:13:40 -0800
X-Gm-Features: AclHuK-5_bVJBffNEkLm33nopZ4Y4fegU-viRnI-qvcSPbYgKaZRfYUy-9POop4
Message-ID: <CAJuCfpEqQQb1_UkWH50tgbdVz9KZ2anfCGWsvvoYFsnC_KHcjg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:37=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 12 Nov 2026 22:01:01 +0800 "Adrian Huang (Lenovo)" <adrianhuang07=
01@gmail.com> wrote:
>
> > Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> > per-vma lock") introduced the possibility of returning -EINTR
> > from proc_get_vma() when the VMA lookup is interrupted.
>
> OK, but what's causing the interruption?
>
> > When this happens in m_next(), proc_get_vma() returns an error
> > pointer without updating the position index. Consequently,
> > seq_read_iter() reports:
> >
> >   seq_file: buggy .next function m_next did not update position index
> >
> > The above buggy message is reproduced by the following command:
> >
> >   # stress-ng --vma 0 -t 60
>
> afaict "stress-ng -t" can send SIGALRM, but mmap_read_lock_killable()
> only responds to fatal signals.
>
> So please clarify: exactly what is causing this to happen?

Also I don't think stress-ng --vma 0 -t 60 command reads maps, smaps
or smaps_rollup files by itself but I might be mistaken. It would be
nice to get more details on how this gets reproduced.

>
>
