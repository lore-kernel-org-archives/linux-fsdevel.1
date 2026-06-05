Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05868416CE8
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677298; cv=none; b=HwGVqbc3oMnfgyL0ytvKzGG67drbWfY8G/Wj498bC24TbfuqmDov2NKB+53SjuN7Xr3reFJcGeDhMADqtZDvR9N0CBQEshix7Me++tdXQvI+mr6Zr67Okzn4aFVtWEDkWQ7FUV/wEAffrhxCiGrvY4HpqxuiEQc61hObO+DDW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677298; c=relaxed/simple;
	bh=xhA0BnyaS18CqnQuFNEb6UVKH5NtNpGJdPqoi2RFSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U17x4F/00T+vJiqf74DysIrsSugzQ3jgr5QTy0SZX49A3amIo6SUQ3QYe9dph0bm5dWwGslncbbIs04XrxhX7tq76GaIzwTAfi3zohmBVCtZqrnSJEKuLMChiDId2f1fQ0vNBoy57fx5dN6EToiNSQ5UPcc2GwAhUC5z1egfcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTtcBQNK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTtcBQNK"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-befee9e5ef7so229218466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780677295; x=1781282095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QDQNJjYqwPm+P0wBS/rB5uazpPW4+3idJB2lp6tmqM=;
        b=eTtcBQNKrPL6mMPjkJoYR2KdlMAWECtHCi0W5I1+2Ivfd6/PpI50H4Ws0jZCioBINC
         zzmd6bqhIMEz1PrO0jeTrWpN3Fc9uhuXg+tt7MMMiRSt8BjQHDAb6OWDmsaEF9CSBD56
         Y0Ic1F7nxKFtwT1uXg0I0M7ckBiUqAESnaQmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677295; x=1781282095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QDQNJjYqwPm+P0wBS/rB5uazpPW4+3idJB2lp6tmqM=;
        b=S7hyLIrmJP9yGcRVrpr+VCgJGxqPJ8j+FY0K71h0jtlV/bLL8zijjsPdfAMhJQe5xK
         8vd5UZbjk4Fq/AM2t3/fVrtQZoFqc50HKPZoAE+W+9pfI0l3Uv3cKsZ2UGb7qsDlSb12
         IIvHFJgU8toiaZtSrZJy2nHkf5w8H44rtUGOrE4Y1cPfmfAgvxwEEHi4/7wk3HMOsNa2
         IB2cHO1Q5JA+/Ug0u+yHFcmhkXI5OHRB7oh2b+DGWNBGUCdzuKNqc28kthKbhFXmKzqP
         REf6G9puFbvis1TEDDtbigZ4MkO/4HPUJugnEMTjcVgtvnhoLKXv16uU4pmr+wdU/kTz
         Dscg==
X-Forwarded-Encrypted: i=1; AFNElJ973kmt4/EjnisR4nAo5CyofgzITNFzyselUcOWG/+40qOFVG1k7sFsb1zGGm8aWu7xOiIwnoGyXJdaztmS@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaGaSfVpfQIzN5gQKOvVuHi5IutTACq165Lb4Cx0WYWZLRTll
	Xa5p2v/xa+hL6Kb6/Dp1I7nlFQoJlbMS848KVHkUPQb1n2361vqCGHsGamn2nY7FYWEVRjCJMez
	5VYFLUGmqyA==
X-Gm-Gg: Acq92OGdIy2Af1Ty8Z8sKTcyuThSlTuK3hFk71ZEaD3trK2mFgxCBsTjIMTPWJQmHZi
	FHoOYrJIkgTPazcba5SGW5WqXZ7PBU95hU8WahLmnLqCtr3I4uWVRnvh3dYaxYX8e71xGAuPqBM
	5p02kHgp/J6AKAPHjt72Ig6FxwgR8/96Zwz3Tb2AxOQJEK/Oy5Rj6T//Oyjyl+Bn8H8LTmqpb0K
	8mgWetbbwJhIElF8IkZbcRZW85rVBXhz0Rnxk0iPtiUp+RbSMDxN5y1u8zDhpOxY8CcIQe9VFd6
	GaBd4w1oqlgxQSnC5FMoH79MZXVTYjhwY7m6yR7RvYvnvJp3jHKwIK7BJvvgpn8wwSY8YhSS+xC
	5Zv4S2irdqJkiH5L1PEf7MFujOjT56CsvNqUykx7b32Zx4GAhUvDlLo18opOsfg6s99+PKDm/BV
	eq2sEmshsDyn4Vzpakk0IEJBZrMEcILvnN+AKbfDEIM4MPJUdm2Toi5Lw1frAAiz1PXSsPdjMY7
	bz3o184T3NQ4bke0fhDlw==
X-Received: by 2002:a17:906:d54a:b0:bed:4f1f:bf9f with SMTP id a640c23a62f3a-bf37037b815mr232684366b.5.1780677295221;
        Fri, 05 Jun 2026 09:34:55 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559eee00sm490813566b.56.2026.06.05.09.34.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:34:55 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bebde89cfd3so256516066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2/TyqUikUGeN15HQ4/7B+LJhImxN8qFZfOZnsHSEaRhPY23wtKX1NSByGX28fKxDDQp/7l0xG3eHvweiR@vger.kernel.org
X-Received: by 2002:a17:906:4fca:b0:bec:5264:ee9b with SMTP id
 a640c23a62f3a-bf372c2dbabmr257257066b.36.1780676845718; Fri, 05 Jun 2026
 09:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin> <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
 <87se71jps4.fsf@oldenburg.str.redhat.com> <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMTq8_2rpYoZgoxVCwj=LsvfzHzPuwo-NcizT7J24MPQ@mail.gmail.com>
X-Gm-Features: AVVi8CcJjF0IzkUXs5jB8j5aKjJm1d1LQ0EBlpf4RydnYVXz3zkkVCs-hralHh4
Message-ID: <CAHk-=whMTq8_2rpYoZgoxVCwj=LsvfzHzPuwo-NcizT7J24MPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Florian Weimer <fweimer@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@gmail.com>, metze@samba.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it were to have the same issue that powerpc(*) had - that 'unsigned
> int' has to be passed to functions with well-defined high bits - that
> would be bad.
>
> And I'm pretty sure that clang doesn't do that.

It's perhaps worth nothing *why* it's horribly bad and why I think the
powerpc ABI is nasty: it means that *some* things are done in 32 bits,
but other things then expect the upper bits to always match.

It caused security issues, where user space would (for example) pass
in a 'int fd' what was value in the low bits, and then had interesting
upper bits.

The range check in the kernel would then compare fd to max_fds - using
a 32-bit unsigned compare - and see that it is all in range.

Then it would use the *exact same fd variable* to index into the fd
array, but the compiler would use the full 64-bit value for that array
dereference - without having ever checked those upper bits. And it had
passed the unmodified full 64-bit value around the whole time, all the
way from untrusted user space, and the kernel code all looked
"obviously correct" and had all the proper checks in place.

If you want to bleed out of your eyes, take a look at the rather
horrendous macros in <linux/syscalls.h> (and the sometimes even more
horrendous arch 'syscall_wrappers.h' files).

They deal with issues like this - and others - with some truly
inscrutable code. You have to be super-human to be able to read it,
but those wrappers are why we can then just do things like

   SYSCALL_DEFINE2(setregid, gid_t, rgid, gid_t, egid)

and it will generate not only infrastructure for tracing etc, but also
the code necessary to force clean up the types for the architecture.

                    Linus
