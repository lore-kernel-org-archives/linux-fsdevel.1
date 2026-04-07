Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E537E2E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541974; cv=none; b=TLouhcer3HKNIP30erj2dQ/1rk+UVxb/HDn+84+hDQ6pPu5HvL8upGbb2JPVOQEzumqNlo4BDebXLfYQhuKSvdIzV59XJu7sA0y1zLMy73Qe6pFOqW+jUSqNVre9RqUF/okpMGrEJqQZjk+5sLfcW7gIWHJqV4J/2+O0kq8juvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541974; c=relaxed/simple;
	bh=lXKvxpMe3oACGndHm0nYw+fzaOXCgK65PWIIW7vphvk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EoCm7RikCasi0VUdftv7//Msby6dLkrEH+ehVDA2VtrbLaMyLA/QxXoMhOAGOO0YdojH33w16zHOz4hXA5P1TvCKtJRcRgkIGRhjuVWEL9H2PEWQE0nTPBveGW1LHz9rtfKOQinVSEUA/EFWag9eyg9BBRKUcoG/brPm351JcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3OdJ2a6; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3OdJ2a6"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4043b909ed4so2581228fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2026 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775541972; x=1776146772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMLtmwh87iDT5IsQ1HSkXUyndVMXwToXVP0n0UYd7JE=;
        b=n3OdJ2a6/9tIWd6YVSRvqJcD6dKavx+ctcNmjicsFWOlq4wHU+jpJkPkPOfTHhfu2o
         Vu7qEIAgbdllRKOOGvxQnvENyeOmUDDoZzhtopb4kye1d5Ympze087q/Mcpa7rn7Edo6
         0LkQxIkNXWARmuGaIE8uYKDhRZdL2ejBccnbt1pg4xhMwqDRiVbo8XQQQqaiqZwPDaJq
         zBr7goOTEU5lJfm5wgfd1IzA51S7qkzjrKP8yrGgZQF1FCdIDrwbdUsTLyUR1iGSqpqo
         Dln8GPnqOCMTYULnVYJdca56aLeH30jWk51+gZ5gW2fcPucQb3KcS+bliO1XO5aC8Mgu
         9C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775541972; x=1776146772;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMLtmwh87iDT5IsQ1HSkXUyndVMXwToXVP0n0UYd7JE=;
        b=VNUzIlxm7wPZCjsUA9ur8QUz2zl4ydB0pKqinFW/4knfxjStfaH/uw5qCxxVxtxtyX
         Dz11iwhPsl9BEvR+pQWhyvFfmG4Rgfz5ECzu08u+rzI2KZm+dsLGk0cF1nLtJ2wUbCFM
         ND9evAkveF+oyK3Giww2vSeqPzcCMl9wuSo3kFNWsg7a+zAjW78nB0nJ53ybGUObFzuF
         //HE/VMe80HckGt0bTsxEMPFWLVtqWWQO4EqD/muHrLIxVN+wg+OH+DkgXxXKpNPt4Xb
         ZzY8BhDeZm1Tp8tWMyAVcwbsRr0DuHPop0dLXcEwYgO+SbIB59uVRraq6Lfx+Eiljdmz
         qu2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmTaHHWLc7bNs1YVm3JDsX+qV9b8Kyj31d0SOTk9C5AaSiceAGUCOiAtUmeb192K3WTDgjzFd1QMTYRWro@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZpbAGJBwVNRbLEcgnCbNn18x/wnLM2MbVMpwW9NYyFoGNuup
	Jo2R+1OkZO9lWfuQQ45bmYE/E7EnOevRSa7RnloQGnyBFAMInJzTstUN
X-Gm-Gg: AeBDievQ3X3HkPWUFG0TOYBblh+hpaaxbAKf0/6W9RwkbgO/+egqLpsuy5OfBb+mWUX
	FWdBLSocfSwGr3mbgz2DbXK+Eb7RwlwjAUAJ90LAYy0DPR8/PFXys429BqlCaRS6yews/f9I3QY
	sbImQLP7PSf1dpCsp8o1rn/7kBRREYVYrkuZoojv7WGwrjuXx1NW6s2kxa1vGjSY4YWZRCbrvGw
	sp9p/TEFvgi6ByIUYxO5AGHgd36W7eOVMZNesbx2vtYhW2jHGJz8ErUjSTed/pekgu6/zGyijJG
	Ta7ALMKnrXrbD0RJ/Ty8I+16Sdful7RHW4UGkNBcWK7Z4a4P/88/VO1aaSSxgMkEiPLOs2+8Nf4
	2ZwPu1VHsiMOUvDhgu1cJSroMAoGEkqP0mxpgvNpPQXDB9Fc6MGZU9DOAzV/hFRDvvevoX6lE8e
	wmgIRZBJCblK3AePLFQfs2MLlqlo8j+EGXO134/ltGjhq9rO2Z0lFLdP6de8NE0NPzurcnclUKv
	8LY/cd7
X-Received: by 2002:a05:6871:4d0:b0:417:7b1d:1b2 with SMTP id 586e51a60fabf-4231022b7abmr8328551fac.42.1775541971884;
        Mon, 06 Apr 2026 23:06:11 -0700 (PDT)
Received: from [192.168.50.127] (c-73-5-99-191.hsd1.la.comcast.net. [73.5.99.191])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaed88dfsm13872858fac.3.2026.04.06.23.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:06:10 -0700 (PDT)
From: Sean Smith <defendthedisabled@gmail.com>
X-Google-Original-From: Sean Smith <DefendTheDisabled@gmail.com>
Message-ID: <e5be4e66-5fb0-41d3-807f-d26f78949c3d@gmail.com>
Date: Tue, 7 Apr 2026 01:06:09 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] provenance_time (ptime): a new settable
 timestamp for cross-filesystem provenance
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, dsterba@suse.com, david@fromorbit.com,
 brauner@kernel.org, osandov@osandov.com, hirofumi@mail.parknet.co.jp,
 linkinjeon@kernel.org
References: <20260405225442.GA1763@macsyma-wired.lan>
 <20260407000558.417-1-DefendTheDisabled@gmail.com>
 <20260407014129.GC6192@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260407014129.GC6192@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


[written with AI assistance]

On 4/6/2026 20:42, Darrick J. Wong wrote:

> "Standard"... I was about to write a sardonic reply here, but then I
> remembred that Linux finally *does* have a standard means to transfer
> some of those newer file attributes: file_getattr/file_setattr.
>
> (Go Andrey!)
>
> So, I guess all you really need to do is extend struct file_attr and now
> userspace has a fairly convenient means to propagate the provenance
> time. 🙂

Thank you for pointing to file_getattr/file_setattr — this
is a significantly better API path than our utimensat
extension. The size-versioned struct file_attr eliminates
the glibc times[2] limitation entirely, which was one of
the main upstream concerns with the current approach.

We will investigate extending struct file_attr with ptime
fields for v2. The on-disk storage across all 5 filesystems
and the rename-over preservation are API-independent and
would remain unchanged. The change is re-plumbing the
userspace write path from utimensat to file_setattr.

Two design questions:

Would you recommend fa_ptime_sec (__u64) + fa_ptime_nsec
(__u32) matching the statx timespec pattern, or a different
representation?

Pali Rohar has announced plans for mask fields in file_attr.
Should we coordinate with his mask work so ptime can be
selectively set without read-modify-write?

> So does the provenance time cover just the file's contents, or the other
> attributes and xattrs?

Content only. ptime records when the file's data first came
into existence. Metadata changes (permissions, owner,
xattrs) update ctime but leave ptime unchanged. This
matches the semantics of Windows Date Created and macOS
creation time.

> The reason I ask is, does the ptime get copied over for an FICLONE,
> which maps all of one file's data blocks into another?

It should, conceptually — the content's provenance doesn't
change when you clone it. Currently FICLONE shares data
extents but does not copy inode metadata (timestamps,
permissions), so ptime would not be automatically
preserved. The calling tool (e.g., cp --reflink) handles
timestamp copying separately via the write path.

The question is whether FICLONE should be enhanced to copy
ptime from source to destination at the kernel level —
similar to how rename-over preserves ptime. There is an
argument for it: if the kernel handles provenance during
clone, tools don't need to know. But FICLONE doesn't
currently copy mtime either, so adding ptime alone would
be inconsistent. Worth discussing.

Btrfs subvolume snapshots are a different case — they do
preserve ptime because the inodes are COW copies of the
originals.

> And by extension, would it also need to be exchanged if you told
> XFS_IOC_EXCHANGE_RANGE to exchange all contents between two files?

Yes — if the content moves, the provenance should move
with it. If files A and B exchange data extents, their
ptimes should swap. ptime follows the content, not the
inode identity.

> (I know, I know, you said XFS was TBDHBD ;))

Worth considering for a future XFS implementation — and
the file_attr route you suggested would give XFS a clean
integration path for ptime alongside FICLONE and
EXCHANGE_RANGE.

> Last question: Is the provenance time only useful if the file is
> immutable?  Either directly via chattr +i, or by enabling fsverity?

No — ptime is useful regardless of mutability. It records
when the document was born, the same way Windows Date
Created works. Editing a document updates mtime but not
the creation date. Both are independently valuable:

  ptime: "This file was first created March 15, 2019"
  mtime: "It was last modified today"
  btime: "This inode was created when I copied it here"

Immutable files (chattr +i, fsverity) are a special case
where ptime has extra forensic strength — the content
provably hasn't changed since the provenance date. But for
the primary use case — preserving creation dates across
cross-platform migrations — mutability doesn't diminish
ptime's value. A document's creation date remains meaningful
regardless of subsequent edits.

Sean


