Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B23DA7C8
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021764; cv=pass; b=Qr4jB92+Gs62PxJ/i3QusJwseBmuX+M3mHCRAZ+771XF87b5ol540vKGJa3yCXkRZmfU0jCUt24/m3b1p0fpkLHl+Z327785KgfKG6ClN6wFJKrnK6ElL4+NiP/EGDCibXE3Doq7NMsohdEVR2ap+KdpyHkyPT53ZnsKmni42qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021764; c=relaxed/simple;
	bh=gVZFIq7E6DUEA7UcHTTV0g77Ncrm6ajPHymyOnK3Cyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u94WwTtvb+o3n8NpNyan1yiJUyIlOuYsHLbVSkvrQqy+KUr7pjuf88X816iu6hiASdFA41NZ4ZDQjtlH052deLjJZ2qDg/qWODDhqpYrnrBIZBDwproCby9i1Aw2QHmqiwdgR9nxS88YYga9aJ8Od6UdDg04NbyjSWmZZIH3cKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTetC3FY; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTetC3FY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c253425b253so328567466b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 09:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788021761; cv=none;
        d=google.com; s=arc-20260327;
        b=VNhgTb6FS3RF49jDmn/Gnd+RPQTQ8KGDH44btvxzJc6gEm54iHMe2mlhP4B/yTgIgx
         W/jG9M5J5FH7qRnwJPf0MJBaD0aJBpbeSE7v4GNqLyGCPMCghBkcPqMNRAxUcCmpG67m
         NNpGNqI16vBmFRxIpUkniU01cquyz9zM0rCmiARhthNvhV8U8SkKmf4xC6eGyVCiWcY1
         VTklHlmg5xPlZktplT16UZaNSMjuduFp/2VO0ZklxJRHHiyEiE28RuuolCzgX6ZO2DVj
         HGk8ldv5z5lejVhkwzHURT4FOmNquqPD5KEmEs21fIORDYRzOinAOlPtYkzX5+Hjs6iI
         E6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        fh=oDZoPwoTZ8yv3Hdisx2E4QaZcpnMntfyVjd/Q1ZshTo=;
        b=raACB3QqBALONp3VJfp9LNgHG7iDj0FEgEwl0VSgT8LtimMjqdJDfEz9KljNcn25S7
         g2TZYQhmMrWQlisKzAZE3kGqdT1u4kmr+Ch5kOkZmfXXmmkwWmv3arNS5EkylT58D18K
         E6nALuU8dKD1ZB+zFOeb6eHMDCPvegW4e3YSxiBFr6/VAAg9EA3ucTQxnVV+KgizfoN1
         3EFiC9YOQ9EM5Wrk3IN5fX1vjKcgYgqAd7BgoGUq7AjewiQlE5CIq4SDx9mDdYoybOv0
         ki0vmBM4f38LMliMH9XGr/mijHUVsXKIJf/iYy6aLuhcfXMovfegyCfCvxxDYm/eCkT5
         PpTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021761; x=1788626561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=OTetC3FY9YR2dT91pmq0tWTCBVQw98A+ro76zO0jrdRuA8IZtsnSh7UkqJxyoJsput
         QYkwqUcp//atCTeq9nNabFfVtR3cltA4BnJlSN/uar5m/kgT+3MEs42eO0e02wospduc
         rd7a0zJaN5uoUP6GJRavB4PZ8F3hyZZHH4PEbtX9YmOgSbCfGFN/PElptV+PHQz0J9vf
         Bkx0xSdvVwNswH+ipIw1CNfsIk4PAx0dQAqh41NWWhrjuJmVCLhS+IToYESJMrG28Xbz
         dtUzdafCWjb87kTs+7MK86BNNaSyY3rkhvgNFqCPfd9b+Pbk5DgfsG4pW4torbn/l2sa
         A84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021761; x=1788626561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=WSbDlhLLlSYHTe/XT3mGyEOgSMCsZEktBwBi/MSSsIluiCrrnH2paAQmEdFn4QpXn4
         WrvptnKqx4GJIV4Ppr9iSuGsWwwe7AoJ7vDuh/UUJC1mUb5Xd5SRiOpqrCSskPB8bj+9
         42whb4AdtOyX3jF+MYadQjK8LJAGdfe0oFLiENIcOhUv85OYeBsEkBMyLsJ8P62Yuih4
         TyVXNv4fZkOmOPJhGpR8V5pyoJ8+seomszLzdc36IdNlMBuaw6+zp6uI/4OYdnCZLdDn
         1dB6MhOQs9lVWouEIY4wfSDMI8m+JvKK1oagR4dAJT9kVpH7oCJ54aYyHtgCL2Xk02mN
         VRbg==
X-Forwarded-Encrypted: i=1; AHgh+RoKFmDu2hpHUoAYdHImop9yn7ockkAVcIcLB71MH9q3G+RjRdQoBuQdV19yMU26p+96Wed0o2v3JxdjWMJy@vger.kernel.org
X-Gm-Message-State: AFuF++mqnX+svl31sNnfmVolswcxiO3Ftg06u+L/gHEr2qnl0mqTLB3I
	pCVX0ffPKTF+/NNrKtfvRRj1k8biwlzz/qzxicaGqJWjhTW7GTuHq/apCyaCPyEmEcQk1KgvzRT
	Ov3BPlXlFOee3gQ4hgLT9pZ5QGRdw3PE=
X-Gm-Gg: AR+sD12Eht7HlZ/L5A+0v6Lv0ZoQh3whypOkk2q2CPZEkvgmuC9rEpxS7EiOWKouZPE
	nI5eGP7ucHa2iPJHv1Qad4RcLOuQAZXmnjKBARbLWr9Wyxqs3FCG61j/dxkTEw9208a5EZDfUB7
	nIVlZV93xyHfnUVCZBAVYiRQVotqYd+esowH5Lk8yDOgJXcWuN6OHeuACayt9g+jtbWnBN6fn52
	JIVGLH8LTUxrJINyk/7b0hPQHQXClRphfifVgvkGQqJ83qJA1mV91kqykPdWyIVyau33QaF27CA
	STPrLo3gJ9P5Xwwxa0qd034wX2v8OL69M54N4HzhRqLldQ==
X-Received: by 2002:a17:907:3ccc:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c255741f461mr1048868466b.24.1788021760941; Sat, 29 Aug 2026
 09:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
 <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com> <CAOQ4uxjn3sWjkrV8KbA-V+eno3E4OskTnCznNBex6FOstEbJ-A@mail.gmail.com>
 <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Aug 2026 18:42:28 +0200
X-Gm-Features: AcwNN1VZx95EdI2tjlNCAWiVqqkY5zejH9GYUNhl8FvdsMNeGPTwmtuy5Ph3m7k
Message-ID: <CAOQ4uxioiwVPntt1=QeXXftehoPPb5LFZHuctfJzkNJzrNq9Ng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Paul Moore <paul@paul-moore.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 12:05=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Aug 28, 2026 at 5:05=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > On Thu, Aug 27, 2026 at 9:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> ...
>
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 1ead2eee1944..171b90412ff1 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(stru=
ct file *file)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static inline u32 selinux_file_user_sid(const struct file *file)
> > > > +{
> > > > +     if (unlikely(file->f_mode & FMODE_BACKING))
> > > > +             return selinux_backing_file(file)->uf_sid;
> > > > +     return selinux_file(file)->sid;
> > > > +}
> > >
> > > I'm a little concerned that this only works for one additional level =
of
> > > filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
> > > FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
> > > unreasonable concern that at some point in the future that number wil=
l
> > > increase without proper notification or testing and we will once agai=
n
> > > have a problem.
> > >
> > > At the absolute minimum we should have a BUILD_BUG_ON() for the stack=
ing
> > > depth.  It would be good if we could watch both the overlayfs and vfs
> > > constants, but the overlayfs constant isn't available outside
> > > fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit=
).
> > >
> > >   BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);
> > >
> > > Ideally, the code would be written to keep diving down the stack unti=
l
> > > it hit the true backing file.  No one likes to see recursion, but at =
the
> > > point where this function is called there should already be a reasona=
ble
> > > bound on the stacking depth and the work involved.
> >
> > Unless I am missing something, stack depth should not matter.
> > file_user_path() should hold the user visible path, for all the backing=
 files
> > in all the depths of the backing files stack.
> >
> > This is the issue that was fixed with commit
> > f2381b546e7e6 fs: fix user path of nested backing files
> >
> > This patch makes uf_sid behave the same way and also documents this:
> >
> > struct backing_file_security_struct {
> > -       u32 uf_sid; /* associated user file fsec->sid */
> > +       u32 uf_sid; /* top-level user file fsec->sid */
> >  };
>
> Perhaps I'm not understanding your comment correctly (it's the end of
> a long week), but selinux_backing_file_alloc() and the newly created
> selinux_file_user_sid() functions don't operate on the
> file_user_path() path struct.  In fact the path which is resolved in
> backing_file_open() isn't even passed into the
> security_backing_file_alloc() LSM hook.

Right.
But the file that is passed into the hook has the top-level uf_sid
in selinux_file_user_sid().

>
> Are you trying to explain that the way the backing files are allocated
> in a stacked filesystem, regardless of the number of layers, is that
> they will be allocated from the top down in such a way that the uf_sid
> will trickle down to the bottommost backing file?

Yes, both selinux_file_user_sid() and file_user_path() should follow
the same pattern independently - they always stash the top-most user visibl=
e
path/creds.

Thanks,
Amir.
