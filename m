Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3C3939A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897760; cv=pass; b=YyEcn+tqBzJzt2MFeg+UGyIROS21c5u0Bw1C2yX3BWL/CErND0OeAhZFREV8lJ0f4c3A3BqC9gGVsDHxt3vfakCcWTNGAMvesxTEZ9rwHwuQVfyeTpzzNLFibNFAJc0RevBzX0qqCop5hYybHAKhXa7uGcqRMH0LZGAbgcrwc8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897760; c=relaxed/simple;
	bh=AHt0+86vpId0YnypIvt+8kocwI6bTxlsvlDW/zwRB5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eENRfpbxWwNoJCHDfaPR+UBkCO/xhpiKas5984ZRm7WoinmynBBGMVuRe/7qTAg+VhwK/1j7HtNZfbR3JhZFgrgGEo6HqCyJZwY+SJ7opaEGfttGsc1zI4tXENPhuroR9geb/X+YLtszHQLOOgfux2/n5r8QIAaEEjIK5GaRtgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6AweTLN; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6AweTLN"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa4a628ab0so1083568e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779897756; cv=none;
        d=google.com; s=arc-20240605;
        b=EvxiRbRAvLop0UZFclFwChX4h08T8arBQ9AQ6hP1Q3wTfUrQHX0u4VI9ktkyvTmun3
         X5bNEilHkJoABaDExDLYKTO583OSyqiy8dszxsFeXh57+Gt2wRhtcKWpvF6DDY1X+Y2w
         GRxDCEKeEojFxtBlmfJxLijy3/9Gj2nVkRxRCR0VEHU2gUl8S+7RWH13JHznr3lE/gcG
         rvOHac0PraZUnNg5rhFzRMz7V3Zx/jz9KH9iUWK8GduqzledRXIeX6Sdv/X8cMwG6Y1w
         mSTB1N1TEUCpA9CiA+5jwOF9zPjqFLxeKyNgveQg/D21x7bRreabR9VEcxhaFZbxGrmm
         pUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        fh=FOW9UhG9OVy5i9wzyzlbMSING+ng2Y5lJqc0BxKmh5k=;
        b=TUxALxGPSJmLJTZ19aH0RC2GVESKmuWJdtVU2t5jadKTkhKayr9W4l6Huw+01uTSsF
         /IjTreZTL3rdmDrl3ZOF+anulen1DIHWLvElrkfJDhhY3nKlECN3648X7EWeOAVeXlCS
         OLsUtanLJFK/WFMxP1wn+LVDxaFoeeRpG5qpAoF0UvoqIMqBpR9W+Ql03cF4/jc/9vSM
         DOAjAR9z99E1gsKYt8ZlLCGLN3ZBNhSeRJHi4viCwj2b40eewWaoRXExyCTQrwNDPRi2
         6itYmDyDCNtxlqITybXVyKg6Kjmpzi2IqUZVg7NRqjhZbKZKzV8n3DU2AGLIey8Kut6f
         kfjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897756; x=1780502556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        b=L6AweTLNHy/Z0BzaB6cRHkDYdErwcaMUEx8sJqTCu6h0qBQaMI0UE7aPhCgR72qWxR
         SZBJ7t2RaoXpz4Fldpeu3WtNvtR9fGkYodPHOCr6ktBnEdknHAi631onR1oC5MFvlZy2
         moajP1VpZItzXpnNDN9Vh/8h3PzgP5amoobLKOr4RvS6L4yacQa55e2mV8a00urNt5nn
         HTjaq768EtXo9tfUIVpinlcto7s/5nLIsy4HiNkmZN86ifJim24oHWq+N95dQY3ntf3J
         Z5ZtSXPJv5DKW3uIy9zRs41yXQqczJ0rvHLa8rUvUrd3+qC9SeiuGsQYj4VxNAhx6cpR
         KzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897756; x=1780502556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        b=iutAtjnp4dkzkD5dg7iasGYA9Dg3kyFa3Swpr+zwPZ0xOiD6xd/FogOytkcrBruGeV
         yE3ywu/c2vbCszlhpejZjTUdeOhbMq1rXgNUdpNMTWlwlTLgPw7+BMfma9EC+13h4efH
         4Yfj+PgIDX+xztQdPDSfQVdx3B3xxgRZsfCPHkf/f+CEfihr6ANeRCnH0OkeDZ/Li6on
         psmf9DvwPBUb1NxBauDyFb51WHmPOaepig8iNF/liPnKdNukl8kLrUjQOZgk8wNfrfyB
         39NWDMASjQRYocoZ7qi2974uJ9p0cdNFeAE+CdEbvXlIbeiG01K6Taz2xIwUFob1yIbt
         oL5w==
X-Forwarded-Encrypted: i=1; AFNElJ/ISDxtVod6vQuUHDDaualwV5MXCAsHGgJcoqvwUyRvMeUOWymx3ckdhSzRtxOdujIuLscyAmzPr7dcKr48@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBYOUqz8sZMGR89DSIMBcf1+EkbEvDS0R5voclhTkaiDeUbVG
	QwSoU+6DH6B7dCTh1lMUvwbB7DI9qskyl/sj5NgPMNQXSBdgZCJc1UrAraqM2GlY8Ody2TaC+Y6
	tJGlXnDVEOZ75WvUbLiNu2Q5OFfFK0nI=
X-Gm-Gg: Acq92OEEwAJFNtnH8p4xBxK2WeQ9Gy0x7JleIY1sPdny0DjYX4F2UTVbrlWcHczTinx
	NiCD10jF88LI/YdnzWgNkwCi0a0qs5ituMDeuzoVZ2hD3y3zTwneE6BCSqk7rb2rHBqANqVnHXv
	oKEhD/aCPVVh5Qpo/gDM2qFBgvBglRa0SnzxmqrF2S0VyPYA0lHTII2MulQ+gmjMytfLo/c16Nj
	aUuniStlNOmGHov6olUWxTj3rVD8anvm9GKnrefjGbFvilPGx9Xd6vOOas9e7KYdPrHjvkQl1MU
	JhTixu/2
X-Received: by 2002:a05:6512:1082:b0:5a8:96cf:c8c4 with SMTP id
 2adb3069b0e04-5aa3232a140mr8148267e87.15.1779897755653; Wed, 27 May 2026
 09:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org> <20260523-b4-fs-v1-4-275e36a83f0e@kernel.org>
 <1bb537f6dc36b00788b613fb8f71579478418457.camel@redhat.com>
In-Reply-To: <1bb537f6dc36b00788b613fb8f71579478418457.camel@redhat.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 28 May 2026 01:02:19 +0900
X-Gm-Features: AVHnY4KetSSI45sZ2YEgAEZTRsUQAA2DaTD5AcJyh7fDYB4FmiHhDhxOxGAj9DM
Message-ID: <CAKFNMokr_mk8xhMQ7u8RGRd1XPQSSd_uVKXR=-ui5Zjk8AhfTw@mail.gmail.com>
Subject: Re: [PATCH 04/17] nilfs2: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:07=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Sat, 2026-05-23 at 20:54 +0300, Mike Rapoport (Microsoft) wrote:
> > nilfs_ioctl_wrap_copy() allocates a temporary buffer with
> > get_zeroed_page().
> >
> > kzalloc() is a better API for such use and it also provides better
> > scalability and more debugging possibilities.
> >
> > Replace use of get_zeroed_page() with kzalloc().
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  fs/nilfs2/ioctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> > index e0a606643e87..b73f2c5d10f0 100644
> > --- a/fs/nilfs2/ioctl.c
> > +++ b/fs/nilfs2/ioctl.c
> > @@ -69,7 +69,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *ni=
lfs,
> >       if (argv->v_index > ~(__u64)0 - argv->v_nmembs)
> >               return -EINVAL;
> >
> > -     buf =3D (void *)get_zeroed_page(GFP_NOFS);
> > +     buf =3D kzalloc(PAGE_SIZE, GFP_NOFS);
> >       if (unlikely(!buf))
> >               return -ENOMEM;
> >       maxmembs =3D PAGE_SIZE / argv->v_size;
> > @@ -107,7 +107,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *=
nilfs,
> >       }
> >       argv->v_nmembs =3D total;
> >
> > -     free_pages((unsigned long)buf, 0);
> > +     kfree(buf);
> >       return ret;
> >  }
> >
>
> Makes sense to me.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

This conversion looks reasonable and won't affect the behavior of the
ioctls that use the modified function.

Thanks,
Ryusuke Konishi
