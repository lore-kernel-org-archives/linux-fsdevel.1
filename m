Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475864;
	b=BMV5kTidsPJ7Nn5/tbT3M89S9pNEWV+hr7pHTkHWFyPlBStE7MVEa7wkJHwQMVz8tqRR
	 JLYJn6P1pLUI45208MjRFo45+PmnNQ1zzN+P+WS72y0RyEGoYIb5LJnHGhuNuRYSrE0Qn
	 WqqclS61KyzL3Syk+N0EZf+jXYCHIPqIhSevsChhzbBfulCqbWW8dJfbfxsFCbwtlAe+R
	 fhQH5PD3W0md1FroReGG+9AUUzkKjYMpVzU0cBQSqC+cD0sVFJDxaGwJEFEX38BSZ5xGo
	 B5LHB5TmZ8iNJhVC9uuvff0pT4G+dYPrbWeeFXLcWdUNjIKgBH4P5Eu3Zu0Ml/EZ63g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
	b=LNvTq87NXJT7qWZGFREXz0B8W+6ZnBzjlcdKpyKkQo5k8pnpPAvASDLFDVLTCQfEUGXY
	 3cTrksKltMl7UDALgceNTTJaiQMmrfAR2H9uib9ukrhk+JA9yZQFgGyi2wtREYe06EoHz
	 ng1Uy/gQ6iuoTuEU47LzKU0pkMpO8oBcCXwBVjDKZmntEK1SFZBDAUP4Lj7GouIsJm3TQ
	 cwptpAyuvDgTXp1aNi3e7u1zOe58ita/ZT7jqoKtGwozyEL9VRNfn5ov3/xARkuvd5XoZ
	 tq+pvM3vkgRP9839Got2YDIQacH1Wi7d8o++AHxN3veSCyqqpeLsK4RB2fsLQJxNo1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5C606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 23:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80B5C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so1642828a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475863; cv=none;
        d=google.com; s=arc-20260327;
        b=TFWCHUFQtZbqYfZybwTzPxXEox8bn9DQKfd1SrnlWHuc6WwlVKKLWqhX0pVMQO0yLn
         nYfxjeFC2zphY0yF7afP38zD+fdcdv4g2jsAElsSKYpftJomwWKUu4g2RrlSWTrkd7zE
         zlNGQG3maaCXGCiaBuoPta2LiVMVGmLawLlg7pdukoc8Dq6F2c8CkDpgCybc7PVVI+CR
         qD5fIc6gCd0Mlhr/2WpSqzwiCduifuZYKS3JJggdmYZfbZDp7vkwVd9fltaQlRMBQb7S
         LohROwjY5g8102soxCPVhBqjUifBdc7zXRH5Xg08x+25q6ita2bHWFcP74TU2fYspcho
         pi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        fh=7tUtkbPw115IiDy8uJG7r+lPNnPkQfp4lHE56I4yLXE=;
        b=sZY/a3Zu5i3YGv3qpbG8u9EKewQmvcWehuTLzidw03Bggq8JOU9Gv+3bHWxcAsnzq0
         diPFwl9fubOUbOAbisLQRcyWHgsNvGOGtEWLoW8S7zqd7fvIZOiJTVmtQmJGYIeoJ9Xi
         Ib7WZP1+Dk+ZOcs1vkrhr7GNVQat78dcaMji77n0RaGbfRR/mtHbQO4h8SSvaukJiImc
         ZZZSoPqyDS8XDd69kJQsQ4GGuiqGc85bhwbmrQasOZsJP96Ime1vwVVeDyadFT6L0xIS
         3gKWICERlEkJvYFNxHcZxU5bTGPMDfc2SzO217DnjwP1Gc4CpX1T8z+ZH8e3tQ9WwYl2
         DNfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475863; x=1796080663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=f2URxq+PdSANt2DyfE/LnSY1XFoTYnOosj5xEXQkbA7SxI6W4QwU0HmSJshejcTWky
         S0FQGoGeqWv/V4cetnAuhQG9AIsuiihN0orRNBCn6WjeSaid26HA+lT6VUTjWcBQSD62
         qbB1PFXofdfinS7Mln/088yRU9CiCBNNcCiudlFZlzwG2Ibxhw2O3aFEMNMwREoEyrb7
         CsDxG2c54h+p3PHCJY7OlHB3qiqGkyYxICHT/g7CCS/5/T31+MIRFHRPhTmhfz3hmzG1
         Fon7afxI8wozcjBzuTy7rCmabVdtDYIth244kS2420jGicRJ8THCQhWgSfEHI5cYMGye
         12ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475863; x=1796080663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=Qrc/xD6aROeUDxG+V1NgtNm9ywbs8iJDAlpjHGjuoXbBCufonjrAIgG/rdgE0YIcUk
         1IUq1Q8bMOjnAD3ICuvJne+iEqm3gPMY5N6BO3PgLAy+6nHjhMHmlpscxslkEXz7thLw
         BJbsXWaE23dYFBw07Db+snUaRCS4IjUweCcEWT0qjjA8hsbhtf58D8iBTmozgbapKf4B
         DR8zGH510k6hJ01Pvb3Nyq32ZCKIBrd9PdpN2AUGm9b/k/hhQaJZ5zdw+wR1PKq7Eagl
         RNv0yNjulzIKymNryaPkavpPdDu2+AuwjYDUU94aqAycucfygKND/TWRNy1z3lBbBayP
         UiZQ==
X-Forwarded-Encrypted: i=1; AL+hErFrc3+YRzkqB5v9Vq2rNNgDBga/pG5xKE744wGoIwjSFmh3W+9LwKxlSDsk6jXz1UMEQtvTdStiJdvkJ355@vger.kernel.org
X-Gm-Message-State: APuU4Z/onbLbQhPPLRK5lyD3MrzPNVqcpILe3WDsTieVMlXdM0gYYdO1
	x/ThukBj0c5t12lE5cl6ZQUThLVsKzg0m5In6we2yPIm1ghF/MbJv0diKRm88YfXhGdY1hN3evN
	bQMMdjEl+C41cbphod5Jq+S/uzZfhk02sulKjTKJ1
X-Gm-Gg: AZFdTZfv5yb65ZqWpj43wnHqioX/l54bVojrdd093Vx2bYg1bfiavw5xaS+3fO9LCxj
	2bWxrG1JAsiIvT+Y/9vB2srV+Onq//rQ1tILk1jSlc6KLlkcg110LPK/rAW2i5ryv4YG/K8jPra
	4nNjUV6sEhuId5YyoH4yg2ardEnBdRRUJNlH7Uj5EFOBhzRd1mDNxnmcBW9VVyji4+s16IYeE2Z
	NQOlFN9xHrJJj1whScRH7P0S3TY9az0aCWlI0FeA2jval/MUeohe4xmG/4YBgYsYQQ/1yo78322
	W8GbUqTtBaPJ7PLnC5PFSLwEoEr7DaVBb9lO3yWC80OnyQK+keg5/esfey/NXlKPY1PuV6Y7hvr
	+r5RKUbPQ2HI87G0Kgcir52PLOocfV6mz6LZl5e5NqbSJG9wTAPRIFsvN+NPy4ubhyYA8CA==
X-Received: by 2002:a17:90b:380f:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3b41cb0cae0mr10882903a91.51.1795475862780; Mon, 23 Nov 2026
 15:17:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
 <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
In-Reply-To: <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:17:31 -0500
X-Gm-Features: Aa3M54o74z8pn5Pvit6S16im7-Wxu2Y0a6J5-TPpee1sYBnPKi6ZczEefWRjtvE
Message-ID: <CAHC9VhT78Ktssi1gLWTKPC6KEgg9npeTf+2-vjwANeAbPoSC5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: always call the namespace_free hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 29, 2026 sashiko-bot@kernel.org wrote:
> >
> > security_namespace_free() returns early if ns->ns_security is NULL and
> > skips the namespace_free hook. But ns->ns_security is only allocated if
> > an LSM requests a namespace blob via lbs_ns and currently no LSM does.
> > So the namespace_free hook is never called at all.
> >
> > Landlock only uses namespace_init and namespace_install so it doesn't
> > care. But the bpf LSM attaches to every hook and a program attached to
> > namespace_free never runs. We want to use it in systemd-nsresourced to
> > get notified when a user namespace goes away. Right now it has to kprob=
e
> > retire_userns_sysctls() for that.
> >
> > Note that a bpf program can't work around this. The size of the
> > namespace blob is fixed at boot and the bpf LSM doesn't request one.
> > And security_namespace_init() allocates the blob before the
> > namespace_init hooks are called anyway.
> >
> > The check isn't needed. __ns_common_free() is only ever called after
> > __ns_common_init() succeeded and security_namespace_init() only calls
> > security_namespace_free() after the blob has been allocated. So if an
> > LSM requests a namespace blob it is always there when the hook runs.
> > Call the hook unconditionally like security_sb_free(),
> > security_file_free() and security_bpf_map_free() do.
> >
> > The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
> > stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
> > prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:
> >
> >   bpftrace -e 'fentry:bpf_lsm_namespace_init { @init =3D count(); }
> >                fentry:bpf_lsm_namespace_free { @free =3D count(); }' &
> >   for i in $(seq 100); do unshare -Uu true; done
> >
> >   before: @init: 200 @free: 0
> >   after:  @init: 200 @free: 200
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Cc: stable@kernel.org # mainline only
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  security/security.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> I just merged this into the lsm/topic-7.5-02-lsm_ns_free_change branch
> with a corrected subject line (namespace_free is the callback to
> security_namespace_free()) and the stable tag removed; both changes are
> annotated in the metadata section.  I'll be pushing that branch up to
> kernel.org shortly.

[Side note: my apologies, my script got confused by the sashiko review
and only replied to sashiko and the LSM list; adding back the original
To/CC list]

--=20
paul-moore.com
