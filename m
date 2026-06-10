Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CA2DF6EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061936; cv=pass; b=QcZJa+7Q24nnGWTOGIFRkMl+2WbpPgTbKbxqp7BD1rSZu8y1x+36FrvD4PKwGQB3KsbH4XWcYpiTX6LAhLdamEeYqmWRmZBEKrC1c2HgGHX0kugrt3skWcRXRYOrqcx6pBaA3sU08L1mHiVRZeG6OImCy970G20OWfWESnAPEmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061936; c=relaxed/simple;
	bh=bLTA2n16r0+5ngF72dQlvuuIu9xn7HaM9bU+TkfJqR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzDg/LcD4Ww+joxPi0lBTTjG4VSF7Yg4zUQ0LSvU3juv3OppsoCkUgIqAro4IYhLgi6oxbU2yD4Kw0tz9DG2p/EGSz6S14xt4P530iKhC99+FllaF1+MsH0IgkJyUDv0hXcWzNcw5JX34uW45mrWVkqHFwo83XVXD4xJ4OpGVZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/8VXO8x; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/8VXO8x"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490af320e2aso67967335e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 20:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781061933; cv=none;
        d=google.com; s=arc-20240605;
        b=bufzEu9bMhOGrjzGVQuD7JEcrZThYVy+FpO7NfHyg6yNPPWY/fuKK2xi6h+9phUq3Z
         GjuPirE8dUqojYwVyzgYoUQpJB9OcQamLRraawT4o1+AmXQhyNnuxRNJTSEzF4YMeQl7
         DHGSVxDOt4RD3oHAA3yKxuzlJUyIT7mIHPOF55kLY3vnScvazdg6FzpzudBQDFCFBF8N
         DfSn9tK/9CxX7fEsufvRN94hFb2UqH5OMVEJUj6VnE+abOxHh4XCHhx/h5qfMyDu1T95
         A7bqAsBdnVcPkqz62D90lG7mqbsvkaFtNL0BpGnC3KoRhwJaVfcvPPVXERkLk1NrVWKz
         oNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        fh=zp5z0ED8w12vxLEQLIbKZYv/tdMdHOll/WwKK5TMdM4=;
        b=Zp9YK6MQ+DV+tyL9n0KDhm5b/1h/laS4yd1ARGZuzZJrz9mx8kWTRu3SAeiUuxJj13
         Trkot2mVQ8byBhGbA6dRjknQ3r0AvFBW2KVR9fOtm/Q9Wjo+mmqhgaSbJF4Vxa4Oq86X
         ZzHJ6PWbrvbdK5LvrS0tASiI3DY5kY4/tnsMUGrDH2s796+CPZep7XfbHuQ83jtSXHmM
         6YbzBxpmQnTK5oqQcwvN+NVYycRxeYGKbuLoN8gP5XD5LXRVHGstfbBQuGmj1cRV0HK/
         Tw2+z0odfRTKxX6fYcu6nR1rDvUwOzJy4JrDZH1qjpOrAi5uZmkV879E2f+6aqlJSLza
         ujvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781061933; x=1781666733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        b=h/8VXO8xPkWtp/8Uj7uEBEzd0flkYaM+5EsdXMZJMQVyFn9pkpuShbbz26vYKVZeO8
         mrxCf140NMB+b6k1X9KWOBZqSiAOHP6E0KO+NzVzMKbfB8oyVOlondDFR7JSYI1xpxqy
         sZIlk+HH+1U/2dICQsLrnkyuT8YU7YVl85stzNmsIFy3WmtzGcHpFN/sDCH4nBI43Gjr
         sF4CAS/mc0reQfTStC5JChgGg9/d+ocKREc6z0YpqcEq5QrnNLh5OcpSse+purzDiYS/
         x2V9OxGP10Q4jBgHC+hgZpSTFE/vijzGTF+sfDa2/q46s3kiqHY2joF+StYc/Jc83yOl
         DVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061933; x=1781666733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        b=BgNzjahgzFsQl2Tul6S+WXk6TqwyRBT1nkJW3UFNHI8TrW8WNDpk3xoFt5dGjJYXc4
         lLbSckUypfD7KhGb5hiX9Id5p92+jOaorZ9OBRH0qPkNa+BhodlAx2PyWtH+9Dv85MUB
         q/Tgjzs9NMEcAr3TRRZgVJafxHdp5oMJ3mC7SsQ4zFPxGAUo7lRZUpYD402yHxBR86v7
         J/h+Dz10VoxG8kglx+CKtkoAKbT0W7W58M0VXKErBuNGErxrK6XGtoAqrzjv2m30p7Xa
         3J2cWgjBHX4lql+Yqpwo/Dacp1aehvSqahFhYN2DQ61FvnSAFA1p8SJthhS7+NOErZKq
         j/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iNCxgFngfAg5rd3XyuW+E9PP9Yp69Mnm/Yt8ZiaVmzGD2oGq5kroNVWHNAm//8E90oF5gyUTLbeQdr1eV@vger.kernel.org
X-Gm-Message-State: AOJu0YziscHYqW0g6DhcAPCHirTgoRSi4ooAse7kEmx9SREyK05pZCEd
	3tvLz5scTENkutxP1JAAByCl4/k32uyYIYzno7VK4VxnBWMJ2BnUTS2Adz9UtebTowHcjyFhCx3
	XOuCFTlA9fZPGMWAddLI9UKvko1TzdRs=
X-Gm-Gg: Acq92OHeRmlIJEUT6ILIzIxd9Ozow0rRoJnZt6rlbrpf88kVHAuPwYEUF1ERePpHS4c
	HvAXQr7SrZJd43Nh6K3VQ/34bKPsf4GaUJIu2RzggqLMMNY+r8lE1B6bb9Xk8PfZtOozva/s3cf
	90FyG/9ERsZ8qVcAqyi+HhSDvSPTtcKIGXcveh4+oN18r9ThmvProVmewEci/QEVkBYzZ4gS/TJ
	4iKo/QiygBSNijPt9/b+xOb9CJsptBR29LUzVMqnJz5MG2ZyZu6xRgnbZeHHXlpruF1Uo87u1A2
	gnXVCKu6HuhFb6ybJchfFzfDu7471EOCruts5k4v370UUZTSDg2fU3iRL7mQnkRfv3zi0v7p/rQ
	ZpJNgnx5H
X-Received: by 2002:a05:600c:c493:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-490c25f1ab6mr393052765e9.21.1781061933272; Tue, 09 Jun 2026
 20:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
In-Reply-To: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Jun 2026 20:25:21 -0700
X-Gm-Features: AVVi8CfRPeeOu2dsd9aqrIIj60y--USHNaIrr5n67yP-THOc9yTjY2P-ZtwBuE4
Message-ID: <CAJnrk1bkXSmUp88KAMZvK3rnvN7ijAXMVev+dHCpodpo2GAxig@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, stable@vger.kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 5:38=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> FUSE_NOTIFY_PRUNE validates the nodeid payload length with:
>
>     size - sizeof(outarg) !=3D outarg.count * sizeof(u64)
>
> On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
> count multiplication can wrap.  A prune notification with count
> 0x20000000 and no nodeid payload passes the check, enters the copy
> loop, and asks the device copy path to read nodeids that are not
> present in the userspace write buffer.  In QEMU this reaches the
> fuse_copy_fill() BUG_ON(!err) path.
>
> Validate the payload length with array_size() instead.  That accepts
> exactly the same valid messages, but avoids wrapping arithmetic before
> the copy loop consumes the count.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Fixes: 3f29d59e92a9 ("fuse: add prune notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
> Changes in v2:
>   - Use array_size macro
>
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c105aaf9ff5d..0c6d1855003e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2081,7 +2081,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, =
unsigned int size,
>         if (err)
>                 return err;
>
> -       if (size - sizeof(outarg) !=3D outarg.count * sizeof(u64))
> +       if (size - sizeof(outarg) !=3D array_size(outarg.count, sizeof(u6=
4)))
>                 return -EINVAL;
>
>         for (; outarg.count; outarg.count -=3D num) {
> --
> 2.43.0
>

LGTM. A heads-up: in Miklos's current fuse tree [1], the notify logic
was moved over to a new fs/fuse/notify.c file, so I think you'll
probably need to rebase this onto for-next and resubmit against
notify.c. But this current patch looks great for backporting to
stable.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?=
h=3Dfor-next
