Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793156860;
	b=iF3TbzFomhqFldp13E1geZSe9xzddWQwdUb6z00gglpeaEpUV3qYLR7jsrtH8VOXQPJg
	 5BZLc2ln5umW1OPksMEbIsfnKyIj3Jkh0Zn5XfDwmkibXQ9FlxFOV3hkXL8MJJoJYjMON
	 KFxJrKVqdvSoL/EfiejcL2YM7147JUMsjD4Jh/YUQATV/FIuXzWQadj3Wibq3ptUCV9HU
	 ck9uMA3RRgkQXxu1dnFyfZnTInxUidHCACeIZWvDEjsk4my0VwvpUbyrFzItGaS0PQowg
	 QFLGzDx38ioucSIPxmwESGDNUilrzU1MuzCLE8yu9Yxv5XscZinEFuOwnJyw+pmJqng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
	b=CShZ6xxQFCepywxA5kKiMu/5d4N1IZv8RX367hCSj45A6eJ2AjtB2Nepj371J+ZAkAU1
	 46WgQBUOEC5BCWh+45AyVgFqzWQFCuqOuMGVajDzFci/FZvw1xoMBHYvQpxLQjG+b4sC5
	 8topHZrz14KDxaTtU1kj6EuDr+pOk8XLSt2csQ9VP1pH7cdozqlObcakBu9klGGrOOBzR
	 XtiXN2L5jqD/YbVfOQqba/8shu409ZgT1E6uitmByppfKxX/GHxma9KXKjKj3V08tsB99
	 MW1oPupWJHZ0ryDEd+Rwz5Dnc9z7/lMh3S/N1MwpisB9D5A3iFIghYTa009xQXK9WjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ourcRmkO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17189606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17189606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ourcRmkO
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso795983a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156853; cv=none;
        d=google.com; s=arc-20260327;
        b=JrYnaObhJbCTeO2uoYe+HstZVytgrcWyF3nIgzi1AJZswwF4aFRgpWsKqYxexbtyk8
         Y3s/GD03xWtfm7eFv4a/GAiDla7oo+khvuKznNpqTnlhAFlwo2JEKw98xaI9aZi/n98t
         S1Kqi4dqdMiWCwXLk3nxEcsxFn0l134lpC2tg/zDId6Bi+0YdevWaU4L8eXGRIHfxSQF
         0euuP2oDUYNFuSJxzfeEeESaCFgTCmlfe+ZQFmuRfdewYyukJhk01kjsNpY1Nnd+5Q57
         ZAjxzEcZyhqdULZfVSBp8t0xJ1IE94b2o1I+vTEEuKGlYrzRCQhIfhB9ktTIyDlj9fEG
         1WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        fh=Pqgu1hiHoyIyjai2ljUVRHfjgAXJ2rtxJoqjRUJvY+M=;
        b=Gd7VL8H0bcIILlC5BMtlzLGDvmccQIA1udJHR0UmXsLUYSHhZ0eZeMRMtMyWJji3/L
         g72TIuSgpSpRMraBh0aPmvLVgTbvdGRDI3QE2qsKp6F67bYjPYVFvfOZ8jjyt/Fop4Ki
         E5+LbNcXKDH5sLoNQ5jHvuZ+dmC3ojlgf4qeAAeY5XLWaQGnGbtEhI8FVSGzEb4G6yAZ
         tLozUQVFO4mQvpLkm+3bXuBFM02y1M/RuR8XOyBfqohHPeaM6k+DVajJFsJZ4tulJCxN
         ha/EY3IxRL84xsrmNmA0pm8lXVoS+m3OAta4JMkXh8Gsqn/rh7Vr5DNhhJz4d72pOozL
         C9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156853; x=1793761653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        b=ourcRmkOH/IjfAvfCJMqpw8JEzyGEQLLpIyM3oq32ZzxtqSCibGO/9Qw/Zk8dFF5D8
         fq//S7uF6tXiGg9nQZRB6HtoBxFSa2TVcrKRBzBk5be9hIxjLnhroFo6uiFDTIL9+COy
         GKuGIj4CWW+G7mOqoAXg8EaLp0hk8d9+L0PXgj/Vy028JFOIXvBPPhhEJjYBBEt+u805
         2+GOsDyCAQDkByjNAJiQzEGqowmLSCJGi0AtsMpvSTEiIVkZ5a9wCJ1grbRnLH9hZBH2
         l6VXiMFEwb8nUI2eKb8LXhhz+qy0r0h3R++UuQIYJn1PKvc76dEdobFz1zSbnASn4i9m
         2cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156853; x=1793761653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        b=QSuDmZah6QP+05earXh2Q0GmQrzfJGEZfg8cjH5/PPW75fGee6IfHpmgGqpyxwOJeP
         m+ydPXrHfJSOppnL/ASQlOyCF9zjcZkgSHQYTutvf+yf8amM5UAMEpgTzVocCmeZYYgQ
         QnyUyp0BDrjv68P7rzN55okCSgrwsFteXVj0c6s8VQD2tNbc/wQaff3BbYbqbSef7XBX
         hHjZmzgwdHswcYFfaqyhL6DKQP/E6xyy0zL8UAijECh1PaZNUo+HQe5u2oz2TA3nGXRV
         HEr/6Ia/itWdcJeiZVKO92UKfr7JQH1bgdhNZtPD3y04gRxT0WsaM9Lf0K3tLulBlnbM
         IO9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVeB5cLJLglc82iV8w0Yc++etW/9D05d8st5rx1i3TnAbRiU381dwy6E5tmdy9PhQT/cJQPkUd4ntQO/Xz@vger.kernel.org
X-Gm-Message-State: AFq9FYJxqWe6TGqYdD+r75kfB+dhKUPNqJYOervy5CQufRNuce8H7r8/
	1EnlujUNRAjm/IxQHmMelJOZcxGxzRTrMSfiaijesDkVlchIt8XeFe4LEdyfpRrn67TP/pkjgig
	dqLcexpXqZbFLVCkI3nSsADTrtnqSbaY=
X-Gm-Gg: AYBFou1EUcjAQcVg8+IeF8t88FMggtOZRQxDog8gSug2y9/YeO2Z3Q/oAC2Be5CuOG9
	WG83T+BGcahKUBXdZpV2hTIGV234iVPoCcLPxd5mZ3Jd5p+EBRaom0n202EvKyr1B3MD50m35WN
	r4NUaiT0IaBJ7pIR0/GOZARrVHj2TIkYMyTjb+n51L/mdBQjMQfrZsLnzYX2gj1ytt1+bV9x+GW
	eoDLvs5cVOOL+K6usO+fztWe7gg0BeNcqW7/HdNfvCVD3ozgjkly9FVQG2V8/8Yqvk3w76ewsiv
	UZPnmznzWOY7fbuRir70j3txxKJeJNgAknn/iKjlxKd9JMVQgV+hB9j7F+0mKTdzo1JhFFLc9p3
	0Gy9T2Tm7gxnuf+H62IeYDNn89ClkaN6PVFTSfsRPmIHVDgDb/bDsfD4+2iRlea5zDFU=
X-Received: by 2002:a05:6402:42c8:b0:6ab:6e:a8e4 with SMTP id
 4fb4d7f45d1cf-6b49cc24773mr498856a12.44.1793156852883; Tue, 27 Oct 2026
 20:07:32 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027192027.8617-1-dennylin0707@gmail.com>
In-Reply-To: <20261027192027.8617-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 05:07:21 +0200
X-Gm-Features: AclHuK8Zk3JqjSuknFqDZQNv-pnsmVv-lUejnYaLZe-5J4JnZLEJi3oDDiYwgrk
Message-ID: <CAOQ4uxj3et_cyzD1iWHr3_z1dH1R3WQMCOm+kO2Q90TXjaV9pQ@mail.gmail.com>
Subject: Re: [PATCH v2] inotify: do not coalesce rename events
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:20=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> inotify compares the mask, watch descriptor and name when coalescing
> adjacent unread events, but ignores their rename cookies. Distinct
> IN_MOVED_FROM events can therefore be coalesced, losing the cookie needed
> to match a later IN_MOVED_TO event.
>
> For example, watch two directories with IN_MOVE. Move an entry from the
> first directory into an unwatched directory, recreate it under the same
> name, then move it from the first directory into the second watched
> directory before reading the events. The second IN_MOVED_FROM is merged
> with the first, while the IN_MOVED_TO retains the second rename's cookie.
> Userspace can no longer pair the second rename's events.
>
> The original inotify implementation compared cookies before coalescing.
> The fsnotify conversion lost this comparison. Do not coalesce
> IN_MOVED_FROM or IN_MOVED_TO events, which carry the identity of their
> respective renames. Leave coalescing of other event types unchanged.
>
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Cc: stable@vger.kernel.org
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 7c326ec2e8a8..6e3af6452dcc 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -36,7 +36,7 @@ static bool event_compare(struct fsnotify_event *old_fs=
n,
>
>         old =3D INOTIFY_E(old_fsn);
>         new =3D INOTIFY_E(new_fsn);
> -       if (old->mask & FS_IN_IGNORED)
> +       if (old->mask & (FS_IN_IGNORED | FS_MOVE))
>                 return false;
>         if ((old->mask =3D=3D new->mask) &&
>             (old->wd =3D=3D new->wd) &&
> --
> 2.43.0
>
