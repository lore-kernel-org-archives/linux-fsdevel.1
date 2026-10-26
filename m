Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007144;
	b=RLk6cNEoCdVvWK/mrvLHedrF1xoOPqBQeCIk9i4Q8pmJ9oQwWskLSXqFydIpwvUcyp/+
	 3/OFN52ruWEhsk2FsYLwZNzGb9bvdmw79ZvIc84YcwwpxBv65h/zhCxW+JG1vjiX8gGsE
	 oTL66mwykn5edzlf0+DnbmBlHqFrDYteLxpIL8JF7O+/RjpAv56h1DMYl/lYm/20meWTw
	 9y+R3aSjFcHZ4RX+LuI/qYpB1J2/ymoez0CeczTkI/MB9G1tU2FXnZTNy4B/cvAAI8+ZY
	 E55AmOKRcpNmUbbfCGZsUosaAB81umpTCbK/0LJvSo2UokK65ZRXzy/wn+Xh/iPlnEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
	b=vMhPqxnkrWizU8+h+ewJjhV+iCZqGR3bs07b6jqXzBB50IMS4zHC03wbonwmFI4W/GDZ
	 Jno8CKaif0BXfHB7+hDz5yO/yLcYxEjzPVkSXrgG14sRTAfebmJ4mfsueuT4Z8y7j+YVY
	 md5LBYllMW+OEjEMSOwtvQByKboog/I4vNBRqopIBm7UoMK7IzKEbA7inDogmGJSfb6BD
	 L4oHhBBJYGglasXhfmyJMan2VFAdglKELdQhFpKAbFGHWv6i0frrXgNotKuvZsxRfmgJP
	 +w578EQtcR0AAwENHes1n4bfKyJaymSyoY94vl6W5vO+mYyS34K9qsYH1BqMsNcfaGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJgZ1kRT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2F606A31D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 09:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B2F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJgZ1kRT
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so4358938a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 02:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007142; cv=none;
        d=google.com; s=arc-20260327;
        b=iEpSlmlKtzKG5EwL0TAcixDnxkx8vfWcDLTmg1QJEbqy7Q7AUXXlosW8gXQLf9Z7q6
         jwY9YnUZGVGeCPgP2BLYY957mmVqxmXjJuMvvgT3j0Gy9MJ3O4HFS0KAbmpYFako2D1S
         tzwGE1cV5iY2JzEW8NS+SBIJLozMEj08TlJ7ZJzYRnNavgEsZOZtlRfOE26rE0ajscIg
         HSp5rkIT9BBtbgTwNlUeWnkOaYl6wiIqQbzIEsfEBKFNCaRjhEzJnnGAVTDGeLgexTq7
         8zC1PilG0sdK0+dAe//dMGmKxaOcKAfUJ4KVsHEZ9UwsAZKrHhDc3VWjOb57u5pyyS8D
         zE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        fh=RnOp2R37ZV48zgEVrN0sqvuTyGab/ymhQ/6X+vTRx7A=;
        b=oWslQxjodLzrXvORi82QmTATd/hCKTfwKDc4A71O0nmvAcs3CWOJWOVAgvlmvrnFIo
         wqrb6CzJ/mxZntsxpJpJ4T/0ChOQfJM+/eOpxsBngP0sJP9/tq1HCRoL6qes0Lbti2YI
         E9mwqfBHQlpe81GYCAPtG3Tis4vpVtACENBQUAQMX70mjBRIV5Lyf/OpLOjEWaiv76IF
         2PYrGUkB9+A9piHWw1loSN837vP3Z+x59hFVRP29yBN18Nk7+Tz7ypyDOFHbuGyOb9dx
         wYn/ILCuWtzmIdkG8qIGwP7XECubESyN0sr86daiQB0rNAlcHKN/Brs2eaqKfvafcdf+
         TOqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007142; x=1793611942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        b=jJgZ1kRTnuHOfldZYkyTH7Q7gInsSNyGbuCrnkEaHqjGU+VEafB1g6eX0BhRsyA26h
         k9t9loRX2tqzrB67q32zXLg2ywkofxQa2Ee3xXwnj8CAcr1J6eskhZ+H+zhsNQzP5Q5H
         FyarA3x4ZYdySiwD1GinjcyzHt7LsXxfaYgLLKqX6iQxFx4lD9CcFYC5e7NAoEoCYaTT
         mN2wjFzP7BNoREeHxvonn9fZeN0FPKjAPCTbFc46ZCt+/p03GLv1K1Hjzy4+DNvKBIl3
         3hbaoGRy7A5EjdV2igBOGhFgsyTh3RfLOHjFt+QFFckflFF+d9TWjVow5YoWI+Hf3HNC
         JPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007142; x=1793611942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        b=iTfs3YhvvwjBqsiGyUfUcIjPN9O0ObIcksrfWkrzW2Df/qo4DNknju7Zdem5j0ZCxC
         20JJsHVcmONbonJGrW1t3+BDMRoo83Rtoe8Qo74eudJZvIveMJoVLRuNN+ckrACVcgP4
         ht9jfKX+WxzewGM2BZ6PpRnVBxeg2iXba9A2M/aDSPAXW0tQYMP6AIBI4KU1h5uWPnBq
         qT5a7rgtC5PZ+47xf0EEHDonSdfDKD84Qen0quyhiFF9og17ZvXPb7PaskcENlNyIIAY
         J4cLWh4fKEboOt7hkDZZkD/dLwdyYdPsKJdE4U2XJlQ1hLdULoA1Yh3rs7Reu7rbf7/d
         SXAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKdhBOf/RQfDGysntysUYwE5kK11kMjxxmNKvglB2kL/sngIlN4dJ9MFK4rpOucHPvv3AJUu93FqJ3WuJ7@vger.kernel.org
X-Gm-Message-State: AFq9FYLyJJoMYF8U2KQ1IpNuXNTwE1fK/vv93CBLDZwAyGyxGvre47tE
	Co4+P8XmZbNmUH1KxIgX+XBiEgStGEuwU5Po/+XFQ+gJIfRFQeow5DTwwaPrHs6I4GyCWS+/TBc
	kso1ebh9wtNNTKpn7gvXqFUkmY0qtgmU=
X-Gm-Gg: AYBFou36zX9hh0KvU2mQogu60uc/ikAD2m4u36S4BgsZXOH1e1VwzPKuvs2oLw3Crhm
	ir1JzFDRYylfPdG+cYIR+idVimmDiym7izS+uLrF2x8syZ181zYUiwHvVsAzIjykfGBAO38SAUD
	RmbOJRDXOXALd3V8WWhKzT2A+Va17aH86lPzrfGUW+6IZcV18Vtz9pPlZcKap1fHpc+rVNNtm5Y
	l1p2r8icgiFuLzXwpN1ifYkUXQjhVW6EZFKl1el0mtWuVruspEmtrR8WcVGTho6WBi0nW2hdnMg
	8L7O7ip00A0xZRvMBS9l2rywWjhqT7Ir7dzyJSpBwzdhnGy/aPl6WUiwhgFqRBeokqwHqjGfp5g
	T6aZlWfcT0bbnZUolZA57mtE6LcRD1vVS+O6XP4r+39O/1i2TRFzHDKpHLNS8yTw8J5RaLb1F7r
	QSQY9idK4yGT/ndqQ=
X-Received: by 2002:a05:6402:a515:10b0:6b4:2fc3:7d85 with SMTP id
 4fb4d7f45d1cf-6b442fe9a23mr5162442a12.26.1793007141857; Mon, 26 Oct 2026
 02:32:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025232251.58252-1-dennylin0707@gmail.com>
In-Reply-To: <20261025232251.58252-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 Oct 2026 11:32:10 +0200
X-Gm-Features: AclHuK9HrNxGfGq3Xk8d9bF60_YyoNgGHS0nIQi_8ycsJWClOpl0dBjTH6NbKO0
Message-ID: <CAOQ4uxifE0G4r=cpevTB4mzq+HhGdVsNhddzFNuH=BN9YrD6Ag@mail.gmail.com>
Subject: Re: [PATCH] inotify: do not coalesce events with different rename cookies
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:23=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> inotify compares the mask, watch descriptor and name when coalescing
> adjacent unread events, but ignores their rename cookies. Distinct
> renames can therefore lose an event even with IN_ALL_EVENTS.

oops. Somehow I remembered that we never merge MOVE events.
Maybe that's even a simpler check. IDK.

>
> For example, prepare two files in an unwatched staging directory and
> rename each onto the same pathname in a watched destination directory
> before reading the events. Only the first IN_MOVED_TO event is retained,
> although the two renames have different cookies.

Thing is, the "wrong" rename TO cookie is meaningless without the FROM pair=
.
If the second source has a FROM, then the two TO won't merge.
Could you really reproduce this case?

> Similarly, coalescing
> distinct IN_MOVED_FROM events can discard the cookie needed to match a
> subsequent IN_MOVED_TO event.

THIS looks like a case that can be reproduced.
Can you provide an inotify LTP test for this case please.

>
> The original inotify implementation compared cookies before coalescing.
> The fsnotify conversion lost this comparison. Compare sync_cookie as well
> to preserve distinct rename events, while retaining coalescing for
> ordinary events with zero cookies.
>
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/notify/inotify/inotify_fsnotify.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 7c326ec2e8a8..6456d9c0e408 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -40,6 +40,7 @@ static bool event_compare(struct fsnotify_event *old_fs=
n,
>                 return false;
>         if ((old->mask =3D=3D new->mask) &&
>             (old->wd =3D=3D new->wd) &&
> +           (old->sync_cookie =3D=3D new->sync_cookie) &&
>             (old->name_len =3D=3D new->name_len) &&
>             (!old->name_len || !strcmp(old->name, new->name)))
>                 return true;
> --
> 2.43.0
>

Practically, this means that MOVED events can never be merged,
so a slightly cheaper and simpler test would be
if ((old->mask =3D=3D new->mask) && (old->mask & INOTIFY_MERGEABLE_EVENTS) =
&& ...

Thanks,
Amir.
