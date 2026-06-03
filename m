Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57C42A82
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479602; cv=pass; b=OeJZfSYaqJjKPkKnw8sPJbxKYxaTDddhtmwD+aPSCGYGiWo1v3ctyVZnxF6wEDQgirTEWeHYMyh2rGQNp1McNsuomF1TbEVA1EjTZjxrKjvdkExueuZNMZLm24i8QxlKtfySiFIpb3GfYepQyG+oII4qaNkI5u/NIaAhdtA8BnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479602; c=relaxed/simple;
	bh=1IeoGmyXKCHF+vazqnzxSivC66X9NGYz6nKU75EaHt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoDkVhQmp85NsTXxmTkINs6TnpEIEdFFXHizF38ZgcMg2dR3vq6ag22WnOECTKzBCMGM26FrhxsVCjfaYkVd/2DTnycu8x0S0oIpfDg974hp3UgyeDxKxD8daGJNwTiLIUPWf6066e22y466RnrD2Vz8pecOBwwWjS8sOh3HaH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oDORKraF; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oDORKraF"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3074adb8fcaso340011eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 02:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780479600; cv=none;
        d=google.com; s=arc-20240605;
        b=ZpxYgtAGprcwsznnB0bowHpTMdmzChwHAKRXvatYG9uulTWg3IMKOiV7W2w/us+twC
         Tl9dUNSiSTQDkCUCfc/LS/r4Bw0bUpGQ1oy2hQpBvJJXGSS+xnesBi10waLZf0g2zEuY
         bN7wUcEWHNzSjv0ZhOHLUOrpRcIDc4lSjIt8yyERXZVyRAdWZvxQRgCSjjv2pggR2W2a
         65ywAh8D/CwrbKfUdSQP/f1rDECsdp9R0uhLASvqyJYlHccdl2V/tXX9lK8i7osD5IHP
         VlBhq4vcaWSDPEwHr6A4MrbA0mpM9qgcBOUvr2sMdjyQM+BEaPiuaIQ9NGE6zTbAWU7q
         lqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1ehSj23IfCmzPZngwG8XDa8t9FB4fozxZd1s0Ny6Ia4=;
        fh=F2PhSesBfvrmUw6eK9D3ymkz5+3g4n5fP8Y5qZonkik=;
        b=Fmz0nWSHa3w+OlG1jhq299s0/pAREywy1fP8Dzkh6OgndP3SeAN0hlSjMqguG2Q8i/
         agSwtVtnInr/GDnuDqaLndj8ubZ70pWkaEj49nDYMg0HX5OYAPKwDEdicO3Fq455ykfJ
         2keLIDPyIjJI1jMBGyqY+hq30ZLGHk+8L8Hp1XzTLmp0IH+ylrC49SPtmwDnbsvfyC+K
         py87QPUHOmJxkjIMBtOM0isqDUcMd76+xZI85PdOohcOAt5YbEnqUNPN9qhC0nv8a1+s
         UudREMIQ4AizyxhffDwsK8nHvd1kEcyRcFXh73MDPYblh0Ii7oTEFMMKGGWF6DiP3k3m
         dcEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780479600; x=1781084400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ehSj23IfCmzPZngwG8XDa8t9FB4fozxZd1s0Ny6Ia4=;
        b=oDORKraFHELJzN3bDFLA82PCELgtFtz3SqzJojuTxFFOTYxNWGqPvxVoH+uzp2bPJ/
         3D8BA53EyqeBA447+1rvyjLMPAsSH+OE508qToFgARsYPotHkom7l3CRKikeBLAr5+gT
         W7VrEdtQfPtNd6MZo5Vo2YaRvV2lQ2cIAlWj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479600; x=1781084400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ehSj23IfCmzPZngwG8XDa8t9FB4fozxZd1s0Ny6Ia4=;
        b=q7mbhI3GkCnb4Ofy5dfix+I5VPNXHLgsbNeFP2YTL3fmRmJX/4vgW9x5I6NzapsfdZ
         5STRchDzben0M+dDLONY2YqZQIC6Yq3y/KX4cy2Pd8Jc1rFDidHaorQ5wtZ8qWch7wIn
         kHSp43Yf6BEizA6ONQ7VHr7uO91QPgWw93jooJvNA9DQUJg5Yeoh+iFWr6ik9IxTARVU
         ViEJORql0BYiEXRCDAtriGKApMaKrWLBU0hvtWYU5G9e7emNLSqzATJ/8ne4kmEL02o3
         FwCOgeSx2GVNKuf6rYhxGDK4/qKxtAxQhgfcyhdc5aa9cOo/pXWG1tL2Dre6FCw8cOKM
         EB6g==
X-Forwarded-Encrypted: i=1; AFNElJ8pRTl1EX2X2jrhgqLYn7hVj37ifq7e8PJy5bfNaDwm6WXx28orxT+82KmtuNiuSX/wto2Iv4lua+Ya20LB@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/c8SRxsiUgpbCLHM45qCCZh0Nt1sG7VmMagOORAzTSLHK4+n
	S9+BIMGTuxS9wd9zLuff1Zvfb+Z8BkBq38lor368vx0/zrBYSAoN3m7079SavnhqvpU06+uNB/M
	EPdPWkD587YnULtfjDhtiV0ibLeMRVA1tg7k/KjemaA==
X-Gm-Gg: Acq92OF8gr6dW/OpldXPBruf+4LtzV/yocXsS61FGGjNSXyrgyjUHpxWgQl+iE6VMrR
	wo9xhhfTapNQdoRZllvs8ybdyAPxnzlj1gVaBJBMyefUpvzxm7RQOvklS+/cwB8cwVrBngK7U6h
	wLnclS8YJxzBC2oJwOW/M1udIeRwGSsTpwwS1qLumOjOpGY6TE5S/JubcbwwIQx2lkvQmJYn3NG
	HtBJtZDrhOiOaVovN+2I/NYetzml5BTocxhQ0wpDmWohFuQLraTnG77eN8ZXxWBBjRjG9PVeT+b
	LQW2+AdyeT4v8HkLCm3SlpzbXzJad0yKlZtUVTbWRjZOdg4=
X-Received: by 2002:a05:7300:72cb:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-3074fa5579dmr1310275eec.3.1780479600262; Wed, 03 Jun 2026
 02:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
 <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com> <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
In-Reply-To: <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 11:39:46 +0200
X-Gm-Features: AVHnY4IoGOIZC3vvhezDGQYniFFeuDo0XpHHJxBiuhhHmBWXiQF3cxck0JH7m5w
Message-ID: <CAJfpegt=DphJP3pYHL6ZMzbYD4Yfmo_G+DAm496Ar57L0RzymA@mail.gmail.com>
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 01:43, NeilBrown <neilb@ownmail.net> wrote:

> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b658b6baf72f..3f16ecbc358e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1605,13 +1605,29 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>                 struct dentry *child = try_lookup_noperm(name, dir);
>                 if (!child || IS_ERR(child))
>                         goto put_parent;
> -               entry = start_removing_dentry(dir, child);
> -               dput(child);
> -               if (IS_ERR(entry))
> -                       goto put_parent;
> -               if (!d_same_name(entry, dir, name)) {
> -                       end_removing(entry);
> -                       entry = NULL;
> +               if (d_really_is_negative(child)) {
> +                       spin_lock(&child->d_lock);
> +                       if (d_really_is_negative(child)) {
> +                               fuse_dir_changed(parent);
> +                               if (!(flags & FUSE_EXPIRE_ONLY))
> +                                       __d_drop(entry);
> +                               fuse_invalidate_entry_cache(entry);

s/entry/child/ for the above two lines

Otherwise looks good and tests OK.

Agree about the need for comments.

Thanks,
Miklos
