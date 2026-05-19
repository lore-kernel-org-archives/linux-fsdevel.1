Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DD327C13
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201297; cv=pass; b=C9yb8+H5/T/Rln9oXqxexVpzlrka4YXRVP5crlge9QsZpLxEzujKfApwnWHTz9pU3cyi09Id3VDpoTlQokPwy2WM8ncPTm/ZzDzlKBUutg4wtnqPaW4kFoy+63UNqpOOnANCPoQLc+d0YDznkrWZ7XPlo3S5qdGi4D2xwDc5V1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201297; c=relaxed/simple;
	bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWkWEn/J5r6oQ7I+1tj0e8qpubpCDlM6XEGJEQU012+4P9zA1U0V7K7y+4CqIensGJWfAm6KC4OsTRUN69RL4Q8XGAgO8ost1Mn72sHNDIn7grzl0k883VfTJu6QpIjVmrmSxEdBGLuys/g2q5ELqZ75289MkVctQJo+aKs2kZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MW76B4vU; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MW76B4vU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb8e9a4edso47500661cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201294; cv=none;
        d=google.com; s=arc-20240605;
        b=PGlG0mrVqWGEEyDOkhaVYb7y3gG2pyzMADURiW5VkkBtuJlFCCgjDk2NIe2L/dbgpe
         ZyJG7Lm2YJzF8GoUzhmTeBf027nf4jnbUw1KUXcXayeo08gMYFCux/TAcDr2SIPtradg
         /sUTQ9S8SfakGch80PDtVjcw1fReNG/nuMXA1drNQ14YrH/iTBLA+8OlgkthbAJ6HPYO
         /6As8ZmNZcKe3F03LpSyrW30zHNsOV/s7kXwQo5631nykMfx/0N+CvPa881Xw0Pbabaj
         uwn6oAbTjhUtMNc2Nte2MxtMeQNlOC3Gr/jWZPr3RVJnfnw2E8X8dLmxVQGmTrfkI+Bg
         cv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        fh=AZjerB2oAsgsF8mXCblUU0b/3GwMx5K2mqDxHQmAsQ4=;
        b=aCJH2ldTFL+WEqdf+2vlQAqEIAQUJu3f97h8Q+t29uRCz9N1fYIRLi4iRAeiOEyl/4
         acHK6fSiXGF8cCeij8XdUWP3GmCWdCROYjddxrbDJlbIeGI9jxjsL0y3ss9IqLBXTC7x
         5gwIGdozZj9o0APc0IABpFSm0PHeADfX+A9xBoXPp9hrtFHzfTxOh5qxEtbC/2NZ6OU5
         OhxcRQ1eYfO7di2bd7f8DG/T+Df7tHTBakoHI+Vg7bPWbF53xi3sI/x43Fv7vMJT5ADY
         Pv80951Yl6++h0s4HlFKACZTve6Zqi3YoAFpWCvgypLDFOLDB3sossPlHFFmK0uP86sI
         OkSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779201294; x=1779806094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        b=MW76B4vUG4iqUZQ630WpZkiaA4gJqJey4Fnx9+gRE5L9EccKfsm6dzz4TUPTKPIKVm
         p0ViacrAmApl6FM3WElFBiVdlC3QowyfKcWq98O48L/U4mztBv5L/DFrCoT38a9rtvnf
         teUA75DMizMtElaAuLdabVlmFR5O+SI4zH7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201294; x=1779806094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzuXZgF3Qrmd6JYQPtb9iWDbLS1sA1jibvcsjdBphjc=;
        b=kLxbdZGTN5IpO/p/ICSGAKTl75ROf+b1h3BFz6thXbk29Ue9Ijtk9a6Qx/DeNRdQ9C
         sn5CvfF6hTlF57cxBgFJCezDVL+KQjFbfhd1HcYyM1y6J1BvPI9Ydocu2LNAoPI+CLGq
         EHmtSs0FsJWtLidexj+GlXdQxDe2kdysC9Bi3ussn5elI6G8X8+0nPBbEEUI5ds9UUf7
         qqOq5txZR2SVN+KxA1HaUGK5yZo1rUN0Sg0YJMgdgLbfYtMI2RDxGk+AZnJ+61OyLoal
         pu/zxyJCZ+6ed8BE2b+iRz0vOvJ8mH2r895VjNqmGrS6yRyJX47EQJpqQSNT5zKxoLsz
         QEjg==
X-Forwarded-Encrypted: i=1; AFNElJ+4bC0EMT5+gUofUq0g08Txc9LuTBHXqro854bdrwXcI844Kz8phst9OLXETFB/BLI2JkvsaB4PW1oLBMpy@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvNU/FXjTT/dZc0mHBUxeAvPsX1CqKVgz6y3adI0Y8lVsimgX
	8wjkNYnR/OsXsyR/N8IulijRIJNambWHoB9sVZi/JLPBIlra/I4drN/4AswY4EmjIIPsnyj2+7y
	Y15YUipask4vvjzb+lyOX9I+9wgJhMovh2cYSl6SP5g==
X-Gm-Gg: Acq92OF0EOYDSAXrWWa1oWuPiKPg7Ap0xOP6rn7nTTOXBs2/FkCcly8RVZ7jEZSEKrT
	nCQ/RTPCNmdWF1bbB8T6kApcDJPfXWHbT3CusBqS31cGjR2bt1O/UnIzok4A2shR1w3UdR6Y91b
	szxDwT2bh9wHYnH0R41Ut6EBGjQGYtG2t2pUp9vP13T54AqvTVgkGNrnl4Y99N19EGqXD8NlXIq
	GZvRSf7hpEyEf4W5qYxxAsWdYrHWPebdsQ2+rlvpJhHSE9mEWNuJZUuLmz8np0zDwy4blzWrbPU
	FDaezguy2H7+6OAJ7hj9lV0Aa/VseXAQJmg5qkk=
X-Received: by 2002:a05:622a:d1:b0:509:1b76:e9b2 with SMTP id
 d75a77b69052e-5165a276812mr277461251cf.55.1779201294168; Tue, 19 May 2026
 07:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
In-Reply-To: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:34:43 +0200
X-Gm-Features: AVHnY4Jg59xybOxPkwhz_VWfCMVL-W4M2Tqu4DnxVX0f0TXClapA1CEdciRZeWo
Message-ID: <CAJfpegtf1nujj8N4S_QSa+zPFTvCypj_aWEdUqyz2nUJgUh_KQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: reject fuse_notify() pagecache ops on directories
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 16:29, Jann Horn <jannh@google.com> wrote:
>
> The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> FUSE daemon to actively write/read pagecache contents.
>
> For directories with FOPEN_CACHE_DIR, the pagecache is used as
> kernel-internal cache storage, and userspace is not supposed to have
> direct access to this cache - in particular, fuse_parse_cache() will hit
> WARN_ON() if the cache contains bogus data.
>
> Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on anything other than
> regular files with -EINVAL.
>
> Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please apply this to vfs.fixes?

Thanks,
Miklos
