Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55D1DD877
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365098; cv=none; b=i/PJcUaZSCoW2njCehIK6OM/zqlkh7LElnb88QbUvJaM5EQ8x/ekgGY+AqtkYZ0281eJSS25JIBDJFvSqe9XOByM6GyCUvBvkd6RZtPw0Zf9lmb8edNWOrN8twrhlpnSxpxW0Oo1tzn2k4l4KTHxINe1IV2Zl7tRHWNosq8bMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365098; c=relaxed/simple;
	bh=Bbh8PLsmLTRj5fmH7e4KdBQStHbuuJyJvIYwQ8hh+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPcObmA9GCv9pbmkIEEM7NksaQBOZJFgSEx8lv4s6A+M7gdCHy1LN4202uyLgy4xmQzEsgeE4U/EryS4RYR/ZHgZUYdM3kY/1Ca2SaTxMBQ3+Duhjmk5aeyAbcQ2zAa8yL6FUyhxQgXCqC/XiHp7EtsuPzzR9BARr2uz47xtPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWeFdjbA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWeFdjbA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so189753035e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365095; x=1777969895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RxY8zw276a9mHZLXdZl5uWrpf1lva4cGE/+QOwlf94=;
        b=fWeFdjbAKaiWqGM1OFxbICFgI1SKSJWQGIceqP5lhNQjzWlKym33zRKtPuyYGAmdsJ
         3ezqysleeKQeLTeiDYO/bKsnGC4RwmjIFtHuwp3idbn5/7KubzaiTqI0+LZLeGjx/1Wk
         w1hsC0iMmH8dhdXWtmLjrSNpzBY2O1+y/lq0o/oZbbaxU0E1O6d0nTweFpz4pw+S0aBz
         NMHKo5U2dT6mdlMQdWf0663UjrBi4XMCbuEhfTtNn7UJfT8TdgWF+lStb1ZrYEw/nokb
         apK4ZoqHAPRlOuP/7ij1rnykHh1jrsOpk+MwuRAfBi7VeW1FDzS3eaEqgQyh93iKmiKs
         3atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365095; x=1777969895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RxY8zw276a9mHZLXdZl5uWrpf1lva4cGE/+QOwlf94=;
        b=NrxqKpuJO3KJeubeGhCbwBj5rwPK8Ukf7sanLq377H2o7T/yoVoQ+w+LJCf3Ys1M2Q
         9VJFGBlHO6yhTDlmxEf5d31AM2CRlkABBpp+iGqGfQnVr9t+AB/Idw8q1qYCwYVY4AgY
         e6motZnwQbST1Z5d2YlG6/mc7S8ZSu79Gmbm4C2ATZM4jz9/+vMeDcs9pyyvPCOjFIG+
         iuZECl44da/oKQ8Ynrmyw/LEjANy0sqLGo+BNDRIm2UxSzmtZeWXHWE+mNYKXLZToTz7
         eqR56lw+fydPqiaX1CCw1WwyNFVLUSj3PWwBJHqCyG777KczM5zhxm2d+xlDzlgOe7zG
         5wLg==
X-Gm-Message-State: AOJu0Yw/Jgv2mAUIA1uC2u1hfOHcu0aHOHukUNdjLt+aoZ8SBEFTGnpS
	Pjgrf3fEKKCGxyFMD2WHWJTDPwans+13STJYUZvliGO9hTDBvVl63DNc
X-Gm-Gg: AeBDievTYvCgH8vC8/Lnx+MvNWC7Rv+AGqW8PxGyhqWdRo9R+jLx0AHiDNcpOQWfbAx
	XXWVPaRUoNvFH/IeOuO7DuilJ+Og3jLJmXuA1uVSXnWOb8ZnzGCOSv0Upj+opho3GgjZrGB1Mo+
	t2K4ETkWO2s+tourrhZ0YiIRZbWgn8Q++wKKYrF+xYe9qPtLI/qc78YFAYMVvzswe0SLQcylOeb
	r56nu9bUpmkCIChLmYt+5D66Z5dO5MJMuJeKYwFJrAL3HAhB3xlQT9koFeY4ouNJSsj+Vu75LQo
	IsW9dGfd/rHd5VItKq2sj6rYbnAuhxjTPxa9qY7jjzbNK7rr1wBgPkUsCChbEp0qM10KYx/gHI9
	upN9yG3Bf0MUCJs+cgQvtFMXpgZH/V53aFH8xHA+BqZfJe21O/kSeSF4hEu6qlNyzos30/RaKZz
	u8zF2++nIomfLVlmRSpvz8eNffYMyNMxXxhESQ8kwgNQBOmczS8Vnz+fgo0QZjLQzy5fdltHoBl
	rBLm0BKbA==
X-Received: by 2002:a05:600c:1e8b:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48a77b146bcmr29904895e9.19.1777365094616;
        Tue, 28 Apr 2026 01:31:34 -0700 (PDT)
Received: from f (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77c24cedsm34245745e9.15.2026.04.28.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:31:34 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:31:26 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does GNU sed abuse /proc/filesystems? Re: [PATCH v3 0/3]
 revamp fs/filesystems.c
Message-ID: <l2tpde75icdqj7wusftzmhzjysq5ntmjnehvrddbenmhda6e7t@4capfxov4zfv>
References: <20260425220844.1763933-1-mjguzik@gmail.com>
 <CALXu0UfP6Q0Okod9KmrpFsfg5L2HtRjvGjbycFu3qWd8HjwMsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALXu0UfP6Q0Okod9KmrpFsfg5L2HtRjvGjbycFu3qWd8HjwMsg@mail.gmail.com>

On Tue, Apr 28, 2026 at 08:36:00AM +0200, Cedric Blancher wrote:
> On Sun, 26 Apr 2026 at 00:09, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > The file is a mess with a hand-rolled linked list in a desperate need of
> > a clean up.
> >
> > The code to emit /proc/filesystems is used frequently because libselinux
> > reads the file, which in turn is linked into numerous frequently used
> > programs (even ones you would not suspect, like sed!). In order to
> > combat that pre-gen the string instead of pointer-chasing and printfing
> > one by-one.
> 
> Why is GNU sed touching /proc/filesystems in the first place? This is
> not really a stable API, and would actually be a thing which should
> NOT be touched by a "simple" userland tool.
> 
> <rant>maybe rename /proc/filesystems to
> /proc/filesystems_only_for_admin_purposes</rant>, or stick an ACL on
> it to prevent abuse?
> 

It has support for file creation with the -i switch. For that reason it
links with libselinux which does the dirty on binary startup.
