Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B7330317
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793405; cv=pass; b=dFMtZdQyWewI59zfQkJ6qRrQclkMjwo/fpPN3C7SPhkHhppr2V/DLb7KzM7nXytfJd7gwTnKigNrGanThAZ1XuEWiFxgtnI3ogC9iQZsH8RS7w0oxUxqCL+/VY4BB0Cu7KMV/w0zvoHAMPN8MgNOwD+VjYl0ooL+H+xaaOd1lIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793405; c=relaxed/simple;
	bh=ZMRAcpOeHLaYMTDX+ddAEB2Dl27TP/9xuourH8BZK5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW4eAHkDoJoJWFSZa4w1CwdjGcfUqllj2gxPLGM6/zV55AvXxi0PmQNKK7TCMSlD1hIohk69WhXerIhp1zfeVXslvKFuCo9pG2gMXd+ZZ9jEh4xXpIj56qYK8u4PoL8zrHUKDz3bcB55dzAmq+AjkpA1Xd2MpRgv1p1dK3LPPnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHM9WVnV; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHM9WVnV"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso14634392a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778793402; cv=none;
        d=google.com; s=arc-20240605;
        b=CpSry/NSeQUbx7UHrnKvmbkOecY5JhBRbcEBhGkytppxgRLgDHHpTKWcS/9VVcBqi1
         49duMX8MkyUwqu6SogtWbbvPr3kpEuvFdqJhrGhMqUShkEp6pLe1UQyEZkZa1n+0HYY9
         ZtiG/YR7bOPOZklU/9CBg0QWJyM06FuGrQNgFf4zgYZgfaY1vQRc4yiGNSTLsVpHgZSD
         ok87AHWabZu7FUsZbXpo5qo4X1cw664ZZwZ/Pn0l9uJURZJmAmu1GVLNJ0NbcysD5KRI
         BvOpuii/30abv/zz1JZRa4GFtjEFUnfrSHWok8RJ0QlBwaHboLL2m7mCzyIDZ4e4k6qd
         n2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZMRAcpOeHLaYMTDX+ddAEB2Dl27TP/9xuourH8BZK5o=;
        fh=anB3SlfjJdtyYZpufN7DcJKytpjKlqT4FT0JVZM5rYE=;
        b=WGm59Qidr1bM/Ac8aEiUTTYyCVNORHRl9cftEZZoBygFe6qFTOWtTlYv2IqT1P2gje
         G/tp9eTNLYrOi+s+MshkR7Seo6wDLNzDZVAWnoUtcERR+xZNFOL4jPrjA/HRvXwUaD3Z
         dGz2LmJsO/Ng5q4f7ZbwjlFe8mW6Gjt4TNIxQn4MENA30yAV6U+1fa6pjWOa4HQc9f+7
         AJDrU3RBUCE9TD2/S4NH6R915/Jj/4lb9NAssdW9/xfqUd5m8Z2fJdS8bBSlOwVQ3Xai
         YTh6f9QmD0PuByYScBUW+JV6DPGWqbqEex/hnp22qnohpKr8h+yoZt4rerlFErlrg1YT
         d/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793402; x=1779398202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMRAcpOeHLaYMTDX+ddAEB2Dl27TP/9xuourH8BZK5o=;
        b=YHM9WVnVGnb4ofbvJsM5FBFVxrpjWp/bmqCEbqUtHrmLUozMif2FLBrZtvC2p2ziYH
         ZEmHGF65zXIJyrU6pMKCwUwiupaZxMQuehPoL7ZI4C7oZqVLDiPyFmy/NWdrvuFEdkZD
         8/xu6OmUm92/vZXvYeAjeDCpvfXL53/4/w1Un2Nf3nsUeT2ELBOjJ8roSMATXV0rsfIE
         0qrxQ4r9MTOXDoe3ye5iNMp3yaRtf40RNJkoyLk76e0+urwNb92SPLKP25FDT/kqoStH
         2uGbKa552ZfBqamcXmKtvFxdHGdbpic6a7GJ+3+PhRUHJATHAxXZHa7TwOIA8YCn9E/b
         SvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793402; x=1779398202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMRAcpOeHLaYMTDX+ddAEB2Dl27TP/9xuourH8BZK5o=;
        b=qEh4V1VI1sX9iI1E/s7mp34qMkdXNLrxBzRw+MW0xvHIv5a+4z4gzVAOsmg9Hob1VN
         TzuNRNsOioXOU3td7ZcK4dQLa+cz9PsKhSSzGPfvFELYD5iIYhxyKVhIdymcHOd749HN
         Q7grUIfdy324c9LvWItO03hopjbO/DNQrKLwJoBoja/AYw3zthuqY3e40iEFlWV0GyVI
         ReGBz5tRkT/TrjNOeFoYx91b/9/loN9zyNleuLBvFRlJfpHwxLqqPydRM/FFIdHnfjVp
         HgIhc/JWtAquBh51oLeCPJxtt4mGzuXV5+qCC6LcrYFSBuoZm7oVIs4YhedyoonXMKE2
         uWkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+amAx/oM6Q+pTPvttDAOGTJvgFoqzAnfh+FBAgI450v/IgMKpZmywaVtRu+/dAlox7mKFCmVjxZaMO+x1t@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqSz1sUeWQDUjGyTzHSw4Bzus57D739nQwe0DxJBJsEjV7zLV
	BstUPM6Pk6DGo2+OSQc/vU/w+uNr8vNqPIUlZzYGjFaa83Er8B4oW1z1FIUrgGi7drYKiBB4m5p
	jnBELcIBdbEzz/39YtHsyrNRUlHyJuIY=
X-Gm-Gg: Acq92OGa7KHoq0oKQeWKwvVn5oCNTvFmHmX+cMDBWBCvGToonqdKWLDPOK1eio75YDC
	a1EbsVbrzxU8oTYuC3UHVdlJ8V5uyHuRwXkwkLDwaG6tai0k/2e6SUYghJsqK+Wlix9mgjm8xE2
	+TOvH3Xq1kBOdgHXpBwYf56dhHyFlr0pXyEmmZuFxZBVr7ycMwc8LUh47ny0vsOdw2BEnErFqz/
	+oucZ+ggNp6xGQPTYyFI0iCojKTGFOQ2D3ZlxjME78IROrUQIjAgssWwO9Nj2qpo6KumQru4uEm
	AeXGXYv6yAtDmIVfpWMUil/Qx04y9Izp3YuL9lYvk1cI08MFz2iQ
X-Received: by 2002:a05:6402:13c2:b0:67c:7ffc:c4b with SMTP id
 4fb4d7f45d1cf-683bd384cdbmr499066a12.19.1778793402002; Thu, 14 May 2026
 14:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxg+DkTuinnf9AMR6gdHqAydbD88+oBkTtQtABJfdC0vVw@mail.gmail.com>
 <20260514121336.439565-1-nirmoyd@nvidia.com> <CAOQ4uxg=gONUh5QEW5KJcyXLDF15HbLnc9Ea7RKPcgtyfPasTA@mail.gmail.com>
 <f9f0e951-a52d-4272-a44e-890d7e7555fa@nvidia.com> <CAOQ4uxgRzcSCWWq=eGfSc=iUOs8k_eD1_OKCB_sh9Vc9nSQuOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgRzcSCWWq=eGfSc=iUOs8k_eD1_OKCB_sh9Vc9nSQuOg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 23:16:30 +0200
X-Gm-Features: AVHnY4JAjZIv4zYK3fb7Yl987hx_8Ytprfl8aPYKwzNxqJJ6lw0ZD_07Hvc9l44
Message-ID: <CAOQ4uxjSUufiFpU1JuTNEq7vHejCRVZL1huBPQ5ZqbtZAjKS0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ovl: keep merged and impure readdir caches separate
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:16=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, May 14, 2026 at 4:55=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> w=
rote:
> > On 14.05.26 16:09, Amir Goldstein wrote:
> ...
> >> Patch looks great - real root cause, gave you minor comments.
> >>
> >> IIUC, as far as you know, the repro never triggered the theoretic
> >> OVL_WHITEOUTS race?
> >>
> >> It was always just this ERR_PTR(PTR_ERR()) black magic?
> >
> >
> > Yes, with this particular syzkaller reproducer, it was always this blac=
k magic. I tried with and without your suggested changes and saw no differe=
nce in the crash behavior.
> >
> > But I think we should also have the fix for OVL_WHITEOUTS race as well.
> >
>
> Yeh maybe.
> I don't like making fixes to theoretical races without reproducers.
> I'll think about it.
> Maybe I'll try to reproduce synthetically.
> Or maybe I'll just do a fortify patch.

FYI pushed readdir cache fortify patch to ovl-fixes in github.
It is based on the idea of your first patch, but implementation
is different.

Feel free to review.
I will post it later after testing and deciding what to do about the
"race fix" patch.

Thanks,
Amir.
