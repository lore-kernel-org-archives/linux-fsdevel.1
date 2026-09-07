Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF935B136
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773078; cv=pass; b=RIFY6QgCSLdwSqSS95ehBAeUaUYLZ0qaOxEYrnoM8uv+xO5epTBgg/k3xPEnypXtiVb1jLUuin57hokxoQduXhXNbLtC+lTzj92EkJNkt6tOcHoGXs+rHlCP0XsahVLpWYeZjBdlrigPThUCcZXYiRk5gJUlrkS7Y/QV5t8saVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773078; c=relaxed/simple;
	bh=cSfmMGgIFwjjaaI7Bk9duU/SsMv1zgWa3X4ow3p9Z0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDt2bSbHOYgIm7i4OLgiTVC1h6H4wsFUjvH/Gf1YVi/SACPygegO9PKw0qSwdvj2SzQg3Q2eZ4WXvD3VHzQqM/QKwliHOtaZ8vgUP3scYFveFfL0+L/OmOlxRdGpmlbqyIxQ9lYwRz3lLNqPjQrlqMwT7N48KVOzJ13bKa1TCXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYzWZS6h; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYzWZS6h"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-485843aeab8so3687561f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 02:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773075; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpK24zUgVuyrRzdbNy2GzJakUDPzFtqSXCn0rbn5OUFASns+w024FT6DjGt1Xq7N1u
         U2ua53Eqek5oCotpLwlZbKyHHszpVm/jYaswLzFcLNRsuWedFJ4wwKa0S+QWtr3sbnJT
         gHZjGhKFeSjnss/1MmwUuXg7NnqXpEdK2UYg35uoQW5uFAq8FBvlmkVyfje6fUEjj1tl
         yT/gO+FolJF5ZHbKJrqc/02SDG5gObY0JhMwc+DP14Sk/+MR3zs6vzM4cmmRc6dVhjpy
         yJJP38cBCVaF5fXHc9j/bCS7mf7Qa/VEGn8lROx4aMQz1fGQF39ljhpdlcc0W/rII5sg
         Eq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        fh=2swteUQZyrSFPAquV/rnxTlvvBnP/lmG0IRCdFGs0Us=;
        b=ScCUe2gnCsbxWIgW//Du7/V1kCDvkmdokWQApjJj3ElUxYSD5sIQlzo9b/7FMtmztm
         C8eZjnwtArkZT15/Ddqu/HBnOXP+2jom6zsb1zBA/qslk1nEpy2sbrmwO21C6fdj0wBI
         W4D4A9uRK72zWd9EOnMu7E1euUhCzkNdqWtzUvQHm1ASbXZUR8jJxao5PueRasNZiP4X
         251eRNziVmeBlyb0it3/c7JT6UlB8g4u4Ojn6NiBnAq+ZHKVYFfC9oP0BrSqCys4OQpw
         umwJUFfjfORFF/7E5U2ym5TIc95go9amxAAYwiG7CIs3KnNo6FTTMWGxfYRjHEnEA8QX
         x5bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788773075; x=1789377875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=bYzWZS6hvyblgTmL2WcmqKBFUHHD7UV1gkXyod2CvfAo9EbydIVeGF++9jABbnZPte
         ys7ocRIu1X8wdEIGp96wY0ZJwuX9iep0RRInWAVJmxBvFDn1O/SCyei+2Uu4DEx9EFWy
         Ju0SX+/3BqiQeyfykHFwlXZNMjTYSHT9Hz+p1tge65xlQefntxQdIOB//wajbELDPR6l
         bZSz7BV5hpdU91s0tZALuvzT0BaGoZvdwZ+37h8mSbXVV8RthaPq9o6xvdh7qixRCia5
         5aTu+haqTXNlK7d6WQD6MLUT44ym0DOgw7EgnQhTgLv5A9qh2xRN6Nek2Upj1f/kRQ35
         VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773075; x=1789377875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=qvhgGGqgQxwgmn/mz7nf1FrZvHm2c5wb4wCfkgyjbZgrusXFHok4qfKH05ohjtBpki
         pxgGBm5+zXWN0n1P2wLOczvg4o4pfsCE3G/I27GCAsiMgnMOV3XUqBBA+XAoqJw6M/1J
         xHyhDrLlTS4TfqWpucF6lMgmIKYHOtXj6SPGKq33BG47UISHQZYixTm0inYdClISA677
         g9cxHFtvYPQgTBj8ZPdxuKviAJFeF95d8DK3YpjpXrOs1loAja84poG5tAf496zjxblq
         XuCbfLY4RdxFiwZ8wLQdmMyz7uJqfcZK52k8I65b2qEjUR4zs2I/1tKCE9DVPJr227Yf
         e6lw==
X-Forwarded-Encrypted: i=1; AKwUvBwVaWKRXKttKh21GGw4YM0tSdF7WpKNG9GWYljA0xfRk6N9Ns2mpU76DeHJvf9Jl2lojJ7ZYRnMTsD5MmQl@vger.kernel.org
X-Gm-Message-State: AFuF++mLjWorBoRzXeff1qT1P62x/7zZXCQHLb8JGX9VQfr/V7+6AXoz
	RDFO+Wx7LnBC7WO8qfzoso/crorFl0XtD4Du4ZXqVwmieh7nwz/q81CjUhjfm1jVA5CfkQIAc7L
	t44pKfR9tvj4gxIem9ZTC26Vx/k4oN3WjVX/qT4LI
X-Gm-Gg: AYBFou2wb/UUcx+cAw9+bdDVauE07VQCibM+8dTPX/Pd/NcTKeqk7ZEeORZMNhCkL0E
	R1WDWSECG3qSI4owxjQc+xy2U0bI+0bRh1X/fPH/kqskCm/UtvMFWHyM/zdNwSfJtqdqKvdeC28
	Z4UMLSAPxgBcXuXVE7CD3ejeYB23pH3cSvmDITcllmINsNkzUWeV9gGQxthCo8Pl5y1fLYJaLuE
	qUmmRTXYaHHSJHgY99WWGuCaI56EZOzPaAIVvYMOefWHvKiZyxN5CXmq8L3hsIACE5rVQOiiT7i
	miwap1DTO0uIJk9NubfQh+dpiNjb5hb3GbBuMP88e23L9pRN4gtPivbBN3TEucn21rDGHEa9CXs
	MPJHOQykaJoU/jULiJt2peQQVjn4debQ=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr37026021f8f.5.1788773074197; Mon, 07 Sep 2026
 02:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org> <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
In-Reply-To: <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 11:24:21 +0200
X-Gm-Features: AcwNN1V4plkowyMHAsnIxTQwxzR-aYAz331pg1N8okzwNx7uKX70uWh-YG4Yx6I
Message-ID: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> +        // SAFETY: We just successfully allocated a page, so we now h=
ave ownership of the newly
> >> +        // allocated page. We transfer that ownership to the new `Own=
ed<Page>` object.
> >> +        // Since `Page` is transparent, we can cast the pointer direc=
tly.
> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >
> > This doesn't satisfy the safety requirements of Owned::from_raw()
> > because the page may be used with vm_insert_page(), which increments it=
s
> > refcount and causes it to be shared the vma system, and this occurs
> > before Page::release() is called.
>
> I suppose the existing vm_insert_page() abstraction we have is already
> problematic, because it uses `&Page`?
>
> Maybe we want to change the API to use `ARef<Page>` so it already has to =
be
> shared? Conceptually it takes a reference count from a `&Page`, which isn=
't
> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<P=
age>`
> to be able to do that op.

Honestly, the problem is the safety requirements of Owned::from_raw().
Pages have a "special" main reference, and free_page() does more than
put_page(). It even does something when the refcount does not hit
zero.

The correct behavior for Page is to allow the user to hold one
Owned<Page> whose drop calls free_page(), *plus* any number of
ARef<Page> references that invoke put_page() on drop. This way, the
owned page controls the special drop codepath.

Alice
