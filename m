Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982177;
	b=qqmYwIYsXBnkg/NXrbxza+ZpVx4CNWtT97zGoOw1CgPyvgq+a8hThlI8Blrmsuj227Jb
	 NUg7lfm3avXE/ArHMJDQ4+soIx/pNqco+Ry88hy3wfghSkxIf1/kGi9qq4SxDS2fyISyN
	 O3V0BddaqqObZSr2/8dV8deXonfnJT1GEyZYKQ9u6HzY773TVRUQzpcKSXZYSIcLl8p9Z
	 gcBMFMryZIFaS6h535mE25IsR93far1GPz0Uij3F2Et7Dqih/hLY9RsW5C8Yhyzl/MWSL
	 R5iSpxNfnsrls0qAK/ERTT6iUDQ3l28TQAyDQUBkWYexyJtWFI6+8dewRPCae4ZrHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=opVpgEYV9gBtf6yQWstiOV78EVjFTqAa0i4kc/jTqnc=;
	b=WEfwY7DZfvfTsjfS02XhI8JjCt+XI8+O/3myEaWSmzsWqO5t9Z7QhKXI7cH6/NOjhkbD
	 K1xeGH+CI4+1CLlWE2kqoJc8VCmxbudeS94iRGt4ZvVklsPY5MXKEApRmCLSJbQF6J7HB
	 W/icEYBWQ2Hyw6ypkLePJgoqMBt9G71kYnGQxpv9/yz2KXm/Fumd5ydJPwpADGhLOf73t
	 7/7HokdNGnOLX7tld9NBQ6o19Ohm8QkWd5l+It7kt1ekeAKBGbrfkMUnBypk+CtGm+yk4
	 ybHj93xG2pc79t2T2KLuSD40ov272+2KIvbJO9uuk3es1wV1KOLGy3N3Zr4CgGW1yGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ed83bYUX;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB4606A31D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 02:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CABB4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ed83bYUX
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso6140606a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 19:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792982174; x=1793586974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opVpgEYV9gBtf6yQWstiOV78EVjFTqAa0i4kc/jTqnc=;
        b=ed83bYUXTCIkrhzksy4x3pzmpKMBgYQHrvFqoBH540ywzekGYs0w8L+Na+thNsrfzu
         gp+m5pREcmBAjD4TTrTfILsxc6CwxgnmqRQG293eNQDvhmXGnSogegooX8jlsr8k/FC9
         qA4Y83KOjl0sUKdoArFVQSHIuyAlTmmpc6634=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792982174; x=1793586974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=opVpgEYV9gBtf6yQWstiOV78EVjFTqAa0i4kc/jTqnc=;
        b=IgaV0YCUC5RjoLXtHxC+Eekc7d3+P++n0EuAJbKSENdGDcfCZpJjHOrc7zSafjtkkn
         hJAU6PqDVdQFlHL3aLHBlvS4CiN/sltP04H9zU9iAz7UZ4fskGf0vPrmnjYRWFmstN2u
         ggMJJnWw/f54c28Wv5Vn4CgqCP+onxjCOKY+yiuFPKLgCrz//RmK28URWAHXPfZ3SnGZ
         3g8HyNw87/GJNIciPGaVsvJkhEBs81BmgzZ2quzB0589Jp78K9uSnLKeASSHomP2/x4N
         wHNo1n/NG5PaYaCijtuqnDUsrd5bRrfsmxkGfrN8gwuv7oo22zmCmwH6tmOiubATTH7s
         rHeg==
X-Gm-Message-State: AFq9FYLt9peMWAz2oYXqXNph5554Trf15oqQzXkgvyWXoGGlRZ46yhC3
	8hdvDtVH2sHXw6OXLzRRXcO2yaF5dqb0Opgd8cXJbaUGWNfqRhiWcFgTMT+csP7lkEkzalRE6Kk
	W/7ypyQk=
X-Gm-Gg: AYBFou0aqKVyEaseEwINkX9vjglZG1DabTzuWdKHOdVDBxMp4PQd7xsn/jjUEfnWvIW
	SLPu+WV/lS+XOz9nnIIsTFTuN5XTpQXgMyp6waQqivhq1a0sHTDqIaxcFj12sK1MXwVB0h8v6N0
	jfkSGZbGZ0vLKz/QZ9MstlXNVcl0q0biHLSXhiJBTXLPu7BOT/fMZ8/2VsV3uckSJB+/nw+XU7d
	toUzJMrKm1x+xRGVlDPmJNrToPJ/HvxaevBZnlVOo8U+vBl6eF9YLySdhzjZ0VLUb/vLdOQejIa
	9hcGVa3XCW87ohYPOyUUYvPKuRCwERYbxLfPT7cyy7+0dVf0pa/3FsWdIFJ67ebo9wu0Ai/W+r+
	p+daCqipXBrsM6yzJ7RTdked28A5N2qMLhhvCxxzVDZm1ctFiZtzNVKjyWNnlg8QOPb9SRNcttI
	XVXrNy+tRxcLn1GO+SZHJe9yvSzV0gHIay0Dp/OTy8/sJ2VKMAr4EdOiGjNokwGHcecuJgZXU5X
	HLQCT/sezxWMabGnpzLjlDMt1fIF3kQUd8Nn1ZRDiE2Dt4u75RZSrNWga0I3FHA/y4WF+QkNg07
	TtYrjhg6gHd/521SDNSjP88ZOBBEPQ==
X-Received: by 2002:a17:907:6d0a:b0:c42:4f89:13 with SMTP id a640c23a62f3a-c46bdc13042mr614061366b.15.1792982174171;
        Sun, 25 Oct 2026 19:36:14 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5202d9sm270128166b.32.2026.10.25.19.36.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 19:36:14 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c434376dbebso461577066b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 19:36:13 -0700 (PDT)
X-Received: by 2002:a17:907:3e8d:b0:c46:7fa4:9212 with SMTP id
 a640c23a62f3a-c46be5e3d65mr763708766b.23.1792982173252; Sun, 25 Oct 2026
 19:36:13 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
In-Reply-To: <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Oct 2026 16:35:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh0gCvsC7A9z_H7her218kSCmd16dqtd9uMfO5ZrSvxLw@mail.gmail.com>
X-Gm-Features: AclHuK9j_db__idbNB1VD4BAB9oEUCi3kHT1x-yRvpTXB0AMWOknVyDLChen_N8
Message-ID: <CAHk-=wh0gCvsC7A9z_H7her218kSCmd16dqtd9uMfO5ZrSvxLw@mail.gmail.com>
Subject: Re: [GIT PULL for v7.4] vfs keyring
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Oct 2026 at 00:45, Christian Brauner <brauner@kernel.org> wrote:
>
> Neither keyring is linked into any other keyring so request_key() and
> KEYCTL_SEARCH can't find them. Userspace has to scrape the serial out
> of /proc/keys before it can add a key to either of them. That's not
> great as any user can add a key with a newline in its description and
> make /proc/keys show a fake .dm-verity keyring line with whatever
> serial they like.

This explanation reads *very* oddly. It doesn't actually explain at
all what the patches do or why they do it.

Instead it states *another* problem entirely that it doesn't actually
fix, and almost entirely ignores what the patches actually do.

That's not at all helpful.

Yes, yes, that *other* problem is some of the *impetus* for doing
this, but at the same time it is absolutely *NOT* an explanation for
what this code actually does, and why I should pull it. It talks about
what the patches *don't* do, and rambles about the background, but
nary a word about what is actually happening.

The only explanations about what the patches actually do are complete
and utter nonsense. They claim it adds some kind of "well-known key
IDs". That's complete BS. There is absolutely nothing "well known"
about any of that: they are completely new random key IDs that nobody
has ever heard of before, but that are meant to be used as fixed known
key IDs.

To clarify: I'm not pulling this.  The code looks fine, but I had to
*look* at the code to try to even guess at what the hell you asked me
to pull, and that's not fine.

The pull request was an incomprehensible word salad that makes no
sense and doesn't describe anything. Please fix it.

                Linus
