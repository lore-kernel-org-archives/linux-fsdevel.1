Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73F3ED3A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199679; cv=pass; b=drrIiSOxUL80r6cUFGpUYCAvTv9G+fwrEPqPCITw6U9k5rDne2lnynjB1dBzwnjjqY2oErz9XDbJWsVWOdrI0GDJ11SG8TDjXXu4GpinnEy3OfAXV/PGEDO0rDi9A2Urwot4nlD8Riy7f+9gyhA0o/cRk8l8+bX1wlfF5fFh2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199679; c=relaxed/simple;
	bh=VUN0slV2E/uvTpww7QVUeFC3SqCXZBlBGuW9mvpkZ/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4CbqEdM9NyjDwYcyd9M3aIDiYxIJ4kCZcB6F8snG/Eim+LLO4qdoMWNCXxBw6OX1iQODK/weANefgIQ/malEqVN610Dj48VnvqgSB+GWeAa4HSeWH1G/C7h+ZkZXgaIXmXhCwOY2FuE/qPkB+ibFjSVXTDuY+YIspZ/YgMt2OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QY+14O3W; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QY+14O3W"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e5bea4045so27739451cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779199677; cv=none;
        d=google.com; s=arc-20240605;
        b=dGDGiFPzG6ugJ89ZB5W6PHz9bNYEsVQsApPVM6apiMn8YkuoHkUGPQcjrqIwOe+C8y
         eIyanvOccvpRFgfupwtu0OTj/kRCwaILw/GqG0cp86n2YDzlunhGZxTKXyuWFTZarb/b
         73mHYFWYQr0y9K4/DoTJBAXwfg26QyXQKJr3pBZH6lckc/whoI7y/h22klstKoZKYZ53
         TClONpjgHNZImFOaZ2gfCq/25TPk4mxrcvPkhdb2tfWnXy/2xWGwLVjS5QZsBHnLATxp
         iqV9wZLhTP9qYIJCMq4kn/uidvzaSUFpJzzCgwy7YCpH+rbQUFk1XdSFvdYzlNsqB6qJ
         D6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        fh=v/h1RQS8ZUaxYdm1DPPxUHdbJM1FFrwnTH+BGzXL304=;
        b=d92a/WGTv3+WcUyCG082ScW4P93ThMH9ciaiHPjit/QKODJY5Gq90LjFY/4Equs0Rf
         I9gjPDqoWsmw9mVHkSejmd6rpjN2WbQWiSOADwAa7F3UOOk6ikgkWKPY6/IMrnFb8U7Z
         +k3Ba+183VexiV2wRgobkfOTqNIJqT0Hsq96oPU+rws0O8Dg0kDQNi7sNXQbbUrVl5uI
         1aLcLqC3+sSahkhcBo98D7/7ykSGzhfKTVNpMPDl5mMSp4vDWdXeVsVrwXVYbWAJjOoe
         2DIljECWpUsyCo4vlujTnfO4TYNkxSfRKgmovUww0CIz/zG7sX/pi1XmngsVBNIXL2Z6
         t9Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779199677; x=1779804477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        b=QY+14O3WqHLYpxnM5NCUpxlMLDMB79h6LYUiv5D40RcaagKKbyn2PBsp7PeYJTGOzX
         akdKHGF7zhjwMG6jptIxgmrQ6SqgYCYwaeAD2wRJvetJ7rquaY7Oz9XpfX9OHYLJNvp7
         j5sFIV6D7ZUwm1u1FhQmxAIPdFeP7qMWZb0is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199677; x=1779804477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        b=Lsu+OU/N0DBDrZFcrZdqH0bvDDrHHmjBPEQCu81HxP+O5/CXZBs0f5AXQri67LVh/J
         ayKDLPS3A4NHbhlOdI4HqrCwV3jxn8wwaRgRoYRfMOoaKUjAgJUhkWN7p1z5QZ+yNT6J
         iPdRwZjdbFAo/4/G9QO3bEPKFzXp8f4S72gBSb0YPaayd8NEad22fwUAB5mCyM6DemyK
         W5il/av1cIRHyj5DFunA0nu9LBAmE7uQBPKDREdXa1sR4P3x/3tL1se+eTHajFAApTUb
         tYMjAoI+EkkRyN5jrVyU50S4dsLKS29drhmhbpztnobH+vm8XT8cmnU75bH0jOyRwh0I
         H2xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cCBdkItTi6fTlU/w+mYDbWCD/11olGYDvWNCbeS8J2oFPk4MMlG/CTzgegbW7n6B8AeKpSXbNWVjAMtRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YytWgwikaQ23AXKJt4wh8kNkncaxR0hMG2NWUzUVgqTdruKtMSs
	84fmpWLg9zW/tqG8n1JaSf8AmUwJ23m4uNVW/OlyGnCUGEXg6Vz7EA4o8TJ/XlpUcAG1fYoPTO8
	zNUoz4SIgeDO6fLU/tG2jkoOX54e+EUZ1omenXrC52g==
X-Gm-Gg: Acq92OFR54HxTYU5lmp+3YS7YpUa4FcX5pe+vr9450ZNI7b2pkW6VdvLjIjIsJKcgr6
	wmdXInqDH/HCn427TvZXHYlYYi0/RNSgHknMReDj8yJwwcdyRCoJ3sFZqJTnS1AHednjBrmOq2C
	HWjgytI2/9k3ku5yO1PqW0ToTJ5BYjEs0Pil+f5agr7R7W/19l3DVgwZO1lMxq1hJc0Uain77/O
	moRRLr2+Q9kKYeXbePHb+/vRS7PBu/xrTCkDOpN+hEaLbByDCE5atQq/OGRcYw9bEm+WH8S5KHY
	emqq/VXR62gSSfxE9IOuvCBqNcHNkrItw9G6el8=
X-Received: by 2002:a05:622a:250e:b0:50d:b0f9:1a66 with SMTP id
 d75a77b69052e-5165a20c07emr258446821cf.42.1779199677085; Tue, 19 May 2026
 07:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
In-Reply-To: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:07:45 +0200
X-Gm-Features: AVHnY4Ju8gNxI22X-oXQbbZ3c7C6b3wtqxFhm0MkkpAJGdYIHwyAWsx7v_165KU
Message-ID: <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 16:00, Jann Horn <jannh@google.com> wrote:
>
> The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> FUSE daemon to actively write/read pagecache contents.
>
> For directories with FOPEN_CACHE_DIR, the pagecache is used as
> kernel-internal cache storage, and userspace is not supposed to have
> direct access to this cache - in particular, fuse_parse_cache() will hit
> WARN_ON() if the cache contains bogus data.
>
> Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
> -EINVAL.

Good catch.

Shouldn't this reject !S_ISREG()?  Symlinks also use the page cache
and could break if overwritten by arbitrary data.

Thanks,
Miklos
