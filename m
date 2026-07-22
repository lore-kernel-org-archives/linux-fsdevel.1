Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F73368B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717232; cv=pass; b=je+BjMrw7m54inT8DRTNK1TjWFHkwV8LfrZ0rk4mXlayw83O6bwc0R61LhdmBdqnMzF0JQAEBfpWypWIji5IN/hj9s5gMUko5PvqnGabguPV5CY02OGFpwiPevXjDSFg4Pq25FH2PaMJ79Fw4Anr+w0LIcGccPM/R8mqh4WiGxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717232; c=relaxed/simple;
	bh=guAhZjJfEBfSY1xp7Mz+NJHa/zurYwT9YHjF7Gv7gyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy/rIqBixWMMpN1FlYs0bTCezbghIYSDuoIjB0Q5iKgn5LgmcjLdU9Faj/CNG7R0NnuuNaaxqoeYGSPPeacGpvZCg2X58TyVnizGAARho78Z9lRMpyADwn2/UltZpVFVsE7S8+ysQqOSkilYTS7EG0oye9aVwAqrIas8mqBuQyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WzF0IGAO; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WzF0IGAO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5d6f35c1so1092401085a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 03:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784717229; cv=none;
        d=google.com; s=arc-20260327;
        b=qEH1S9lXQDA+CsIXkHv5I5dekxIPNdT7AjSVK7bLcu8KUJnStsGR6UamW9Bv8jnxyn
         M/fH/RF38NboVwjFTtOZ78BlluCxL1Zfy/7ZNfMDrUWOLub2V9721rKGQPLE4u+Tsnuy
         Z9leM/6ixAFkf+ei16cejJBN7bAExeBRj7iOAnObqObTf8GUz4XEgaT6D9b4w4l651Ef
         bfs+k6s/XV5pgw7AZss1aZTy1zAIp+YT8361eJ5dfEGAbUlOI1AxJCWnFLydie5c54Wq
         xR555utJW6NAa+CnVnUtB/igq8yP/5E2taA0Kko27EeYtrqjrzWoUCfBosxEVrFiqgD9
         PjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        fh=WJFmgk6Sama1/OM5yJ5uGtcxM7q/KNZ53/t3V+UkXpQ=;
        b=Hncx+wsozRAZ/zTSl7BdOQkThtjNGa4I7F9ofzao8i+gCRp10aePvi9iBwBOEnKasl
         xz1618q/WgFUCKbezFYmI1Vca3pt8wNz/9d2c2V0aYx0VQ/782Sdzf8Ocb5lHGg8204z
         6ksHwdcqucG3IzBomGRs8Qsrl0g3t/CFGulJnFNyu+wFODbsu9hymV+szqt37thieiaf
         Q5Xrs317vAvzu48Zd1mkLcSRF/Cu6muAq1iw08U5YV9vQaB7dici/C+OVqjdI4D/F+q5
         FCAW0MZb/bm9SqY9SL1+I4rnO7L7KJB/Y9AWg/RJk6SPxS4EVTun7SllVn9g0DnRJTxk
         tCHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784717229; x=1785322029; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        b=WzF0IGAO8mdfhq9zY44w4C5y2L/qBa3gVWxDXR8IV0PNZdJPpSNBFYMY5Zy1xo+Yts
         pxh19SRJBfAZg7UXoyxxNCoRuWhdiFV+EUPu5TU6JDGsnV0kX0k7br5iJ/D1GUcgganS
         LmLPrKR8ufjbA+A2HHUYQQXuCOnPNlUA3CCWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717229; x=1785322029;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        b=PMeCQaX92oo860mP7kG7ZTPoM9QpsPeZA7Sp+l5o2BP4sZKgVwhbWmgEtyJVuwfeZ5
         uHkeI7sZWnyPLJGmuv34Ua4x5P1PBrNe1PXwJKG4QAG17PJatOEU8ZVq+BqZjff1weMm
         FkD0oxkg0B21fbiTn4vZbsAHrg8JZ6MoabKi8R2EYWqcBkBUtlAf1eVHiEdj8j5XrhWt
         SYncMHORRqzCus7ngOoqX5yfvNGFPoS9hN/ZdSpnLFiBGpu0ZbImHI3i848OPNYMZqM/
         jmDORgUT8LyXaztmgswjZm7GmG9qR6SzS34Qb47zEXYhk7GCbYsCYz/xyr1uWtOtSjj2
         94vA==
X-Forwarded-Encrypted: i=1; AHgh+RpBY+sZM+4JKuTqKZco/aiCq6huvlwLNefp2GDxvEEyvwxlNChV45ZA1j3fmj+dwXCoUch/3KQpBeYpb4BX@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbI2CLhecMp+kYqx73MXtCvTScbBwutH2kRMliG5A1+N1L73h
	4NaUBD/64v61fGC7O2MvoNdq/aAFQFAytovoWk7eziqvw5agxDnSINbyJs8rWoKgxOSzBRv1wdf
	/Uayz/f8VtnmSRO0u0OSUK7OjU69g6Cwx7kiq1zr4Gg==
X-Gm-Gg: AR+sD11ImPlPBMsmLVKewagICc67t+eMCRSfaAzUu3gnKH5aACCus/KvyqrvQ5LkLUP
	/+997Dijy9gRjY8kxMvl4oD6WkL1S3qFpdewfsUhn8pHTbpZAX+s6Cyxc9/81sKsng66RWR9e1B
	iZdHOmhMYtpR4DmamtmEZzOhFc58Jy2XwHScsGz4TLtys+Qe4c6g5CY6rooUyGgeYh5oCFttU2f
	XyhaL3Q2UkqSgA8JrJeR5wVT3LXDg1HgA09O8l/lmSye8xJcMRP4PwPjrpf+MRp1I/8ol7B57tA
	H3r3Qe6T+edfLTtbuA==
X-Received: by 2002:a05:620a:4608:b0:92e:c118:18b9 with SMTP id
 af79cd13be357-930b43c45a4mr2167343785a.88.1784717229070; Wed, 22 Jul 2026
 03:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 12:46:57 +0200
X-Gm-Features: AUfX_mwdbQYshU7Eh86-5S9-gpZDCDD0EXLkbKHjoCISvWGty4DcFL-X4n78Y2Y
Message-ID: <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:

> It's not about this ioctl, it's about infrastructure reuse.
> It's about the fact that there is NOTHING special about dax_devlist;
> and no reason not to manage it via backing_files_map.
>
> The reason you stated was that you want userspace to determine the
> daxdev_index/backing_id - fine, no problem - this is why I asked that
> you pass it the desired backing_id in the ioctl.
> In fact I think that all fuse backing_ids would be better assigned by user space
> so the extension of padding => backing_id is not unique to famfs.

Right, so I suggest to just reuse FUSE_DEV_IOC_BACKING_OPEN and add
two flags: one to enable user supplied backing ID and the other to
indicate that fd refers to DAX device.  The changes to do compared to
the current patchset are quite minimal.

> And the best part is that this request requires no changes to your userspace.
> You already bite the bullet and maintain the new/old uapi but changing the
> kernel implementation does not require this burden from you, so to be honest
> I really don't understand why you did not follow Miklos' suggestion.

Code reuse is also important, but I understand John's position to want
to separate famfs from existing codebase as much as possible.  And
because this is an implementation detail I don't want to make this a
show stopper.  We can easily fix it later.

> > - Lose the famfs interleaved extent format. I have complied with this request.
> >   It makes some things worse, but we'll discuss that later.
> >
>
> I am really not aware of a request to lose the interleaved extent format.
> How can this patch [2] from Miklos which reimplements this format as a generic
> uapi be mistaken for a request to lose this format?

Let's not care.  We can easily add this later if famfs (or any other
use case) decides to want this after all.

Making the initial patchset smaller is win in any case.

> Let me recap the former review requests as I understand them:
>
> 1. Use ioctl instead of GET_DAXDEV

This is done, just need to reuse the existing ioctl instead of add a
new one with the same semantics (okay not true because of the fixed
backing ID extension...)

> 2. Use backing files infra for daxdev table

Leave this later.

> 3. Use ioctl instead of GET_FMAP

Not sure we agreed to use an ioctl for extent mapping.   What we did
agree on was to use a generic interface that doesn't have anything
famfs specific in it.

John, can you please also look at review comments provided by Sashiko?

Thanks,
Miklos
