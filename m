Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0442DF132
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548071; cv=pass; b=pXmxPJG6TIszGN96AE8/OuuDaLGKI2DJji8vQ5c5cwcbCrV7eUe6ZKs3kzh2UZBN0Wi1ECXqmxqj8rjv3nyi4wkW3jj1hzHoFFjypvB7sCTZ5AI55YQ3BYsUCT9LkvMMbh/pXADsRDa/3SBeTm/fQ9ZFKzVX1BKrqJioM3SCSxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548071; c=relaxed/simple;
	bh=/KxTUJ0g36166zQSCV/qmQPKyEZ1y1khVCsaQ6ngVao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZCR0MXcXMRYV5zUiEHdQfFDuT6Uj50jKE7LlZZnLFne3XMPRTiWSljotSY5m1uqjIuWCAYlqV6hoJfNTO27tzPotRyiYPwRn91xFsIJsFb1c3MeCwzbJEyaEQ76xP7yQErTYlbO6nOg8LdA6+J10Gv11QqQf6VJ8at5kF4R6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5rDhBFO; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5rDhBFO"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1801669f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774548067; cv=none;
        d=google.com; s=arc-20240605;
        b=bqzKlGsvHh0kh201U77nXALeAJTYyMxFqKiS2Rz40hCDE+02dgHKyKANN/z3Wp5Gyf
         ugwhU+xN76Opvpjap+8477GBKHpaSXk9CI555e0rT0rs9QcEziVYCA9T89P4Fa5Ht+f4
         pGtahQXkvI69muRktUMDKqEJIYT0pJHg0WHoMZhva+FngiVNC5ImniTJBTNqBhtWPkGD
         38vW+kpIFXj3ropSTeYWBFui9q8hoSScflUmxJ0O1dvE51fi/ahi0E7Yz6Ejpm9RuX40
         XDcPOTvPGMUu+4jUaaMwTRsMdVSLDAUY/3JAdKzShJcM3SvMIEnY8S2iIkNgeWO6x9mN
         9+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4eez3LEtFsZyFFePUioaf3thtImPyWbs47JZxvFBbg=;
        fh=NYjGDo+3srWTDsIkAYJriyQwakZ5ki82C5GJja+nSQc=;
        b=f9/6cOATRKMdPsQK/pKTLTND+2WL9Enf6aq26lDxDaZd/pdyMdzo1QJmEafcvBUNpF
         sIckABxvQsyj8EfSV7z4JqPRzBVI7E9FJW0x52mqVtC8eXPM5bFwj0K25Jc4FMypYAS+
         xLHWwtVdwkLD8YC5e/TYyrGW5Bq6El7kFyrj5GfB1PbnSQs4sKaOw7f7Epo5ZALXJ1yz
         xzybnSPrugqSnHZ8WGVtpi4w8QZEaxTIRXCvLPH7GkMGwl7GmVcBimtMdnJpxF7gDQbU
         1wT8Y9eqIRcUN2q0JlwLfYy6pxG7v+Rc02COQ4QqXWGKhyrB71baECa3zGASKdkXPanQ
         GW0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548067; x=1775152867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4eez3LEtFsZyFFePUioaf3thtImPyWbs47JZxvFBbg=;
        b=E5rDhBFOZOdCTkj4G/ky/Iwc2B/AIK7IXUsyhkj2Sw+PdXUu3e+HeOYYJ4GCP68MXV
         vwOcrKtKLdJUJzP5E/ZcwFEm0Joxa4uLTxhGmrO+qa+WoleddkP3WCbJEpfDbk3ov70F
         V3AyklzCRIZyxQ/p4yecSAHEBtWWv7+aM7yaFVvkhepyoZXamSywoLt41NoflBeeIQ9M
         yVJ+i3eg9ZFKS52vy1tgqGCOTCNct+h1kOEPIjCZou0ZBA2qKk43pKdh8EmVVPdl6iu1
         ray4iYJn4HBS4ZazujMaJKpsVM1SC5L071VHPAPK6rzGDPrfs35DnseG3Se6SywiXFGJ
         nf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548067; x=1775152867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4eez3LEtFsZyFFePUioaf3thtImPyWbs47JZxvFBbg=;
        b=Gm+D+qvda0i9QaHovToi9tDFiBliYSf9K65NqRZF8udhYomQYqthbWP1quQKlNLkm4
         vd4ECq5IiVr/kqZtXWogwprMz9Vzan8/YYj5gwoeohPOdFO5WOdz2v8qhk8R268WDNx7
         nhjcjzH7o65wXR8h3j9KceJ7gy/rPbasc8FQY1ctbaeuw3/4aiyvQuO+EzCF8wRLKd8v
         GHetAw5fLJZXCL+P+Y35B017K9N52a+/h1oceM2js4FEQMEnp9aGVMq6eXyQlqMQ9Pp5
         pjz19QDj2SZmGNmSHgJsRGUgcIdTYL/wrs+uH+y3WuoShap8Y0EEEbfqh5JUUmaYnb+c
         FyVg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ47l85ygvXb6JzpboNqCQttRIFnFXq/wfBv4LJHErQr/zFZfyhwS1BA7IIRPZbJzxRaxa6E/0VeObDOYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aX13YjR9UVSquTg4nH2oDHJ9MN2CajuCQeD7BG0HZ3PyIwCl
	APG4kpVKGI3S9KIAUmr48h/Q0PsGuJcxlakxsYotc/2KtyWGJgYFvlO4jONWC/tTm5Ga1Y0Xfom
	wrfUAVeF3Nf5QNKJ5bNXDjP0t/izQ0LQ=
X-Gm-Gg: ATEYQzyr0lO2g+13pShXGgW8et8bhln6omlwyhq5sA2i0Uzwy/nhm+OitEnW+Hf7OA1
	h5qUlgkKZVUjCJJZet/j/zm984lfV/s7wNSdVawzETEKarcJWC57vJZEzBpwdDDtB9BF3VLWnXf
	qvNOgCUutxkvX1rtQMr3mmCoSaQ6wzMm7pKlFxaKPqV7+ZuBB32qp0+mmEZteVhhu04rZ6Lv8l0
	5vW9NYVLMWS3VHjKB7ZvJ6R/lzYuocEBTAv0CJ2zQP5v/6ERqKA8cWKpKEnHA2TI5I3BQBZu/w+
	Xg0kCZcX9/3UGakP
X-Received: by 2002:a05:6000:1787:b0:43b:4312:2cbb with SMTP id
 ffacd0b85a97d-43b97a264dbmr4986808f8f.17.1774548066635; Thu, 26 Mar 2026
 11:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com> <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com> <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora> <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
 <acVxb0TSSUgHsK5T@fedora>
In-Reply-To: <acVxb0TSSUgHsK5T@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 11:00:54 -0700
X-Gm-Features: AQROBzCJl2bROwheCxKnNOPi_4bE7mucLIGsiNw5V9hb6QfDyP9C_s4IRubcIs0
Message-ID: <CAJnrk1ax2bK-FQXDEc=OGvYS7YvCvL3YsKWv1gmzwkS_QSz+fw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:54=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
> > On Thu, Mar 26, 2026 at 8:48=E2=80=AFAM Horst Birthelmer <horst@birthel=
mer.de> wrote:
> > >
> > > On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> > > > On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wr=
ote:
> > > > >
> > > > >
> > > > >
> > > > > On 3/26/26 15:26, Christian Brauner wrote:
> > > > > > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> > > > > >>
> > > > > >>
> > > > > >> On 3/18/26 14:43, Horst Birthelmer wrote:
> > > > > >>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> > > >
> > > > > >>>     fi->attr_version =3D atomic64_inc_return(&fc->attr_versio=
n);
> > > > > >>> +   wake_up_all(&fc->attr_version_waitq);
> > > > > >>>     fi->i_time =3D attr_valid;
> > > > >
> > > > >
> > > > > While I'm looking at this again, wouldn't it make sense to make t=
his
> > > > > conditional? Because we wake this queue on every attr change for =
every
> > > > > inode. And the conditional in fuse_iget() based on I_NEW?
> > > >
> > > > Right, should only wake if fi->attr_version old value was zero.
> > > >
> > > > BTW I have a hunch that there are better solutions, but it's simple
> > > > enough as a stopgap measure.
> > >
> > > OK, I'll send a new version.
> > >
> > > Just out of curiosity, what would be a better solution?
> >
> > I'm probably missing something here but why can't we just call the
> >
> >         fi =3D get_fuse_inode(inode);
> >         spin_lock(&fi->lock);
> >         fi->nlookup++;
> >         spin_unlock(&fi->lock);
> >         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_ve=
rsion,
> >                                  evict_ctr);
> >
> > logic before releasing the inode lock (the unlock_new_inode() call) in
> > fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
> > fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
> > after the attributes initialization has finished.
> >
> > As I understand it, fuse_change_attributes_i() would be pretty
> > straightforward / fast for I_NEW inodes, as it doesn't send any
> > synchronous requests and for the I_NEW case the
> > invalidate_inode_pages2() and truncate_pagecache() calls would get
> > skipped. (truncate_pagecache() getting skipped because inode->i_size
> > is already attr->size from fuse_init_inode(), so "oldsize !=3D
> > attr->size" is never true; and invalidate_inode_pages2() getting
> > skipped because "oldsize !=3D attr->size" is never true and "if
> > (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
> > fuse_init_inode() initialized the inode's mtime to attr->mtime).
>
> You understand the pretty well, I think.
> The problem I have there is that fuse_change_attributes_i() takes
> its own lock.
> That would be a pretty big operation to split that function.

I believe fuse_change_attribtues_i() takes the fi lock, not the inode
lock, so this should be fine.

Thanks,
Joanne
>
> Is that required for this small (as Miklos put it, rare) case?
>
> If you guys want me to do that, I will.
>
> Thanks,
> Horst
