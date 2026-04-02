Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A3317145
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170199; cv=none; b=ZhreAk7cTo9IDt/tOQCWg+jVN8AWhvAloKkuGE9Wsc7U9sCH4lWUPeVVxyPRn6/SRyCcNsmbYu2lNd+g4y0VhLeg9RasDJB3tS44KISV+m3hkdEekLDhWYMWvHI2mbO7M90MyzOxTQCvdlnKOv3BPJQT+e3OjpgvIDZULhBsXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170199; c=relaxed/simple;
	bh=XuNesgERHlpbvWXy/MVJjNo/tL+ggtFDNxd3sxEoX1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksc1cfknirK8QYjKhrmCS+yZHb3D6POSJe3TptY6ZksO3HshB4csBYyVGmXzWIyOTu6z6qM6Q0k/vWXyIKpA9mVsysu0o1CT8qv2bnYwJFrXwQvD4rKp5j99REDb1gicgM6n7W1PLYRH1RHJNYhP7DJMTjX5NetXTEMld2L1GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vtnz5iMQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vtnz5iMQ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so236154166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775170196; x=1775774996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EW18SWElEn7H9Ljxw0Z1u7lS63IStFd21SXIbo/xZHE=;
        b=Vtnz5iMQjS5P3GoVyAFX3q6pwKNulgrkeyA9tQZ+IOTy9FW45IRkEXe9NIieCrTGqu
         WvtjB0v4f77S0DCSf6ZFzmD3ps0uzD4gJQCl+KrEUF9WEmBC/B5QftF1v0XIcCAwkgx0
         LZ4koRkpr8StD2VwuXiYVuvK1RenWEXX7fc9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170196; x=1775774996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW18SWElEn7H9Ljxw0Z1u7lS63IStFd21SXIbo/xZHE=;
        b=duTWf38EC/klgRGBUvYQ3VazFClvEAHUmoJEbwtUrZI2FzbozGz1C4VERMXiIQt3tK
         ++ZnrZzSU8ahZYwmsrtD7FOu81BgfDXM1qArY2xz8SuDXR/gXxDbkzGZYG47VYs57VH0
         ctVTIVZZ6syJXnZ1keaW9txUMVTiCMPlrpeNOjwoPM3zMfVIDpTGuHOmbXEgbYegaaif
         kQSgisLAoa6+Jf8bFDurF6+/TuzsyeMwtN+ZoPSvT4EgbJVTIjQ5S8SqZejn2c8GN8s9
         2E3NHypMEB1L10uiWdqj/f8X/RlQww5JpBQ/cZzlSqOz1VPFCxR0Zw48XeALGp1ct4Qw
         Virg==
X-Gm-Message-State: AOJu0YwgaiYpkc/xSbFbDfxH4m4PH+vqRiSYH5o+umjAhjo5L4qrwC/8
	A0XAVZSKozMDsgm1KRu5DMcqxdFFbQ9jZcZeatuga65m1UeoUH0HTGzQX23kg9xqguLRWIpR5T6
	8nuyBPj8=
X-Gm-Gg: AeBDiesxORQ4NmeArUdpGqOxwDG3z3jvUO9hLZFOBr48qsKayfO18lBEciWMER6V8ot
	a8gYVzsS4zREJCQd1E5OhOSTg7VdMzVwr9alWjnTPqkaLkBmeoouNoRpFk2zjvgdTptaXKEGoaK
	E8UsaRltFEhhTC6vwil9mrdDiKy3SFT+IMMTdCshkeByRftTWCzaj2IICBVEzAns5eO9Hu9rYVx
	NszZfOMw/58oc7LhFQcLHm7I44V+HuYu/ZSq6g8eaLP8+qcYDMLpQsFs9tzg1KkDfK7NOv4LXWQ
	t2GERaEkfh9El2+8yYBJPouso9djqB/YDJGT6z6p/c6ZPMy8MeuV6szsJKqmg16b82zC2tj0hvZ
	SISQGzVlKrJnxuQ/L1+SZekJ1BpmvvqNVr+vYT6taaTr94QJeBTNeyPzrkOUJry14qOZ2t4jiji
	zlnF+cefVIBU6JgAQqjyKs7b+IN3AHMyI7MKIkmHdRyKGPrln1UgMEPHnPbqL9aUwuY5uIDE24
X-Received: by 2002:a17:907:e158:b0:b98:70fe:cd95 with SMTP id a640c23a62f3a-b9c67b8cd54mr19017266b.53.1775170196162;
        Thu, 02 Apr 2026 15:49:56 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97219dsm140837566b.5.2026.04.02.15.49.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:49:55 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66ad907833dso2508647a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 15:49:55 -0700 (PDT)
X-Received: by 2002:a05:6402:234b:b0:66b:eb1d:b22a with SMTP id
 4fb4d7f45d1cf-66e3f833ac0mr432693a12.26.1775170195066; Thu, 02 Apr 2026
 15:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk> <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
In-Reply-To: <20260402224439.GI3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2026 15:49:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
X-Gm-Features: AQROBzAddltRr5adsQkdLBdRuWJZ5M06k2xEGjULx5vtAgZrrwfk_0NUybD_zDY
Message-ID: <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 15:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No deep reasons, really - it can stay hlist_del_init() too; the only
> reason why I went for __hlist_del_init() (and got immediately reminded
> that the sucker needs hlist_unhashed() checked first) was that ->d_alias
> ceases to exist at that point, so there's no real reason to zero it.

Ok, so that's what I thought it was, but then the whole "now you're
checking whether it was hashed" confused me.

> Let's go with hlist_del_init() there, possibly with a comment that "init"
> part is not really needed, but use of __hlist_del() is clumsier and it
> wouldn't really win us anything.

Agreed. A comment about how the "state" of that union changes from
being a hlist to being that waiter, at that point is all that is
needed, but I'd prefer the "hlist_del_init()".

In fact, the __hlist_del() *without* the init part would work fine for
me with the comment.

But it was really the added

        if (likely(!hlist_unhashed(&dentry->d_alias)))

that made me go "why is _that_ needed?"

Afaik, it's a perfectly find hlist entry at that point, and no need to
add the hlist_unhashed() check. No?

                Linus
