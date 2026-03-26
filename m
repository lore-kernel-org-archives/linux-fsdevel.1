Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB288391838
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543396; cv=pass; b=PUvc6E/32wX8axsZGqEnY3zmXgTWD04UA7YSoZQCI43NNYQLOuDzqKKF+x/FD8+GLzHPktX7WoJOLzgH/ODWiyCKIniAwEnV6FNy0PXpD7ENU5iMVrHS/++ozSxpV7PV1Chm11ObfqVQErcIWLWlX7LthVZqo/7Ef97Ev8mBH1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543396; c=relaxed/simple;
	bh=KOkHyUIjy7nttXtLGwegI7u5hwqM+PKZjLv3coihyio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8Vxur378ACxZs7Qr7VIDiiwy4WhTWEY30bFT+oGm0GzN12umptNNfY7tAN1IrKSx2N0NZiwGUor1pUoqP6WqWZBM2L6r2StruV5roI4Ls4LlapHcwcRXOF4jyIONvS7btAX8VtDZpn3H9wzqLl6ToiEuIP3JY41W0qN3Uc/2Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3zMBtMf; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3zMBtMf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so772454f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543393; cv=none;
        d=google.com; s=arc-20240605;
        b=C/ZoWhA3cKzW6/fkrgGzEUEVC1FVhoLJ6zUR2uQsxSkH8c3qXbncNh+rXE1XwvgCIf
         s98oHFkYvuDLCpGBvkxKxI+egdreIT2rtgo2wUHyb6ck4d9VIe5FYk0MaAu1Jtqlv710
         KWwL7XO9dCvS92ItsjufM5YnlPvnArtug3+1XIaKNu+GoBnL5wVTgbnIgKjj9zUvrUgj
         D1f+M60Eda/nghGcK6wVnjPC8NFGx9qVmjaGzWmAQZfvCjLdbHZdzr49rhfTZXYOHQmB
         kG+NJeIvJzvPnyDkQsUFQ28mNlO6wUJWnQ3ESkGFMmqZXAiZEdMTO3PZJUwzHrM4zHiK
         rxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SDddanoEW0aBY4o7DSM8aIIKSGffsl1eQ1flIxBr/4o=;
        fh=CQbatzmPkxVVKgXtpFPSS5Gh3+py1QHAM5ScdpnFNzI=;
        b=SSI6NLtRSGqstUxunC5ab3V6P58K47tsDWHOgFqMgqqW6FpOAcJXH0YwSakckXucJm
         lzxJDl/Uan/DJGUEuHpM+q3vtDV5dXsEczqCgcdvLMBMcotdMn0vuJ9werXGP+xSN7vD
         iurjlAtH+bCFsr8SstcKEBq0/2cb4CMFZbp+GQosFcIYn0IRaUrlQU7RSxA5aaEy3IuW
         XUy5cxEq9VbV0PivnqqecYt6ICJ0sgZjnonYiCRKG0t4OwFP8z66dbAF9Ks69o5ZiQhI
         ieuIyc70lrztxXjn4PQlzhnEbNyeXQ0jJjiNl/QgbDzngnhFbeBoXwnzY6ViWaEjhNOs
         dVYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543393; x=1775148193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDddanoEW0aBY4o7DSM8aIIKSGffsl1eQ1flIxBr/4o=;
        b=k3zMBtMfq9cri3vq9PS3+QtrU5T47D4+6/yJZziJg0GyUqCEAx6I9yNVF55IL5Treg
         eSosDC1BJPYuU4MBS6+0va/xPZI6IrUId0mW1GdOTTDzsrj5pqK22xEJ2xFXvzcr72VP
         GDSpUvv4g/seotGwL0W9JTHtqor9U9yvqRLkzlGu4C6KWs3DyGjgmyPXvlnGK2rXTZ3f
         kKNbZWsigoY9TGrgYqkfeGYHPOMcRKSNEYA4blVTst/37LVGYiqqbz9+VV0gNRSr1uSa
         rQgX5rKW2NXpcKdZJT0TvdFHLKq3rTvB+1aNzILkonQWeO0TtEjht1ALqMga1Jb3SxxI
         5fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543393; x=1775148193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDddanoEW0aBY4o7DSM8aIIKSGffsl1eQ1flIxBr/4o=;
        b=f404uP6R/cW2LLoEiSjrRUUig+IiQmjMI6Jq8Hzc2sbnYFmlKm5Bey6YXm5kU3LDs8
         HgugF0sH/zqsU/SsKtEByGRGUU4gi+z6HoMPYonWjvdKPI3QFLmtZRIHxu6F5r/nQtI+
         ZB3RN6oMB+R0e5y/v0Lp1zz1VoRLxU3Yhohe1H2K/DNU2sPcCt4Cttgc+lrT/ZTqDfnG
         +hP6Hgq7dKwlpXIEXJHZfQvUmsNLOx0wDWPxVCiT+/6oSXd4rFmIVz/uxGMiZLeyyUD7
         CBt5lW2h15y458jbdLmTAT0Vpf3KrzAG4tbc6iZvf7rV2Bgw7j9IoNqupqSVq7z9bYt2
         TX6w==
X-Forwarded-Encrypted: i=1; AJvYcCWCzsEKpj0gEtclq1893MZCc4Orr/T+56jpttAlYxaIQQJirDAolaKTNpBceG0cT0vomhpDAYLG1aCOd7sV@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtqPJK8B5LSjuF7fa1h6/BKbVxBUwSKI1es+x47dSA8y9MzRs
	2WRhsNXlBJf+a0b/djxPr04Nqi4nBZQVqgXvmUgXcLXUXtbExpl1B7gsKrlC2qEoKHBh8J+Mm9d
	wvSiAW+gb3dFR/9eDi441IdR6YrMK6Q9jmXrKGW8=
X-Gm-Gg: ATEYQzwbLyKIDa9ag0/nQ7f2fTrxSsu8v9NWgIfbebR4ghrWHsYdYmlNlkjwUiqY7Rg
	YEuIPWaUO2cg/ZHyZpLz+GmUzhvrGmWJdZssFhPAHI2Zd31fPTtiOWVUjnE+4Ten8cKINxPHQvJ
	jEjjNFO0I91rvr+RbsRm8Rq1Vi9rxkgGA5ixPMaM25j/Rn4pYca0C/Ps1gjkAjuIFJBAJcLf8QQ
	oFTks/GZoXMlncCoiGn9oN1y9lPeJImO2SUIX+vPxFR8XLe7pmCdOjHreeJMYeNKtUrI27ZjNhk
	0eCkbCSIfPSborgJ
X-Received: by 2002:a5d:53c7:0:b0:43b:998d:b60b with SMTP id
 ffacd0b85a97d-43b998db636mr2042494f8f.0.1774543392862; Thu, 26 Mar 2026
 09:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com> <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com> <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora>
In-Reply-To: <acVUeX54PDFfApI2@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 09:43:00 -0700
X-Gm-Features: AQROBzCqTU-_jDeLObsusqY8i8rZ2EPkx_k0ASCL7sCXgkzvaHd_sid7GNbLNbA
Message-ID: <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:48=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> > On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
> > >
> > >
> > >
> > > On 3/26/26 15:26, Christian Brauner wrote:
> > > > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> > > >>
> > > >>
> > > >> On 3/18/26 14:43, Horst Birthelmer wrote:
> > > >>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > > >>>     fi->attr_version =3D atomic64_inc_return(&fc->attr_version);
> > > >>> +   wake_up_all(&fc->attr_version_waitq);
> > > >>>     fi->i_time =3D attr_valid;
> > >
> > >
> > > While I'm looking at this again, wouldn't it make sense to make this
> > > conditional? Because we wake this queue on every attr change for ever=
y
> > > inode. And the conditional in fuse_iget() based on I_NEW?
> >
> > Right, should only wake if fi->attr_version old value was zero.
> >
> > BTW I have a hunch that there are better solutions, but it's simple
> > enough as a stopgap measure.
>
> OK, I'll send a new version.
>
> Just out of curiosity, what would be a better solution?

I'm probably missing something here but why can't we just call the

        fi =3D get_fuse_inode(inode);
        spin_lock(&fi->lock);
        fi->nlookup++;
        spin_unlock(&fi->lock);
        fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_versio=
n,
                                 evict_ctr);

logic before releasing the inode lock (the unlock_new_inode() call) in
fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
after the attributes initialization has finished.

As I understand it, fuse_change_attributes_i() would be pretty
straightforward / fast for I_NEW inodes, as it doesn't send any
synchronous requests and for the I_NEW case the
invalidate_inode_pages2() and truncate_pagecache() calls would get
skipped. (truncate_pagecache() getting skipped because inode->i_size
is already attr->size from fuse_init_inode(), so "oldsize !=3D
attr->size" is never true; and invalidate_inode_pages2() getting
skipped because "oldsize !=3D attr->size" is never true and "if
(!timespec64_equal(&old_mtime, &new_mtime))" is never true because
fuse_init_inode() initialized the inode's mtime to attr->mtime).

Thanks,
Joanne

>
> >
> > Thanks,
> > Miklos
>
> Thanks,
> Horst
>
