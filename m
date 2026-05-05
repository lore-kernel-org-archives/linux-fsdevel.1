Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1623AD529
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000788; cv=none; b=jzQJiJyW0xEx0qD/fZI7lMx5YKPAUfnzM0sDvyt4Gve03r3yakVEg1LYLLdg7bCSYG6x2skAj/36hFIsnF/956tXKM2hUQOUJLcjPp430oS1p1WmGdF0WS4RCfGCOt2CjcUHMtEt61G0kGJPpLvClQukFLZWL/NnT9uozZ6j7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000788; c=relaxed/simple;
	bh=lEkWH0DRniM6Sb8zXIsEvFuwx0H9VX2J3vFEDDDQ+ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su4HWmbNyCEh0EusSJa/JNYuEG2Nxv2/2TvY8PEdpUt0WjCVIaBCm1jrA3AHvdHRg8EM9cnVrTFf9uHwoMTmmI8N0JZKAd54B+moMbQvMMT3jh/5dNwaJRWW+Gb/1DtycdCO7qma67QJieAKFuMYmv+X2LsqAmC6h70xsuXAUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=avcMiUd0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="avcMiUd0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67b6dc50b61so8253360a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778000785; x=1778605585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AORfPd+y34AQbpqEkRFaZUyBypUofsVqz20ncg9amG8=;
        b=avcMiUd0p20JyzwajMzk+zyeARcClLz9AYRCESPTDqyP6sYjLcFOSf/thbd46zYz8M
         etmTbKwsp/amRej5nBhKdPAC52dfyRKCD4+6Ca8939dbA5CRO60SIaxEOKuFzImy9hww
         Egi+BxsbVBZB/YT0JwF+FLX+tPGYFCUMKNL0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000785; x=1778605585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AORfPd+y34AQbpqEkRFaZUyBypUofsVqz20ncg9amG8=;
        b=iQSyUobnabe5Pes5IsQNThL82Z4aZz54UoEYMHQoSStCTX58ogeKH5dNlC8bhpA/jJ
         6raeKRiL8Uz4fNpBgLE8XnollJ9x970TDhEGJ3U9bNRukSE/Nxyu+TnlHb198P4OyDzt
         NWFCyJk2aXFNzobtzOEEw/V1aAQV+l/QkYWL9Yo+QmYLNqMo28OT3253G4YBfxMx01oW
         Cuh+7XUhJ6CLzDHAiUe9PGDwLQB2C0yDBEPC6GM4hO0X6ZBEXi5XYc1ZGADU66qs9UH7
         eVH8X6yZf7CeEw8iy3c4W7Na3NIGJiOfaja+DWO2PcEY+U6zEgnXYKFdR5qW7lUVO73Z
         dX6Q==
X-Gm-Message-State: AOJu0Ywmuc9FdDzRSVcIl0QUi7hspvubktNTF5l6Y7dV6oBgaTBPRFxO
	skIoN46NQjc7bM8Z9aFoFACNNQbDYUs6PYvTjELJ//K1LKMHFbzOnMCBUFUyccSYOlUaTSnn3V+
	R7rudqck=
X-Gm-Gg: AeBDieuoxNvhC6j/VNQFuJWVINNc4QWRE9+Iykt4J7d0+bczHHx+PxXhfGMXauvq37a
	LbzalBWm5CVjejWP5fJApJw1HyHwg59dxjZBMgvFQth+wQA2ZdiVxoeGjqHoASjvOefGklPiFqi
	SmHCwO86bUWknZKCUe3zZHkhBJMRg/xpzk9tDbKexjUo4RIVqB/yOi10IQiHHvyLXpziezo61eU
	huxzNW1nj+WU0s02NOMQ6yMtPFlectiDnxPr6ueZqR+E3hljJ4dZGMR7CzEKM59R/ZUyOlzCzoU
	Jq/8CrRWwB1AD1VvI/doP2lc6XE0oSfPRM1JL09HUOR42gLXrEL8klrODXdgqWJSJnj2Sr72rUa
	mINMz7J/QhTJDx76EuzwZc8ni7X6Ot25C87Zx0NczzcZcNrfNybxeMuonsVrwxArBpcPavDO1qb
	3fdQm6+7jqQEbOuOq3MjKnJ2z/mtjkj6nwEnREx7ci2Cb/1RHLqhlZy2S2NWzPyJy/6elv56pyd
	fzF4JbOLwU=
X-Received: by 2002:a05:6402:455c:b0:66e:5662:2121 with SMTP id 4fb4d7f45d1cf-67c188ccb41mr5560210a12.7.1778000784908;
        Tue, 05 May 2026 10:06:24 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91d5727sm587122a12.29.2026.05.05.10.06.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:06:24 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso6215981a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:06:22 -0700 (PDT)
X-Received: by 2002:a05:6402:455c:b0:66e:5662:2121 with SMTP id
 4fb4d7f45d1cf-67c188ccb41mr5560153a12.7.1778000782507; Tue, 05 May 2026
 10:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk> <20260505055412.1261144-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20260505055412.1261144-4-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 May 2026 10:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSmm8r9yv6EvjaDYqMgBa1OwCi=W+NM9ZLzEgaGs66Bw@mail.gmail.com>
X-Gm-Features: AVHnY4I_VWn8wLs89omurF8YouSi3XOEHzW9JjnS7goP34xSU9GuBMCyfPp1NcU
Message-ID: <CAHk-=wjSmm8r9yv6EvjaDYqMgBa1OwCi=W+NM9ZLzEgaGs66Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/25] fix a race between d_find_any_alias() and final
 dput() of NORCU dentries
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 22:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +/* dentry->d_inode->i_lock must be held by caller */
> +static inline bool __dget_alias_careful(struct dentry *dentry)

I know the double-underscore pattern is the standard pattern we use
for "internal functions that have special requirements you need to
care about" and I'll take the blame for that pattern... It goes back
to the very beginning.

But maybe in cases like this, we could just instead document the rule
in the name instead of that "careful" and double underscores?

IOW, how about just calling it

    static inline bool dget_alias_ilocked(struct dentry *dentry)

or something like that?

I'm being difficult today, I know.

So feel free to ignore me if you think I'm being silly.

                Linus
