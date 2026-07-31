Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5C446078
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513795; cv=pass; b=tU/iWSstkf8xuXs5NLD+03ErQ97VvBtINa3P/hxTRV5fdNcNqR0LvnDmYDVLeDiSg1DfTikQWaInUowofz3KsU2+3R38pcLVGjoBLP0niAYN2RzjBHX2deSGS6IVVAZ8G3pED6nJjchtWdYB9Yg9/Ls2wI9uGKZy4i3uTDYq6wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513795; c=relaxed/simple;
	bh=n+9aQXVCyI5+nq4dxhlKhYIzN+km1UKy1fzyENReD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bobTIHXbBtDaADKQEpYcSUuk5Ut+Mb4npIExUEY/ilbuzoCmxVGIEQSuOD7Llb4tuNyPPri46FQipnTn4rlR+S/aMGagrtBGaZZeD2Iv0ArBkSA5xTT93da5wgRjyfF+HqaxhjvpQhvTC1jxf17C5TxnPb6xvZCds9sLL9HROUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a0OcVIF1; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a0OcVIF1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1042679b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785513793; cv=none;
        d=google.com; s=arc-20260327;
        b=kf8zg0Ct2PI6B3F6LPTcIJCvCmFrQLFQAEbwHmaa4p3+5UgEVejK6I5u9/O67A+e13
         pVA+lIuIgzESqX3YIneOBgxznPC2DmNuZbfU7fdKCQjlecWLS54ZNkReF0AILSeuesYE
         zIzD+dP0i1oNa4THNJUd/jdH+NQezNQFlaC+zCsg9rImjILiivJMBiACgZwJv/3QwXON
         fdFU3EygMEPnpUfb1/SJBJ+NO502D2mGcP9umQweIZjK9g74ANGQZaN/356W6N/pY64H
         brbFnU5nBXAqQCMLHQTU4WF9YFlcwVwX7fVoFoQQPTtTtxonlpE90LP5o1ubRLGdpBlb
         /ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        fh=P5SgY/mxb74fwr8DaHiylI9fMC29orstr0qIOA8ciJE=;
        b=E2KREZx+KU0FU/TFG1wyI93LAq05LjMlzRZ2dRaK+N78EmoUGGyVFKh2lzxwYZfITK
         zXXIojDI40d27wh7ishw6Z33TS/rTCgh7xvt8A8XpIACZUYox5CR4SB7dRrB27C4iLoI
         AaGDgzuDE7hEk+uSY8pO6K/BC+0MaPofejaisnfO7jgBKcnnp0imFfJHCfrgHEBKbVBp
         bry6kN2WdGi1jBhi6MIYCYj3P4AdIc5yt47Ruw5Vj0kazdFAjX6TXVzUX2nL62sHsD0b
         Kbt9dXhtFotJGwS6ajWc0gkY2/Awj3oxRtZQmsAkv2cbq12KD+ODFsqCCTqOlL97jC7I
         1Stg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785513793; x=1786118593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        b=a0OcVIF12lLVGVOtIfSx1+TKTqNpVgrze1/CLf/w6WuIFAMe8TWbyywpKFz+IZwAGT
         GrA01XVdi6CufaR3E0uq/uXmW+n1tSatdNMF/vxIUisQIQ5W9UmNNseOEq0FvYN0u4GN
         85UibeJSYrH/nIP+P/U5JaIssnF7hOGj7/TDIv3+RyTtovCjHe+vrY50MEBB/c1BRmKo
         U9dt/BvOvjv50PJTJEunlFw0dQvoszF3GjUco86M7dpGhBQsOQ6n2X+j3346ZEB6/Jz3
         shBQ/2418NTPr2DgGAmPzEvTOlUPQZtNU6hktOdQgM1MMra+4+UZJylVnTYHxiQCU14R
         QzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513793; x=1786118593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        b=JRs7S0tL7l3XlewLY48GkfG17RNsyp2FWItlCCCnLsDc2uPrhGAqXBeoqB/HJe1Mbb
         T3Ihu36i7QOph9B7t/2QK+pZ+Cx4QXW+q9HWYbyctSsKFQNR5it4747Ep7yDTaZT0688
         tz3sqtI9U6LPWbP1jgdocW1w6iG2q5GDdw7frnhWO0CpOJBuXT78TIy7I+HfAxReVqgq
         Zo7HxRzhXgKolfmk0GmE7s3+V8IC6kvLufCkQ/iHTV7t3H4mXMmvhvb+FcNdo6AdUt2u
         FANdOgqwb/sp5i4hRTe3Htrcg13UBjgw7q9icTts4dk6ufdEJ9JGorF7kVhnT/47RRck
         03cw==
X-Forwarded-Encrypted: i=1; AHgh+RpgGr+1a0/f3H5BiwKocpocRdTx1kqC6doW7jZaIYjmvpCf5NWnefabz4E1yXDa4jbAz81kEC2+dgB09LEc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7N2tGND5LYwh5MvM6/Wsnj6yqCiBMAmg/ReqdPKtcNuATErvm
	qGNL/Xdpf9bEXAwdDW6wPZQBxNClBfFVDJ5TdmrRSQsQAPhSV4rFe9uUh4IzNGC68yvf5KufQay
	NJCiMPnRbyCFQZ7cT1MYblRUsRzWK/Sh62zmnAZTf
X-Gm-Gg: AR+sD11mpMXjJn9IpMLCk8XGYs2oAWekWzurcKpHIyl1h7IvDT42fLm2addxzDtX/TY
	ZU7ZPnNbhZ3es+Ntb0cy9AIZ8AjKdO5TFdVs13BwA09Not1l55WYo07bOLwy8ze11IBzSrQj0Tk
	DnlKwAi6gcRdLB3no1+b7hIZYvPr+fxLAIdiu4tqbQ2PJwZwLU1qjzy9D9kGWEvGxawLwICbpJY
	ZjA5GB9PvotZKpO6PFZCpBHspiML57Z7Pp5IJ82CXhxagAD8xj6Qo3gknOlbm0rWWWLswqGugBE
	2Jg8m9KKcDSqSEzn3Y5xuh6UE8S8Qx6A+4OnvnTu5Eb6
X-Received: by 2002:a05:6a00:1956:b0:84e:223b:98c2 with SMTP id
 d2e1a72fcca58-84ee494dff0mr165281b3a.77.1785513791519; Fri, 31 Jul 2026
 09:03:11 -0700 (PDT)
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
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
In-Reply-To: <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 12:02:59 -0400
X-Gm-Features: AUfX_mxjC65mK_RgbRznYtgcxw-6qcPS9DZ0388yJaipWl41dn8qJKId3QYgWYo
Message-ID: <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>
> >>
> >> Okay, it looks like there was some confusion/misunderstanding.
> >>
> >> My understanding of Kumar's comments was that he was referring to the
> >> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> >> not necessarily the new kfunc you are proposing in this patchset.
> >> Kumar is welcome to correct either one or both of us, if we read that
> >> wrong :)
> >>
> >
> > Yes, after another reading, that does appear to be the case =3D).
> >
> > We'll need v7 anyway to fix the ocfs-related UAF the bot found.
> >
>
> Since there is confusion, let me clear it up.
>
> I meant it for all of them. I don't think it makes sense to keep this one=
 in
> security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo sta=
te is
> worse than just placing it where others already are.
>
> As I already said, the discussion around whether all of them they should =
go in
> security/ is orthogonal and should be done separately; it isn't productiv=
e to
> repeatedly bring it up in the context of this patch set.
>
> I honestly don't get the urgency; it will be a mechanical change if we ne=
ed to
> make such changes. The worst outcome would be stalling David's work over =
it.
>
> As for landing this stuff, we can let Paul take the patches touching secu=
rity/
> and route the rest (3-4) through bpf-next after the merge window. We need=
 them
> to go through BPF CI anyway to ensure nothing breaks.

Some existing LSM kfuncs are located in the wrong files.  I'm not
suggesting that David needs to fix the existing problems, but there is
no reason to keep making the same mistakes.  The new LSM kfunc must go
in security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF
developers then David will need to find a new way that doesn't involve
kfuncs.

--=20
paul-moore.com
