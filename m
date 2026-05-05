Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73B311968
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988996; cv=pass; b=i24/5Re+oKIPHlg0cWPzpUijOmAa/YJb8WZCFct2KCWJvZeATV8N7mj7bTlU1TQZJ7jAlPWp7OA+JgvLQYUZx2Nc1ej2SpTe5+lscPiRnPT6YPK00ZgztlRwMwmp9+nxDoXR/O/4s57ADt4vE0OD9bILt5eAu5QH6Pbd9/GnijM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988996; c=relaxed/simple;
	bh=dwtJGGtWfivJTDnEUkDart9O2ukOCksxaNnx6dZ9xy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmrY5weIYHQI2xOaJbJv6NYzQUV4RaQRWyV2WPy6Kl2mWlvAMapISCNRVO0vN4InMdY52Q6kjSwP7kKxZtdeeb/mZkqOD9TCpr3ohWYId9WkYzuFOYaGgFe719olKcDpReJH8JwfPwz164bVudbO+vC4dErpdSIGKrzwqq+HT3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=frbFmbFg; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="frbFmbFg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365212191f6so2083607a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777988994; cv=none;
        d=google.com; s=arc-20240605;
        b=lPeVOpsF9PRs40nCqXDMLDGQzeC/cVk9oA2dnzJ9NuhDNto4JTfkSyxmbwy/frKKwD
         TUhafsv+CuDbf4GTQuseyMBqFjvTAX3M0lhs9RWMjjOdEyr0g9t8h/754Ss8jAuSRGAs
         W+LEZFyLECJADdYucr/vRif8fUp4tE0TPYUkcqFYjC+e1ZQWBqwEq51Jui38tyOATwQ8
         Jvn3lfnj20iJ9mbXl/CwnEKv5V4WjxDWzNfh8lGAYyoGgG2nY5SfVXAEwLu+l4eJh6Ei
         IfO21vR6ERbxcuUTVaifjn0GPM7RyNdLqRCQCLTJAzvv7CLOHD35GB3a0pRt5zFz1YMB
         Zohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        fh=2ch02JGRCReeic6vsa9lFxR1yVB6avneu/y02Q8m3Lc=;
        b=KhbBtsnHdSfMwhIOkZhrt2ofCjyw0Wqu/qSalnXP8DG/HlxQoGt8jVaqh3J3V2tXO1
         7xjiwhKpXXfl4fFFRhoFAbw0JZX96bNSyBVtsllEMdRLw9NmNgwrRVog3am109IPaxIm
         5qgBgA5I6Zlp23imqU2UZQaWVvGyOzUnZt73P23aimnDPnElMHggbkrlkki9sfMENxxn
         BKkwT7xO9j3pcs4AVowMuPLbS5IA/2G3KpuHJBw1IIxS7FOC+O406F4nN+oK3sE7JgD4
         iRz0gq4C4R+pfnKG5D10glkTMoXRBhS+/KhztgMlg23GYvs3Gp+o7nBaF51/QCoP9LmR
         R7CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777988994; x=1778593794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=frbFmbFgOy5VDj09J4f62miUa6qVAKlhZG3/8HfPOneejt5h6GUtQh+bJQcYyVXcJy
         OmsPiOMuN59cYHOycQHeT/fex5uKz0C3c9lNgZRI5cWhWaf/YgfV3zrNKOTQvhctF7/b
         SsxJo8VaIiPaynadx4HM4POuFQY7HM3sNWB3aP6pj6djFe1joxyMQF/ThxZnKM3T5tui
         olWtUGCea0udn3tlMK8N80eYwbORI2WLMtMKL0G6v0P3OTM6azccnmnPrJCmunmrLZ93
         RPuZFY0oa1or8jPs4empxBo4YHxMqqLLDwDL19QSzLbL4rVWxUp9aOEvIlTWfpe1qw18
         Fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988994; x=1778593794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=cxJ898VmkFm3z4HVW8i+J3tZowFrd1eZGdFA9rmKiNvqaq9tHN8wvOC7f5DUS+HmVr
         ixxli5PWor/yM+V03IU8fiaW84hR7aBHdBXqcx9MWC+hJ5IsHOOc6VSYjVbwDntumyN9
         SxOhO0sbR7WVCRD+ZxeJAU8xu0iTQJBenrTi5nVshlv1mb7GiQ2YCHVfYb+JbL/mVd8D
         qRA6F7DghLJpeZvTYWRh6wRXlzukJD1RXnQm72yIKm4gO8BE6adpqzPujfa7UVV2khS6
         kyJ+9rSXCj5hjFXiCI9mqQaQ43pY4Brc9wpAdkerbnMOAmq9DIOEmUThQ3p11+CQFYuX
         Vjbg==
X-Forwarded-Encrypted: i=1; AFNElJ/Jc5XnNw6ry2RfYhlAdf+YEFQFDyWn/mAgOwW+IimpiefskJihPL9MfrDNdyauZ82VNZFLZK/oXM1Yie9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Cg9OVV0U44aD6+3Qfaux2dfjQN34qsZ0+k4sEKKmepPB1jTp
	2po7im/4/AXrAJwuvD3k+48FQHmzFgboq3MODH7P9KEkk6r5zy0DRyqlxdD8hUpnOu07UnCCoCJ
	sP0x1hdbxG35t4CN648Djremk/mLMK8+NVXMLJa3e
X-Gm-Gg: AeBDieuUOJNZs6XSSDn4hplM7ynYeZCK+N8hXvONJdDOEYnerWoyMLgtpEzlsmVTpcn
	M6Mr1inq2yQwUI4uK9gVk9rM+enSmd902ZL0DbGApkpwGb81MFaiM7jPYSmzQJko1Lqgx+pkZ5D
	CqHmDJliGUy2CBBACU/NvzR41dqrvFPl2twbVeL9OLez0ylL/p7Dt8M9UGF6ZnCVJF22xWuxM1J
	kBTG2YHipsnnBVJhFfkjyxDMy5rpyUjP0ggPoJHl+MOePyc7JbDwSdYfQ8hXbJZ8RQQBzapJ07L
	eVpbgYeWInQBEzd64Q==
X-Received: by 2002:a17:90b:3a84:b0:361:4521:d311 with SMTP id
 98e67ed59e1d1-3657747cdadmr3159694a91.18.1777988993821; Tue, 05 May 2026
 06:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
 <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com> <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
In-Reply-To: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 09:49:42 -0400
X-Gm-Features: AVHnY4Kdcn8NUgT3x3TCJLSbVA7TxZZZNO16IatME0SS0-imLL4d0tdSq1ceCGU
Message-ID: <CAHC9VhTWpFbK30ueZw5zTgNfMoABLXcbny=_eWOV17+1ebFVKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 4:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > > > Perhaps I'm simply not seeing it, but is there a check to ensur=
e that
> > > > > > there is only one BPF LSM calling into security_inode_init_secu=
rity()
> > > > > > at any given time?  With the BPF LSM only reserving a single xa=
ttr
> > > > > > slot, multiple loaded BPF LSM programs providing
> > > > > > security_inode_init_security() callbacks will be a problem.
> > > > >
> > > > > I don't think there is such a check. Also, a single BPF LSM funct=
ion
> > > > > may call the kfunc multiple times, which is also problematic.
> > > > >
> > > > > I think we will need to make the default bigger, and also introdu=
ce
> > > > > some realloc mechanism for the worst case scenario. This should
> > > > > work, but the code might be a bit messy.
> > > >
> > > > Thanks for the clarification, that is what I was afraid of when
> > > > looking at the code, but I was hoping I was just missing it.
> > > >
> > > > Increasing the default is an option, but I don't think we want to
> > > > support a dynamic reallocation scheme for the xattr slots, that wil=
l
> > > > likely get extremely messy with synchronization between the LSM
> > > > framework and BPF LSM hook registrations as well as special code to
> > > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > > programs ... I suppose there may be a way to do it, but it will sur=
ely
> > > > be ugly and come at a cost.
> > >
> > > BPF trampoline already handles all the synchronizations, such as
> > > add hook, remove hook, etc. properly. So this is not that hard.
> >
> > How do you plan to handle the issue of disjoint lifetimes?
> >
> > > All we really need is to allocate a new array, copy pointers, and fre=
e
> > > the old array. And we only really need this in the worst case
> > > scenarios.
> >
> > Oh, is that all? :D
> >
> > Keep in mind that the code must also handle arbitrary ordering of
> > LSMs; in other words, you must handle a BPF LSM that isn't at the end
> > of the LSM order.  While a BPF LSM at the end of the LSM list is the
> > most common, and recommended ordering for the vast majority of users,
> > we've been working to make the ordering as generalized as possible.
>
> All the BPF LSM hooks are called together, so it should be fine.
> Maybe I missed some corner cases.

I was thinking about the LSM framework as a whole, not just the
potential for multiple BPF programs attached to the BPF LSM.

> Either way, I agree with David that we don't need too many xattrs.
> Since BPF LSM is reserved to the privileged users only, it is safe
> to put a reasonable limit, say 4 or 8, and do not handle the realloc.
> If the admin would like to brick a system with BPF LSM, there are
> many other ways to do it.

That is definitely the easier route.  However, please add code to
ensure the number of attached BPF programs is limited to the number of
requested slots.

--=20
paul-moore.com
