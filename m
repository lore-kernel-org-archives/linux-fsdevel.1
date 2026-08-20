Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422F36212F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239434; cv=pass; b=quRSkfGl3FwTOr0oXlClmJljcx2UUgPxtXR43bz6bN4clC1m7wnmKMyaiT9BRU0gvWG2Uh7UPy7pCDUtj/FtoiMC4EHbRhi36b9CK8KZvYIWmVrrAfizLUrHSJfiDGivZqZkY+EYRtwszUXLmpMhyFBinv4MARyw212OPiodC0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239434; c=relaxed/simple;
	bh=PQ0Uv3fFLVyIJEFAQf/e1k9Wz6QlYJWOA2A7cUy7gUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzMxmPOoc5XV4rFpojPUbn3HOFG2wPG4ya2RXWQt2gBbNqO4PFAiYMf0HAG+EBh/jkRwIn1UT7I3J1nouDnQdn6QcERpdEMmSPaThL3UPCPxJ8KTUSzWEPV/x6nCVS4xIB+YeiE2hcUjUSUEIutzj/jcA89J6P+64UjSTGvig/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noDFYPDe; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noDFYPDe"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso71115ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 08:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787239433; cv=none;
        d=google.com; s=arc-20260327;
        b=SkWINhjdglZhmC+Og3pcXd1+fg/YkOHrv8RBbD03lPdIfibj5AnaXdhpFBanCmXiPI
         OveYH+Xf7ELVesaUqJ8f42187vhrnZ65imlO/O7R5HzgAz9Db2Et6uiSLK++oZzst7aw
         11RAhllyeyXC+2kSZs613A6aAa7XntFfr+G4Cu5PMoytnrui5VKbQ8Bbw6/i4B5ZBLRU
         VO9ApGyuEvlfQJnm6LGB3nNR4VmRQcqxh3vZu19xmQHSCeZHnrLp7HOFhGpUxTOtVk/F
         ets0S4Wnh1mLwa0c8nXhGNsItfe72lJjkmXlryPqWI9cmcwqv/fSVHN+UuVq00zrrKh3
         wr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        fh=CL4/tMzgVoI7rx8f67/A2DXFVhZeGbJbgDy673sMvh0=;
        b=TPuwcDwrhFmd+bU2lh6tR49TMX2Ew4b38rMbC/96hXU0d92Hbl40Lojv8Jq0K0s2ve
         nQXqHUsfiLfNw68NwmIbT1EVCS6sPhz1YIyJltwa9BQiVZrrIOVnWX3zHrq2mbB6W+Mb
         gAeSpY8Xvca6aStLjOuopzCvgLhd2IEoq4O/qAi7G11ox4C/RV5kjdwcesp1ErlSPwCr
         NlMCc9kzM0GiHke3EAxFrdbaa1o2ifAvhGODGDLFfiMk26np14ySw6WmIiLcMD5n5I98
         wMycek2MPH/lk2bV7i/UAzxhDQ50Nm67gYg4oBLx4wltIPV9I6p4D6a7sfxxGpUIjaFB
         99Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787239433; x=1787844233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=noDFYPDejiltH6Z5HYHHnoLKbKNvBxK/7X421zy0ZEtN9ZY48PRqsUlpy/CbFgtnDb
         GmL/oG6LeakrQ35Xl8ZBN7DHeQMTrKvW2XK7bvtzZ2pfJvTHsDNvHlc5gAseTiQAXsvo
         eeEKGH+09QXLquXcZ65M5eTTOctX2VPP0J55dk+isHR2ryvRq4Wuccl+C5B95XmKPAMb
         kcC7z8fKCLGwQIrvP37cse92VpoG2sQ/A0YnqS5MaO4aEndm1it0NThP6Cak6oANZnA6
         lkcnr1jT+yGHI5z6MDEUqsjq0iprveLmbKDGnMYqXuSUJo9UUnlX8Bv9oKYiiPrDqI/K
         QtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239433; x=1787844233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=iTUExpbO9u+RBijMgJIWtKSd29RMhsYa9bhKLtA2utX5HE3hRpxZj0plGNUrAC7IUq
         PAGUtkT0f7vpGdGgbxA5W52PCvaJQAXG3Q6ZqmSE7GeH1akzjCSIlKcAD/3iiSVFpG5K
         iWMDunfYMb/dHLoOkkue7m2FaIAnB1SfSavtqslp+gGb7AJx3GuHSIypM8ElQ6hTKjch
         GgoxblJ3UDs7fsSJcq9e9n/WXOoyuE5cFOj0kfH8M6Nne51BAEL5uV5WaVlCgmbNgRPD
         k+Wv44Loi1BqNxe1WRaWrXoIOY+8pZR6c6/iAkzaAgCgpbN63u/aXHhb+WDn8w8vLkQg
         vcTw==
X-Forwarded-Encrypted: i=1; AHgh+RoH3/iWwlx9jwg/9Vx6rqR8DOXEIUqEaqdq9EpMLGQNkmszUt7B6ra51kiI/+a3Iqt5IgYFdnZkQpz6RwV0@vger.kernel.org
X-Gm-Message-State: AFuF++mA7567TI/E8CDlyK0baelCvG/Duz/gbm1ohQ6P2PK3KEQXdZxK
	3o5aokk3aGJEKXAqzl00LFxKJ8OjUbUihedtRph/AMBkwZdYddc12k0Q1u3lQ9L0CWMXSXOyqku
	3fJWUiZtxn2w94KVNMTrEQBplQtKLSa7Bb4Dc8AfN
X-Gm-Gg: AR+sD11/ORZPAuFhX+OL403aEZ0nRPCYnBlH+a0XxmQ028P31Pv//lF4tWK5TLnwCd2
	DJucnOSQB8NFzTZwLgHYN8gTS3DyHC5LpL4btkrXM/xQ43WzrE9gg0C5z7UFTBpbCrZQUWRXMnH
	xNp6riklEVcR6S/FjXpc30D/LAv6dhubhOa6j0Q2HNqUz0Ft5TXtrULY19XUb/x3EW8ZyH/qsN3
	xTV0opmsdTcJM+MMtW4jsHp5fxkKZeUspxeW3P6+fc1UQ/vWOeiXw8RT/b374Y0XQs5nYsdSHKB
	0Z34l7vBHo7u+R2hK/b2rsu0/CySxqd2QJot+2luFSH0loQW1BwgaZLXM9LOA1onHDanNo2W0g4
	YD8swRHrRTsvNrHvkUhtC/6S6Zg4S+w==
X-Received: by 2002:a17:902:fd8b:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2d61eaf0bdfmr8352105ad.18.1787239432253; Thu, 20 Aug 2026
 08:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 17:23:15 +0200
X-Gm-Features: AcwNN1WfGO0jtM01Prl7T2bhwvtOuD_4x4w_Hjk9Mm13CRcqjZxrghBAfwYQIPw
Message-ID: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process=
 can
> > only create anonymous executable memory via /proc/self/mem if it has on=
e
> > of:
> >
> >  - EXECMEM (like for other methods of creating anonymous executable pag=
es)
> >  - PTRACE (like when using /proc/$pid/mem of another process)
>
> Allowing it if _either_ permission is allowed is unusual in SELinux
> and seems prone to errors.
> Is there a reason to not just require PTRACE always?

Hmm, that might work.

My two concerns about that approach are:

1. This is an operation where a process acts on itself, while PTRACE
is normally for acting on another process. It feels to me like those
are different types of privilege.
2. I feel like blocking this operation even for a process with EXECMEM
privilege increases the risk of breaking existing configurations.

I think if we want to gate it on PTRACE, we might need to put this
behind a policy capability and let policy authors figure this out?
But I'm no expert on how new security hooks are normally added, or
what SELinux policies outside Android look like, so if you think it
would be fine to just check for PTRACE, I'd be happy to go with that.

(I've caused stable regressions several times at this point and am
trying to avoid causing more...)
