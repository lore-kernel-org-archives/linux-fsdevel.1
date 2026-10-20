Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517834;
	b=rJzw9morkncx7/Ikt/OGs1R/9W3+z3lXlsTtTmBwdH32l7w7kGg2ObqqTEuTzyfgiGxZ
	 1sexVz3USe7DFBppa/SuzdAc0BCpo/GTHnpcXEsYc1vnKmyts4GlNpe4PsojD9lU5XyRF
	 jlGJGBID8iXGTCzz8d+D3qycxz1LLBGJ20u1Tqbs1PFnNJ5vjNXw/xkRTE3b8bvFI4kBl
	 CnPFY93S/oFSknqbf/YrATrNbvcrHmqNiWc8FvUdRQIMdtCtKC17x9l3V55H8nI3/D6z/
	 O8se9ESkgNOGN5vz0ddjWq/knLq4q1Hm900YkMxjybEJFprn64Qbky+TtPYX7T43QZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517834;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	b=sBcTuv+hGj4aBqXCBSJVCPCKY3pxm3oGK608eXvJRjsXqy/Eqy3SaforxO4kfz97mr2V
	 jGKUDQELBMG79jc8l4XoPiaiEUeuEuOTBT2az2OEKtfNh+0IP7emMm8u5E2Fm3fbbjlJ2
	 RtQt6zeL5RNw53qi3SgyQix5eWzPc++OQuifMbA9FXP8/DZyy015xDBoMkDQtpcTw5tih
	 94tCCXC6z/bcpacbPiiq1bfq3vI1mhv2n/j4CEHHVQWc2YNH//RAGaXsa6ZJ66FKGL1h/
	 UIOstac4Jt4WR9JCXxa3kMMpDMVXd2GAdmViDFohwO2eI5uZeawUGpuVQqVpa6FfwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP9Vniv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA8606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP9Vniv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FCE1F000C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517833;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NP9Vniv78Onx/ks56IVBH4yn+4ttWg0NuH8B79SRS/beeT9XqCxopTm2QpihI65bn
	 9pnzl8n60UDmaVohsmUcv1hPCYXtbwlPbW2CHY4c/52bFJrSKapQk1ObdxQogw4Ej2
	 3TkNiG+DPOQNJU2RIXoRt96Fzilfk/b1fD+KfoULfEydTHKjq43CD8RDqjN8Yg+tNw
	 YJCZ8NUZk6S1LB3cr2gZku5C8e4OQgSQ6SzSBPWLBS4DTY0VmFhrQ57gCRaICGtXmJ
	 kdsQ4m4HDrxFEN9Xef7pShotexmK4mIfweVrWfsQOytvjBjHbcKPYZWAV/c5akPaig
	 UAT8Rt8KRcB8A==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f2493c28bso273451485a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzjNAzsdVKMSMPjm3VFqAiTe6tyuTNVYyRwPnJd+jgR+UJIeZuS2AL37bz9uxQgfyVpeDrq82KUO/8Y4ycf@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4pGCCpSsRVVLip0l55MXadOpWsm46Z0djM+qxN3kmIeEK+ZHs
	upOkV4bsYPRRaXZVFnxr1GaIJJAQQa/VYFgPsvOBvR6GE+xEuIjaMgVClJwTggwMFlq7HtI1GTK
	1VzBy3lM0WUvaVA/u4g/3yXVhuJSXrIg=
X-Received: by 2002:a05:620a:4491:b0:93e:c12c:9b6f with SMTP id
 af79cd13be357-93f29df45admr1849134685a.74.1792517813956; Tue, 20 Oct 2026
 10:36:53 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:36:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
X-Gm-Features: AclHuK899YpzPcxp4mjqjQL7lgr3tszVq5e23B_cgGOF0EjYuXaU87fb6LLw5SY
Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
To: Matt Bobrowski <matt@bobrowski.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:50=E2=80=AFAM Matt Bobrowski <matt@bobrowski.net>=
 wrote:
>
[...]
>
> With lockdep enabled the fault is taken in lock_acquire(), from the
> seqcount read in get_fs_root_rcu(); without it, on the read of
> fs->seq itself.
>
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
