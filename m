Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5971376BD9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327089; cv=none; b=Hw5Wqt6atkw2m/KtKHy4ME+qw61mH3Yx0LGmWERQ0rPjNpnxCYvZJagTPZq3/IEDuw9o4iTDh9ex36n4KbsEwWgfcApvg+H7y8mnXgz5wQtgNk1CnjLQaY753VHbP7RtkXdMVVp0W97en7VYMUP53e43vaSear/ewTNeMHcsc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327089; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzHlxJjhiNZQ6BC2qAoI7X3e2wtn/slMUMeO4d3lz1kGFVWQHOPxIhjN0Iv5zAXkesHotQKzt1SJYT75cGigW/uEptlGZKRCZNgV+/CObkAus5P/UaNIhDtj+aMlnwjGZZj4BQyVIXcTatePmLem71sGaIWxz137zQwhSxCb2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YIF0ZCYk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YIF0ZCYk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso1581880866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327082; x=1777931882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=YIF0ZCYk8+ymflCsyK+Npm310RPcZhIhAfSyYLuc4sqLh1cdmALl0Tr+B9e+dHUwuj
         0tjn+YI0oxWaDKy3baSUjgmm4gyCDg06/YhnrEwyIdVoBlthT1eX9hrhoF89gezmH329
         H3bRV8bDn+UyAfsDVvhB77gdJ/smRBJyFsnME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327082; x=1777931882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=iEoOhl93LEUeW3d57zINQcWnwQsug8cEc+8WXZnTH4von+z9EMm4qc4K8LzA4OvHaK
         I4kIFuXKIr5M1v8+O/KFEcy9H88KnwAXlghwxkxxRB6hGFM+VmiirYIjQXr3R9Lzt79C
         MXt0lrBietDgFPEJQJfzaUKCd6nTaEQYWyehlzdZNtEv5E8VEEwet6lqQUCgUGKdoa4V
         V8IeRegoqJ8SIXNOCz5oKdXVTZsPbhpmc3sg6QsxyYHMv2rsBSR172dCn6EyJUcVuZi1
         QDFPrXKJOehqpbSDkSEe5RjUuXS773om90f6A3TUq6zZS6h3YTxne4BbrlxcjjFaJ+6f
         N1ng==
X-Forwarded-Encrypted: i=1; AFNElJ9P0jrCRzMUcaHu6RoFgaEDaUQJlE9F1U4D1OBz9cOHczeRqhNo8Pf/c61Jd+mFUmnvXC+27J/FAXkRuiH0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9a+1Te16nV95Sy1GHQqsTw6Un3cCgxEqNwcO53VR7kzVXnr45
	tGP0GotMKMlzH9NmA8NEb5xqafcMvwcx3fosknNZBjf+fnU0X7YQZN/WMCMiycgLH18VJz5zM7N
	r7S3OMWykKA==
X-Gm-Gg: AeBDiesOOQ1qCB7We/eHemAZoypTYFiS9W9QYIzRBdkMpYLda4d4ET1xx5IkAz4kqVf
	m9nZRvGxbk6KDX07cU5TJiFLspjGN1F08VJ93VPkd5Ydqnz+MZLPLhpSJFoeBZdzknneA3MgGCp
	nQ0I9LkK+hovYmr1DkpOd8frXohrldTG7Tco4QyAsj0Zc8Uy78rfUrXGwIvelpI20It4NGz3OCf
	WBbRoTsZUdAJLLRU/KAjcSjP0WC4xrvPYeX5E04UfPd/TvpmkAIOZPRiQCYGKrBH1Da8IYHKjTu
	urxTVvuNMJYQ19f9Sh4SUTb2xbDkdfLlSwEvYgMFfPxLi8ExRIg4aTyb/WI6AopRnP6Z1naYJrb
	8S1omyOgksuWNAhr4Bj101Ni0ye329EQuPLIT8vVmmtTyvwucdWpMAXN1zw1lyUaMat/Jgtuqx8
	a89hUMe7hKZ+Enllastt4Ykc/fAesmrpLHnPpI01Fy7riKSFWbrOTmNCmQ33nXSwjWIqsgdp8px
	MkGWpHXXRnRui7ot01o5g==
X-Received: by 2002:a17:907:e84b:b0:ba5:dfa6:1e8e with SMTP id a640c23a62f3a-bb80100e719mr32294666b.5.1777327082271;
        Mon, 27 Apr 2026 14:58:02 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b886ff5sm10167166b.45.2026.04.27.14.58.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:02 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1770652166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zEoVxBClQlbGo0XTXJmuO3NadipQqBf0jn+co6VZBB/2r8+YP9NpmkntMYspMuyo0aEt6k4vCRI1qmc1N@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
