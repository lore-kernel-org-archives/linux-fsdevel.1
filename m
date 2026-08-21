Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AF3546FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324910; cv=pass; b=HAcwI2Iw4E6Uc6ZISZiB7KGUQ0GV/4iPEHT/ENujqCLiJ32hZxYt+JlI4BNbP3qvqP3LU3hfqpdjF1Lyw+gIXjUyl7Eq1ALSH+qCF3aA+Vs+SfueYlISy9Yc+HWqx2GAGse0kkVhWkESfIRKLkpUgQmxM/CWTTXFseTzvUnAhlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324910; c=relaxed/simple;
	bh=xsvH04/zWmLu6VaMQp0d91tlrFx34Z/3JARQ444mLbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6+j4MxlnN+l7ACpHCGx6HYIMzphYtLrRPX83nfXzBDO3hmiuzZUVVm9mwRPsbkkZUCmnjdZVoQJDgGm7dLmVrHFDcyNwnaLEy0wzx5rWTPaAqxa5bx+VSlr/dkztC/Ql1rnO9hRng/VUxWkHlhT44ER24in+qfNU1u11hrLAvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn3llhVh; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn3llhVh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b445a84fso82755ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787324908; cv=none;
        d=google.com; s=arc-20260327;
        b=ZI0iWjhhpUIuhn2n8Luy6N7bFkrf1OkIeWcIgXP0uU3NVSb1g8AFAMbNPIv/A/rIgB
         srxVeDbcQrbE3c6o4/bFICcMQB2bleS4O2CMK2siOZrGwJcCYoBN9Pw4IUz5v+Fre3lQ
         Bq65ZztQ9VD7PTWnOJlDEEM4pQuj24S3TkzUbrAln/HQiLms5HACgb0X7EJc0J6nN9D6
         FFM71T4kgVoLR+QGYrOvnX0fTjPstEGKyqPSkhhCCkFgT4+JuyXHrJX3SaSqfQ1vLQlh
         4dk428unHlWa8kEkL5re3/GLvWC83Zvs+5Zy/yP8QoP9RBSt1mou6GHz4Rv1meGImlqN
         2bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        fh=6X5wHD6kixbhiYS70ZVASu6Zf8nNOMkyGKlFli1MY5U=;
        b=cMO7zPAzlKBtnzypDxuG7W9T36etS/euOLFMGZPgI0e/sTNWUowLcm63EVnTshZlmG
         6pw77vtfP4i9swT89Ci+Wnyu3zPAtaRft7MUJpeEsHhxPvtG5c7J/itsb8c8YXtdnl1d
         Ho/ofjTbr2+K5XYADbh734Xv0s3ZJgrqAJMM461Cd6YobNSwzTSH5c165HCndYaTA9Na
         AdUAl63NSX2zezc79Zg0bez9F+KLulRBAfluze7iDPQqeI1gondFETRoP3F+BEyyLJwl
         SkBFtjzeJU49RHraXQy8LYt3B2I5fe6NxuYaZY1DnW43hPSpJaghNRQIgz1nwH6wgXP2
         Sh3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787324908; x=1787929708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=jn3llhVh7gBIXYmlyYrL8WSFwdMj2FeaOqUzMm20N/uwus8nxn2nTiYrr6Spo3Ic/r
         yzdUP0CyskkQJFgBlJqkaeF1d01HU4FExNId432GoipNMKJNfFOEUYefVGSR/Arz7L2F
         /xUoyd7soP5MoKCvjKTAR/giwPjkduRJ/9eFnMdyAd/kqf12n7J3VybR8YidXE2HSCsL
         vGMS4sZfe/9FAI2ndBJGlu/2U9EJxDFF7tuqyHEB0M1EWRgDIg9OYneCHklHZeX2zyCT
         91PVWLA3W5cMBuaIKZc3siKwJJySuVjtrdDJ9VfQkJJQIqwEFDyU10WXNwEdFfg0TS0G
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324908; x=1787929708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=srl+s4Mb0CqaOdIJip/Iq/HpgezjEWqOWLRLxBgI4fFG8gY4iu8w5eNIDuQ/LK+tZi
         NMeBwbSwSatzesC0gJQHLfasGFfrRBalloKRrot6pZfxfSrzOth0aUyxxDiMHrrOSHaS
         Mnkh4r4EmaFLKDFJSx47rofTn+TxPYOt5pD/NZvEKR5aM5dP1bot6MGPBgttqEnTUAGm
         Z48iuMldv49WtGvt1yJtSIAlCIpYhb7VGrYFsEozZF0vnqphZiHaOVPq0tXJonIVG9FT
         4xQLBdoahS9SmaMlKiHSMGL51vkuFE4XiPfyBLk0sb7tQ72gVHdvAA/0CiL9hx/iEYZd
         2IRg==
X-Forwarded-Encrypted: i=1; AHgh+RrXgXRJCkPzyPvVMrXEExzQo2opHipnmCA3p5ZEC0XE9RNCmRsLaCYNP84fdY0PnuY4oN5MSaeT1kSJkRlL@vger.kernel.org
X-Gm-Message-State: AFuF++nRocfokugdpKNcSsIsa+WsmYxbzhvA4+I8j58mIF+fGtF+yF3N
	h1QsYvtj+Ggo5flA7t4KiJB9QjTF02K9AhgjMpLVrZk8cQIzzf8AVlKAXhCaXTXq1CoE95E2Aod
	yiO6brx9dVT5Lgl4Kt72sg2B1wGczCDD1eOLaHWxN
X-Gm-Gg: AR+sD11Ike1CCxlEp4uM+2xtutXpeT2QwJ8H7fYtIBIY7WLPfxa9AztuhkocbIdq9fT
	/4nxky9sDVAFDYeYrmxsxF/gbCMn7tIrHfnPCmB37MEd/NeLQ9rUlPnuc5LQxV5dR2zg5v9OTLl
	hfFwsKqxk+j3jNCWCkoCKtzDmf5vtfMQVKQE2lknCwNYvknmiLG2ZzCVfZw8xeKwRu/p8WGpAO6
	cP8UIxcvL1l9e71Wv0b7hza9RXyYrvX8IY0Ct/PRBxFIiWfbRXnt5KbvgFfv9fFLShbeCU/6Nrv
	YsE4YVIfhoj6xQLUlZg+bBOP8gOdO8oPZ7ss8qZ5lFNdiFBSnJmRPAT04nr2nZGJ7ZD5W4pOVTe
	D1wnCj8YVyaOUsPhLFqjzgMMYsPbF
X-Received: by 2002:a17:903:94d:b0:2d6:3c22:994e with SMTP id
 d9443c01a7336-2d650da6ed0mr6702055ad.11.1787324907361; Fri, 21 Aug 2026
 08:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com> <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 17:07:49 +0200
X-Gm-Features: AcwNN1UOD9xZwijeRgcDq5q20lqu4OjcbnnkogdrF0uco3EOG75h8KaWFgvrdww
Message-ID: <CAG48ez2q6rCbVVWxE55RpuTotmMrNGYfj6+56EXWhXFSrgJXQQ@mail.gmail.com>
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

On Fri, Aug 21, 2026 at 3:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a pro=
cess can
> > > > only create anonymous executable memory via /proc/self/mem if it ha=
s one
> > > > of:
> > > >
> > > >  - EXECMEM (like for other methods of creating anonymous executable=
 pages)
> > > >  - PTRACE (like when using /proc/$pid/mem of another process)
> > >
> > > Allowing it if _either_ permission is allowed is unusual in SELinux
> > > and seems prone to errors.
> > > Is there a reason to not just require PTRACE always?
> >
> > Hmm, that might work.
> >
> > My two concerns about that approach are:
> >
> > 1. This is an operation where a process acts on itself, while PTRACE
> > is normally for acting on another process. It feels to me like those
> > are different types of privilege.
> > 2. I feel like blocking this operation even for a process with EXECMEM
> > privilege increases the risk of breaking existing configurations.
> >
> > I think if we want to gate it on PTRACE, we might need to put this
> > behind a policy capability and let policy authors figure this out?
> > But I'm no expert on how new security hooks are normally added, or
> > what SELinux policies outside Android look like, so if you think it
> > would be fine to just check for PTRACE, I'd be happy to go with that.
>
> I don't think a new policy capability is necessary here. Is there any leg=
itimate
> user of this capability that wouldn't already have ptrace permission?

I do not know of one.
I was thinking that it is theoretically possible that some program out
there uses /proc/self/mem to patch its own code (similarly to how the
Linux kernel has Static Keys) or to inspect its own execute-only,
non-readable code (which I think would also require FOLL_FORCE); but
I'm not aware of any concrete cases that do that.

So I guess if nobody else has an opinion on this, I'll change this to
only check for PTRACE as you suggested.
