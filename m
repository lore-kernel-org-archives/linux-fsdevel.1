Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E93314B9A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913373; cv=none; b=DM60z3Xf51H0DtM+hdu+jfvIDGBD3V+NHZRBmhoFmpbrwD8+1dZMOFKj10W5iN5QAJ7wQNSVYV6nlLJoWblp/Nu6qQp57PYLIs9s333Hinkx+X+1wldEJDCxTtMmXzLv3p9NkbSanlnRbgt5TbfCejBiHSYXT16bDIZ12YFRWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913373; c=relaxed/simple;
	bh=yPcb2yhm4K2GOkEJfjvSUv790XphbvJ6WzOdoBRLa/g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tPs3RpIyptoqLA+5A/mN6f+TDEEwC/2FwY1zSadXItiovpGciAMoMVg31olwOZ60Z0RDMOGFwoinlVkQcgqZHX+eZYxnA4Iy3qfACzbe+XVj31DM2oixqj+q5WpzSmSz4/UAY5eeaKR/yAV1q/HPnXHY/3iiXoMkG8LLT+GxUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abWHddLW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abWHddLW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so1712689a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783913370; x=1784518170; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N5LwUqjbpPHissd18BCl9UcC6YRNwOX+ZmfwwTb7nug=;
        b=abWHddLW8gruXrxJtTArQg2G0cJAjmJcTESDjp943KYljubchkU1a9PALBxN50vj69
         N0u6t3ou/ROShlxyary2jM4S1K9/pdHiVenqpRg52bMx8xlOrT81j2nJNKSLUjH2sekN
         BMiYLwwJq4Ux45SMyTzvy//pobtLpND14rQmgfKMZZIQ4Y8c4IcVhyo2JjYsP0DJtMHC
         3lLYqfHAcqtUgSW5XjqGyxGuk6VYXoSyROf7CUduOTo7lt9oUNrQhP4UEkdl7dVnbPrg
         OZPzuMAqMfcoFyV06J4RaHbb/Ne93xqUJ7hEj0q2+YBzZfMC1ZGTJvxyAce7kCfEQ7qP
         aEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913370; x=1784518170;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5LwUqjbpPHissd18BCl9UcC6YRNwOX+ZmfwwTb7nug=;
        b=lhGBibBUrjvZW0Ynebg9DeHY5mVS3aefEz/CtIS283xv3ZvrKiMvRd5TS8B7cJWsMo
         yLD2d6xLQgdQ5FfQunLX9/VTek5lSCaMxF++Ji9Lowe1cNGa/7mkXZCkpi2ygxwf+Kdz
         EhfuTF/z9vKlsvK3x3U10amUsifitba5hEW8X4W5qWK7pqeviW3jV5bX1f7k4HtoC+vz
         AImgqlWvcoHlUhECvwKZG0GE96sxOPATTixOovKxfyvQ7joKnwIBApqNkkNpxr3geRXC
         RwLwZW0Qgq85fbsCXNuGLwjEq9cJYDOucrKuuUtG6rE666EgfQif0Qzx1gI6WZlyEiCM
         1ldg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo/7p3LDF+MOQS6SO7oCJSookKY/0H0fmthnRWZljZx0iVYQRM2Kc25hHwb7yDejtoGphl0A1IUSkDUON2@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWWUqCe0ruIS+9GrI4JlV4eBOwjU7EUXO7J1yCBV/vFjnX5DR
	/wAaCz3U6zQpqrkBnfZKJAgsnaURdJEJRYhVdxjS1zTMSE/Kxvc5EmQ2
X-Gm-Gg: AfdE7cngOXLPuTDseFOLAC5fjnlhoRE8tJFkhy35zpsTc41qRN6EgvmC0KxWqMygw4R
	FCqd+efrlkrxOGNjrCFlxIa7bVE2w6mDAiXEsrHnaSz6sNkhSS2EjOQYxqX6FqdGabACP8OwCOe
	2RrNl3az/aoUfDmvPALcPUrPfZPWlJTrSHyaOIhZXY7Iw8K5ICPksxLIsUozG6MuB7jVWTUuQkY
	NwLV8z9yCTqkBKVt+CW17tq+DIimH89u7Nqai8ghzSrNUC8NqRoHefD0s0Q9AYy011B6IXFZ4KO
	BYepK0/gLKq6cTylabe7LAA2nVQDsPNn9F1Ovf55eNVU7k5cZgVsGdsdib7YYcAL5YOmpKiduUw
	KMGeiebs/+1pfAH5FjmXK8NlnydSBneg7FLlEO0PxkxxVR3HAqCuOMMPLAGWQH63kSiASectskA
	gSbEyzficAv58hQ6rWJGzENULQ
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id adf61e73a8af0-3c110b33403mr8114739637.71.1783913370254;
        Sun, 12 Jul 2026 20:29:30 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b84d6ce15sm26187778c88.5.2026.07.12.20.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 20:29:27 -0700
Message-Id: <DJX4IFO55D9S.3IV3K5XICJAEV@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Shuah
 Khan" <shuah@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Jann Horn"
 <jannh@google.com>, "John Ericson" <mail@johnericson.me>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
 <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>
In-Reply-To: <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>

On Sun Jul 12, 2026 at 5:32 AM PDT, Christian Brauner wrote:
>> This is a continuation of Christian's bpf-backed binfmt_misc POC [1], wh=
ich he offered
>> to hand off to me. I am carrying it forward. The kernel design is his an=
d is
>> unchanged. This series rebases it onto his binfmt_misc locking/cleanup s=
eries [2]
>> and adds selftests (+ fixed from the one's shared), and therefore does
>> not apply to mainline alone.
>>=20
>> As for motivation for this whole change, Christian did a great VL;MR;
>> write-up [1].
>>=20
>> TL;DR: binfmt_misc can match a binary and hand it to a fixed interpreter=
,
>> but it can't match programmatically or compute the interpreter per binar=
y.
>> The Nix community would love to support relocatable binaries, where the
>> correct loader can only be found relative to the binary itself.
>> This adds a 'B' handler type: a binfmt_misc_ops struct_ops program that
>> inspects the binary and picks the interpreter with one new kfunc,
>> bpf_binprm_set_interp().
>>=20
>>   bpftool struct_ops register nix_origin.bpf.o /sys/fs/bpf
>>   echo ':nix-origin:B:nix_origin::::' > /proc/sys/fs/binfmt_misc/registe=
r
>
> Thanks! So I've spent some more time working on this because I had some
> future ideas that I needed to make sure could be accomodated by this
> (currently on vacation but hey...). So the version I have givex this a
> better design and has future extensibility in mind:
>

I also enjoy hacking over my vacation. I'm often told to take break but
some of the best ideas come when on vacation :)

> - The single sleepable load op is split into two ops:
>
>       struct binfmt_misc_ops {
>       	bool (*match)(struct linux_binprm *bprm);
>       	int (*load)(struct linux_binprm *bprm);
>       	char name[BINFMT_MISC_OPS_NAME_MAX];
>       };
>
>   The non-sleepable match program runs from the RCU entry lookup
>   walk itself, exactly like magic and extension matching: same
>   registration order, same first-match-wins semantics, and it can
>   only rely on the prefetched bprm->buf. It must be free of side
>   effects since the walk may be restarted.
>

Is relying on brpm->buf enough?
Right now that's only 256 bytes I think, which is not enough to read
segments we might care about. That worked fine when it was just a magic
number but the idea with the eBPF program is to make decisions based on
more data.

In the selftest I provided, the `PT_INTERP` segment is already at file
offset 0x318 (792). I was imaginging NixOS having to support
`PT_INTERP_NIX` in order for the produced binaries to be backwards
compatible with older kernels.

The other idea would be to make the `match()` broad and select
everything but then nearly all ELF64 binaries would match and then pay
the price to `load()` and ultimately `-ENOEXEC`. Seems like it would
make multiple BPF binfmt programs less useful.


>   The sleepable load program runs once the walk has committed to the
>   entry and does the file reading and the interpreter selection. Both
>   ops are mandatory, the struct_ops plumbing enforces the sleepability
>   of each, and since bpf_binprm_set_interp() is KF_SLEEPABLE a match
>   program cannot select an interpreter by construction.
>
> - A match is a commitment. A failing load program fails the exec instead
>   of falling through to later entries. -ENOEXEC keeps its usual meaning
>   and hands the binary to the remaining binary formats, for a handler
>   that discovers it cannot serve the binary after all.
>
>   This kills the part of v1 I disliked the most: the skip cursor and the
>   leave-and-rescan loop in load_misc_binary() are gone. The walk is
>   never left and re-entered, and 'B' entries need no special semantics
>   against concurrent (un)registration anymore.
>
>   Your v2 changelog note about keeping the bpf retry loop in the
>   __free() style is moot as a consequence. The loop no longer exists.
>
> - The load return convention flipped: 0 now means success after the
>   program called bpf_binprm_set_interp(). Returning 0 without having
>   selected an interpreter or returning a positive value is treated as
>   -ENOEXEC, other negative errnos fail the exec.
>
>   So the "return bpf_binprm_set_interp(...) ?: 1" idiom from the v1-era
>   programs becomes plain "return bpf_binprm_set_interp(...)".
>
> - The handler name moved from the offset field to the interpreter field
>   that field consistently names whoever supplies the interpreter, a path
>   for static entries, a handler for 'B' entries. Offset, magic, and mask
>   must be empty:
>
> 	echo ':nix-origin:B::::nix_origin:' > register
>
> - 'C' is allowed now, v1 rejected it. It behaves exactly as for a static
>    entry. The setuid transition stays gated by vfsuid_has_mapping() in
>    the caller's user namespace. Which makes 'B' handlers usable for a
>    per-binary loader over setuid binaries. 'F' stays rejected as there
>    is no fixed interpreter to pre-open (I have other ideas how we'll do
>    something like it later.).
>
> Nothing changed in the exec patch, the fs kfuncs patch, the kfunc
> itself, or the registry/namespacing model.
>
> I can send v3 in a bit if that's ok.

I don't mind at all you sending v3 and in fact I've been enjoying your
involvement. I didn't know what to expect when I offered this idea up to
the community.=20

I'm happy to keep co-developing this with you within a design you feel
acceptable with. Please let me know how I can remain engaged and
helpful.

One last thing I was thinking about is that we will also need to support
$ORIGIN in the shebang path, however I just tested it and this current broa=
d
BPF solution can largely handle it [1], with a small wrinkle.

  $ printf '#!$ORIGIN/interp\n' > /opt/app/greet
  $ cp ./interp /opt/app/interp     # any interpreter/loader
  $ chmod +x /opt/app/greet /opt/app/interp

  # stock kernel: binfmt_script opens the literal "$ORIGIN/interp"
  $ /opt/app/greet
  bash: /opt/app/greet: $ORIGIN/interp: bad interpreter: No such file or di=
rectory

  # with the handler registered, $ORIGIN resolves to the script's dir
  $ bpftool struct_ops register shebang_origin.bpf.o /sys/fs/bpf
  $ echo ':shebang-origin:B:shebang_origin::::' > /proc/sys/fs/binfmt_misc/=
register
  $ /opt/app/greet
  <runs /opt/app/interp, the loader found next to the script>

The wrinkle is that it can't express today is the single optional argument.
(i.e. `#!interp arg" -> argv[1]=3Darg`). We might ned a way to express
that in the load.

Anywyas, thanks again. All your ideas made sense modulo I'm unsure if
`bprm->buf` is enough to make a decision...

[1] https://gist.github.com/fzakaria/2e1e1c44fa488a951674f8761c672366

