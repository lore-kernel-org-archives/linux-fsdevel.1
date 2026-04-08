Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0539EF15
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636531; cv=pass; b=Sv/NraPWJrVJl6XlX7+J1eFFHi0TqN3Fs2L7tNNk24g64vgkKnBaHB6feU9jzWT5D82gWfn8UyFOCyi7rtkK1ljoD8P7m9ug1R4FkD8q2STrY18U3WpcLgGpFv4F9Uo/XUaqpTP2tOxwLfD1bUDGvm55TtUterU0PmWHPIZ6v30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636531; c=relaxed/simple;
	bh=+MxucP+ER8nWtMUIJL4h2ostqs06B2cWbuq/8yb6QWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj2/QGrE9GH9Nwh+B6eARZ0D0tYl60Cp/AXOax8WaEWXo2aNC8smMSzsKX0RQukkHooOjtnr6AgDI8NOSqL4I+r4oxSBxn4pd7U4vn/xEMf4DHjZP5cLztdPR/wdQ6zdtMHFnOKNnsU2dV5J5CLROsDFo7fVo3GpLuxREn20nUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+qWrQmZ; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+qWrQmZ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c01854477so993860766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 01:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775636528; cv=none;
        d=google.com; s=arc-20240605;
        b=itEfeGe+kLSyjGMz4koQCHy1QzaZikBBZWSlVO69Y5QiyIR4oQ8fN7XkjcL+wv+1wZ
         LwO18mx2GsZWlqB5kpW8tdFOFbpCUFaAZyULX7KW/sBqdW4zeKtFiztyAlYz5ET+anew
         cks/MW4fVAm2xzN0b1F8Z7yVVNWG5Nk507ZUpocTcxRPM7zpc4bOWWhQ5qNiMt8A0xOd
         enCov2T51pNJ9Du/+ElBmqpIx+PtSYuBqwS8DVCUp2KWuXAYTsP3l/Gnw/tBXKjv7bxX
         WjicdnsiVriSvCD4mPY0CVlEKNgzEYyQitw+bcZz0hzcs7zEjk0gKWVlEfeqcFExTa4p
         0mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77roRYGnjDC3W/Z+QnJGbM9bAdDYbZDtp3ZOSZTbJ3k=;
        fh=KzdWaJZu16wB1yvIlu7IpzkTKVAfKw9LqKYf6Y6MhKM=;
        b=aLSDDkVdDnoVuJ7v81+geJp7h+a5wu9UOyzTn9vUyj1EelWvnckCQxLAP0J9BmhhzJ
         VvJTqTuaFSyQBTOjf5zzI/oMt09Rb51JvtAXH5soujPRRxcWxC0V60lD9LGO83ZKCAB/
         t5HLpiF0ARH7Eq3jyTunRA6M5YlDXbVhd+P/NsCuaU6/wXo29jMrv2mjR6pvJD3ZX1GG
         XIrKdzkctoO+b/5E4bvwBcT2spEWVlMmnh0naCkp8Iy04sVuR3ytG44knc8md4frHESd
         ZwpNr7IPIqA91LK6HvvIBXFCZim0b/goMpb9dTHOSQRveI4qjh5Ht0LzlgHQXlhcTU5Y
         0O8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775636528; x=1776241328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77roRYGnjDC3W/Z+QnJGbM9bAdDYbZDtp3ZOSZTbJ3k=;
        b=C+qWrQmZ4ydG0UksUTD+UNK0MmTv6TgwM9zo/VwOCS49MhcpdtSmbtsoTuGNe9C/F0
         MCsGE1JNCXEl2D1Fv3vyGaSW/Dv/MM128q9pSMZegwQbbMkwYAwsCDXaUY2mQgMnLDo4
         +e23vIg+3OkhhVkNuUc60FL9CnkCifqfTSnFjOEiquDRR5JZ3AkXhlLxYSZyDj35vRoS
         JYVC6MpuvPAR6nCiNAiF6fXATpDCPqiqFhDIdi/FNTC4PBZPP6r96jU33zYdDyPOodEj
         RK4bKhRarkKPVtoG1JyfLtGZ1m30HgLCZHn2dRRRlQcKKXsqGXzPFGxt0aUswwJHWbU6
         JUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636528; x=1776241328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77roRYGnjDC3W/Z+QnJGbM9bAdDYbZDtp3ZOSZTbJ3k=;
        b=B9XrkEv7O92nZdgnx2C9+y5ry1hK+RzjpRgdb/ShIZg5ydG0AObsNqstWIg5ClAUX7
         dpDMs+vXtN4HqPLv1xdxAfGvOGEbl0d1VjH2oXOCHV2fNczXx0giO3jLAxp9UETBv2Qp
         48SXEQWpETXxA2Rggy6ZsS7EOw8rvcbHbO6IIXhsxlEMP/bWEUenVn5lxtqtpuw2Z/1l
         2gMfoDGIITt50eODrvkFvOL4/o9nAa6Q0aj82HCF+jWGvKxryR/ORlGeDvOj1OZcmtt0
         qmERygR1YvBx9wuueAgw/WvvwNBqK3KuZIukLDK0iE96aoWszYA1yGygMVYzjPA+r55Q
         dtqw==
X-Forwarded-Encrypted: i=1; AJvYcCXtqXfgVx4huDHqc+W9gjzR8oeM3ouo5ujCZ4DQEvct8Lr3QJmrscr+0xvo3+jz9bK+bPkum4or8Q6qQ5jh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd90K60Jku4UKejVBXfODZfslbcFgFbvTmjXCRtKEOvWR8Ze35
	WMD4Bi8XNjyabMgZjSps9oMxI+EGFNGSXq7EaiTztXW58itniVeWXAoC3xMO9lzN24PPrWAq2Tl
	c7dg2lcz0wFOKqPApdHLi15cKILoyp9M=
X-Gm-Gg: AeBDieumiulJKcA//ZSyvOCXj1mH4nW123h9/B6iPu44AqlQ+ls8Fu5WtxdtAhuthMZ
	wODHvyKHV0BDD+cnHVgAn5smeVn+t5jIxMrkYU/J3X3j9WkyPSOSb29n40XuAOTKo3B4LUuWb4A
	g90jrHOwJhVnnbncQx1cRLagb3x3tvZu6otO0MsX38Nj7ypmDe+X4zikhReoB/k77udklYSnKGD
	4dbGy4AAb8mpsxA3pQjKrHa7cCNLwfKeuI/vOr/4kCu5KY3zPmO+GHr4oODhZkPmH9aV8im1UMP
	OXfIwDT+RTjpR2d7+o/bj8VPgHneGXWfGlx0TnwVrYjTMNEINshA
X-Received: by 2002:a17:907:61a8:b0:b98:4186:d2a8 with SMTP id
 a640c23a62f3a-b9c6742f123mr688517166b.12.1775636528111; Wed, 08 Apr 2026
 01:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480> <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
 <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
 <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com> <20260407191046.GL6254@frogsfrogsfrogs>
In-Reply-To: <20260407191046.GL6254@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Apr 2026 10:21:56 +0200
X-Gm-Features: AQROBzCWVui4RkiW0ecVejJceZ0pcq1MpDcDT46MgZidtOi2dwbsEgBiank_I0Y
Message-ID: <CAOQ4uxiU3RcoNMD21Yx_ZPqCpmtL8-Eda=a5+uJC+AsO7F=_2Q@mail.gmail.com>
Subject: Re: fuse-devel list on kernel.org
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:10=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Apr 07, 2026 at 08:05:36PM +0200, Bernd Schubert wrote:
> >
> >
> > On 4/7/26 14:29, Amir Goldstein wrote:
> > > On Tue, Apr 7, 2026 at 2:25=E2=80=AFPM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> > >>
> > >>
> > >>
> > >> On 4/7/26 14:04, Amir Goldstein wrote:
> > >>> On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
> > >>>> I'm taking Darricks example here and posting API changing libfuse
> > >>>> changes to linux-fsdevel. We should consider to create a fuse
> > >>>> specific list if that is too much. The existing
> > >>>> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> > >>>> of spam filtering.
> > >>>>
> > >>>
> > >>> Let's do this already!
> > >>>
> > >>> https://korg.docs.kernel.org/lore-archives.html
> > >>>
> > >>> Do you want me to send the email to kernel.org?
> > >>>
> > >>> I suggest that we ask for fuse-deve@lists.linux.dev
> > >
> > > Just don't copy paste my fuse-deve typo in the request ;)
> > >
> > >>> and then we can migrated the old sourceforge archives
> > >>
> > >> I'm all for a new fuse mailing list.
> > >>
> > >>>
> > >>> As far as I can understand getting the archives from sourceforge
> > >>> required the admin password:
> > >>>
> > >>> https://sourceforge.net/p/forge/documentation/Mailing%20List%20Arch=
ives/
> > >>>
> > >>> Mikos,
> > >>>
> > >>> Will you be able to handle the archive migration?
> > >>
> > >> Have that password from Nikolaus.
> > >>
> > >
> > > Excellent, so will you be sending that email to helpdesk@kernel.org?
> >
> > I can login here as admin:
> > https://lists.sourceforge.net/lists/admin/fuse-devel with the admin
> > password.
> >
> > Here https://lists.sourceforge.net/mbox/fuse-devel which is supposed to
> > create the mbox file it asks for "user" and password. Assuming the
> > password is the same, what is the "user"? Also tried my user sourceforg=
e
> > credentials, does not work either.
> >
> > Can we defer this a bit? Too many things to do and I think for now
> > reviewing Joannes Patches and finishing sync-init and Darricks mail has
> > a higher priority than fighting with sourceforge mbox.
>
> I don't have a problem with deferring, but FYI you don't have to have
> old ML history ready to go when you apply for a new list.  It, erm, took
> us months to scrounge the entire xfs history together after linux-xfs
> was created.

I requested the list:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjRgQGxWYWbRbjVZy19oA5qKZSd9eAN=
KyD8yCoBNGPNNw@mail.gmail.com/

I cannot imagine anyone missing the fuse patches on fsdevel
if people just started posting their kernel and libfuse patches to fuse-dev=
el.

Should have done this two years ago when it was also proposed.

Thanks,
Amir.
