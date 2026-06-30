Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71A40F8CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824720; cv=pass; b=hfpJYr9B5OQHkYVg4n6IFTPTX8vrbIrxLp068wnE2+m4vXs8leIhOU9jEqwrOpnFpGMu8EhIQqORQW+X0dAKoFJKaVqlsB/wIIMSZbNvF/LiNkQ0bwaF4Fps1oMPjxOE4r+xOqssg0Nbowps0+TSGjQYx4sc3LPWtooXKQXbvI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824720; c=relaxed/simple;
	bh=cdnAl6CG8FnZAr32hCJ2oizWU5LnzFU7Jb2iVak9W2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7D+SW4VBLqwV09I6eU4EY6Hw6QJN4NG3e88SS65JFTVNcjcPCsbY/uwaipzdrfqMt7sGXMhNMGy9NBcHd4YD6+dPLoeL1bCld4v2T6BRGOv4lq4yAOHwPH1gsiUob2Bv5eGPoTUh0yZ/VgN2PHN2gb/nE5nZIbCKJrEFeJ+3R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICh45lAz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAFwh+rZ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICh45lAz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAFwh+rZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l++p880DQj6sJ5IzdCMvCKObAiXKLcBFNZo32Fuyh1M=;
	b=ICh45lAz58FXtOUg4WDvcl//gS0IT3SPL/1Sg9ag1caXHw9iyVDhkUoFOrByZdir19l14T
	Uf5NpFaLWX5oVyCJTI9BWwlmfwbvJ8EPFYfNson398Ceqjomd46CB2Jp92JXvPZfkiRdFE
	MuoQmZWkBPDUiy74k7SUVvsZDAqP8WY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-BxDvkhQzMhKSBGo8KmJMlg-1; Tue, 30 Jun 2026 09:05:16 -0400
X-MC-Unique: BxDvkhQzMhKSBGo8KmJMlg-1
X-Mimecast-MFC-AGG-ID: BxDvkhQzMhKSBGo8KmJMlg_1782824715
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-664caf6c3bfso4332901d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 06:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782824715; cv=none;
        d=google.com; s=arc-20260327;
        b=LflGfQHK7dnyCbY3RZBc6MiJ0rhOLiTG1FNS5VSJAcMfg/0BW6fsrN7c+1HL1CMSus
         Ib27K8eco/lCZzJ8hZxH65cTJzH0dJk4a9wBrHLYF/5jwLOYGV5YuobBbUWBl+7Gwppw
         4MJjcZaMC0wm+hh+xUCwcdCAWjn5YwVMcRo/xVNnrbOiKl6JI5n646i8VZX4GADcMsEJ
         4Nlt7M652THBPsgFWPpinZEeC5sX2uu9mtk4VGuO5IXxAD+3yRBV3hlHeO+GSbvJbZ9w
         LQWFibvWYG0TSfvTqcWeW+dVa4ZYBqU4ny4Qd2bH7q1PY6Rq0uvhWWM260Ru4ysIcsbS
         j8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l++p880DQj6sJ5IzdCMvCKObAiXKLcBFNZo32Fuyh1M=;
        fh=cpmLVpkzZjywKp6+FU/Y7evIxbs+dO0P2wib6+r+M8c=;
        b=ZUb6WhVs0/trdC4csoK0eU2tHx113Skp0rDxSmDGJvsdpGw2fPCciZM3qFvLsn1F6K
         MrVYdIqJc1r61yxoFYdgFzlV7MAN9g25qehZjNW2+MGN3K6jz9QcoXJ9FqtrPPuWtXjM
         /5BvX0KZpLaN6EF61ChRPkJBjYyQMtdblWY+wlMaaN7TkJrCogfdnWm7HoIw/a03+X05
         +QcwLF3O7ED1bAx5SmAFyJeHkXODWI7nSqGgB13BAWPb7cL4cen2zqjRsmDWyR7+Zpx7
         +Hmndut+wDOtLBglLojco8e+T8LDwu5ouIx4qrA87y5x9NlHJfUyrRUtJM33rcjjJfgk
         RpRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782824715; x=1783429515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l++p880DQj6sJ5IzdCMvCKObAiXKLcBFNZo32Fuyh1M=;
        b=ZAFwh+rZHbygTkljGgGd9i1fG0jcYpreO9AVNHLXNMJAwUNJhAlx764yIorO2ge/A/
         uebnAOyDgbvvf4FBJ+gWo0qwewHQvjgy1i4V6goSYbdy7PZKKPP6W8VHmvseN+RRn8kJ
         k/JcC0h63BeRkibKlH+O58kaLFzy/oyCb/ISeShp9dT7U1Aqe0fBCTV0YLPwH1UluLvZ
         Y24YgtX5oCUO1Vvl+cUcEIpdp6jZmHiRHpa9XtC5NGaS7p3LIa6qXBW/PGeTuj0PMlfL
         59u4b/RISH1CyO9L2wY5zcZVi3aBirUOcXWYshI+nCeY8zE42Vwkc4I6+xl4uMnsyrxL
         aCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824715; x=1783429515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l++p880DQj6sJ5IzdCMvCKObAiXKLcBFNZo32Fuyh1M=;
        b=HTWREjrjVm+MPvoskg6sCbZ6LkSXfiVCWWpptB92hHZS93hlr0aIIjb0ikLyy3VytQ
         0Hd0H54bPwROfW+VTCHdY0BlMZUy/vK2lFXFZgEs7yA5C91fn3L1GrEg2f1QYQWAablt
         ZTIy7S8fNSSH5sjKfuEL4I4jpxdo6UQMwlQ8v8InJcq1iuycJGzwv5RBSYnLv3WOlXWb
         /FxPNSzgmUMtn5Ii+Jx9UyoAVHR+Hl57AYF6XRT3y4arrhGI6haYk2LTzWCo4+bD7EfS
         dLBadD+nKSWWC5nz2TUACEAV/5x1UIc7WRQFds9vLtjdBoALLpl97nms/OLHMNARpDWY
         NnQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHCCe/IPbPd0FmQHMpLPlGqArILP/6/HYWf2D8XSqSZPZktPdAhvH3ozWyxGtfGqQhr55xzFz7PIT3IzPo@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxFiBS2tQOM1WZ+izYN7AP44rxV3Ztcp4rkYiK028OrbE0wR1
	6uvXvn7+AmgVGhOoVzqudVXAOQJcXJf4H1q8KZqVLMiKTZOO3RnrnZfCjGka4GaY78Xev7SHW6t
	A3uJifP7ZinizGOULoJT4+bT7wuEQMu/pWkVaPFv3F6rfKHuxwTAHrsHOyEq2zDXbCbcLGa/gr6
	wMe2W+KU1yxzFyRkG+W8CvVSaWmcWqtOXcT/z8JbrTjg==
X-Gm-Gg: AfdE7ckG1ZUs8CfWPMBq0/Aa8aru1g2vPmxvWGsk/o+GXpXNZ8F8qwsNKYfOlz8xsOV
	n/vQlN0O+JT1rxaav7dOfMzP6ZVGDygZe5T4h8Yv4EYl9TXIoQtJmq9L7A3SNCLS1sLPsRzBqly
	iW8WCFWaUN3M0DN7DySjbDi9ejb5+Rw9HVnTWpIWx75aoUh3ecR9noeLzEU91hWCft6L95ePSgL
	WeNbovv36obyBtMGWT8CH9LxviLJzyek+qa7FrNEaNywpjUENOhPKA=
X-Received: by 2002:a05:690e:4894:20b0:65c:513f:5a43 with SMTP id 956f58d0204a3-664f96f5b03mr2420023d50.22.1782824715343;
        Tue, 30 Jun 2026 06:05:15 -0700 (PDT)
X-Received: by 2002:a05:690e:4894:20b0:65c:513f:5a43 with SMTP id
 956f58d0204a3-664f96f5b03mr2419962d50.22.1782824714516; Tue, 30 Jun 2026
 06:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner>
 <20260607164136.2948550-1-agruenba@redhat.com> <20260607164136.2948550-2-agruenba@redhat.com>
 <20260630120641.133521-1-agruenba@redhat.com> <20260630-ochsen-neutralisieren-langzeitfolgen-f685027b7f3c@brauner>
In-Reply-To: <20260630-ochsen-neutralisieren-langzeitfolgen-f685027b7f3c@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 30 Jun 2026 15:05:03 +0200
X-Gm-Features: AVVi8CfGCaeQQi_vHUiYdYA_nQpCMy73WP_9y2dEycWo2s7vl-egeOoD-7Vw8PA
Message-ID: <CAHc6FU4E8t1wXg4MFhi4W=+fBMsrHXQeXQ1B+W3ELiLxRdErJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On 2026-06-30 14:06 +0200, Andreas Gruenbacher wrote:
> > On Tue, Jun 30, 2026 at 11:12=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > > Right now, the setxattrat(), getxattrat(), listxattrat(), and remov=
exattrat()
> > > > system calls fail with -EBADF when dfd is an O_PATH file descriptor=
, pathname
> > > > is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags =
is set.
> > > > (Regular non-O_PATH file descriptors are accepted.)  This is incons=
istent with
> > > > the behavior of system calls like fstatat() and fchmodat() which do=
 accept
> > > > those file descriptors.
> > > >
> > > > The same operations can also be carried out indirectly by using
> > > > "/proc/self/fd/<dfd>" as the pathname, but that is only more cumber=
some, and
> > > > for no good reason.  Fix that by changing the xattrat() system call=
s to accept
> > > > these file descriptors directly.
> > > >
> > > > We stick with the existing practice of leaving the behavior of the =
fsetxattr(),
> > > > fgetxattr(), flistxattr(), and fremovexattr() system calls unchange=
d: those
> > > > will still reject O_PATH file descriptors.
> > > >
> > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > >
> > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > index d58979115200..4737554df5fa 100644
> > > > --- a/fs/xattr.c
> > > > +++ b/fs/xattr.c
> > > > @@ -700,7 +700,8 @@ int filename_setxattr(int dfd, struct filename =
*filename,
> > > >
> > > >  static int path_setxattrat(int dfd, const char __user *pathname,
> > > >                          unsigned int at_flags, const char __user *=
name,
> > > > -                        const void __user *value, size_t size, int=
 flags)
> > > > +                        const void __user *value, size_t size, int=
 flags,
> > > > +                        fmode_t mask)
> > > >  {
> > > >       struct xattr_name kname;
> > > >       struct kernel_xattr_ctx ctx =3D {
> > > > @@ -725,7 +726,7 @@ static int path_setxattrat(int dfd, const char =
__user *pathname,
> > > >
> > > >       CLASS(filename_maybe_null, filename)(pathname, at_flags);
> > > >       if (!filename && dfd >=3D 0) {
> > > > -             CLASS(fd, f)(dfd);
> > > > +             CLASS(fd_except, f)(dfd, mask);
> > >
> > > So I can live with the O_PATH change, I guess...
> > > but I really dislike fd_except. The code should never bother to pass
> > > FMODE_PATH directly which is just rather ugly and we've taken pain to
> > > make it work without passing it.
> > >
> > > I also don't yet understand why this would be necessary at all.
> >
> > So we've got some system calls that should accept O_PATH file descripto=
rs
> > ({get,set,list,remove}xattrat), and others that should not
> > (f{get,set,list,remove}xattr).
>
> I'm very confused why the f*at() variants are supposed to accept O_PATH
> but the f*() aren't? What's the point?

Oh, I see. To keep things consistent with fchmod() and fchown() vs.
fchmodat() and fchownat(): the former two also don't accept O_PATH
file descriptors, while the latter two do.

> glibc has in multiple cases used the f*at() variant to implement the f*()=
 variant.

Yes, but not the other way around, and keeping the behaviour of the
existing f*() calls unchanged seems to be the key idea here. The *at()
variants require the AT_EMPTY_PATH flag to be set when operating
directly on a file descriptor, so it can't happen by accident.

Thanks,
Andreas

