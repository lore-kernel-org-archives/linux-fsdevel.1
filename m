Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AF3E866D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788114; cv=pass; b=HoeD26AG/FqwBRugtnfFYgRQ9fZxIgQcLxfWJkFTFKPJHEeO205yckI6cOqdFrWTrsJJRtEvREJHKEaTBQTHv0Q4FK8FMUF9p9A3NjPPn+2fqkKXuyaAdReul9dCDcWLVbZVvcDP6DUZThzTYZPbJ5xCG+rIjFE3rZPeAeDiCX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788114; c=relaxed/simple;
	bh=uwEgaZIry4BwlZGiEYiKKAka0IgGN+yBojuXmD0c0es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtsaj6zl1oxWlAuvZ9GWli9uL09W4ftMZorJ6XGjYe6iZMjdiSghMytjOc8LJOyVViM0fJCgyMLB+UA23l7SflfD5iW8zW5T7Ci8LXhyf3/BrDf7S82mCmch69VAPUHjTw3CQGqr5Ng4LHVFj4XdQCXXCUcaXD33Oa1IWgYBHF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjJE65xn; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjJE65xn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so74033955e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 15:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773788112; cv=none;
        d=google.com; s=arc-20240605;
        b=lgVFm5YEe2q4DtqWZo7ljHsdNvZBT9vHlnINig3VFeBTxny9ZL5pOsJtdHcPrEC0qE
         SAWzNvHL0Y00/A52+vl5fqphq6BX60zk/+KC5dRy+ddCVrjQCoZuvW16tAJEipPLU4Lm
         n60p/1lJE/iTq4N6ce4Ye7ZL56FHSEwCvBivQmEOFUE1qFeZvK/zmhTScBZHhkmom7rk
         d/XQrbczTiikYtJpCVzT+PidWsaVST/7YG9N6u9l4jrVrdsF9UXIxCuLdUOItGFEyVax
         D6/j9wcf+aLN/fBdP0/F64oNoI/5/OEyWvbGHClicjQr5f7iuMlyvioUT5KwFDQg5V1j
         aDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        fh=+jEsyLY7bzU2L6FrSbIPjpk6QKLcX6Jx3dKUJ8QU+rE=;
        b=G0EzPIuPU5G0NEGHG816DO7UXGNHSJ2+7cJqWBES38nuCMUyeZ+V+tkpHd1/Cqs6FJ
         I5JSovuJBi9w8zecURVCUXo0qouDVvGvtTXIe/9Ly733HvnsgdcI+eT1GLyX/cZBjqA6
         DppokNi/R3HFTVWIMb4ydqEzJa0RLuhGYEdZvMoVtIQXCl4NiSyHGzWsqo6es8JRUfI0
         v0SRNqweOGbzVtffJebIURgL5tnuJ66dtlBX8TiANJad9rCxdkPdpwoprfViHMrUHlSD
         uM2euI4r39I6liQeQPSmdZVg1jo6at+hhMGXj3KJ35tqBTuqCj9MIPLRWgdOe4El1Yml
         OmMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773788112; x=1774392912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        b=jjJE65xnPdFpwwHShXBLFWSVa2DzQCG+BFe2WfMwGIeon53wFlguIlXWXFPxEUQ9ov
         oM2ZbDBKxnckPYq1HlzGts7k7jAd0tRB+iW/imC0yMAiRyIMyiBOMDMJJYcr8PczP7nP
         a1vbDcySwn2ItpVI/2jCB2IKjCWlvPIqtEQ+eE4tDif/cSjJOxqVEXrv4RlzUyoHJ8Jj
         +SpJUkoHCfoF0I/IaDkSwSogKKjgxoSZxaNY/MnPkDYN88ldLpNdCByx5w/8pPkw0J3D
         QAyHDHb7b1ocTRUx5f8ZfUmnNQQVjVn5L2x/B8Zz1OBN5G5IuySGDw/kFre27dwjMgmC
         lL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788112; x=1774392912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        b=naLfFIKqkoKDWV2GfvLFNnzuO7uq1w+5ECgfOvtzYB5xAhEryBEgMnpvX9dxgRgwT5
         EnKuRkjerYuR18mDVVctv+Tp+/7J9J2vGM7wVZKUGQdRMBIuHENzcruoYSgNcg//A65X
         Jhr7yC7CT+YIM8dvh4LAX99PG1OZSbVUNUMmzu8vBDc88PWHubcHjRHSsPUPjS8ZZlRT
         5N9P8C3LoVD/JXyXGKwzn1mtukfWmJxObQt2SxhVM6qlaLx0VxqiUsTLERFg9HJXhTri
         DYTBv43qewNilSdydRsXYnwYiOmZMMGaO9JAKZuhpxnGh4ti11HH/e+CNo8ldtryFifr
         KCfw==
X-Gm-Message-State: AOJu0YxxU1mzehwARF7iiLL9vF0EtVCGZqEDkvNqp0XgJ2P3PclZwDg0
	fFbVhUIV3NFjh8w5zK8mYNjRLStj64MCca2nNaMYBSrJ8n1f2tEZio/7ihwuP2OJb67vJkbQv+F
	BXKQ72xX1BqiwroGxcK63KbkkVtU9/S8=
X-Gm-Gg: ATEYQzzbnB3EqlEHYCH60taZWVRhWnXM8rTqpJ4HcZPewmJWddC4bkRbViHnqTIzrW9
	qLXLvhy+q05KCVt5Rh63Zg55540BlUKh1zgun46GlJLSO4OOIWz6jvdXpBFMqAbSeQcw71IszgJ
	YN6JBQBR+Ya36sPMXc/EzQJuoU2rJxpxWc0KJZeVGT4qu/hiGIT15TDY485Oz/S9X5mkH4EX1TM
	HjhXtDajE/pbwGnPXYfvPPsWa6wGXc8vWqZayO2bc+yCsmDTRjd0pcPyRfSrqGWOcko1m6uMMnQ
	6Q4zQw==
X-Received: by 2002:a05:600c:3551:b0:485:40c6:f528 with SMTP id
 5b1f17b1804b1-486f447a463mr20108425e9.30.1773788111575; Tue, 17 Mar 2026
 15:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com> <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
In-Reply-To: <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 15:55:00 -0700
X-Gm-Features: AaiRm53X4kDxN0tmE1mfMIGtV9-MvwmMgLpjBLWEWSipYhbAQryb1k1XK0a3UkQ
Message-ID: <CAJnrk1ZTOUOrcK9PEi+wJC1ZUaVRJ8tumqmRLu5ApH35MMg7SQ@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:08=E2=80=AFPM John <therealgraysky@proton.me> wro=
te:
>
>
> On Monday, March 16th, 2026 at 8:16 PM, Joanne Koong wrote:
>
> > Could you verify if this fixes the issue?:
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 8f8069fb76ba..4cbb22d80acf 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_blo=
ck *sb,
> >                  * Don't bother with new inodes or inodes being freed, =
first
> >                  * kind does not need periodic writeout yet, and for th=
e latter
> >                  * kind writeout is handled by the freer.
> > +                *
> > +                * For sync(2), skip inodes whose mappings have no data
> > +                * integrity guarantees (eg FUSE).
> >                  */
> >                 spin_lock(&inode->i_lock);
> > -               if (inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) {
> > +               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) ||
> > +                   (wbc.for_sync &&
> > mapping_no_data_integrity(inode->i_mapping))) {
> >                         redirty_tail_locked(inode, wb);
> >                         spin_unlock(&inode->i_lock);
> >                         continue;
> >
> > I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
> > AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
> > even with the above patch since afaics, the writeback we wait on could
> > have been from a previous background/periodic writeback run before
> > sync was triggered.
>
> Yes, it does! Amazing!
>
> I applied it to 6.19.8, upon rebooting and following the steps I outlined=
 above I was able suspend and wake up three consecutive times.

Thank you for testing this.

>
> Is this something you plan to submit/backport to the stable kernels serie=
s?

Definitely. I will submit this patch upstream to the fs mailing list
either today or tomorrow and cc stable@.

Thanks,
Joanne
>
