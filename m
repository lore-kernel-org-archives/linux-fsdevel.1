Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C123AE1B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330734; cv=pass; b=dhOXNP9s8UxovQtV6LVnmxWae0UIosRgrzSUxg1fstxTCVzHHCbn1T1qUJOAgV7zXmVd2oKHv3GnxEQuo5qiC/oodqGZ0RYqW0mrwRzimL8lhlkk2svZu8R4O+FZPNT1+RF4O+VQnw5uBlZzeXEWXt180huK9gQLUJI5cfdNUJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330734; c=relaxed/simple;
	bh=cyC3J+VH/K8HQzqFUvlj2hiBlDlG7YN1Wfj41a74bn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYlU+SVCJo42XLbwcx0d3+ZVsK3SVJ7/GizoCipaVr76eFAovQVJGkgUufx1H+YAyAEcs1f2UgNOfteme7WluohHYgmZPvdfuSijZB2ZEPA+IdGpy/Muj0qfeG2HhT4VvFfjfoGWEA/jUVm05e8YqkYF6HiCH7h8ZScyJxuoOBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYffDzDC; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYffDzDC"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270fc2bdf2so5330c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777330732; cv=none;
        d=google.com; s=arc-20240605;
        b=kuojeoHdjar2NeBrWQJIVFKDilH35Jb3LTIqcjVzAesQHgyp1EXWQUKzjgC8QpBFZP
         ceUP5xfSPv+zb/1HT/9TQ60UznddSH4s6K0UVYJkScUgNKEvgzfTcFDDiyVBa4YvbvRl
         owrerOUMgKpDzDIn6kBZJxfrGaS+BXC5rZAqg4xeo/itxwiUxU2m5z7wHPT9srO2MLAy
         rl9rD4aVA3ppgYLcKZZ4uffLMh4VGYaoecB6qoPD8WK2n/QBpvumlSeqNEmAko1mBpAQ
         Rs2+XoJxwB94K5k9mS+pNJdnjcLaCTUmtl1uNRUzuK+ONY0Ed4jLWHAU6XFUln51SMU6
         oe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mFDjDkHXVh2Z+wp+XcjLdnVYy1AJI7gNEwLbuf8ELlk=;
        fh=55Bg+pl9o9aLMM2/AW8582uhCvEXymVCyYtmw0mOuPY=;
        b=B5XklyTcJG4tCzpVXaNbVxQQ/PEsqUZTpcI/jnKMOH3mqDnhRoWZYMR4hQMqUqQUbb
         W/G7SIdTcBcDjZauVnRgAMgxPuyg4teOz6m/9NAmjesJMm+POCzNqzw0J8IU5n8DPGAQ
         btbj0NddbNJAyzA03POTZY9DS0RmNWaKuj4J0WCbaYA8tHyuJfcgqQXY98HuHc9Ucdtk
         gguWrbUFvUJQpzjVuXUwQqcdnWmdsvjelDhAJ79ierC3Wt4h1fy8r20jJ8ZRbH9HUPVf
         Hv0J/hNAHugCo1jTDzO9oxoA4DLjEezOzjLWktRrsGJDcVnnJLnnz1gdcL9Q1MYbHVV7
         qltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777330732; x=1777935532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFDjDkHXVh2Z+wp+XcjLdnVYy1AJI7gNEwLbuf8ELlk=;
        b=JYffDzDCndMCeI4+/tScGcMSPWSv/bd7uXxqBY//2Xt32+BFnC1j/7bGZPxJYozM20
         kPzMooitA1HkRHyqQEolXIoVw9smcuxLC7Zb/Jubbeq8OCLEuOCQSg4tPjcT6+hJvXFg
         78v7yl3lNrXpILhkFeCa8E71gGwEuvAoMuziLJGtXi1facdKFdeOv5IbEQdmrsmU1Pjo
         xu2yTSpuv3oZIiSm7OUL/eV8cOdUjdaS52zF/rgyRLBfIp+pLHl58UkqqOPzSjP8/pG6
         x81R5oWL4fGGv9OSiFi1h82RvtqlvyQsKNfWMb7k7HHLUe7Ed+Za6kbrmWDKh+yfY9ud
         ZPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777330732; x=1777935532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFDjDkHXVh2Z+wp+XcjLdnVYy1AJI7gNEwLbuf8ELlk=;
        b=Yn6sOHnxAgLkaWdCphEzMtZ/+uidyMKBgp4NcJgpMWlOVAivTJ6r2mX03f0sT4sqEi
         zKk9Ff15jx+r+QlcDKircYIDg2/Yc5pfWiE0M+kPCY61mbVD7kzQOvFot0mzes5vW7eh
         77x0ARYwK8TPz6FDSnyRmKv75P9xMMwKlJbpnaKQBm4ORne7ii1xE+wIsNvsFIGV9mPA
         nW3gX07kAV1Liovh5rMs8nI4j+EH40XHb6yU9+GwwgorqCgAHoIhAMdHqbObjHo53g3T
         vKUQbgJV7PKmfbtuuti21GY+nJ03/fN3+9hsmtYTw2FkTksA4jQbGkFHGmFOLOsh89PY
         b8GA==
X-Forwarded-Encrypted: i=1; AFNElJ/dUqaAFIOg6R6MJW5RGfFDvcC+WGSANIImwE/YLCPoKzOWQX7hUt+irgW4ziEG7enFkIOBTNawqcLUxk38@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ionul3hUCGzPzawrqXeVmDgD/Mge/v54ucMqIPY0tUi5jTk6
	gp7UZ1OJBOEh9FzF0Wt3UBenT7OwsMBL1At9VkIQvRGH4115cXB05o1//Oss0WGRwQ/Os0F7CAa
	8A9CKkE8gE6NFs653K/X/NUcE+J3r47kIpwA6gtS2
X-Gm-Gg: AeBDievrZnXAFb48088GIufcJTcrUR9/ozi+KFmQeAFVvH4f97U4cH/4ABzTC+jmhb1
	6qHQy2VsCfBqb5Hers4txR2PCw00PAJWX4EAoEoFCw8gcuK35eer2qahP3ctqlwZCxJ5rmzApKx
	rZe74saCeuqsEa6leOpejochsQNLKWUul3gzXwANw4uQAV4dn6/PNcFrksXKRkwYDdV0/DXiuR1
	aHM1W0PW8ObTuPvdEstyp0FYWKVUx7XcWg+uOPNBrs0YhJ8wmO3vG9cwcG2H/I76uwb/3IsHTCg
	wfKGNhCjmGnXxy28j+Q3kVk7+fb3FAcEl2GliOQ+
X-Received: by 2002:a05:7022:e28:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-12ddd6002b9mr109501c88.12.1777330731707; Mon, 27 Apr 2026
 15:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427030148.653228-1-fmayle@google.com> <c7f94ce6-1dfb-420a-b073-d86abeff1f76@kernel.org>
 <CAC_TJvcM11got-LcMo24OTN8uXa01oVvUX6HmVvrWMJWVSgEzQ@mail.gmail.com>
In-Reply-To: <CAC_TJvcM11got-LcMo24OTN8uXa01oVvUX6HmVvrWMJWVSgEzQ@mail.gmail.com>
From: Frederick Mayle <fmayle@google.com>
Date: Mon, 27 Apr 2026 15:58:40 -0700
X-Gm-Features: AVHnY4IRZsDNSD2m-H5xb40HcijzEyG9TEJRAtLxMG16_OmGeOcdmUtyIgLLGcY
Message-ID: <CAHCxdc7JxwCNjsyyuPxuaVd7njgXyOEHvknCvjSKLvvU7nRAsg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: limit filemap_fault readahead to VMA boundaries
To: Kalesh Singh <kaleshsingh@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, 
	kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 9:23=E2=80=AFAM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Mon, Apr 27, 2026 at 5:41=E2=80=AFAM 'David Hildenbrand (Arm)' via
> android-mm <android-mm@google.com> wrote:
> >
> > On 4/27/26 05:01, Frederick Mayle wrote:
> > > When a file mapping covers a strict subset of a file, an access to th=
e
> > > mapping can trigger readahead of file pages outside the mapped region=
.
> > > Readahead is meant to prefetch pages likely to be accessed soon, but
> > > these pages aren't accessible via the same means, so it fair to say w=
e
> > > don't have a good indicator they'll be accessed soon. Take an ELF fil=
e
> > > for example: An access to the end of a program's read-only segment is=
n't
> > > a sign that nearby file contents will be accessed next (they are like=
ly
> > > to be mapped discontiguously, or not at all). The pressure from loadi=
ng
> > > these pages into the cache can evict more useful pages.
> > >
> > > To improve the behavior, make three changes:
> > >
> > > * Introduce a new readahead_control field, max_index, as a hard limit=
 on
> > >   the readahead. The existing file_ra_state->size can't be used as a
> > >   limit, it is more of a hint and can be increased by various
> > >   heuristics.
> > > * Set readahead_control->max_index to the end of the VMA in all of th=
e
> > >   readahead paths that can be triggered from a fault on a file mappin=
g
> > >   (both "sync" and "async" readahead).
> > > * Limit the read-around range start to the VMA's start.
> > >
> > > Note that these changes only affect readahead triggered in the contex=
t
> > > of a fault, they do not affect readahead triggered by read syscalls. =
If
> > > a user mixes the two types of accesses, the behavior is expected to b=
e
> > > the following: if a fault causes readahead and places a PG_readahead
> > > marker and then a read(2) syscall hits the PG_readahead marker, the
> > > resulting async readahead *will not* be limited to the VMA end.
> > > Conversely, if a read(2) syscall places a PG_readahead marker and the=
n a
> > > fault hits the marker, the async readahead *will* be limited to the V=
MA
> > > end.
> > >
> > > There is an edge case that the above motivation glosses over: A singl=
e
> > > file mapping might be backed by multiple VMAs. For example, a whole f=
ile
> > > could be mapped RW, then part of the mapping made RO using mprotect.
> > > This patch would hurt performance of a sequential faulted read of suc=
h a
> > > mapping, the degree depending on how fragmented the VMAs are. A usage
> > > pattern like that is likely rare and already suffering from sub-optim=
al
> > > performance because, e.g., the fragmented VMAs limit the fault-around=
,
> > > so each VMA boundary in a sequential faulted read would cause a minor
> > > fault. Still, this patch would make it worse. See a previous discussi=
on
> > > of this topic at [1].
> >
> > I agree that workloads that do a lot of mprotect() magic likely do not =
depend on
> > readahead optimizations.
> >
> > But I'm sure we'll learn quickly if that is not the case :)
>
> Hi David,
>
> There is already this limit for the exec VMAs, so perhaps these use
> cases are in fact rare enough; but we'll need to see ...
>
> https://lore.kernel.org/all/20250609092729.274960-6-ryan.roberts@arm.com/
>
> Frederick, could we also now remove that logic (EXEC mappings)? Maybe
> in a follow up patch.

The VM_EXEC branch is still meaningfully different from the read-around bra=
nch,
it sets `ra->order =3D exec_folio_order()` and `ra->async_size =3D 0`, but =
I think
most of the details could be unified. I can try that in a follow up.
