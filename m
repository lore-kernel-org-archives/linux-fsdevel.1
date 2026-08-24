Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D146F4A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593436; cv=pass; b=IelppuYkdcTlvZ/3ApNjF3VmbMcKpOLHxzn+IXZANdnM+Ls/DJFYFaYhq2py6n49swU3Yv1bRr8ey/vN8AKbpdq/MNGl1w+QMCSu78E+hrEV7fvkfdF87TQNNC2tkCxn4awJatb9l7mOz5Eq2ikfFgR+W279Tg7fJn8NovU5Kp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593436; c=relaxed/simple;
	bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=losrd93c9r6RShsb4RaJKrla2DBS5ZlrCRnAaQWGXhY2hXuOQO027ojswZ9r4OOkG/wnCFOYYW0bc2sZL43KvbIL9EQgadeVvIxTlrptxuvmY8snQo9CK/VNm2UcPHAZIRLCu+ZeYc82lCCfsjv11ezZZzAxqbq6Kplx36idMYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joZGmF9X; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joZGmF9X"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d3b440b97aso11965ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787593421; cv=none;
        d=google.com; s=arc-20260327;
        b=SPueiUL2E2NpCm6kGhihs/giAahv/5eQ3SOAABYYw3ayPS9rI1cdaZTST5JXzW2Z5Q
         a7C1ZykBsPXOr2H0HGWmZwFsF0fLPKwV9NE3x/KGW2g4M9BK9LDkQ5ULvXGPcBd1gxl6
         OsEKA0NEiZl735TUFQs+QigcbQon4U1jAtg5Sb/Y4wUyFEA99YSBRsyBaCIslW+EkiUE
         gKAICAgyDdVO3pSHsfrFey4H4D+H5QjKBycQvKEEAnpCKpI/D3TfunjcmR4NUfv+Gxq9
         imyZq/aMFezfDro197AolO0vEAHI782gi0eynv1mxTWAdByuiqYDeB23qIhN5gWZf3Qr
         GDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        fh=IhTDeYsKcf7FDhMCoNYrfEBPcO5pANN3l3FebpgbuB4=;
        b=ZtCQpUvBnIelC72ebNq2sBLNcLGp80dy1gDOsUEBtkjY9ZXuWrLXETBneH+uducxCH
         lcdv3k4O+KL/lj1d5hKVfVu6jUhU8XjCVkCgLO67AKV0Fsr2xtCMQI5CdvGlHzyGnVZM
         +TJ+3WeBFvlM5vqS15h/f+rfXWnfer/xvBCTvC3aZoFtoxe7hPAPGg+IH0HzgGM9cUGw
         tAoRsEjzk0LyHOGdr6R3BV7i2FrD8lYAc7hL33Hbu2yx5uji4b+GFi5s6MvsNpoag7aP
         bZuI9AwIO2qBDMuziS5K8qHYtS5k1ZnPmJ1fQtxUOKfIb4ezxVptqaGt/M5FwB6Exav+
         LfGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787593421; x=1788198221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=joZGmF9X6QfJaxTMYXhYEZbMLmkmqBAN5EA9bvW1v2ezu+L7IG0imX76Og0W8AlQDG
         wxlHIHdWM/jAMnQR/mz1grjzyptG06p3gTwRGj0+TB7NT2N/3LbXMVI/WQ243ARLaKJ0
         0K+okMPpuESFoJEeI32SlJatbsXciGmOz4Ga37nTBlyT6sXwR14HiXbMsxP9HShtylEZ
         rdbU69YJONyM2PBRJHaKDbQRH5wgpyo3eAuN5tore3hNychk0/UvXALRWpaYVXubgS3J
         hz+zHXtTcuU646DtzWJXfpEymJji2evbjAy9J3jLfrxf8NCZV/ZwDu5mu3wmJ+BPWCac
         d/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593421; x=1788198221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=PtUoz2OWYglA35j5NExXpM/IZDHAjmzV5xVIZWhRUQuDamFHSMZR6HQh8DR/wAxQfw
         ksh4OzEmfoNm8MZEVC5puBGfq802rOXvkS0Rwo2Um/xh8D+Mr44BWY71DgX699o8ob2l
         1GbtmG3mS0nKIWj54YbnCe9w7cg/K0tMmQ0OhdsTveuQpNxAWRWImSEfYpQfH5DR3AC+
         kC/+us91OR0RyetrEEmWxMzwi4nZZoY+iZqecGRpyEOpcWyp1Zt8aP283VLDfBZS8SP0
         yrsThTGs2KnU7U9ANPRNm1RmG10+hn4Cs2l4YZbR3H1IGdgw9yrirbG3M4N0isttpJKZ
         hvSg==
X-Forwarded-Encrypted: i=1; AHgh+Rqt9nK1Ya/gKECQE+bWBrB+Ppti/gSOZtQ914KAjxyi5+o6qxs++lt5hhOgcHTH/rBU4vExcKV9MPUHEISn@vger.kernel.org
X-Gm-Message-State: AFuF++lBYEZ2Ov7VpFXgAg2CdNEfm/5CuFPbmJwVjx/0E7kTsHuOxmWw
	FF958tRujv79TnbFTKVmj1x2KX/O5KMfmRVnt298R8e6ujo3LoZY//yigiUX0mppKGTCf767LpJ
	CAf5lTH5cFnT/K1DMTxW8kHSoKp/kCuQFT4kunZja
X-Gm-Gg: AR+sD10ILOJCQnPmu64gYaA+I7uOqEinNJcLPKINttYBMpEKwyETU6n4xid0J5UU3Dz
	D9WCZRR990+SMwh7kMVDUj1KUll5noSjjfHS5E9kctf/HDpfepMLmWOvihQiwCdwLC5MVYj8vQd
	GaUQ9u1zOvWkyYaJfuVx7YMt07+z+1IKL/hNIV4xHN8o3IvfK0C0Hf89DJ3rEnofo/eEeOFCTFF
	t/7A3Uz8wLAXOkgR84/Vqh5ZGgSx3LekeD+nuxTa0NEWoWMszGQQ5mgrd0f4q2Qaiol4yUm9btD
	dCChozajofIRhFdhRvPeFT0uyqIu8QgmEu0IXCXT6qbszV/vjRsENSswBTgZqmt/Qqj/S/TVTUO
	67SpgczJUsq8v4+3OoAaqEfQ5pr2LDwY=
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d673b9e9f2mr11726905ad.9.1787593420034; Mon, 24 Aug 2026
 10:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
In-Reply-To: <aox7tVIQBMuz-xFO@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:43:02 +0200
X-Gm-Features: AcwNN1XNlUaHE0KSmD27zjyuJQAPDoj5SG3PPI6IvJrIGr992XerqXx0rzodOY0
Message-ID: <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to d=
o in
> > > general :) but I guess you have to protect against that.
> >
> > Yeah, it's a kinda weird thing to do...
>
> Yup :)) but I guess we have to account for people doing weird stuff...
>
> In this case (I do mention it in a reply elsewhere I think) it does seem
> like perhaps you should separately check for current->mm !=3D mm of (what=
 was
> originally /proc/self/mm)?

I wouldn't want to do it for this access check, since that could lead
to "confused deputy" problems.

> Or at least it seems like a crazy thing to be able to get full access to
> another process's memory (that it... gave you though).
>
> Anyway perhaps overthinking it :)

Hm, yes, though I guess that is kind of orthogonal.

For what it's worth, SELinux can prevent such things happening across
domain boundaries - it enforces that, in the SELinux ruleset, the
process calling read()/write() on an FD is granted FILE__READ /
FILE__WRITE permission to the file's inode.
