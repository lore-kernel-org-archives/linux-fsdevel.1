Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261021883E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800277; cv=none; b=p6bYqnNvs8asbo/MdxiVKZljd1kyAHgeESP8CmL+g/Vk4AniNxPdogMXIEDm698oaVUIr3DPKBPSHrhs17gJTtfiSkdM7vUjIZlbHF0vmntEZGJjdS7i8T3pp+ODcEUzsnkvDGtkHJ78rf8aNEGEuyyzYenQjwY6qIscrSXeKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800277; c=relaxed/simple;
	bh=wpogzMHA+86aUMR7uMC+zWKXxrxbf5zSXZ2Pl0q/UOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1PgVfzeDENnqOQUXaKEncQIMHpnQ0tl7lvDNz46cljd0GveM/PFFMmyaLsgAkyqWWwhLwztPjLP2RFBhltmpk/xTddmlv/bPNGAfiPUh/7f7QG2KdjTHt6h4qHGDJFEOTmHfrL0vANDlAtMzrxVJTy497KaO4j+UXbBEEn/9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hsiangkao@gmx.com header.b=D14yyF7B; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hsiangkao@gmx.com header.b="D14yyF7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1785800251; x=1786405051; i=hsiangkao@gmx.com;
	bh=zDXi7OWTbpdPYjqvXuHmBoIm4oP9FwJhQNX1ofpFS64=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D14yyF7BLL9M3PjD/D+mjMWUqt9UX5t31JKNtUKbwqJb4c+5ixDGyBnmR5gctSQE
	 Edq4bnf/XuS7HdjfSuzpKL7fgaB/Z/Ui2dJxnRLbKphbOrKZ11EhZkI7/cMnGBa03
	 0Y4Ljz5Cpc/K2kpRQONNkVw3XpWPsfG5g5kVMWauoOKRC7t+W9jq+CCD45yVjH1m1
	 seTOCMHJxzkjNgYP4X0XsTH3EoqCUd3J+Wtu9LzFItq/GsQWBCF06j4JUgspL73Vt
	 za+uzTcEtjdDSsUmV41xP54kiVNmf6WaU7ZPFmdEapHTdZjLjRwDcrX4lqcM3rota
	 9TJHh6yKIEUx1mFtdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8mb-1xMoGd2EMP-00hthI; Tue, 04
 Aug 2026 01:37:31 +0200
Date: Tue, 4 Aug 2026 07:37:25 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	cyphar@cyphar.com, hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
Message-ID: <anEmNQWJzo-osec6@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	cyphar@cyphar.com, hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org
References: <20260728160619.853924-1-gscrivan@redhat.com>
 <366a9c6b-ec56-4cdf-b373-22a3cd8c9beb@kernel.org>
 <874ihbxviy.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874ihbxviy.fsf@redhat.com>
X-Provags-ID: V03:K1:MStWG9YfY+66xmSnK9qGZw9XYfyXfUlNxn/fbdKt5HaqrFJJmB+
 +G4V604W3dUPMCKkpky3H+aK4qlmvU3XqpbuvDmVb/XEhjDfeWn8cjlxNO82DV9AX+uh/jz
 7iUeIgEZ1W8bdenB9Q3ZYDDGZl3Jtbx4LuHVhzZgctEEji+arQ1gv1F0fu/qWXWUQItTmv0
 mZixgxAsrDjLhHo2ZwVhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WJg7xcwtgJE=;3Fijpd2jKdUw67xenAqZ1FRkgQY
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 02:01:41PM +0200, Giuseppe Scrivano wrote:
> Chao Yu <chao@kernel.org> writes:
>=20
> > On 7/29/26 00:05, Giuseppe Scrivano wrote:
> >> Allow userspace to pass an already-opened file descriptor as the moun=
t
> >> source instead of a path string.  This is useful for tools that alrea=
dy
> >> hold an fd to the image, such as composefs reusing an existing erofs
> >> backing file.
> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> ---
> >> v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gs=
crivan@redhat.com/
> >> v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gsc=
rivan@redhat.com/
> >> v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gs=
crivan@redhat.com/
> >> v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
> >>   Documentation/filesystems/erofs.rst | 15 ++++++
> >>   fs/erofs/super.c                    | 73 ++++++++++++++++++++++++--=
=2D--
> >>   2 files changed, 77 insertions(+), 11 deletions(-)
> >> diff --git a/Documentation/filesystems/erofs.rst
> >> b/Documentation/filesystems/erofs.rst
> >> index 4230884fb359..774e8b236d09 100644
> >> --- a/Documentation/filesystems/erofs.rst
> >> +++ b/Documentation/filesystems/erofs.rst
> >> @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing=
 for this filesystem.  Inodes wi
> >>                          page cache.
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>   +File-backed mounts
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed im=
ages
> >> +can be mounted directly without a loopback block device.  The backin=
g file
> >> +can be given either as a path, or as an already-opened file descript=
or.
> >> +
> >> +When a file descriptor is used, the kernel resolves its path and rec=
ords it
> >> +so that /proc/mounts and similar interfaces can still report the mou=
nt
> >> +source.
> >> +
> >> +Only regular files are accepted as backing files; to mount an image =
that
> >> +resides on a block device, use the traditional block device mount pa=
th
> >> +instead.
> >
> > Do we need to add an entry to describe the new mount option source=3D =
in
> > "Mount options" section in erofs.rst?
> >
> > Thanks,
>=20
> I've another patch "erofs: reuse superblock for file-backed mounts" that
> also touches erofs.rst and it is currently based on top of this version.
> I wonder what is your preferred way to handle them.

EROFS dev branch usually has a small number of patches. Since Chao gave
a new suggestion, I think a v6 is needed (but you could add all
previous reviewed-by:).

And "erofs: reuse superblock for file-backed mounts" needs to be rebased
too, I will find time to play with it this week (or you could add a
testcase in erofs-utils experimental-tests if you have time.)

>=20
> Will maintainers deal with conflicts or do I need to submit them as a
> single series?
>=20
> Do you prefer a new submission v6 with the following fixup?
>=20
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesys=
tems/erofs.rst
> index c972a869f3e9..49c4e7dbc5d6 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -137,6 +137,8 @@ fsoffset=3D%llu          Specify block-aligned files=
ystem offset for the primary d
>  inode_share            Enable inode page sharing for this filesystem.  =
Inodes with
>                         identical content within the same domain ID can =
share the
>                         page cache.
> +source=3D%s              (For file-backed mounts) Specify the backing i=
mage as a path
> +                       or as an already-opened file descriptor.

Not quite sure "an already-opened file descriptor" is "%s", but I'm fine
since it's quite a minor one (it's unneeded to nitpick the
documentation).

Thanks,
Gao Xiang


>=20
> Thanks,
> Giuseppe
>=20
>=20
