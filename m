Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794038327;
	b=S+i6V3TEh83RsYWI3BfTyf8GUCE4KCaS3isg2eWNr0uf6wXCrvuQbhxKCh0o3XUiV5M9
	 8//gCrNzYE+VIPGFpdizemtrK7m58N4iH/eAJKthq7dYMHOILgN3p6YBqfUmiamwzHD09
	 oNUoByK7urHwNeyH/AP2PYC8BaNcKsaLW7MmIDM1MExG32Q4oF6hBpSScPOeqRb1JfVgC
	 0g/gZiuW3AB4HiqNtChq9HJbrVxqKOWvhLIZ85ZmMWFm/V6+xuA0vnsQ09ZJ+IXd3dpQ3
	 pqL/RiHaDc/gM0igbILADQIgCvX8Q3yZlT3f7XBZgUXdsw1WR24lWYXAkGRo5nUdJzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KVUTn3NefB2pYcpRgIbKLSS1BYXCOeKVEt1Rx8hpLqE=;
	b=M3oe4RPHbXAuJExSW8yPimnVz+PVG9ZfIDMK62vTblVcqRjOgQ1pQAHYH8sCgjNM4Din
	 Sp3omMNYB3XHdlGEc7IODbBNywaXEacXLwe8C49VmemvvhYXhO5NqivofSpya+nQ2aKrH
	 PuI5d+qkDxyreIoVwHI71NFLmLdH9tYuGfJJGufkvxytnv29RGcft9O8ABhF1PzNzs31L
	 38Y4FtD9Fn94CDZN2X0yUEkK6/x5iKpuciQ7I0aOWG+L3so5b0NAMt7npC2qVQ9+K8GSl
	 N0Fn9TNcFq/YD9hGlDZ8n1NG9hKcm/vdE0jEg/EGhp8zlHAe+zAvyhlTCWKJBO0qFqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFKx2RIA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F5606A326
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 07:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFKx2RIA
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d28f75d62so180746366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 23:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794038325; cv=none;
        d=google.com; s=arc-20260327;
        b=cn+re9Qvf61hYOHRADbLndPr13mJjVSamjBw+J7yQCihDXaT20aRiqCvhnYkxN+c0H
         osRslhknyDoOzKPdA3ZaXFq44aTJvV+HN0/YH13U06zVvQiBWi678UsolZmWfTj38fxl
         FBEt5+W4QNDejKKLPgznVZXhkFFrLOvcUZOwPGlDW8VOvwWy9ojLkdPgMlKMw640PDzb
         K1ZikC6HK+MkWbj0maYg7OT7GBQ4EyYt+u1mNYiblVJnJETwxJH/bZim9Vhc0UU8JXIS
         E7Hj7Y5nRVL7hWqk8DimQ1CNphoPND6/ixmAPmaal5MBzzi+YMolfL2Vyg4hl5axOGEc
         ag+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KVUTn3NefB2pYcpRgIbKLSS1BYXCOeKVEt1Rx8hpLqE=;
        fh=Ap+jigipimlehL8OjV41Dq6KdhAgZzRV84aEdNsJGa8=;
        b=i2f++zHWKA7r4kQIHJWqHENevByUnozCgKCYCaizj6UOgdLyAwYBT5M4KPszvHF/HX
         g1bAev+0AJbNS8sxVOCl2UTqIpNns2Dp/V3MAYdueTqgo2EBmpYstEB77JlfAj3X9hwy
         TmT3BFVj582vMGsUIVebE5Cc6PGNr1Hy3EyFHKJoAn0WXcBIBMLZmg2g3pRwIWX33wY+
         2gjsuUOpxo7hJlbR2rk+fhxu/Xgtg6fbhE4XVoI7jPgMurrJkWAmatr71TKvsO4B6t/Y
         2MByHpJ7IN0NZdAxnDyais1+KjGcdHO84/3DTYjL/piNOdZd8TsBlZUKao8TQPEsV9In
         js6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794038325; x=1794643125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KVUTn3NefB2pYcpRgIbKLSS1BYXCOeKVEt1Rx8hpLqE=;
        b=bFKx2RIAIdR2p7+rzCBfW2P0k/uPgdITJEM2ARGv+PoRa6NfHyBdGRjf/XpbjJFWGj
         Z15FDMyDo9ZoCQ6oa+IECOETidlqGiUfQPMv+0aqq2DLHqJVxV/URLwqELl0Nc3MhTIc
         2FWjzfNFAac75Xr357D/elYj2B9yEYKOIBaOAaoKfoFnzJuVtB6UwqZm9i0CfqV+lWGJ
         89eNHb8cm6hX/ndALAueQZWOWhlNSUIW9lCMMGqgKiSnuYDr4xOdG50IyGTzKFJd3iGU
         FdUYT54WtnPPLC4aN+FPmoFqCYO+w5ymlNdoevEywfq6HVv3g/V1PeblsOfSrbCZOIOQ
         G87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794038325; x=1794643125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KVUTn3NefB2pYcpRgIbKLSS1BYXCOeKVEt1Rx8hpLqE=;
        b=RwxezTgg75hoSt3hS8RLmBHOVXk4R9+KnQpd436UJLTQliJ94jVkx+agH7KNeEW80d
         O9gEaSByCBtYDuHNPUzMcgTKKB1c3fwj8mKakqsslfgZMyMZTM1ORmkgFommD+dLF1i4
         4CYOPkELNEaZW/KNeVdpzL7Hk7IvYHbTWIJMqTP4O1QpkY9i9ngkg26zTBelisFH/N+p
         CAjXRN8jwhqXUKUcU2KmBRCGuBzZflLVEIIuZezciC2Sb47qJuDV+NB5xegeBnw0IC4j
         oRElXyHo2BrEwdsmIOOg/J2J72AsLTmIPANjw5BDBMqC6zQ8SIjreA4iEvJLVwrdqIPg
         uMWw==
X-Forwarded-Encrypted: i=1; AL+hErGP1FWCk+ANBuocEXPbm/rfy6BYgQZUQiQjMQdpah9hOalT/aIW/+6AYksfTtxgrP5+iOvGhLB/ErsBciWs@vger.kernel.org
X-Gm-Message-State: APuU4Z+aqw5VLgs3yzPcWBfrpFMqFVy8QoJFszNdY837z9IBIKAAzTEl
	XInt8+nnrUJEQkuCZxtMInr1qTTOGw7h63wVSLQLSQiW57Rn+XJK/5ncwgOy7AxEKrGhuTGeOL/
	HxKJvLiO0D2X4vlmMhHQ/qpnEKDvLMoA=
X-Gm-Gg: AYBFou0HuKEMz71q6ZmHjsTULlJ91cc1Czif17EbSxSejk3cy6JkwVZB5nxA0crTo/y
	F/EwFbB2fIuJ5aQ8LtuYAk8Inyoz7OnhonMf5vluEbNxW6YRf/u7reYFFIg56m6qF9QXi5t96Mj
	i/RI2t0chc4dOfI0UKFpyb55HZIBLKWoO4EWou9WRzjekLWuMK32r8PwqAgCy/YkKQRugAG3bkh
	Tn86a4GNIe7oA/bNnlP6AcC7cGc9btrnMo2SlFVmRWzbkU5QMjDBUPVXGrw1OCqpLKFhfc0nXR+
	gI2dc5YPenll5Km5ie57Kgeyf/lsTilOITX5xLcEIA60UrPXwMd8+CevZ/139EvJhsabXuW6F55
	ltsQ3Elk8lku1QOC9cHmYJvTVxB4LmXPPoQB9
X-Received: by 2002:a17:907:c0a:b0:c3f:7ab8:bef1 with SMTP id
 a640c23a62f3a-c4d34c5d8e4mr392839966b.34.1794038325410; Fri, 06 Nov 2026
 23:58:45 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
 <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com> <CAKLmikN9Aod9Va=FsqkRmF20=69sdgdDOoV_bUuGh6wTykVcBQ@mail.gmail.com>
In-Reply-To: <CAKLmikN9Aod9Va=FsqkRmF20=69sdgdDOoV_bUuGh6wTykVcBQ@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Date: Sat, 7 Nov 2026 08:58:33 +0100
X-Gm-Features: AclHuK8tSl2eC8RfsY2HLkZzpD_9Mv8udwoMRcvajXKX7YtJEXcVLoT4j91is5E
Message-ID: <CAKLmikO5y916zgeX_UFqfGQ+BUmNC6uvHFR_bsizeTJu4AwxcQ@mail.gmail.com>
Subject: Re: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate()
 and copy_file_range()
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Not sure what the process is here, but how to get this patch further?


Mitar

On Fri, Oct 2, 2026 at 11:32=E2=80=AFPM Mitar <mmitar@gmail.com> wrote:
>
> Hi!
>
> Awesome! I looked at the patch and this is all probably above my head,
> but I think the patch should also include some protocol text
> describing the flag-only SETATTR, because this is now a new behavior,
> no? And probably we should also do a minor version bump so servers can
> tell that they can rely on this behavior and decide to request
> CAP_HANDLE_KILLPRIV_V2. For example, in our case, we do not request
> CAP_HANDLE_KILLPRIV_V2 now because we are aware of this issue with
> fallocate() and
> copy_file_range().
>
>
> Mitar
>
> On Thu, Oct 1, 2026 at 12:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com=
> wrote:
> >
> >
> >
> > On 9/30/26 23:45, Mitar wrote:
> > > Hi!
> > >
> > > While adding FUSE_HANDLE_KILLPRIV_V2 support to a go-fuse based
> > > server, I noticed that with it negotiated, fallocate() and
> > > copy_file_range() by a caller without CAP_FSETID no longer clear the
> > > setuid and setgid bits of the file they modify, and that the server
> > > has no way to learn that it should clear them itself.
> > >
> > > The kernel makes the decision, but drops it on the way.
> > > fuse_file_fallocate() and __fuse_copy_file_range() both call
> > > file_modified() before sending the request, which ends in
> > > fuse_setattr() with ATTR_KILL_SUID and ATTR_KILL_SGID. Since commit
> > > 8981bdfda744 ("fuse: don't send ATTR_MODE to kill suid/sgid for
> > > handle_killpriv_v2"), fuse_setattr() drops those when
> > > fc->handle_killpriv_v2 is set, expecting the server to kill the bits
> > > when the WRITE which follows arrives. But no WRITE follows
> > > FUSE_FALLOCATE or FUSE_COPY_FILE_RANGE, and neither carries such a
> > > flag. All the server sees is an empty SETATTR before the request,
> > > which it cannot tell apart from the one it gets when only
> > > ATTR_KILL_PRIV was asked for.
> > >
> > > For "fallocate -l 8192 f" run by an unprivileged user, on a file with
> > > mode 06777 which they may write to, the server receives:
> > >
> > >   GETXATTR  "security.capability" -> ENODATA
> > >   SETATTR   valid=3D0
> > >   FALLOCATE offset=3D0 length=3D8192 mode=3D0
> > >
> > > and the file keeps mode 06777. Without FUSE_HANDLE_KILLPRIV_V2, the
> > > same command clears both bits, since fuse_setattr() then turns the
> > > request into a SETATTR of the mode. I verified the fallocate() case.
> > > The copy_file_range() case is from reading the code, as the server I
> > > tested does not implement FUSE_COPY_FILE_RANGE.
> > >
> > > This matters beyond the mode looking wrong: fallocate() with
> > > FALLOC_FL_ZERO_RANGE or FALLOC_FL_PUNCH_HOLE, and copy_file_range()
> > > even more so, change what the file holds. So somebody who may write t=
o
> > > a setuid file can replace its contents and keep the setuid bit, which
> > > is what killing the bits is there to prevent.
> > >
> > > It looks like an interaction between changes rather than a choice.
> > > Commit fe0da9c09b2d ("fuse: copy_file_range needs to strip setuid bit=
s
> > > and update timestamps") made copy_file_range() kill the bits in 2019,
> > > which stopped working on FUSE_HANDLE_KILLPRIV_V2 connections with
> > > 8981bdfda744 in 2020. Commit 4a6f278d4827 ("fuse: add file_modified()
> > > to fallocate") added the same to fallocate() in 2022, which takes
> > > effect only without FUSE_HANDLE_KILLPRIV_V2. As far as I can tell fro=
m
> > > its source, virtiofsd with --killpriv-v2 has the same gap: it drops
> > > CAP_FSETID for write, open and setattr when asked to, and calls
> > > fallocate() and copy_file_range() as they are.
> > >
> > > I think we should pass the decision with the request, as for WRITE an=
d
> > > OPEN. For FUSE_FALLOCATE, a new FUSE_FALLOCATE_KILL_SUIDGID could go
> > > into the currently unused fuse_fallocate_in.padding. For
> > > FUSE_COPY_FILE_RANGE, it would need a new field, or a bit in
> > > fuse_copy_file_range_in.flags behind a new INIT flag: servers pass
> > > .flags on to copy_file_range(2) as it is (virtiofsd does), which fail=
s
> > > with EINVAL on any bit, so a new bit there cannot be sent to a server
> > > which did not ask for it.
> > >
> > > What do you think?
> > >
> >
> > I had actually noticed this with recent test additions in libfuse and
> > had to add workarounds (on the day exactly one month ago).
> > Unfortunately had been too busy to post the kernel patch yet.
> >
> > libfuse commits
> > daa6cb7f6996 =E2=80=94 "test: check the KILLPRIV_V2 kill-suidgid flags =
reach the filesystem"
> >
> > and
> >
> > 60ab8c0c35de ("test: check a write through passthrough_hp clears suid/s=
gid")
> >
> > When testing the latter commit I had noticed the issue.
> >
> > Could you try the attached patch? Right now totally untested,
> > I can test and send it out earliest during the weekend.
> >
> >
> > Thanks,
> > Bernd
> >
>
>
> --
> https://mitar.tnode.com/
> https://noc.social/@mitar
> https://bsky.app/profile/mitar.bsky.social



--=20
https://mitar.tnode.com/
https://noc.social/@mitar
https://bsky.app/profile/mitar.bsky.social
