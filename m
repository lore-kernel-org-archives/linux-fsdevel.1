Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9796485CCF
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728424; cv=none; b=f3SdjX4SUmuVSLdw2YNNLRo/EcVAZDodXD/c4u2ohw8/QtQikXId7UbIQit0xzsoTbKJvWkecOU1jpo3AXgGk2e2ijVuLNbdwygFrCrUfxpSZ9v2VTaTvWcWUALlHo2vqFJYvPyinVh7VjcTsfEOXOlOsVDpV6UV3n891MaxErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728424; c=relaxed/simple;
	bh=L2co4r/441gZZvqgSmgo3PT2kFGC/fBdeAadMLHIDFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfuZmQDP385JenqUuzsppA5xJ4aN2NE4SWxjFj8/vp46keFTiP5sDTD/uRdcefGhAln4ZRgYG4okYDRHZ7H4d2q91sO4xcU77RHo2RG9h3AnHCaLFb9vKim/HVLDvZEBw2Xhc0lhptSsnNz8HVmbh0+z8ukBUUfUWLfj2wKoQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ix4vMjhz; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ix4vMjhz"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-81ce92c1a48so8929497b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786728422; x=1787333222; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2co4r/441gZZvqgSmgo3PT2kFGC/fBdeAadMLHIDFU=;
        b=ix4vMjhzGF+GGE3hC0yGgl4s6+nY0F+PWh0gfVxLfNEOUTfBAlbv5XEnMNJzjy2cmX
         DBORrbP55Iv7WAnD3o1X1Z79MNaBFwDijmtsicrI8k+kT9jz+IZ8x2NdPcrKRcUMkMfg
         zFDKUnr07uPkzikd7VD0PqnzRqUL2mb/FuvsJy6KGTmlGj1ZOQdekHxsy28xOGsWSZW5
         uDOtGMjGaVVc52Tjs/OakTF5cadfjD4dfYYQ8CCsCiBJMxzJYPYZOP2ehyyMJ9mKvxrv
         B4OVJrUo/ySQSow+Y371kYN7kcdfhSQP3mkr3WB5m2Z+K5XmyV30VNB8kmzRGdTXeanm
         nCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786728422; x=1787333222;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L2co4r/441gZZvqgSmgo3PT2kFGC/fBdeAadMLHIDFU=;
        b=gc2ScEJaz3kUNph4UV791ZlO9mazqmM0O9bl/SgtnWs+Iy7TnesWOzxtpGR7CszA+d
         XS+qkrFRTFxeZJ7PQxExLCXy+YbDLgN7PBoRiRiObJPlZUosSDSAS5lxSdzHtkV03NMJ
         owANftxNz7NMpbj/VjNIxlbc4oWxlGhFmCcyp9qJVaKXb+rFwCSm/9uKt4njK9uQOY2j
         SYZ6olrjh/hDGpiYGQFDu/FI4/FZRqzSRBCutQwNPT2oM8tN3bD/t07KNxY2MrdUseTU
         IvUO0f4UH62ZO9a+94KbIxiXNiOamIUH4LMfInLfDDP1SWsSgiYtBLWU8LA/uyxruv4O
         KEaQ==
X-Gm-Message-State: AOJu0YzuqfjJT2bOolHcfDTFq1skfCYVkPKlYW0GIMRzSMMq0z1vtkWh
	P1EUHHQCjcATy/fJdvNSh7UQj9RAG8HipDhGJixVuIPoALhBzLt8g3rXFQKCUK4HAFEqIHtF9qu
	nwpws17u/ij+g
X-Gm-Gg: AR+sD133/dZkdEAwP4CVcvuMk1aJriFJow5Im6ZGGE6+kQ04FtNkkZFT58YcToQ1AoR
	70ori3ngyr2wIuITLHnjJ6JYXJPT0ABEyiRBmFJSnsM0V3fq0VuiS7TD1zVHZqk70UkuUOmEyEv
	x64Fq5DmEAOvxWBoUgm4OwdqVXW4YS6Luq3HVzWsy3gShq9yPmjp3VFP4nGY9O2kAMhksbXNdqD
	THm5wEsw41oK6nDFfa0Ns1b4r5N5za+CbfYe/Ho+t6JLaZZkcrGuIb6iQaRZVM+HuC3pjMfovCi
	xkuTNX/bdU1Os6gITbrsL/GbtSN9vv6HHlszagwlyXwDnGRIrWzIWkOJF3TJ7vff1BVtp7zONyP
	pr6lqAtQP0N04rlEOXykjndZOdI6OdgjS3iCnqL1qoD4IfhVL31M6bq1WROFij3veEw3FkA41Ab
	qcm9Fh8KLwalzhbOgq6pCSeq0ibep4RVfWgEyJGbdB9XtZvanic5eOIr/LEm9frIdvJa2NDKoqL
	93pF6Ku9PZQM7iL89m/OjWbqFZqU7L04Ijk1Jv3GQCVqJrbI0jhb2rUmilesZBGcbQLBzE+ZhkY
	TRj5pK/dDkijxDc/mQ==
X-Received: by 2002:a05:690c:9681:b0:80c:16ad:2f10 with SMTP id 00721157ae682-8371337c24emr29001577b3.33.1786728421557;
        Fri, 14 Aug 2026 10:27:01 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7c1e:d951:252e:7fc3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bc2a1ef4sm16083937b3.14.2026.08.14.10.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:27:00 -0700 (PDT)
Message-ID: <b19a7fe07b79f6b47b58968a601e5ceb0fe9c2a3.camel@dubeyko.com>
Subject: Re: [GIT PULL 15/18 for v7.3] vfs nilfs2
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Aug 2026 10:26:56 -0700
In-Reply-To: <20260814-vfs-7.3-rc1.nilfs2-f036b3577823@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
	 <20260814-vfs-7.3-rc1.nilfs2-f036b3577823@brauner>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Unfortunately, we've found some issues in the initial patchset. And v3
[1] is what we would like to send finally upstream.

Thanks,
Slava.

https://lore.kernel.org/linux-nilfs/20260812221154.1119137-1-slava@dubeyko.=
com/T/#t

On Fri, 2026-08-14 at 15:14 +0200, Christian Brauner wrote:
> Hey Linus,
>=20
> /* Summary */
>=20
> This converts nilfs2 O_DIRECT reads to iomap and removes its use of
> blockdev_direct_IO().
>=20
> /* Testing */
>=20
> No build failures or warnings were observed.
>=20
> /* Conflicts */
>=20
> Merge conflicts with mainline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> No known conflicts.
>=20
> Merge conflicts with other trees
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> No known conflicts.
>=20
> The following changes since commit
> 1590cf0329716306e948a8fc29f1d3ee87d3989f:
>=20
> =C2=A0 Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-
> 7.3-rc1.nilfs2
>=20
> for you to fetch changes up to
> d5c57d9bf03516d625521cd6cf5acfd93e3e63c7:
>=20
> =C2=A0 Merge patch series "nilfs2: convert O_DIRECT reads to iomap" (2026=
-
> 07-27 11:43:15 +0200)
>=20
> ----------------------------------------------------------------
> vfs-7.3-rc1.nilfs2
>=20
> Please consider pulling these changes from the signed vfs-7.3-
> rc1.nilfs2 tag.
>=20
> Thanks!
> Christian
>=20
> ----------------------------------------------------------------
> Christian Brauner (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge patch series "nilfs2: convert O_DIRE=
CT reads to iomap"
>=20
> Viacheslav Dubeyko (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nilfs2: add iomap operations for direct I/=
O reads
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nilfs2: switch O_DIRECT reads to iomap
>=20
> =C2=A0fs/nilfs2/Kconfig=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/nilfs2/Makefile |=C2=A0 2 +-
> =C2=A0fs/nilfs2/file.c=C2=A0=C2=A0 | 40 +++++++++++++++++++++++++++---
> =C2=A0fs/nilfs2/inode.c=C2=A0 | 13 ----------
> =C2=A0fs/nilfs2/iomap.c=C2=A0 | 71
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/nilfs2/iomap.h=C2=A0 | 13 ++++++++++
> =C2=A06 files changed, 123 insertions(+), 18 deletions(-)
> =C2=A0create mode 100644 fs/nilfs2/iomap.c
> =C2=A0create mode 100644 fs/nilfs2/iomap.h
