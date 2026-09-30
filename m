Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486B472F87
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804721; cv=pass; b=S4DjvmvsqTzrleEMnpR8ukHIoYYWryf45gocDssqTHwDJx+Bjx9sSDLuQ2ZqrJItQJxgy6B24Q6L1Vgzr/EuXQxNlRIr88NZgLkIJF4/1Siq1OwIS0dnQMg+tAxG3aqQXtV94CIeUnyTSm1r+IDuBun+PRNo5vq0hbc8Ppl151w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804721; c=relaxed/simple;
	bh=PiF+5JhYQyqyQQg0yIhizhLY5K8knHwjm64JM2eQzDc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=u35UusURQS0FQrsbDuFjJ+NxGrIagk03MYrDPIML+c/nU4BzQGukEAps8S+erc7JiYSSmQq2YqNKAn23M91iLUHwASvqi7kiXLLxL6fwD33JgsSN6UsD/eg9WC9+wrYMpXemkLi8QciM6xK+Ht325y9KUnY5HGayKSl1Lwmdyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xso3W2DV; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xso3W2DV"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaeeacce15so9398863a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 14:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790804718; cv=none;
        d=google.com; s=arc-20260327;
        b=EzryUm5lUqnAZIIi0+yoa0R1ko2ZnvRgxSYIc6W+IPS8iZUBzuObmbBp+RuUSUdkUh
         rbUdJq7tgV2wJdAjWqbABZVyl5UmlXqJwjENifDxZkVNRwdHic4qcvvsX7vwzOeFmq+4
         Pq/tn/bLBBq+WO1RwR1SIwWcsMQ+IjFf1xAXuBgsMj/TxX0EetJzxppwfVYvd80Lid2p
         iqg1lDGOITvUJqc7U/TMaAeGwCF1/GOe6lYqJhJjtJA+qRcHl6KzUmup8l3c/MapfVu+
         WgDfpNpgdk8pJgjCMdQtRnfvmpYcqCPRv+Oehd39sb4ha5X+3M6ap9cfGRc6dwBBhZfx
         tXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TmzptZmFD4kymUTncO9Qq9vTT/IrpfVRobSN1GvypKQ=;
        fh=nUcqxmYVDzd+SEjsT50laL+roKCvnw/a+Jlk6QdFv58=;
        b=BbTs8G/gWl4lXUPmr6A3m4RAkuwP4AEUs/olR0Rj9wv3BdT0YWKa8w1LP51jqBbbuL
         A1lD6xCReXpwiNk+STjvM3Npw8AuvF4f9zcVSylPHnls+ts5bBUzKOKe8dfFkcZdXmhi
         r6LoID5VmXl4HO1pmX2etGFin9w4lw+apzTuhVukohwk37DhXOw3LYj+xpwGOdH8Ara1
         PiZt7XLYa49HA+KCMinplZtnyAtibTGLrRsdslZRLq3TT0yUghBHWvH2J9YH9pUCJvMY
         Sfa7vvmUcUM40O72l3K/+IFzYzkI8tlZamGoqx/+SXPe/Qc34D4U2S4F6r7KsgPQ2Luo
         FvcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790804718; x=1791409518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmzptZmFD4kymUTncO9Qq9vTT/IrpfVRobSN1GvypKQ=;
        b=Xso3W2DVRr0//KWC7nZyQmG3kzZ3O6Y1NUyEkuaPMZPAvYZT4mNKBDNjJgo4LBFI8h
         46TFjXkGPJ1wHU0GI0nHDc6CYVRh4z8EsHvefU3EVUtumVxp67N6S59syGGtW4YNJeeJ
         Y/9YEmskM9dT+o7UoQm5AdfW+iPcLn/WDRZmbDbP2Af7vSYSjBaNXRmCNfWumT/EAQGz
         5y1ilFPT7E2SMA4JC7W4jhoijh1jShKDHJ5X7j21asThAjcwfNBaZpb6LX5vBvdY/VJz
         qyhmHw+PmzbTgN0hBdskSiswScCF/mdpIbBrqk/0Yt0HTREABqDKFPpsLp8lSVwiGcxD
         2IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804718; x=1791409518;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TmzptZmFD4kymUTncO9Qq9vTT/IrpfVRobSN1GvypKQ=;
        b=lJHj65Dxywxktw15wdU+b/a98dU66sZFoaii2gGYgT/6crQ1vI/frjyfc0dt2z1/nK
         SGIn0m/DjvB5pxDYfjFhLYlroxKGusETz9HbSZ2u75JQFRZey3Q1695TD/fOdbB7/jYk
         1zWm3yKzmI3uUE0o2b0sjCAzkJFRkpLNaFkMRMwR+6ZsBcfNtZ5UIXFMriR5cSdmG8u/
         6ae4JmoDsCUUmLC1IMImTzxNJoz1y/qMaFE/cxGaaXE2ioeB0wfADRoDs81DXbxEW6gJ
         Uj4AAuuukGkBsN3Kvtq/1Gy6cpCfxRhi85Qi49YfAH5FFOd20mMPcVHR2WgLwbsID/Cl
         5hBw==
X-Forwarded-Encrypted: i=1; AKwUvBxBOB7g1j8NrdC/yCTl232XyhGHyD1J40KK4OsjxPzdiV136wQhkXmC4NutRr3YiWTRew4NjpM48ZkiYVOn@vger.kernel.org
X-Gm-Message-State: AFq9FYLZrxcDFwkJjU38mHwET2LF9oNip5KRMEM4NUByvNYQb/jZV8rS
	7GzKCSLf8H3/lLkgPr5I0UHD/fsH568mDlul+3DmT7pOlGeEqgHR8fUgecvlAo84wv6ucr1wZbM
	hWaSAr6v7aruhx17PGZtyhyLJtwe4mSs=
X-Gm-Gg: AYBFou2ylR7WJkKVK3qSGFuMdwjfdFXps3i0CBhXuWipgDRDbKbVVjBlfRBLTrkbHRP
	B7uOLdNNPbZsTm9GslJqVd9R9wvKo4vK0zqZQTEyfE2aZqUWRf2stcT/tyTuskEFwQM8U0yncTJ
	hBprtHYctNiSA0avCyAvzebbSuYtDMZPMAkgd54MdZVjJtpciq106NBO3Fcs3NSGRGPa9y+beWi
	NqaDOClYSElRPveAh5GuHavrBENEsw+IZfUIZyW6l8t1d03CcP/Y1FVAJ10v3FmuML4NbEhO802
	73IRz7UxXPRT7HHCH7i7GaKo7NV/lz/iyv60JuEyPH49am2crpwD+7af
X-Received: by 2002:a05:6402:a0c8:b0:6ac:9145:7adc with SMTP id
 4fb4d7f45d1cf-6ae197f807dmr1937264a12.0.1790804717696; Wed, 30 Sep 2026
 14:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mitar <mmitar@gmail.com>
Date: Wed, 30 Sep 2026 23:45:05 +0200
X-Gm-Features: AclHuK_os7J_qSTseF2-q1yDEA54saSmM29NRE0m1E3A45OjVezUpEjaBz0C_XA
Message-ID: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
Subject: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate() and copy_file_range()
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

While adding FUSE_HANDLE_KILLPRIV_V2 support to a go-fuse based
server, I noticed that with it negotiated, fallocate() and
copy_file_range() by a caller without CAP_FSETID no longer clear the
setuid and setgid bits of the file they modify, and that the server
has no way to learn that it should clear them itself.

The kernel makes the decision, but drops it on the way.
fuse_file_fallocate() and __fuse_copy_file_range() both call
file_modified() before sending the request, which ends in
fuse_setattr() with ATTR_KILL_SUID and ATTR_KILL_SGID. Since commit
8981bdfda744 ("fuse: don't send ATTR_MODE to kill suid/sgid for
handle_killpriv_v2"), fuse_setattr() drops those when
fc->handle_killpriv_v2 is set, expecting the server to kill the bits
when the WRITE which follows arrives. But no WRITE follows
FUSE_FALLOCATE or FUSE_COPY_FILE_RANGE, and neither carries such a
flag. All the server sees is an empty SETATTR before the request,
which it cannot tell apart from the one it gets when only
ATTR_KILL_PRIV was asked for.

For "fallocate -l 8192 f" run by an unprivileged user, on a file with
mode 06777 which they may write to, the server receives:

  GETXATTR  "security.capability" -> ENODATA
  SETATTR   valid=0
  FALLOCATE offset=0 length=8192 mode=0

and the file keeps mode 06777. Without FUSE_HANDLE_KILLPRIV_V2, the
same command clears both bits, since fuse_setattr() then turns the
request into a SETATTR of the mode. I verified the fallocate() case.
The copy_file_range() case is from reading the code, as the server I
tested does not implement FUSE_COPY_FILE_RANGE.

This matters beyond the mode looking wrong: fallocate() with
FALLOC_FL_ZERO_RANGE or FALLOC_FL_PUNCH_HOLE, and copy_file_range()
even more so, change what the file holds. So somebody who may write to
a setuid file can replace its contents and keep the setuid bit, which
is what killing the bits is there to prevent.

It looks like an interaction between changes rather than a choice.
Commit fe0da9c09b2d ("fuse: copy_file_range needs to strip setuid bits
and update timestamps") made copy_file_range() kill the bits in 2019,
which stopped working on FUSE_HANDLE_KILLPRIV_V2 connections with
8981bdfda744 in 2020. Commit 4a6f278d4827 ("fuse: add file_modified()
to fallocate") added the same to fallocate() in 2022, which takes
effect only without FUSE_HANDLE_KILLPRIV_V2. As far as I can tell from
its source, virtiofsd with --killpriv-v2 has the same gap: it drops
CAP_FSETID for write, open and setattr when asked to, and calls
fallocate() and copy_file_range() as they are.

I think we should pass the decision with the request, as for WRITE and
OPEN. For FUSE_FALLOCATE, a new FUSE_FALLOCATE_KILL_SUIDGID could go
into the currently unused fuse_fallocate_in.padding. For
FUSE_COPY_FILE_RANGE, it would need a new field, or a bit in
fuse_copy_file_range_in.flags behind a new INIT flag: servers pass
.flags on to copy_file_range(2) as it is (virtiofsd does), which fails
with EINVAL on any bit, so a new bit there cannot be sent to a server
which did not ask for it.

What do you think?


Mitar

-- 
https://mitar.tnode.com/
https://noc.social/@mitar
https://bsky.app/profile/mitar.bsky.social
