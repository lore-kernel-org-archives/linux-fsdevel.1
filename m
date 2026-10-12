Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC42253EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765514; cv=none; b=Mo36j6MZuURpJ5V75K669/tGIdlyPkoRK9B801HJ119wYFd44UYsIZCE1BAAJIoiuGtGk0+i5/HStV3FR8UjtAcV3l+MGkazptYBdvyBVKY9qCO3ljM+fs0wpCEFTErGR8M/2jcvJzfQ+uYmtyLRzMthozT1/J/Ru9YB3hTV8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765514; c=relaxed/simple;
	bh=rL46dvqgWAO0JHhL8ZpJm5OF9TLhrI4cxOyg7tTEA0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORrqA0ROiE//EhKEnYl0jBXfPkWs9rWHuINTkDZxM2J8Si/CBHDD6TCsoxSTPG4siRBePx5Tv6WrAZoo8xwH5KWBgZ9IRhHE3tSzuo/a6emUcXq+oOoULSWZ5ZJANR3cTSZoBCscCTfgGQLZQklFMj3R6p8ihTOuFexjwnDhz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhZdW02N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhZdW02N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B181F0089D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765513;
	bh=+nU6vAv03n1Uau01SCXRAGP4ph0cczKwpJTRadSH7xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lhZdW02NzNfeSF8pmHzlfeWHFnSmwYxVhJ/6eaI75ZFC7vVB9pPhgaSlutUD8BwO9
	 v6gIHR/ZbFQGgmN5uX8TA685cKonpV98o0P02emeh0QI4C2d7Q+Wpn0nfKOFx+o4+S
	 CS0ZD9kQEpzrMbCAiZ2JK2qGTAfkbwPuSoKF4P3+d4xtwfXYZeLawFRJg8EoZb91Xc
	 JKRcMZpbVxGJZRE+saazNdXNMKvxdGSJS6kI3DE07PQXvwjz9F3Sh8xWfWQzrApd2k
	 xspU8FexGzfJ/OnglixrLTHp3YIv5Pia55PW1s5f9YrBjvHik17+9yxYCBdcsvYodX
	 l/UlkbTbHeE/Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e5e801487so219860166b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 17:38:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxp0/cRLiMZzLZpCCNfc679EssuQpXQtGnFakOYSxY0xNWBU6GXbXlGO66BpyfLUZIsTXJ2qhm9brSIAVYi@vger.kernel.org
X-Gm-Message-State: AFq9FYLDwsDvifeE0LtyXzp/zlbwh8IORBdT1EyhTNIGosAmraZBCcLQ
	z2hnJXjTcKBSOvL0eQYR3wE3UwKaA+27i0OAENsU5SKhxlNK2yitMXQsZv/IT4OLwenUSJAnwMT
	4rfhMigHK8KF6qs9pfy19Uo3f0pX7CwE=
X-Received: by 2002:a17:907:3d4d:b0:c28:599b:7782 with SMTP id
 a640c23a62f3a-c31aa0120b4mr776028966b.21.1791765512192; Sun, 11 Oct 2026
 17:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011221648.6811-1-linkinjeon@kernel.org> <CAMrLSE5=KsOYNdRokkb=_do_XUA_cehpAUdp1TrrUcnmv3rxBg@mail.gmail.com>
In-Reply-To: <CAMrLSE5=KsOYNdRokkb=_do_XUA_cehpAUdp1TrrUcnmv3rxBg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 12 Oct 2026 09:38:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd88HhEJWToBKRtv=iq+CraLrd=i5z_VPCS0H6KNy-qvjA@mail.gmail.com>
X-Gm-Features: AclHuK9f-uc6ErdSm2O3DG1kspls-aeWXnBYr2fSP4gaPlKzxY0WxL13Rh7rkWM
Message-ID: <CAKYAXd88HhEJWToBKRtv=iq+CraLrd=i5z_VPCS0H6KNy-qvjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ntfs: add named stream ioctls support
To: CharSyam <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:47=E2=80=AFAM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi, Namjae.
>
>   I have two comments on the named stream write path. I tested both cases
>   with the NTFS module in a QEMU guest.
>
>   1. In __ntfs_inode_non_resident_attr_pwrite(), count =3D=3D PAGE_SIZE d=
oes
>      not imply that pos is page aligned. Both full-page branches need to
>      check the alignment of pos:
>
>          while (count) {
>                  bool full_page =3D count =3D=3D PAGE_SIZE &&
>                                   IS_ALIGNED(pos, PAGE_SIZE);
>
>                  if (full_page) {
>                          /* __filemap_get_folio() path */
>                  } else {
>                          /* read_mapping_folio() path */
>                  }
>
>                  if (full_page) {
>                          offset =3D 0;
>                          attr_len =3D count;
>                  } else {
>                          offset =3D offset_in_folio(folio, pos);
>                          attr_len =3D min_t(size_t, (size_t)count,
>                                           folio_size(folio) - offset);
>                  }
>                  ...
>          }
>
>      To reproduce this, I filled an 8 KiB stream with 'A' and wrote
>      4096 bytes of 'B' at offset 1. The ioctl reported success, but byte =
0
>      became 'B' and byte 4096 remained 'A'. With the condition above,
>      byte 0 remained 'A' and byte 4096 became 'B', as expected.
This has already been fixed in ntfs-next by commit 7de32a72b75b7
(=E2=80=9Cntfs: require page-aligned full-page attribute writes=E2=80=9D).

>
>   2. An error on a later page returns the error even if earlier pages
>      were written. The ioctl then returns the error without copying
>      bytes_returned to userspace, and ntfs_inode_attr_pwrite() skips the
>      base file's mtime/ctime update.
>
>      I reproduced this in QEMU by injecting a test-only -EIO after the
>      first page of an 8 KiB overwrite. The ioctl returned EIO with no
>      transferred byte count, while the first 4 KiB changed from 'A' to
>      'B' and the second 4 KiB remained 'A'. The base file's mtime did not
>      change. The changed data remained after sync and remount. With a
>      test fix that updates the base timestamps when an earlier page was
>      written, mtime changed in the same test; the ioctl still returned EI=
O.
>
>      What partial-write behavior is intended for NTFS_IOC_STREAM_WRITE?
>      Returning the completed byte count as a short successful transfer
>      would follow write(2) conventions, but the stream is currently
>      extended to pos + count before copying, so EOF handling would also
>      need attention. If the ioctl should return the error, its UAPI shoul=
d
>      explain that partial changes may remain and define whether their
>      length is reported. Either way, timestamps should reflect data that
>      changed.
Okay, I will fix it.
Thanks!
