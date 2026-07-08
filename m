Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D764442100
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519316; cv=pass; b=koKR0QmOnbgVATUMe06+TGmhwtQKu8e/ypVHjP7bQY5+RQs2fHTiw/Od+YJuVau5ydw0KzFILL4ZhrSwpfL08yYhFWs3/Vb44fw3pcAn1r7y94GD05a4OKO0ZB71pYo52iw3Ur7klWy8D4tbW0zSv0SzeSFpDwuPSO5pWGqwpA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519316; c=relaxed/simple;
	bh=+K/PolHf20ghWCB0E8aQv5OnAwl4AIEKdX7utssQh+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA6IoOvgcZUe1o/QnaMVhBZfAjGDYmgjdaR8iErZ7RXwMUhWY7hK5kvi75HJNxkZKO9GKgEfnU6CP4Rxp6GWTS4CRjzhSDO0HaX38nt8qnX6SVFzkYM3Vowy97N98yDVAJnHUY5MVznNjv129UR0c2XP2obvi9/9JM0VYiu/LFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FE2vSemL; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FE2vSemL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e85499ffbso45070885a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 07:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519312; cv=none;
        d=google.com; s=arc-20260327;
        b=gOBYIrGw1ZrFMz7jGHk/iY7Yb/6B6lOfkCv0PD72w18vozDXOCgip28DWFg4SqBXx6
         7CsrcaaHf9K0S31xtU721SXCh2O67iFK6SV2fqT9KhFtjShFccwOvahg5NbrZiaD6iyP
         2tntT0FILZVmdb7vXgtC7S0+YVvzS+zdIeXEthABNnmtI7pkbHk3gB/py3pF4K5UE8b1
         f7fTCb3TqQ5QiUTihMHwRSAT3RS+ZRgiPlBxq89jeMqEaquBflKYPxJmZzSws/98AdSh
         mOioVJ5xSj2OH+e2lt5D8AHVSZmcSOEGWgpAXkYaeTmsn+ggPJ+IJ0qqKO8zCN9VY+DB
         6CWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        fh=w7zA2SrifkQdTUTB1dPmUS92YwYn8rmmFi30P/iSfGE=;
        b=IiJqidB7VvoSK7O4bGmTll04D+6DSZY2RNVx4C74g0LpXH0GEPa/NqyoS7JkgaypRI
         MV/P1inZch0Hmet8RF1jGDCBojqPoAZH8TrXDXeOimpsJqfRmayeKd8s60dOBsph6vny
         efoWlJn7InTDnrhb7DzcyJcIqs3flaVI8RGFJKRGYasV95cJ6INkEYc/ITVvCOvzwyuN
         7q/b1lyriuXitvtDvOZh7BT5JeK2Iln6L8oj4qAdwtN1Iq9VieesxvWzpWMHxslBtmWI
         ZI4XLLtQaDj2qe4DtFihDw5bDCODeKxmVEnl5wHllUyS6EqHjPUQZIgJ+4yYBSPgucUq
         sSNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783519312; x=1784124112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        b=FE2vSemLBR4DA2u3DKo6sacRgKuvHvkma6XfKcwJXzklAe1ek9iqdilGqwArjhLmO6
         NfUwhi9buKzf3KcIXJNhaoIipQ/Q//VznO1yHOG2GwWTkpoB1vXxN33U8GwStJMknial
         GV5fNfjwGNotd8h14zqhvEISgWggwevQHua/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519312; x=1784124112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        b=dxsQ3hV9W0iFB5qt16V1+NxSzlULHxHZHLu2087jQYH1ldUzp6F0TjfhEqw4Lu82mS
         cYDClWyxn55mWAGUIC1qcUH9aggQxvn7f4gPxQUJaEewBfwNBxqLXOVMhM/4wE7Fy7jT
         GsWRhla1Fq7PHR3zkkviywCwT6aG1yyaDgDmPlAvAx6LJodypQEzrUghpL08xNBWOniQ
         H+UpWaojFTEb79M9T2rFTpw1FN3p0b4f07CggkxiUeTxfeanMJf9/vcqsGo9CAfba1BE
         4SoIIwK9Odxcn0l2anHaVequbh3rjDz3dHV5UgTUJK4lWNyoa06wOqeKom1aBebQ4xqW
         2Ryw==
X-Forwarded-Encrypted: i=1; AHgh+RpuLVtL3yhrBRcTGSK61DohC/ziACZhPKzzgQ+6T/b52kXXym6f0WUo7sWA9uKqGanaaEo4OJ6+DZG8lPSH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCOyR8JCQLYJBNAdN4rBOSKzKSmWwBspi0L+txgejFTWZfpml
	fyG80A3q6y7bf8y/TwNxfXO+yfNixHuSSwuvbg4BymtfoE27q/HnhLgUOCaE/o9FYci4WnlFO58
	gK11ZdUp1dYoM8aaaizJLLtKLyCZsub2t4c0iZ3gv4Q==
X-Gm-Gg: AfdE7ckO+c3jsoW0HzOBLX8ssIrpvToA0rwLnRY6aYWXuBsDn+f2/9yvSbJdaS6cL0L
	lhSFzDkJUhB/kzFgb3DSHtdh7nuAYNVjy3aP0MjJWj7/O6xCmalJi4OSvzGTB3ShWNcttpdNBjF
	VNSv/ndG7633zmY3c3l8jD4g8pXBqTtODe1AUA1oXh1qV/OQ7AA1TBw1kc+4zM6TjTU3wLHsjF5
	fYaRWJ07KoAbS/guVlVSa7NWPpu45mYBx9CYXQgDYJf6P2W0KLRZBNAxaS52vQK1E9YIB7D86Kp
	fz7L/akKc+EBn60inOO38vkwun46q4bHEzCYUA==
X-Received: by 2002:a05:622a:134d:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-51c8b3993eamr26471751cf.3.1783519312028; Wed, 08 Jul 2026
 07:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
 <871pdd8ukx.fsf@redhat.com>
In-Reply-To: <871pdd8ukx.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 16:01:38 +0200
X-Gm-Features: AVVi8CcKoJxcOuex25eFuQjNrcac3g1KeS0qxI4UBoIPpSpnnYXfivqBUUnrS0I
Message-ID: <CAJfpegvtd--TEQP9CVjSZuosU4meELdzhTV9oFo6joR1f4Dpgw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2026 at 15:44, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Wed, Jul 8, 2026 at 2:31=E2=80=AFPM Giuseppe Scrivano <gscrivan@redh=
at.com> wrote:
> >>
> >> Miklos Szeredi <miklos@szeredi.hu> writes:
> >>
> >> > On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com>=
 wrote:
> >> >>
> >> >> Add two ioctls to overlay filesystem to allow userspace to retrieve
> >> >> information about the overlay layers:
> >> >>
> >> >> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
> >> >>                         arg =3D=3D 0 returns the upper layer (-ENOE=
NT if
> >> >>                         no upper is configured), arg >=3D 1 returns
> >> >>                         lower layers (-ENOENT if index is out of
> >> >>                         range).
> >> >
> >> > We could do this with a plain open() call.  Something like the magic
> >> > symlinks we have under /proc/PID/fd/.   Question is where could thes=
e
> >> > live...
> >>
> >> is there any existing user of such a mechanism?  I don't see any mount
> >> specific info under /proc or /sys.
> >>
> >> >
> >> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
> >> >>                         with numlower, numlowerdata, and has_upper.
> >> >
> >> > Isn't this info obtainable via statmount(2) already?  If not, it
> >> > should be there, instead of a specialized ioctl.
> >>
> >> no that is not exposed by statmount and I don't see any way to export
> >> file system specific data through it.  Do you've anything in mind?
> >>
> >> >> --- a/fs/overlayfs/ovl_entry.h
> >> >> +++ b/fs/overlayfs/ovl_entry.h
> >> >> @@ -35,6 +35,8 @@ struct ovl_layer {
> >> >>         struct vfsmount *mnt;
> >> >>         /* Trap in ovl inode cache */
> >> >>         struct inode *trap;
> >> >> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_L=
AYER */
> >> >> +       struct file *origin;
> >> >
> >> > Don't need to keep the file open: the only info missing is the
> >> > original vfsmount, everything else is already there to reconstruct t=
he
> >> > file.
> >>
> >> I didn't manage to get that to work.  As soon as the userspace process
> >> closes the mount fd that was passed to fsconfig, the anonymous mount
> >> namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.
> >>
> >> So whenever I try to use this mount again from userspace, it is not
> >> usable because the mount namespace is empty, causing check_mnt() to
> >> fail.
> >>
> >> Do you have any suggestions on how to solve this problem?
> >
> > The suggestion was to store origin->f_path->mnt instead of storing orig=
in file,
> > because you only end up using the origin vfsmount.
>
> the reason I am keeping the file and not just the vfsmount is that the
> file is what keeps the mount namespace alive (preventing
> dissolve_on_fput from fire).
>
> Should we export open_detached_copy from fs/namespace.c?  I've not
> tested it, but it might work.  Are there other ways to solve it that I
> am not seeing?

Using an anon namespace sounds good to me, that means the original
vfsmount isn't needed at all.

Not sure if it's okay for the case where the original ns is not anon,
but we can save the vfsmount in that case if it turns out to be a
problem.

Thanks,
Miklos
