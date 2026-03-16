Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339351C6FF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681163; cv=none; b=igaMr3hlF5s5HGIG0hLCUH2Mu6tVm2chAW9BkMo5MTw5+o6AR7H8pvom3jv5mOyOhKQclq6EhKqglZ4u8q6nLOG/VZ8zMBp36RYRFjDHHy47LuPvbwpgCcRf8J2OaWWpfHYV5OViEfy58IOSF/h5ImOeNht/XCzUYqCQOA5TP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681163; c=relaxed/simple;
	bh=iAcwNb1yUC+KeXOYREZeT2CcBOBNScD6UASYT9uoIMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPitg1/B0tksVva7Ts5IRng4iyqNiJdOgeMFD8B99oMb5ZUWBShb7zNyAAm8X+x0jnm8OfURLQU90vnwpLM0QTUS/RvwQC0zcmZGp0jQDDw2KUeMC8/TasyKqLkRdoDNcN1i/8b3s7etV3cxsJ3bUmSUvv9ra/zD310RXDs1GV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QokYjukm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QokYjukm"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b97a0f18a3aso257739166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773681160; x=1774285960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D47H1/9DWNZln2C6xWaf+lxnKwfPG/1sbTPxxqBOoXo=;
        b=QokYjukmY22jX2ka6ngQJwj2JkiT3oyu2NRYTw7wORa4sFR3XgUxHKQaGSEYVSfuom
         4Tx5MFgfD2hVN5XuSdsG4v58yOETSIDoouRpgIjrHkc5zKanKI2qP0djiYYDh9PvyLkL
         uJsWJcCMbZ3XbO08hGLr/7y3WDKL+F16Rn6C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681160; x=1774285960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D47H1/9DWNZln2C6xWaf+lxnKwfPG/1sbTPxxqBOoXo=;
        b=kaRpjBfUbYiiJLdavwr4z6NFKB2FQAedofJw7X7tOIKgFX8Ukaa+L2MkRdGHMFbPjR
         j0qH/dtVwAC+pKsGujN6ZVVRNoDuRiDMS3PNJJGOOyip2Wcw1uAmSyVys6XuonSYjJav
         PrFqpk+zqPwvzDDUiVYSzlXP7f2uZ8ok5DZ7zAanInwfPl6D+HDmv01YpGJIoBp4LqA9
         nz/yMmOUjlsSU6Q26m22U/mEglre9qiftLjH83u1Gx1nsSzNxXXCyeGlgaQ4O4xrA9Zv
         i9K1HZZ3btgyxuzWMZvDLIoPDZMKXpBTN8c1jiwRiPmQtnKFGAY+rw3zQEaBTmzp3wSa
         KJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWR950JW8yTCgGX0nz4xZ0yOy/fRHQRC1FhXqQhgubl6w1xeCYOAKMYReKLDGJqNMFUJ8CKtnie64WQP649@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnzu3oBcugM6k8iQcraMjlstZebLGCTZpjRn6DwRuEVdEhynhk
	NyFlgAxo2aImzeKx4SQkjqQlduP0yn4tjdcj5NNcIQ5/u3O2rQ/X8ma4pMeNlaR55g7stP5XdvR
	Nl8CJbCc=
X-Gm-Gg: ATEYQzwZi8TOx+cG+IFSNNYrO+ivfIlPMKWDsTRwdb1/4/S4vLKSclgEQb568xIoo5r
	t23th4yEjXvYVe/P6vX81U4E6uFFL9CkM1D4eVUrfOmQyYKlL/8xr6pGgzkx8Utyh4uUbN1WnDR
	itOPBMU5jYOOV7ii+5oMF4k/lAIe7JnpGxZjn5UQiLblDinTaf1Z1SQ8VS0XWFTU8AYFutGFY6A
	9dxdWpRV4zWnIGp8ZKIYxNqBFbCDNtjZOAuA/CFf3EIxEMQ1euXYYm/2NWWNokUtJyS0Z/MNtKf
	FqwM4Dzg0C97Zpwl/83H3c4fImAWiJ6lCRNzfSEACTl1koFuCTDon7JD08LfrcyMAT0qzgUw5Hv
	bTcjlXQPPXjjnq32cNYtpdTZJpE69Fd0tLsStg7WFNJ3UVxiSmS93UhY7vIuC//Jr8L1E4iwsmX
	bN6pvgaTyTZQ5JGjtmkmqDB6sgupZ7RkuezGZGwzhppV19X0cP6vf3nFpkvFvzk8Z6+4z49j19
X-Received: by 2002:a17:907:9346:b0:b97:23c7:2b5c with SMTP id a640c23a62f3a-b97650a527emr789774666b.25.1773681160217;
        Mon, 16 Mar 2026 10:12:40 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97a6d8986esm344839266b.1.2026.03.16.10.12.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:12:39 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6670ba39400so200674a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:12:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpoifWbGm++WVBTfaekDccEvkIy5Mp2Cj9DgXsqOBzBKvxeVd3BQkviTlkqu68pDYowU+7KBdDQGIxzHtE@vger.kernel.org
X-Received: by 2002:a05:6402:34c5:b0:665:5e1b:ddf2 with SMTP id
 4fb4d7f45d1cf-6655e1be5f6mr2571949a12.3.1773681159693; Mon, 16 Mar 2026
 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
In-Reply-To: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Mar 2026 10:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
X-Gm-Features: AaiRm51b9UuuqYN0w-D1Vbi30YHEjMd68XoQaIApreWlSDySVTn6sa2mUa3X-ac
Message-ID: <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user access
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 01:53, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> -       if (!user_write_access_begin(dirent,
> -                       (unsigned long)(dirent->d_name + namlen + 1) -
> -                               (unsigned long)dirent))
> -               goto efault;

This was already pretty unreadable (my bad), but..

> +       scoped_user_write_access_size(dirent, (unsigned long)(dirent->d_name + namlen + 1) -
> +                                             (unsigned long)dirent, efault) {

.. in my opinion, this is even worse. It's a 90+ character long line
(or something), *and* it continues on the next line.

Yes, yes, the old code was disgusting too, but when changing it for
something that is supposed to be easier to read, please let's make it
*really* easier to read.

(And yes, there's another case of this same pattern a bit later).

Adding a helper inline function like dirent_size() might do it. And I
think it might as well be cleaned up while at it, and make it be
something like

    static inline size_t dirent_size(int namelen)
    {
        return offsetof(struct linux_dirent, d_name) + namelen + 1;
    }

[ Making things doubly sad, the size shouldn't even be *used* in sane
situations, because the user access validity is often checked by only
checking the beginning,

  The x86-64 __access_ok() does actually do that optimization, but
only if we can statically see that the thing is smaller than one page,
which in this case it can't, because while namelen is range checked,
it is allowed to be up to PATH_MAX in size, so even if the compiler
does do the full value range analysis, we'd need to relax that
__access_ok() check a bit more ]

Hmm? Can you do at least that dirent_size() kind of cleanup?

              Linus
