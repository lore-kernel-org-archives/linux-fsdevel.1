Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605241DEC5
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372226; cv=pass; b=TCVkKBwUQ7IDxGcNcmvzoDSiPWuMOSFnXZnpzP/ioDfVDGvtBkEUcxFvsPA08DB5Lbp4hpKNJKDgGzQKdaRH85S5bnRehsijSQhKz2eLV2L0FPwYCEoAfY/Az8Foyy8z4wNTxbyc0R2gbANbFgkji0aRsnAyfHR6ggKHv8CCxLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372226; c=relaxed/simple;
	bh=G1PsgoNk8ZRW3MpWx+p3EgHcNI5RrHxdJM7/y1Oj4XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgg2SrihWkUl6QJGIonf8DiG43/XLdm4klTQoquUWY0wbLK+Xz9sJ49om+FCep6M9Eu4UE2Yx52L77XasddgSLx1regvqb3K0yqemaHm+Fxb2yu+iTSrOV4+UQpD/96POy8yLQ8uPHyHraxB2vD1r8AN5wdvpHA8SAyfjdqFdUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOZ0wH69; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOZ0wH69"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1527022f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 14:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783372222; cv=none;
        d=google.com; s=arc-20260327;
        b=qKwQrSODIfqh8dK7uIh/m5Jlk4+x3woE2SBDJqn6SJGjIxhmsx0EO4Rdsf27B/6Pk4
         Xv/PI5i5pv7nAeyGIjbx2onuOQlp3FyDaOGW+ase41JMAVzWKHH0pXlMetnCju+MRPY5
         IZ3m9jSVT7igTks0wmUQ2ipgA+1pKuQO0YosbG8yr5qKry5cDU+in0XAeU7r4fAb2n56
         dPQgsNWiQJL0jkhm7uWHwb2VATS17oF9CtydqfEg4HpxYN6WQCIrrJ3DbPsNBESIXwZl
         iXQKG9Nu9iADQ13uKsswnAD/qT3Erg4cT8WmtI4B7t2rKjV1pLcyhv2EcrMzmD90EZsX
         Zk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTPTVUtdS4k47QUOBTcq39fwXmGTETu3cEn0VEiXrKk=;
        fh=Ln/2H1PZdIyGu9pZnLHp19WnAWEuOyOvk52wtPNWoS8=;
        b=pEUHsGxHul5nYStrWQ6HAVUCrDsmjNxHm+ojrW3ueJe/OEOHFIgNb01EY1str56c8m
         2V0MA9SW2s4VyoXEqdXrAAbZBDHI0QkSkeAGvSRTefGF0pooY7/AjeJQpd9Y9nv+SOdr
         ABdhUWQJqjqlxPopoaAQEqNLh+LzHoRWjJCG+bTd8rj6svUKpKq+WHmcwALZ1txEhrie
         SAk/oIUPXEGrjUiVzpwpzpQ0q+DupP6QD6kGS7IQ642cCM5+f+VHW52XtZl1uEGblFhq
         WeBwI2Xs9a1qwpVSf9XHTQ0a9+CZ9PGgo8ACchI2sAk9TmQDhV6ezGhpDy6rcSLJL874
         cHgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783372222; x=1783977022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nTPTVUtdS4k47QUOBTcq39fwXmGTETu3cEn0VEiXrKk=;
        b=VOZ0wH69JPBnCKNsnqanOS+g2tRBf9/0VnD/6iC2DC6A6beW++SlokfHcz2gFlp1X/
         7+/MFuOYN21AOJg9dTk+4/qTttZ1iSFZ+yIf8WSGYo97gW4/KCjPXcz+kMDdP9yfoB6C
         gJxXGJMut8RlOhsbq17CvUsSpdXEB4HYbYKDdEZwcdbUnUDuc2YB1TJ0aHXQdQI2GWV2
         M7fB1OEFFSQpOl5Uyfe7PLPGxZlVdIjhVL6aLZ+X7rpS1PKa9Kv6b5bNcINVqDCoew+p
         74mm+amMYcrM4zPD37RBvhDLbyCSEEfxqHNy3y+G2OhnNJ8O8guZU7QKrx9BDTo/2aEy
         X/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372222; x=1783977022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTPTVUtdS4k47QUOBTcq39fwXmGTETu3cEn0VEiXrKk=;
        b=cCy2UFH+yBcaXw1c6i2HNdDbwUEArap5qvTiwlTAezY0zOKVltISpEBItlz/pTUtDM
         oVZKcb5MW9/F/B5UWems5lWzpSXKXZrSQ6wy8UIPtHlFGEe4J8l2CgkLxJwAM+mdBIGl
         ty9nM/ymL/AWyFHulDjRs5djthbmA1qFKbpDo50UpU0W0h0IbDMtOeuHqWIn+XncPh+W
         Z8ok9gXxh353kcjP4U0pF07Vay3gmptIkefE+jngIJLkJIdoC6t+ormr5WP/0afP2rce
         xF+OtlegJW4j08xdCqQtfKw4eGlsrq1sbljSvUD5Pz3SDig3XKfVSRiBEmVw66voxXld
         YNGA==
X-Forwarded-Encrypted: i=1; AHgh+RoNSDaRavQf2bsHK/891TYmRB1r1FfIpsw9P1FhWoqSogM8J9uhDkN5H0glw9DL7Yam7dtd3EJfqxuozB8f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00vmNQo2Av4lLoT8QkzUOYJrcgoQmEn/0nymL//WAkn5q5wOw
	IKK3ETg5pcrwM18O8gcAeU29xA2h0Janm5+4IRTZ3g7tdSByxbV4i0idh0yTEkY2FT5Q9p9XRX+
	0S827NO8F/sVGUIVgwidiA+Osv9UPsPA=
X-Gm-Gg: AfdE7ck5GZv6H9IblhIrUHQUg6cC7W6R+AoNeaaUWvcPI+7J5nzl/HGoQ+PK8XuGwFH
	XL8b7VUmqGWQH1zjm0/RX4jo3KvRGwETPEgX2G7Ldr1ft/DFvdeOfWAKv7l97bePWZD/0Ca/iXb
	AjMsquUWeLs6tCRx3ieLZGYU75RoS3lSYi2ZAOJQ0DP65s4R5cwV8TmE0Oru0z29eeTMOyC4Y3H
	g6udaQm/2FdJbZFTtZNihLr5KGCgI80XwKK3PH0lcjSWXgjcPTiNW0RcezybL/dgaxTrLLxWb4W
	hdIMt5iIx5lztseeeA3kBDPJXvOoeT5G5PC+x465yHHyL+HtigJn/XCveKGnWRU=
X-Received: by 2002:a5d:6608:0:b0:472:55a:ef90 with SMTP id
 ffacd0b85a97d-47de6697c81mr1703222f8f.8.1783372221848; Mon, 06 Jul 2026
 14:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703092815.4602-1-swethav0411@gmail.com>
In-Reply-To: <20260703092815.4602-1-swethav0411@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Jul 2026 14:10:09 -0700
X-Gm-Features: AVVi8Cd-dyt7Ii0P9xpbxtCjFtS5iCPO5yJeLQKlWwBTmbKjagmt7tI5wcFyw0M
Message-ID: <CAJnrk1bxAfK0QJQtQ213T0ZKhXu4Pi=2wfRfZ5u0_frC8bucDw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add folio_max_order and folio_min_order controls in fusectl
To: Vadlakonda Swetha <swethav0411@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:31=E2=80=AFAM Vadlakonda Swetha <swethav0411@gmail=
.com> wrote:
>
> Expose `folio_max_order` and `folio_min_order` entries under the FUSE
> control filesystem (`/sys/fs/fuse/connections/<connection_id>/`).
>
> Motivation:
> For fuse based systems like GCSFuse (Google Cloud Storage Fuse), large
> folios gives a significant boost to the read performance.
> - Without large folios, single file read perf is capped at 3GiB/s
> - With large folios, we are able to achieve 12GiB/s, 1MB blocksize
> - Writes:2GiB/s with large folios vs 1.6GiB/s without folios for 1MB bs
>
> We understand that subfolio dirty page tracking is not available for
> writeback cache with large folios. However this is not a blocker for

The buffered write and writeback paths in fuse go through iomap which
tracks subfolio dirty state.

> GCSFuse and similar cloud/network-based filesystems for the following
> reasons:
>
> 1. We generally recommend applications to use larger io sizes (>1MB)
>    for writes because of the latency involved with the network calls.
> 2. Random writes & small overwrites are also not recommended for cloud
>    based filesystems.
> 3. Beneficial when write back cache is explicitly disabled. Incase of
>    GCSFuse, write back cache is disabled for different other reasons.
>
> Providing these controls allow individual filesystems to explicitly opt
> into large folios once they evaluate their specific workload patterns.

Could you explain the use case of this granularity? The page cache
already adjusts folio size adaptively (eg small/random i/o still has
small orders, high-order allocations fall back gracefully to
lower-order allocations under memory pressure, etc) so it's a bit
unclear to me why a tunable would be needed. It also won't enforce the
order for any inodes that are already in the cache.

There's a patch to enable large folios by default [1] and the
benchmark numbers showed improvements all around, so I don't think
this would be something individual filesystems would have to
explicitly opt into. Does the change in [1] suffice for your use case?

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260624012132.1719941-1-joannelkoon=
g@gmail.com/
