Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E6BA34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320343; cv=pass; b=Qli88/JhEfKNuPZ+5cv/2+pGxcBj6qXW33HbUIONcwFdkqLZ8sTIQ+lOsRd0fdqOcLnsE0fZOR/CXKGPCdbmPVJA8IAU3SS3GfPf+Hb8thErtiz4RW7FOH0nHHnQSfSZ0e+jhZw/lo2Ch/k3ZI4xZ2p/UMybKKzUU/n7PFq0saM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320343; c=relaxed/simple;
	bh=sMCXD58Ck7XMjqxi99CPuHjkI5MeTfpATIu7xweU010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFRi4LS/1z9pBquhv6JHsqjrTva9NBmjXjBFBu04LSAh2Uf0C6zcYdBGUHgdie+c53SgHAg7BAOjGyqYqrgtPoSXeZ6P724u9qw0UEkaqiTp4Wef3MrEWs+gk6mC1MEEOBiuNnGqgjVSSrTAWS2jB1rC7xwO3dE3dH14MMQ1n3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOkW+V22; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOkW+V22"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecd7216cso820599a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 06:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787320340; cv=none;
        d=google.com; s=arc-20260327;
        b=A8t2zHLNMnnlI4NkK5bp93HLUXMnCkIZyFuMBp6DwJ+KKDkNexD5SwhB1N5ro031JF
         PjtN4LTjVqODASEOhNKCN+XT/+rbHhNttMYHlDYwLXVkA5pZl4OT7I5FleM7USVfrKKW
         204HlRSOD2jtmxG4Vsgj2Z28udRLLmiXaNWIPUwlddB8VwwZgrzpavb/wfOXT/ZkMNrF
         8BWEoRVP6FHqFuhHkfHoJUpmzOHPxvYV/VIj992Zvx1htzN1wR5BA2+luPAWjrDmcsYJ
         6BdL/TcahDGowa8SEx35k63TTCho/XSFBLzFi3f94O2aQkNLGeljnBqMUjnIyzFFhf1u
         pWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        fh=FOqC+Lkc+TS80ETjpLv+nw35J8YpEMTbtrVNV+epfZU=;
        b=VorINtgcjlcAhlPst1zwMzof7/b1kuTkVxoeYsfb4fVXSXDe+A4QFbMr2hKxNFnFZW
         eRISc6OgeQMJLHmHtfw6EtJUqEiTWCHAIcnjeqUdBAIeBUCXcCtfpZwpg6XDnBquSBIC
         XMyAYkCJVYi1WuibA9j2GeiOZmxHjSZIKksczoA5MOL6rPY81/paQpx65ztQAxn3+KOg
         ZvzWe2dVA4m7IPFZP2J1AEsvD4UF8n8sd/18WlNYFPB+H1ssE9OMziD3I5KAJWjYfQrv
         3ijKtYTqBYFsgimFX6BU7F1BC34xvNQjIFN78a7mJF+dysiDYRjlmRWwnG30CVu905i/
         wuXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320340; x=1787925140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=AOkW+V22rhrAxcDrepdr3WEBsSoDX46UNW13oEtBAtR86Zl+J5D9pmddAY7Bk0995M
         QuotVn4oehPG+vCPdruMMX5U4gu8EZ+yy2gw7vaEU7vUfqAs7W4uvZAshk9+a24YGt1V
         hE0y9L7jgoUSzx6YXi9cqEVIleBrHRIctPZ70NwPdGmB36PovDhg/W1EwlBaMinmXMVv
         E7Bvs3AtK2x6BJeUad3NremEA8nwU3nHssME2Xb5WOKNMZyRHRlhluK3JZwXDkD2/oSL
         BxNctSj79dDb32MfOHET0LHHkDLRVhjufn6uuN60QOwQNIrvxdZPfzC/N7NGwXuZjD5i
         ukyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320340; x=1787925140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=IAYPFZyFOShxalihptmLERlE1wCYe8083sDOuR53zeTTlwOGVBf9DSuIkxBXAOg9iG
         32zzWBNqXaoOfns1SRp+a6YXwUqigTNWl6QeSj6XBjrtcQ+8vgN6/qkNeN+0ahzXlCtv
         zop1FfoNOitO3cZsNP+TlmWAJ5UhE1w62eAa0Y6x35EjS0d49n8VvStAc8S/0Auzy1TL
         4OQD41zyBC+cECz5CdmHiUcwpXv8araXXfTRhJtuFuYDCx2FM03n7jjf8bgUZp41N3W3
         2kx6MdK2in1ZJL1E9qe7m8hlu2Ft34yZEPzY4vNVA2hWrarVKxZOWE2XO8XLVEZk0E5f
         pXJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1A7Hl1ISwF4LYU19KSGNjyR00suz0iKIT6Tor07Urpgx+cJ2Ux83P3uFN12Xoep1/4iU+0/l8aYcjFb2F@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVd/Ns/02AFfK37hI0Yu8KspHg0ti/S3iI3JgXxeTk5Gr37Yg
	ywwodr6Jjz8YtrIJkd2WnYSyViVCdQ9hjopNSco/DyJH/B29bfOPcIxFNkOhHFB0n/iM20qa/SB
	t5OyJYcvlAd9sJzsZcFGWx/E4oRYEeBE=
X-Gm-Gg: AR+sD12Ie91PBtmbB5B0EjV7eH9izFHhXLqqx/ybPUvKjUzAra6xXBphfOIpg3+6zg2
	FM8N24mIsM2ZVavPvJI7aHHamQf2SdJ4JzFfamzTvgCLkrf2qfIMZ64610DqsZPnEwQUgP9mwfb
	BaWkS8JYXFMd5la/lM447pMgaJZQsQkLrGJyhzkVvOyoiIulyUa626GTPDpiMJgXMm7JMLpWuMy
	sl/VEziAl8ODxaPGVeRInwMA4xI41ipD9S5c2DxcHaA2uqpGCTpxLD+vQNazz2ntKe24moR7aJs
	3IXzvJckxI6HzSANBYTWDtGmmv3rO3vJrxI5gMRrRecQ
X-Received: by 2002:a05:6820:341a:20b0:6aa:e176:bcb5 with SMTP id
 006d021491bc7-6b15925da2fmr5108790eaf.14.1787320340365; Fri, 21 Aug 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
In-Reply-To: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 09:52:09 -0400
X-Gm-Features: AcwNN1XIMQRcAUBNk7fjxozSpQ8JckvqGIQ5KHe6kYNDH33rw4pKhCm-h8pgeiw
Message-ID: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a proce=
ss can
> > > only create anonymous executable memory via /proc/self/mem if it has =
one
> > > of:
> > >
> > >  - EXECMEM (like for other methods of creating anonymous executable p=
ages)
> > >  - PTRACE (like when using /proc/$pid/mem of another process)
> >
> > Allowing it if _either_ permission is allowed is unusual in SELinux
> > and seems prone to errors.
> > Is there a reason to not just require PTRACE always?
>
> Hmm, that might work.
>
> My two concerns about that approach are:
>
> 1. This is an operation where a process acts on itself, while PTRACE
> is normally for acting on another process. It feels to me like those
> are different types of privilege.
> 2. I feel like blocking this operation even for a process with EXECMEM
> privilege increases the risk of breaking existing configurations.
>
> I think if we want to gate it on PTRACE, we might need to put this
> behind a policy capability and let policy authors figure this out?
> But I'm no expert on how new security hooks are normally added, or
> what SELinux policies outside Android look like, so if you think it
> would be fine to just check for PTRACE, I'd be happy to go with that.

I don't think a new policy capability is necessary here. Is there any legit=
imate
user of this capability that wouldn't already have ptrace permission?
The other alternative is to introduce a new permission for this, but that w=
ill
deny-by-default on existing Android and allow-by-default on Fedora based
on handle-unknown until it is defined in the policy. In the case of Android=
, my
understanding was that kernel updates can always be coordinated with policy
updates so there is no need to worry about a new kernel breaking userspace
with old policies i.e. if and when Android ships a kernel that
includes these patches
they can also ship an updated policy that allows the new permission
where necessary
but I could be wrong.

> (I've caused stable regressions several times at this point and am
> trying to avoid causing more...)
