Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D87314B93
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943279; cv=pass; b=F1SgOiZCp5GwogV0msFDK303tvNPnXRaj2AdmhDRn9UwHVJLkQiTJPzvQZL7NlbMEuykR+dwVpzUMzKhdbdayIJVCYN1fiSN8RJAjSKiFLuaLma+gw3x1dwL2V1SspDc7aTlDRHjNjP6NwFYu3LSLi3vsKTOGSHmbdtccRQEKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943279; c=relaxed/simple;
	bh=h25CviPPheRk/GDUJ4W9hQ0/45Mh6Y0yTtuThhLME2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie0PD717rJzoS9V1Q/mad5erTsor0M3Q0OxUuXs7iru8N3V05yqPxegvhwweQKNtGyonCNgAxtEzpwbW1fdrUBuFQSZK68/ElvHzc0LMcMg+pwFfV45cb0SqouSCLXawu0g5T47dRJz9ysiRDzH/BpxwHR1djhLg7WaHUDkCX+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTVpH+gh; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTVpH+gh"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso62972706d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 18:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777943277; cv=none;
        d=google.com; s=arc-20240605;
        b=ZKO87fxgNH7b5nzXNbU/H82zIKr6bGBaqFR+44xrVb+1QIO3yV8Z0rt/wmiVTPE2Mq
         j2/JDECQ5tnZH103/VrsLjsvWj2cWA5KEjhis+3BNGzW2Rta8F0k2lH4W9G7M78BGhNE
         D7ELXVg8HPaVxbFkkhpSFl3EjD/uMQpkhIQ76iCsmvm1Pkm7/PMsfZFkiCYaAsaMFSgB
         q5azyIxqvhGvY+vRYqckoDlHe0K3UUtpsX6mldrcaSIRD5dW6DpYowRafEoE6NNwLyVP
         9ZtrEJQWe9OMdwK+IqIW37sRVbsvsmH6wxBNjAfgd8mIKzsweMpjw1KDPBPUHHnRou7R
         pLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        fh=CysTo2mgv7DpAddQx4ETlWBSTjlaLcBU6yvHj8NVaLA=;
        b=Ufq043wO8HEuNrOrSyBJmz42nSYTcPya3Z7Uvbuaeq2pFTeC8h3C3huhXGcTtXig6Z
         P0B/K/iYAgDcpFD74mVov8C41YVJXlvMR1vTvFWO/ADPt/V2zUpfHaze7obNKCuhXPSI
         NPB8oMC2D1URPgBEAhF7xUGovbmY247tmGzusVj/Qux0ov529u02dSn32OzuyCv8IDQ2
         zRbSjg+sNaf1IaF+bmNMqGf2DMls/G4Rw+L+M/S/NRkaP0fUm8NMqayZVKrQM+Tx3dZo
         ok08i1EYefYRIlvMByKfMPP2vyL3S6crDqo9Irmusi4/EyqR+41MFfP4//S4XHIBBrbo
         d6LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777943277; x=1778548077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=qTVpH+ghIW+/XDi+RUUfZXIYXca2uui6Y3kQjl7dpab9CnbohPRqTtY61ha6Pfw0dF
         /74/B/feQnq7guYOFCAUg031sk91U/WQe+BOPqubaszqRlgYLTXnCReddRjNexwcGYLJ
         HO6jhE1QudPeuO9oMC3TGGT8AqlYW9ebmTH+cgVxpWglLLhK4W5KthSHbrrBEs6LrECG
         1BbgBA+cUOg9skzw/GjyX5Q8/FPAuHJ1QcX/fdXcFtQbyaZFE41gHp0gueQL+O1WTyun
         aZx0cKVG3YxGx6qJjsjyke0idcF5LJNhvhP7FLpiOFf0OlVwfn9NhTMMtW+8ROf9KGAz
         iUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777943277; x=1778548077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=UYrUuKMU/dVig7gQaVmQbztT8+naxPk6GOtG0a4uOvziY6IsHpV0e85RRoZaCqj7gw
         lvB4mwm+uLm9+jtkPCnayF2voE4klPB1aXNTPI6OExcratEkcimEcWtuT+vLgcsX+Pyp
         R4ntyhlREdCuTQ2aHTeAFn9Ap0UgNqauPjjkBiVl6NHks37+lupVeTAtzvrCWZq8fwzR
         2EepjzTvNFozzzdryPvNIezOiwxgNIdh8/rV7Qg2XqOANRX/Z0CsAx+ZYBcu2ioJKQJ8
         w6HwdhKjQ94/4CCr6VTRD4zE0z+MJPXIG6WC6ixPMSJCyZAfpanr36oXEkq2UCggT44r
         bjCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eaevf1bglmdnLSAbYAnaAHKuz9F8vcluSpU0dXqELfUDK/CKcRzhWhd9+iaGCBPgPJiKgCQC/szKo9stQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoTKKzphmnkirtoNCnJS7Q1aSBYP3Wf29B1JiL5cmHqrhHveS
	oXFyitVyzAhdOwrEHEUqAc7D1eglPczUiSwao71ckr7KVdJuqFwlDoFaqWixnCy1PtyJNHNiPmE
	b03WlRz0+jzjWELcQuCvYvh4g/WhK8Mk=
X-Gm-Gg: AeBDiesmpH05HwDtuYfTkRqaihlb4fh9VHvcAKh7Qpf5IPV5/T7twjfBnNN6qhymbcA
	cfiMHy01B84ELPIC/aYjYfHtBTLMK3JtK/uY6DqnFdBOJPkwsV1/c8E2tKhcees8PZ5x0av9POn
	oem3JkSwarUCEft0oqy9irc2DuB9x0r+ZMXuvbNz8ta/LwJ0tJPPi4C4NpjrTNzBUYDIdozD1eD
	Hm4YV6e8XdutyqfJDFz4DdNCRzjS9nnbjWLDtfsSlL4/LBD1z+nVMFxqzyP4DKMmlMWe85DtJyK
	LVOfUgJ0Egq4dyAAKhkNfphYuOQWHEoNp3KhJeVJpwxizLSH0LiP2L3OnxlJ7w==
X-Received: by 2002:a05:6214:2b98:b0:8ac:dd87:b5b2 with SMTP id
 6a1803df08f44-8ba9ea852bdmr30666216d6.11.1777943276686; Mon, 04 May 2026
 18:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com> <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
In-Reply-To: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 4 May 2026 21:07:45 -0400
X-Gm-Features: AVHnY4LpG15Ov5YRtOS0i0ZsEyHFvRUaNMxQ4C3yLGhd4sFsYnvO-3LzEMQWXWc
Message-ID: <CAEXv5_jp5wKgR_ZozL3n+4NgrLTg9FQ-HW1EHTtkyA_6GDMhgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
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

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > > Perhaps I'm simply not seeing it, but is there a check to ensure th=
at
> > > > there is only one BPF LSM calling into security_inode_init_security=
()
> > > > at any given time?  With the BPF LSM only reserving a single xattr
> > > > slot, multiple loaded BPF LSM programs providing
> > > > security_inode_init_security() callbacks will be a problem.
> > >
> > > I don't think there is such a check. Also, a single BPF LSM function
> > > may call the kfunc multiple times, which is also problematic.
> > >

bpf_xattrs_used() guards against this. The lsm_xattr_ctx is shared
between all callers, so xattr additions by another LSM (or by calling
it multiple times in the same function) will be tracked by this.

> > > I think we will need to make the default bigger, and also introduce
> > > some realloc mechanism for the worst case scenario. This should
> > > work, but the code might be a bit messy.
> >
> > Thanks for the clarification, that is what I was afraid of when
> > looking at the code, but I was hoping I was just missing it.
> >
> > Increasing the default is an option, but I don't think we want to
> > support a dynamic reallocation scheme for the xattr slots, that will
> > likely get extremely messy with synchronization between the LSM
> > framework and BPF LSM hook registrations as well as special code to
> > handle inodes with lifetimes that are disjoint from the BPF LSM
> > programs ... I suppose there may be a way to do it, but it will surely
> > be ugly and come at a cost.
>
> BPF trampoline already handles all the synchronizations, such as
> add hook, remove hook, etc. properly. So this is not that hard.
> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.
>

How many bpf-lsm programs do we envision being attached at once? I'd
think that stacking of bpf-lsms would be difficult to reason about
(moreso than static LSMs) and won't work that well in practice, but
may be wrong. Most LSMs use 1 xattr, Smack is the only one who uses 2
IIRC.

> Thanks,
> Song
