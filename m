Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5B35E1C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690249; cv=pass; b=PZioDYbCNHsNNJVWpd+n0eJcAJgIOb2hkhMnHAdpC46hDEgnh6Mt+sz4Ndb2ZsrS1MO2AdBF3jwMrJzifi7LsThobloUD6OvCfiwfVzi5M7FsrwI6PfWmeFtCMrtJ2nxqegs27j2tcV5cDJ36ASVDrGD9Km8Nq6MmiQEk6T76nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690249; c=relaxed/simple;
	bh=icaoQlncuNouot2ubF2dsoHbwyyeV6Bw8zTIqKHHtao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNjhigPcuNrU6zu8mBXOslAIG7fIZ8z+9JOBfPWhJJjymre519oh31V3oYzu7Cvd6tJvP1L+DeWi8gOcgCZnoEgoLWDc/1QgAYT9cBu+GKFAwg957o9iQDpez8vb8QGzsTTd3FhvBaPDu+4gHsEJd3R1CPVbhcnwSQDtMhhu41M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iws//TSa; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iws//TSa"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10e86e52so1394131cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 20:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784690247; cv=none;
        d=google.com; s=arc-20260327;
        b=Fo6EVuUXzTjTxz3RRFaMFy0jqQU8qw9yveREUrAb0mjaBnsZP6NprWr/Niu49rQPqv
         s7rTyrxgwvOFLqDarxOA5HuitZfI0N2tcfaivaat/K/lb2W9o3pcPBRfJJrEvCF2j4GQ
         j+6Z36iksjSd4iLizTQx2SeDpZy600NS57O2NvN0pIYo2Rivvjv1xGQxtYfG2nMpG8FU
         wg/cwsRT051pb3LiDqKUOGRoLnI5gGw3+pzjIt7pL9vEM2tvj4F4y+tcPT2ft4gXEFjA
         U0pD45eeUqW1SPMSvlFv80x6+YjTMvatlpmqeILz8LVpudM7P+FeN6NZQCxaALjSFgsM
         e8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j4jeUlskt2tIQj8M1PMkFdsb+jXr8VGm4/YbSXLXbIs=;
        fh=wUDLtChmoBV8LADV+FVu9b8Yln8AinpnsswdGhPmdaQ=;
        b=en1YFmqov/OqHygmDuHo7FtnH6WZMHn5tiRYO7YjIVW7Qg6S3HJneZBOj/P4ylxthV
         UdCC4wfibwA1GIj7Gf2VSq4B4uKcmNtXOzjkXnxJntbGpL3yEo38M5UeFZ8Hb8WWuCzE
         f+EDzoWwvYCPB39NMnNoeCVg716tli6Qj2qT+cs9y560XDlS7llpYCczl6WTtdhwkBeP
         RwgfQvA37hlIApM5JjFx/M++3Yq663vT+zL/PerCNMmG4V9zC1ndITYmo9FqkSoczrFn
         p1XRR48b+1sbEl5OMrRmhDTBC3e7YHGZ7uC47S0fsROK5Bt5v8l6mlIKdrJ7dAIBYugp
         +H6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784690247; x=1785295047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j4jeUlskt2tIQj8M1PMkFdsb+jXr8VGm4/YbSXLXbIs=;
        b=Iws//TSaggngEc7WiLwwl3PUF9mtsDUsFE+BQFiSXxcjV05P/e4/H1qpG5JH7j+StS
         8qYj3/ULABkfToQiz8O9heMD/agYVyPhfuK2WhD/88CkSj0WE/iKJyVpDSYVHFAXoMa0
         s+a/X3K3iAWXDQWa1P2bkgRmjc0+U+gKwIZjCFniGqYM9sFJL7CoqYxY31mIrltv8UE5
         W22l3mvy2By+VL/6XzCgfHPRD5/RnPU5icollXxApRNNWHOK/QIPGx1XAreAkIC4ol/S
         eFZ/p2BulDPLH5Np6uYt9RdaHpd0MPwv5iIgXMpt2BgfPkcGm8Im2a/zlUIJbMm7227A
         3RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784690247; x=1785295047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4jeUlskt2tIQj8M1PMkFdsb+jXr8VGm4/YbSXLXbIs=;
        b=SKKHnQVto3q4N/l4uY7h/oOacvOSABWWGyO8WxuBW6Ntmo6nyYrIAG7smdnEZZcAl9
         PIpjsy9D6wmhA4OOAsww+jgw98uia8/JqWZ3axJMfUNbwe5FrBT/eM6YY9Fn5jhPCLj9
         QTH64GNMhF+MgfPnT4XaBaanAq+moGXpYN5qIgt2gN/bA62nBnkXvyjyE1iDdK7qakM7
         JMfdGgaGoL1WCPbqIIY5z47cVRHPpWwNadfZmqNChwnr740scFVnPnIsqoFlm6M3MjoS
         /v+wAV9bAerBfOe/pbfj0HwFZia8ZIwa38jPe6likyXcWlZuAifLu1uFBCwc9oIcx04V
         Z49g==
X-Forwarded-Encrypted: i=1; AHgh+RrhXCOMy7j2t+jIHinrbtqXBt/LqwHdVRwGNKZUM+9FwP5Ir4axEIlhPeR1GFCQ7XFomB1M5mA4DVzgC4LA@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKp1zutJTB/3Uh2muXzKRyiKct9Z7JaceWcF6tEQnAtMjCkO3
	I5DBSQ6JJuL5hAE2b95FgPJm1tzht87ZCQ8hjRf01HXXmu7Wxng+jQNUflIdkKMWuYQ4rfRwF/U
	LDZyi07bJcQsT0rZfaRUeDLoXEEEzZzv/p1Ua7Ko6
X-Gm-Gg: AR+sD11B9ypq5u6rnSBJJANd3XkaQAPGSfHL/WiTn74dKEzceBhePuXB0+WsTJe5xAi
	yUkV+gmA4uX0eHbCpNZhykUVS5lSLkWI1otl2SE1hWBeTwz8wYmbNv7Pn1htAjbiKVVdiAsF6O+
	vv4+bdUGVKXU3Elm4q1gm8+gU7w0YaBwdD6qIfewCpoMm6bGrlOJNSyQZ7KPxcLpcAZSveh718m
	awayew3EsZWRR4hhftbWQd/t6KIW9QwYHPQLWpoQQjgi4yrk0RpHKXYiG/V
X-Received: by 2002:a05:622a:6084:b0:51c:289:6979 with SMTP id
 d75a77b69052e-527efd1f994mr3666981cf.21.1784690246021; Tue, 21 Jul 2026
 20:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721051903.691848-1-kaleshsingh@google.com> <20260721173939.6bee67b6af17b54961daf4f8@linux-foundation.org>
In-Reply-To: <20260721173939.6bee67b6af17b54961daf4f8@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 21 Jul 2026 20:17:15 -0700
X-Gm-Features: AUfX_mzdJ6l7ZHNA7SRCoMlMuAxO3rUAUEiO9n109Oxt3pqHFJW2MXorJHs2JRY
Message-ID: <CAJuCfpFVSrP2DGNr+tZadVzbuWvi467F879qndkQ4VTx6R1w_g@mail.gmail.com>
Subject: Re: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kaleshsingh@google.com, kernel-team@android.com, android-mm@google.com, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:39=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 21 Jul 2026 05:19:02 +0000 kaleshsingh@google.com wrote:
>
> > From: Kalesh Singh <kaleshsingh@google.com>
> >
> > Modify smap_gather_stats() to use walk_page_range_vma() instead of
> > walk_page_range() when walking page tables.
> >
> > walk_page_range() internally calls find_vma(), which asserts that
> > mmap_lock is held. This assertion fails when reading /proc/pid/smaps
> > under per-VMA locks (where mmap_lock is not held).
>
> So the kernel is emitting a WARN trace under some situation?
>
> I'm surprised.  The offending patch is only six weeks old, but we'd
> normally hear about this very promptly.   Is a bug report available
> somewhere?

No, when reading smaps "start" is always false, so walk_page_range()
is never called.
Kalesh, this is not a problem that ever happens in the upstream
kernel. In Android kernel there was an out-of-tree change that caused
this warning, which I pointed out and you fixed. However, the upstream
kernel does not have this issue.

>
> > walk_page_range_vma() walks a range within a single VMA and does not
> > use find_vma(). It relies on the VMA lock instead (when configured
> > with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
> > locks.
>
> Sashiko said a thing:
>         https://sashiko.dev/#/patchset/20260721051903.691848-1-kaleshsing=
h@google.com
>
