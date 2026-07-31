Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2594499B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524752; cv=pass; b=Vk5quhbW/RKpqnytIeeGr1z5CwsL5OP5UsOG1eUnz+Igg46pegPNzHcOby030Cza6jjunQMp41A5HzB2gJefEMgIC4ngXQGAjda09iZlACAWhpXPkHx9R4mZ4jFoaYFcaq69E69SbO4g3PkkXGySExUyTr1oG0M6xEciOdxC4rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524752; c=relaxed/simple;
	bh=yYMvOLG38w4orK+MApkA+zLYeQLhs8q2VGY6o9e0R70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvF/4/WVZkUU0b1OngX9/U3V8kkV02JwgkDYGbe3oTLFZ5cE3ghmrrew39kw2UDzn1p8Epm3nIayB45iBweRR1LFscMByFalB5J+pYLoVwf9TpdyzlwCp9zFu4Nz1bVRkz1FDA66En66TNkPw7Ykx72Gr51koocaRHZg/Q4tmGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JHsniNAR; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JHsniNAR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab973140bso17096495ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 12:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785524750; cv=none;
        d=google.com; s=arc-20260327;
        b=IyafGl8rCBNIECeKAV/iY8azRwjG/5iOyxNUBB2ggPv8eY6IOtLKx/91WJ+0bE4N3+
         qCxnFV5DaAsNYBZFYi0G41fGkijKa8eeMm4MK+3PxkpaBn3RqTpelXolCgwv400UZ8yz
         jt5x5wnZk1YBSSABxxmIAgOr16rBpa97MMxRycM8jeJP6vfyjbW6PzYeKovdAlqrPppI
         mvPWeJFqrIVR/hNh5m+EIb5NdJNlFZoOVtvI2Hz9kj9Z5RI+VveXmBoiNmSkDUvnS9AW
         UW0sQDN7vCKnP34rD3J9u0WmSDTB/hN1BjA6X4mwavCE5h5JpsEkHt0Ct1eZCfxhzuIH
         mYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        fh=uwWZAJFwTuiJDmVPLVfhd9ij2u9ltu9YXvvzWvCqzFI=;
        b=oMSmUKBXfVcJJbT6qpJqM0EKKIYkOgE7OIaSQ8FrU+hkLgWEMycNbHy9W2oMeJmy6C
         R9jyfgDUMcguhHhz9ZM87F/RmzdWysnq18iIXgZ++vrBBkNpb8GrdpBEuHxq+fbhZc49
         sRFRptrPNOnOcSRxiLXpvPnazcNPTr2m99r3MkkgSwDlD/ZxBzhvzQsw8jRfLti0DuNL
         GGzDuFNurghnWEDYwWlLXdv3bL6vcODqQ2GjX09oDYC3hgAV0+UZdwBmzKG92mG0hojo
         BdbihTEMvX49/wZyIBULg2zwbHH1SNQc81x44yPn/IREsAy6tRypwv7miXpHXElZw5xX
         eUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785524750; x=1786129550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=JHsniNARppQyfJeOgEgBJvYYzu8PxccLQtymddShLvf8oyb5pRRaNbSXotDjNhau36
         +hBb3nubmbuoMpB9/XVN4ELIDLMy/ArNYL1yWJZ6ROnOokG3T/hGs8z+mwcLKfZRxmuS
         ek8A/9RDiZY1h/u+1sYJwSz7awEGiAw2eHh2nwLf3vRTGy37vuRAiZFN/+z3r5QT7NMI
         MbxoxWNq5djA1Z2XkI1LGRxpyeZ+cGTKSO8Zn0Oq6B1QdNcbcbj8BzClTNxHEtvSzjGe
         7anGUu34U3LKcW/bI9SDCerAiIAFR5cMQ9DrPeN9ENL9qZSiwPiRnqduKgyRQhK6QM4l
         E7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524750; x=1786129550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=p0JX7LXQ/H1JxK+72A84vSfFyMzfieiUDkKK9yeLnUuY+f0ccmUKS28Wkwfvdeldfh
         aYvkrg5UIM9b1JqrLg3y+e5NpmDZ9myRZHdVpYb4O3CCWS+9jrghKoCgIigRiW/Gb6wp
         LpD/aRHJ3X5NM6023KpAgdBHa1jUH3Q4FlmN7EgzfnJjaRWUdkj9IX9XRjumQ9mSFqq9
         1lw1XTDVeq8Xu1KRl1p9gJa72SY32xpbnqV3NVer88gL8HgmuvywqwL6RMvAkhBR3Q1y
         lU87Hj4dbmNVBZqK13QDgoKgseubvSFC4zYYb8zVBNhv79pCYsxW+3XEmYf2eXM5EjSu
         4wSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEKcDjBVveLU1IfM/iUh5e/JIrk1ipGES+emDnxPWqVkFMIjoR5u8hLHaFBkhB8XN+9x7ZBJvLY4Lgj/Cu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yDFuUXhywdtUvyxOIY3VVnPI+byd8lAqnt7bCWHJM8ClCJ9Y
	tWk9DXuLRJX3hYhx+m3SUTH3hsMHwx4rxQWorWxuUfxmKcfzy260cyQ/n/47RxH2vzPxm4oXAiZ
	4vBUCYF/1p3YEycfs5KkOKaHFjkNGwsOT7hJkZQt7
X-Gm-Gg: AR+sD12TnYQZCK4FJcepqiSaktf/EH2VkSGkkmll9buhZyJ+rItkdS6kQedDn5abpf8
	MSsWWyKJ+N/q8nCw2GbpwM62KQ9WQ/y/44jA0qtu0XFYgwF2zkaPYOkFxguxD4Peawcc9sJE7s+
	5vXebdABTioyVi7Y8pTz4+S4ujd6VG46o8w/VQC20SfoWTiX9NBMB2OxnDHqBGHEJeKiCAmAMMf
	0PO6IjZbZ334WcSyS2fQ6mLmSIC76D72Qto2wtI2O+JbOi0cZ4/659sKeCr36hzdDh2cFWtEOh0
	2Fb2lYYadchtFly1PyPvvSqCkENr8JqiraoPyP0L/m+aYC4NI2wl864=
X-Received: by 2002:a05:6a21:7a46:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3c92a53fb35mr967925637.12.1785524750076; Fri, 31 Jul 2026
 12:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
In-Reply-To: <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 15:05:37 -0400
X-Gm-Features: AUfX_mzhQwXzX6axL_JCU146kBpF3HezC08-d7tZrEnJLnYGCd9nHtAkxsjABNI
Message-ID: <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul=
-moore.com> wrote:
> >
> > ...
> >
> >> Yes, I understand you feel it should be placed under security/. You ar=
e entitled
> >> to your opinion.
> >>
> >> No, I do not think the newly added kfunc is a big enough layering viol=
ation such
> >> that we need to do it ASAP, disregarding everything else outlined abov=
e. I am
> >> sure you see that too. There are several other instances of similar kf=
uncs.
> >>
> >> Therefore, please attempt to meet me halfway here.
> >
> > I'm happy to work with you, and/or anyone else, who wants to work on
> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.
>
> Right, and for that file to exist, you need to get everyone (FS, BPF folk=
s) to
> agree on whether placing all such kfuncs there makes sense. It is not for=
 both
> of us to decide on our own. So let's revisit this whole topic once you've=
 done
> that exercise.

The kfunc that David has proposed must be located in
security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
you will notice there is nothing in the function relating to the VFS,
well other than the "inode" and "xattr" in the name of the function;
this is purely a LSM kfunc and I stand by my previous comments.  The
BPF maintainers have seen fit to decide quite a few things LSM related
solely on their own, I see no reason why requiring a LSM kfunc be
located in security/bpf_lsm_kfuncs.c is unreasonable given our current
situation.

As I said earlier, I'm happy to work with you, David, or anyone else
on ensuring security/bpf_lsm_kfuncs.c has the proper test coverage,
but I'm not going to continue to go back and forth about the location
of the bpf_init_inode_xattr() kfunc that is proposed in this patchset.
If you, or any of the other BPF maintainers, are not able to live with
that location then David will need to find another way.

--=20
paul-moore.com
