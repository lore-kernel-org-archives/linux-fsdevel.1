Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831926;
	b=rQpNjoEHrCgBMDChgH64tGdB9xkBai4Pg0EGlvc6lfB9rQ0YXw7GCYk5DVK6rfAdDOfG
	 Bq0ZrVp+2Kr4AghET8oD5O+utfM13ZrFEdEsK7+nzqP5hmuqGT7ABR20jC+ljqQZMfK4G
	 H2JFxNT3i7UU4fOxqzsqhwylBGQopNzY4RwvSXjer5ql+5XdXH3dqR64UguTKMdpXs50c
	 I1s17Nxg+4dKVktiJIvNpS08ywysTNk+cZsXsUlJtdjs/j3Az0kGeZapPbt0xIezm9Z0z
	 0IR6kve5mT5TA5J6FhHiFD2rC/UkSOXKVK4L1TBvi1FVS4aNBm0HXBsLtMRzD0e9HNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
	b=Z6reZEOMMXd+z/D+J0JKeM9BsoWGVRXvcYvRlUyGsZhf79mEPFCtQVihu/e0PtB/k6sm
	 5coC1G/jMWv6evfz44ZGPmgRIr+RTDfrzdtQ5Yftpjkkq+y9yzjOAdj26eI3vdxE08s1g
	 GfCHa85Sbuavgqk2UupDLWKlK/1l8TB0sEyRgeXsWzIBmIa/Ly9UaYG7hQe/qU6Fkl7Gx
	 fX5MIbdOqs0lNQmCaHSzuTuWcaBtrSr1HnU9oI88i6eDx+4TgsXjTokJR4nsouk/LzUal
	 OgQre4ShudK1nESRd3/Ui+Wj1RzQNQGozFY6iTTTQlxY9LIVGIhTWV09akmiQ7Xng6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Io6RcOzD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBA606A8A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BBA606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Io6RcOzD
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so30706831fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 04:25:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794831920; cv=none;
        d=google.com; s=arc-20260327;
        b=F+1TXI8jbt5/MIFwSgO6jbxHGQw2EsZeb8pSR5cy3rwUhiBv6yQD9fuyzOpL7XO3fh
         ZKAnCC+wRFxloo5g/VKpgLH7QQRuJXY5Hx9rID/tkXBYF7JhmwcV2EtUiQrqxqhkRtUA
         BXwtN7w5ywGccZPSRBXWOSe8c3dPQsXdppmODEWeYvy39rAtrftfdq4tkj5LwzvwjfB/
         OtcUvCJjZeMvcBX3ceLnV/oPa0NSzTrjVZhoigMa8pPjBG9XDYMLqyy264vI1xNA2UKD
         vFfdgVIvRz37b9F+jOO0csO8YkqtlymD0IX//P4CWhUdBhsrh6Yoj6XpG7eiPAE8W7t7
         5BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        fh=Eqv2nl9YfwsNGlqPynJwNvnIgssdAQ6t/mHw6v6g5Gk=;
        b=bKSJyVJ154dnQ7Lu7ohGfzUW/d+/0kHpOKoQevuu3BdP00QJuooAQI6u19cJKAyrym
         lmd1bYc/1/8SFGdmg93nt866vo4MIfi42+SMS8oznU1EPerINGCP+QYaRe4WZVBB4+aH
         YaqlQ02f8YYXP0AXw2d4dLPX7TGIuu+vQjHOKJJLqmtl4RCYkaGcG1KhnIjKoVRxeodA
         S9QkhVd4ktMYtvjQTBHkXmn6KFXPlNtC/uFl7KoFJQMNCSgXezaF+aBEheWRU8thZV09
         B7uj29WMh6pXQkaHgyV4PNumJjlXSNy2q9WmIFp8xeDvwzVjuDm1vyf29M2dqlL7IKzO
         cTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794831920; x=1795436720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        b=Io6RcOzDR0JwQSOMZ2h/dhataExRAczwSTQYM2gQGcvveSLFkoliJjGCFbhzZ99VwP
         9xDPwkg0P3o4hEJS2bKPbWl/SIDSTT5vif+ZberzXGPC1gJ2yEZDQb+TVWFrP7aBagAM
         RYdX+hW9Ys6Vx4eHmulxcgkFXEX7FzLwsnbKwoKQeQrQcqbGwro95zEANdjKwE2PWuPO
         I27p838Yp1sAveGpu2sNwbQgbBkK3CP3eIenSSnNb5EWDY7e7UYKfhDUJw1t460K430F
         P2ILgEKZwkxcbRYmPC5i4YfVKTbPg9BldMzn191ptyulfkn5XEb6Zl02u/O5HvzMmSqI
         FM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794831920; x=1795436720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        b=t3MH7zWOVSIhnwbVx7W4r/903cvvBhPQJnFBP+CfDbgkIJzL2Si5LWmeNABpyiLubN
         Lo4dkEBJ2tHMxpPfjQ9Sl+WIlYruFS1t9cvGtgBnk4wurhBLKtuHIGFa7wwI2Sti0swV
         Wth7W68fRER/3ugfnyynwLr0ZvsowygHJ5uiArM6YErgJD+s1LI7SN2lflKxV2+31pv3
         K4bMN2SwlMzRh7VZvjPlYJwOjFKvZny+JMQwaiy05pGktqDATA5FRMq8Qfy1vx9R4An7
         q0y/UFJWjDi3qT4VfMFjGv6Am1qe6VXU50QbH4iseaARg2YevCPZZB3/rw6sOl9eVRIU
         Gjzw==
X-Forwarded-Encrypted: i=1; AL+hErFWoBOMh+Q3Mod2+TfM9FLeMfiN/Ypc/k/2q8AEl7gBL80Qw4MsF9Ok7EmEV4EVv2hly2e03rpEUCumqCqF@vger.kernel.org
X-Gm-Message-State: APuU4Z/UhLDtPcjwBCBmbSEsn/LvlY33fEU5nugp27S7vq7cPPIdycuI
	TLezhSxNrYXUOj3Z45QvG7AhH/qD7NM9ZVThnp61NIB3mX1AxOtkOR9WDqaHX0Byjrzk9lNauR1
	jiIz7cpcKEQyVGiHrDbWhjxxsi5An6hA=
X-Gm-Gg: AYBFou3+IRxolVptRnXUAjwiLluHQAVB+3oxYIWiQea4fCqKtYmOjptbZqDUFTUhD+B
	5RRGU91BM2R1pkDQl3z2LvKmaWZI30KGJ7gbEez3jvwDQL2Ulh9WGQx0Y5yP5mQqihj0lNr6Lqz
	9TTnhLqfa5jhAcEmtKQZyVjCaNbCjyGo3ngyIZykHGrYM4EIb19+tgm7aMsJpGFi1gLs/YGUYW4
	wszbwj6PjbFhtbDR1fNfanMwrSe18Jjkorsoz1XjObMqtlOyrK+HOYf2iSyy7Bp5v7j44HdY5s9
	Ywk3F/br5CG1Xwqs4spGT4cfvmogqYeT6I9yAvenxipicQrT3aFVEoP85lRmalhCKEOXqgFI+WL
	KtIjP6ys+V8lMYnHAAMVnjBlvTJCnAQX1qd98HA==
X-Received: by 2002:a05:651c:b2c:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae2b5302cfmr27450321fa.24.1794831920174; Mon, 16 Nov 2026
 04:25:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
 <20261115210952.2140036-3-graypanda.inzag@gmail.com> <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Mon, 16 Nov 2026 21:25:07 +0900
X-Gm-Features: Aa3M54r2Viw7fFeJwPagRzK9IYztsTnUnL-IHLph1k3bGx9UGsJ-OXrvkjOjw2M
Message-ID: <CAO7ntTQvav7mhK6caZ82afGadP8jeOJ_thanAf8DXBMBboN14g@mail.gmail.com>
Subject: Re: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 7:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 15, 2026 at 10:10 PM Junyoung Jang
> <graypanda.inzag@gmail.com> wrote:
> >
> > inotify_handle_inode_event() allocates the variable-length event with
> > kmalloc() without zeroing the name buffer, sets event->name_len to
> > name->len, and copies name->name with strscpy().
> >
> > If a dentry qstr contains an embedded NUL byte (for example, via a
> > crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
> > stops at the first NUL while event->name_len still covers the trailing
> > bytes. copy_event_to_user() then copies event->name_len bytes to
> > userspace, leaking uninitialized slab memory from the tail of the
> > event allocation.
> >
> > This mismatch dates back to
> > commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"),
> > which replaced strlen(file_name->name) with file_name->len, and remained
> > in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").
> >
> > Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
> > are zeroed.
> >
> > Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> > Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> > Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> > ---
> >  fs/notify/inotify/inotify_fsnotify.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 6e3af6452dcc..78eb1e92a14c 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> >         event->sync_cookie = cookie;
> >         event->name_len = len;
> >         if (len)
> > -               strscpy(event->name, name->name, event->name_len + 1);
> > +               strscpy_pad(event->name, name->name, event->name_len + 1);
> >
>
> I am not sure it is inotify/fanotify responsibility to hide awkward names
> which filesystem emits.
>
> First of all, I think the solution should be consistent with d_path(), so memcpy
> instead of strcpy here may be enough to avoid leaking uninit memory.
>
> If we want to be nicer to userspace, then we could for example pad the
> garbage bytes with "???" for here and for d_path(), but I don't think
> this is worth the effort and also don't think that hiding the fs flaky name
> with strscpy_pad() is the best way to go.
>
> Thanks,
> Amir.

Hi Amir,

Agreed, matching __d_alloc() and d_path() is cleaner than zero-masking
the trailing bytes.

For v2, I will switch both inotify (patch 2) and fanotify (patch 3) to
memcpy(..., len) followed by an explicit '\0' at index len so the full
allocated buffer is initialized. I will give others a bit more time to
comment before sending v2.

Thanks,
Junyoung
