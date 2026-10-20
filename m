Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517898;
	b=XD1njgz5gkWnY+yxaXRDjlysqDSB1GnpR2kQiUfofOR1L9W4KqaCLTAGonWCiYoqxOyt
	 7I8WDw3kYx18aXGLTe8DaFm1LTNLWFyDiYx+galXaonEdZWqfuVyIGtEvuctZZyTMhRwg
	 2R4edhP+N53z1vkeImgtA7FfEyRkeUm+9THBcC85PRoVipT6UGS8LdAxGvayO+KkZT6oR
	 Gt10o8JTS4fGMxaKaADE/sSeJxGMCWUaDWFHchXnyk91pZ+tvpAVnWXSjm5mgMphSCWrN
	 2O75z07FXnI8xCjsqHe7wbABsl5ppZzpsJTXY/JfvBNG49tDy4thVyL0kFCBY/YB2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517898;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v/3r8TNEKPTmA62qSgMmjkBfW6wA3NDTsnBMpgNm5gk=;
	b=HlwXM95IX5zw73iRAFKqChEncYsGD3SN2hOuK/M0ILZ3sOF6KcMa7/nbwqto/MQwdpeB
	 KQv18yXDFCVbrLqXfAGmYxYIVWXP+C+hVmcmMasNQZ5g/NiMZj8EWqYAWvdczicSQcM8J
	 ewpzSyIfT2Jai/5FDOtpqCfgm+eHckn9aLBP4HAIpm6avwslSv7UdZcHM5absTDa74jDg
	 usOsWLXnchx9RPXoKVlAGS/wVWU4oy2LcGVTE89jjFI30pS/YvotKxICJW6cod3R76kJk
	 60sfZyc8fme6vMB1t8YLIWLZDJwYVFGiUDQFQRJSpxGyKQ5arN9ci7NBQx8+KsVoo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211760A5BD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185491F000CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f20c3aaa5so329840985a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzPSDX2ErbE6zPlG9UHnTxCPxiFq3Uz7ZBJwx6yo05ncknQbiEEs9bai49FDMn4e/RjLxIcIUi6AYeQTuRr@vger.kernel.org
X-Gm-Message-State: AFq9FYL2bGurqcbBd9ws8clMy6lnuCySu/A5xTJkD5/ASZyO3exFJ8i0
	3k0e7SOSTMY6YZ99MGAQ2poyuDLmizwwLNeNGJfzp3BTu/kZ3tAXBV5pyX2rKn5tke4nGPKrDGH
	O4rCsNEteD3j5tZ+j3aWlc4Gi7cCRl3s=
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id
 af79cd13be357-93f29d9616dmr1909077885a.55.1792517867359; Tue, 20 Oct 2026
 10:37:47 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-3-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-3-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:37:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
X-Gm-Features: AclHuK9-NsxuAA831m7ol4gBimIkAE2CXBl-izBBZR0qJbIURqC8MwEK5TsVfws
Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a
 file released at task exit
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
> Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
> child opens a file and exits without closing it, so exit_files() drops
> the last reference and the file is released from exit_task_work(),
> after exit_fs() has cleared the task's fs. A file_release program calls
> bpf_path_d_path() on that release, matched by the file's inode number,
> and records what it returned.
>
> Without the fix the subtest crashes the kernel in d_path(). With it,
> bpf_path_d_path() returns -EINVAL.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
