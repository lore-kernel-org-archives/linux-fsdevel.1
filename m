Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDF286891
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170047; cv=pass; b=rAEaE6pAqJ+V+oAvZaCFjMRdTBQDj0Y+Ok0vJd9M/Azs6AvoyXy0lAW/zKAfdnNsEvTbg/DXea5fYuDlodNSLww9Zzg2nbjP9RICv9GTy+Nc8zFEEC4cerrdqNgJqbgGDn24GOB7zu8lpurFt3wyoeZMhW6COl347eVmBHpUxRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170047; c=relaxed/simple;
	bh=cIra25/7V0IbwrRRmDW+gsrIYwnkI1A+HRB1U6+DiGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRL+Mnoao7Wlez5jOrFpn6ecGocxnLGHqE1Ucp8vP2fbUrsLHFOb3mG2+coX9dPbs94eXP+QTBZOjr7wetB/YOHoYwFCHOrE+JkG7xxM1Uwd2bs8dMw6VfOQoJdrHCgBRnyCfs08/2QdnHoGPy3qoTqkXjo0UaB4d/xYC3hDJUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Qt+8yHh5; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Qt+8yHh5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7ded779a345so14264897b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 12:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780170044; cv=none;
        d=google.com; s=arc-20240605;
        b=BRylCRT0p6HBxqXSEFUuEy6ZyQf7cVGtpxbju1PhZVlzKR8pCtLnc4q4DX7oQ6d5Hl
         CymXX9De/N/mRN4a893dBB9woz2EnhVx320SvlxUl1GZ0iWFwApBx/hmO4AW6LUjQjmb
         oBe17GUKkMCG0HW71w7H6mJ3neD+Aoo3SKMeGKXXi9ZB69ZNqJ1RnttPFdBihqZwGEXc
         vG5iSwsDD7obvhaAOewjWFeKOLecWiG4EgVEbanFSexu1oCH10rSYDT4jd181Q2SWhIL
         Nts979qj9Y6mxXYy6UiW7Q6ujifZSx4I3j1wtSUMvF902gfn7Cebm9ez0Wy3SOnfPSIS
         hywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhMPXpo5C9bO9KiY6ITYmWYOylh8Rc870xEi824FVCY=;
        fh=t13a8QGNy1zK/OkczCwwhyWfKvFmjFJq3z8xO1trvgU=;
        b=ibw6C9AZJmhNhoTXSZFhRkqUwJSIOnb4mdKXV+e5Y1VSKJiaHv0nsQLUD6+VMT/MOA
         J1J3llFSYKRP3L6o6wNR5HCpik0QD5CO444gZPDIhT7YsI273EV18V79rR7bm1alVj/2
         vkw+PN2xqPTPWJ4zutUxpHCYylFcZtsbYGaWzp+ieVOPzWb3NiBSPmhrjZMyri9x5UgJ
         EIuhzsgn6I6nqbXU2lIc+U03o3xmCNkpJOEAmMsd/pWayeINcb86srMUJfUSbxbKeIH6
         Wu2r5W7VOFJNmRozqYP9JX/nN/QzHPSW2PlRi6Nuc5ym1S3LsgMJoRHJk8mYDVNhdrH3
         m8+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1780170044; x=1780774844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhMPXpo5C9bO9KiY6ITYmWYOylh8Rc870xEi824FVCY=;
        b=Qt+8yHh58r4R+NE3XN0weWjys05F27eRVNqBeHUwzPrPfJIKcRzY3yaEfYSkm7bNRF
         WFQ4ip9DJnxNf4dVyzBGfXCX5wFnqOF1O2nHXzEJ0jEiPS5p3vUl8IUW0EFKS7XBbNdC
         M0yHGqpSPNCzvQQRO9GwPrG+TIYzU/DunJS+whSQTb8hExQEM/wTvzVO/D0b1/Xd1QVn
         sUZeAidxDcpIaw84E0YFA2/yK2cDE5sx51BfkQr4oDOaG+KugSFfOAOS8LPgZ5/iF+bA
         X4D+Klf7I49HMxwgEEywbD5SNFXAz38zWKwV1DvNd+YZlZCLWasy9J9AXDx8WYSdswhI
         jNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170044; x=1780774844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhMPXpo5C9bO9KiY6ITYmWYOylh8Rc870xEi824FVCY=;
        b=cC3xfr7hZsOjul/I08r9AeFlu2LjY/Px0mcdkH1R4ZGTwT8zYZs/3FaCj2EKSOVed7
         tZ85klN/0aBdnYGN5s3hQn0X/w8oWgeJo/6PAIcMSdM+6930y+fvWCPSdIc2zr6/9ypL
         YhryfEAbf8h3CE04XGbRgoVjWjm1z9nUDJm0QeEnHsVEMh5+Kegl+l4QaVcWghA4dcxY
         OZS238WFSM8CGgKAbdkckTAJ4Ubz+zF0JIUoD3FVJdYfKmDz/KoUVPJ7KprEflLKrnbq
         174vvL8ad+WUl4NvVOD720yX66ebL2z+NFpmzAegIDgizG0vWX5lzzi6BnnVbaIyIE48
         doRA==
X-Forwarded-Encrypted: i=1; AFNElJ9k0t20dwTVvzJvcCprd1OEXqxoeJ65/+qOyNJOXPH8UQ2RSsv7csJ+XtVbRuUZWDssHfROYWrgsif9eLTj@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNtu9XSmNo7ZIaUT9IIgbKV/IsX6VmMXZ6v3piO9beAtOI5Kr
	tPkcWX6I14zDB+KrgaKBL09AACgHk457cZFy7Ot3bKGoNLdfRpVEffx8nE5ZMHojnfp3Jge4PBu
	IuwNugU+NjF5TkC2001JVxPqxznOAhrrLTIvz2dWabA==
X-Gm-Gg: Acq92OHNzYCKa0h/6zHxtNAHITjfyI1KGVkDW7dwnsl1pBYuzwjjMmRWsPvV1QUWcvU
	+OUw9YZpsoKrqAZ6XbtTXqmSA8WkpVEuOrQLy6hu3FGd3m+vsSUBfQjqLAZW3jS+H6k8CwgR7RN
	0h1jF3qGlMX0LwooGk6HEWCxqJ9OpQt3sfQkFD1KtA2jFU0pLjUbsXfK0QuIZzyyXmn0oRHFKy6
	2PcIgwRRxCEoWFwfrIGHfEnCw+3ccwHr42U/57G9vgol+VwwpwQqZvJpjBNprJYq+SoKEZA7PDV
	PpJBlApNhjCrseSorf8n78mwbGTxvuW+wxPj2Ri3alIBy5zSWkk=
X-Received: by 2002:a05:690c:f04:b0:7b2:513b:34d7 with SMTP id
 00721157ae682-7e05c664b30mr45779587b3.29.1780170044578; Sat, 30 May 2026
 12:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com> <87jyslndo4.fsf@igel.home>
In-Reply-To: <87jyslndo4.fsf@igel.home>
From: Deepak Gupta <debug@rivosinc.com>
Date: Sat, 30 May 2026 12:40:33 -0700
X-Gm-Features: AVHnY4L_dtmKXZYG4oLZDjuNSTdF7bCgCYfC8yAIbkNUuu6y-j26ASIyCiMoR50
Message-ID: <CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
Subject: Re: [PATCH v23 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 8:02=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> On Nov 12 2025, Deepak Gupta via B4 Relay wrote:
>
> > From: Deepak Gupta <debug@rivosinc.com>
> >
> > `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> > VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> > updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> > This is to make sure that any existing apps using PROT_WRITE still work=
.
> >
> > Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encoding=
s.
> > Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> > encodings for shadow stack. Above changes ensure that existing apps
> > continue to work because underneath kernel will be picking
> > `protection_map[VM_WRITE|VM_READ]` PTE encodings.
>
> This breaks LTP mmap04:
>
> $ ./mmap04
> tst_test.c:2042: TINFO: LTP version: 20260529.5ccf816f
> tst_test.c:2045: TINFO: Tested kernel: 7.0.10-5-default #1 SMP PREEMPT_DY=
NAMIC Sat May 23 12:09:09 UTC 2026 (bb95589) riscv64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:753: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow the execution
> tst_test.c:1870: TINFO: Overall timeout per run is 0h 04m 00s
> mmap04.c:66: TPASS: mapping permissions in /proc matched: ---p
> mmap04.c:66: TPASS: mapping permissions in /proc matched: ---s
> mmap04.c:66: TPASS: mapping permissions in /proc matched: r--p
> mmap04.c:66: TPASS: mapping permissions in /proc matched: r--s
> mmap04.c:68: TFAIL: mapping permissions in /proc mismatched, expected: -w=
-p, found: rw-p
> mmap04.c:68: TFAIL: mapping permissions in /proc mismatched, expected: -w=
-s, found: rw-s
> mmap04.c:66: TPASS: mapping permissions in /proc matched: rw-p
> mmap04.c:66: TPASS: mapping permissions in /proc matched: rw-s
> mmap04.c:66: TPASS: mapping permissions in /proc matched: r-xp
> mmap04.c:66: TPASS: mapping permissions in /proc matched: r-xs
> mmap04.c:68: TFAIL: mapping permissions in /proc mismatched, expected: -w=
xp, found: rwxp
> mmap04.c:68: TFAIL: mapping permissions in /proc mismatched, expected: -w=
xs, found: rwxs
> mmap04.c:66: TPASS: mapping permissions in /proc matched: rwxp
> mmap04.c:66: TPASS: mapping permissions in /proc matched: rwxs

But what does a writable only mapping even mean? It can always be read.
I see two ways forward:

- It can be done in generic way where incoming PROT_WRITE means
  PROT_READ | PROT_WRITE irrespective of RISC-V. Although others
  (x86, arm, etc) would have to weigh in.

OR

- mmap04 LTP test can be updated to expect either of "rw-p" or "-w-p"
  whenever only PROT_WRITE was specified.

I think latter (updating mmap04 test) is the easier path.

>
> Summary:
> passed   10
> failed   4
> broken   0
> skipped  0
> warnings 0
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
