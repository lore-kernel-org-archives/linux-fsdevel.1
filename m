Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963E31F99C
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778399195; cv=none; b=nMeSq4V3Z/WppMwTwMYK9UKP3T8aqgqlMMcQOc2zlyhI+HGRr3fG6vWTmvtlkTzjvIBjWjwFAUpSD94mHTXuJLVBZphgejq3cidd5Wv1mGYRSLV033Mn/ghuCjlD+2oTKgv4kRKGYInSNrJe11/eVBpB2DH6AS3HNFlTkbYiAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778399195; c=relaxed/simple;
	bh=F93aXlNsHQJS7hEypebdb2l7YqYczrdys/+BlpWOHmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVEl/qHo5LYpXvMArUY7+jMfnIEPIfrfAG/lHRpIbfEcFrfLvDPxnfBYM9C9lZnU+3aM+pz8wmgruKapGuOI7IfUAiEdBwNEAW1vF2eIK5j/Md3z0Cpt65/UEYqkeS03qjny5yH5y7jIU5ZNVZO+2Xz+wHFsL82k2PrT0D/07ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvFgY/tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvFgY/tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA39C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778399194;
	bh=F93aXlNsHQJS7hEypebdb2l7YqYczrdys/+BlpWOHmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OvFgY/tmFMecYrdncV2JyeZpL2PJp31PwC1mSzfw7zeOWxAVAQrUchnkxPWIRj2ac
	 LXwVZK3rtfmCPnmGHHlNU4MWaJ6q1n71ObjTkp/eCRj+zxCPDwJ/SkS8MgIpcO3ryM
	 FDHSUgZ1Qut+F0NBQOutqvRuv8BibzAyhz4qT8EJN5vpGEACqdSHMzHO8aMu9zgsMp
	 LGdFjwzBNm579AVGwOJAEL8EbW8wg1mP8m916dQ8h/+Xp//VCoRLwkONJHujjFbI6o
	 OjppHPJsu6yXkYX2GMRDYU74+zZJ0vvJ15cgTCfzJiiSx+MyZ0OY5+VwF+skoYPIpE
	 a14lY43pJQj6g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so5215134a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 00:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+symwnzsFI0bJLT1DgpGgf1LQtIFfdfQOBGQvTr8P51AdJi7qNOvA8D1Fp2b7MDuLKUthLa+uQELlA6ct@vger.kernel.org
X-Gm-Message-State: AOJu0YypZB8S+9ET8gK/ynL1D7Vb7/+I8wkvUgfWFMJr1ksrEW9ldKfj
	n7GdFNcXVuQeTV+PAzZgWLQ2a6eZ9fEX+VZ9IBQvNgucuIz7cPuAGCeDzTiJc/2TlCtw8I/DKvV
	54q9CeNLVGW0umZEMfxsquqgRcj0f0i0=
X-Received: by 2002:a05:6402:913:b0:67c:d93d:89ce with SMTP id
 4fb4d7f45d1cf-67d648ab8damr9091696a12.23.1778399193285; Sun, 10 May 2026
 00:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510021311.3995015-1-charsyam@gmail.com>
In-Reply-To: <20260510021311.3995015-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 10 May 2026 16:46:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-8grj+VsrA_9=mNL+dQ7W7V9ZKmhKU3nkB=hXh5LuVpw@mail.gmail.com>
X-Gm-Features: AVHnY4KT3SnIDQhn_m-qWNiqvtt9xCjUaOsjPOm_UCKBYQs9W9vs_huMIe8DrjE
Message-ID: <CAKYAXd-8grj+VsrA_9=mNL+dQ7W7V9ZKmhKU3nkB=hXh5LuVpw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix empty_buf and ra lifetime bugs in ntfs_empty_logfile()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 11:13=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> ntfs_empty_logfile() has three related allocator bugs around the
> @empty_buf and @ra buffers it uses inside the per-cluster loop.
>
> When the loop encounters a runlist entry with LCN_RL_NOT_MAPPED, the
> function kvfrees @empty_buf and goes to map_vcn to remap.  @empty_buf
> is not cleared.  If ntfs_map_runlist_nolock() fails on re-entry,
> control jumps to the err label which kvfrees @empty_buf a second time.
>
> In the same branch, @ra is left allocated.  When the remap succeeds
> the function falls through the @empty_buf re-allocation and the @ra
> re-allocation, overwriting the previous @ra pointer and leaking it.
>
> The success path frees @empty_buf with kfree() instead of kvfree().
> kvzalloc() may fall back to vmalloc(), in which case kfree() does not
> correctly release the memory.
>
> A KASAN-enabled QEMU harness mirroring this control flow reports
> "BUG: KASAN: double-free" when the second ntfs_map_runlist_nolock()
> fails.
>
> Clear both @empty_buf and @ra after the in-loop releases so the err
> path is a no-op when the buffers have already been freed and so the
> remap-success path does not leak the previous @ra.  Switch the success
> path to kvfree() to match the @empty_buf allocator.
>
> Fixes: 5218cd102aec ("ntfs: update misc operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
