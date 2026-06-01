Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C5374E47
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336674; cv=pass; b=OCk0OX6fV8a2ieojT58tEnCrYlFTWguzvFYYepuaD0a9/L4+yJkig3PDSbfmKFVSM658C/Z7sSi9f0p/ikbn/bBxSl8DUyYK8LCwA0ZNSQcIhoMsb4pvuZyAcupHxjSzC8b9i93O+8ULTlU0wCqMK/JQuzpVnS1IfbPE03IJvJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336674; c=relaxed/simple;
	bh=jS/ZEKJo2ddAZIP+307JZp0uZcdcPAaQg1XEpdiajmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrxTNcN8YJv0v0b3FIQC6LGnrtoLZeL45NHRWxutJV64AbxsZLzTp8TgHfZao5w5Du+8XmvTn3G/AaXdQvzxPfe7TlvfrrN8JyN74WF/WNLJOm+JvcCskQ1mOm1skiMBOTt6DZ5iYXAYa71OVLseRpOyCtex6Mp5M4xVbJtPSV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Y8gObGVn; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Y8gObGVn"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e3b2a435ecso14760747b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 10:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336672; cv=none;
        d=google.com; s=arc-20240605;
        b=lI8BSv5chTIvQas1umTqUMsoey/eSZx7Xr+/IB2AXm+ZsDp4dVugh+f7kbFam34SH8
         W3abt2ZwSozVDO6U0Zivon1Fj3AiaBnsn7CtDSfSmWDkkqKsLfRXnFSXbUfpCTMCpjSC
         hS3htL1cfuIuRKhiqQvMmiHPTaYMviJvS8GzAGpo82kI4cyyYPtHGMk/LkADd4mZH2zW
         ZOLwhd0SqUX0m64656e4E+56ezvlwkjlCeTa3NiUjC9vkF/ExhYOsTe1rymAxAmRyk0G
         Wvv3GPKJQIwBueSzDKLwrySm09YB6F3ZmqyhGviZWj8XRx0ahmX/wpqVgE16Ponbz681
         uNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        fh=Mlxoh9/RoIbCeMdgia4YVMFiM8J/uMhkHgjxC+qqURs=;
        b=itrpFRO0IP7/Cs6BgL+bLqvvGKQyofpEn+Y1OOC0zXi20d3oKGrGvoLuRC7mKsxyDY
         MZbtx8+SA6W6v4em1UBAlTFFc4jygx4KYIWrJA7V/utC8GFTfe10Mvsm/2i0q6xqS/xk
         1Ileu4y+xOWiZknabQln7acZGLlXqxQogaRwc09aZASV+bvPFBkG+chDDutd8FD/55dC
         k4PSBIF4gxaDlFZ84doHWc4WmdPgwytTqyWyoAWk1u8Df9J0XC4roztx+pG9LBbnhXA7
         2UktYGmI12fx3lA7Vshevi1w88BmTvSROIfUP4H2iYGI0Xk9GR/vcm/pa7iZLFqi6j+m
         Z0KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1780336672; x=1780941472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        b=Y8gObGVnIQEkypCR7OU54mIgGNbVOHe4Lc+1yn54ancdyLNe/ih/f4zzt4VmsHT7EB
         RcPsTBQfqLYFQ6z9qGGt6Hnp4NdvbwA1OzEBLeC/STfKaFf6nQgEoDYPf1ZdUW9tXXYj
         wK6bHimi4TPbAe2xSk0JJgnRZupzA30ZYcNUazyMd5RuTQQ4xAmpSZUzzsyxW2d845tZ
         JeGBx8MP8Ex75k/0VfMVmqYFjS+ayM+mX3glfVuyIGxADVqmHlK2DF/NCYjZJNrQhBfL
         1lgIuk4qmCInUBEv5T1GCUMJs7lsB0TUmfS5l0zFgGPja4SnPZO/pZ6g4p35D2qoPDIM
         mQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336672; x=1780941472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        b=goX/hJJqQ8jAxJXBS7BQIEH5368SvwwkhGjlrkBlxckqbkDxt9p0MdV4AFVChFUmjE
         cnUan6WZVDmehpGs+N0GDrcSdqRJpJM/o6R6qaBT1jR3of9zwtqIl/uLzlS1OvZ5woOG
         AwVynVSSIF7urhyCdu/Du3zXoGWLxW3Fpv3GTOdncbuYjCLoA3RNZGYATQJyFa2ioQW1
         f9m6oamKvZhIej4y5tDUx9biLMETPZT7aF6SylsAOkBSjbSN020vIGSn4gzwIkhgcMln
         eSzTZUnCHjGh5fis+lJHHCoQQSEEKssFmcCiPAjcUiRLbXZVS7xx+um5R8NJQ1/kvKQ6
         Beig==
X-Forwarded-Encrypted: i=1; AFNElJ+Axno24BHyTPysUrefKuEY8eJHUTwuW5Q2D6LaT7ceEqWhcVE1HVY2p1rqTK8Vc1Oe8oRDNA/xFQaTfa5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tOWG2rAUv+71Q4e9mqADzRbeFm4sRT9cnNn6QNZNXu9M4zyd
	IelMZ8PxbWfMEl2GyLeKVC1Rt6HsHuNhJiVvu4ml+X6Nbdjp86YWmDc0UC0lEJvErl3nbUn+luE
	7C2nBGDV/IPyeX6QlOUc4V5bvLexZLbzx0NvkUiG2Ww==
X-Gm-Gg: Acq92OFqL73gYe0Ly44vG0FBVmVJ9sm+nySiFjk3MS0ZV/ZQBVXZJgm/wv+/QQ1YYaF
	UWTt/HgHRkvviF4uwG05so3Usq9q0Xa+ngpy00GSbDg57CUZMVU1gDbgtLN8ni0hDBRzhcyW3ca
	67ErVkkaOW2Gq33pNhHANzuUfr84I1zC8PJzZdY5r7zv4YB3nrTNHCV32qZG6pvCgdBjA9qwWvB
	m808LABrX6o8tZrk9JUHBCDU8PaZeEXyzH7vEM0cgJMpwxol+4r6+lRfKhKXSG/MkpB6EIOFqCd
	TXyCaaZUKjc+MVbrXlZu8xGePf8q75teM0q5KyWb7qfYFKVsmOs=
X-Received: by 2002:a05:690c:30a:b0:7be:5f3e:5309 with SMTP id
 00721157ae682-7e05e853e5amr107636127b3.38.1780336672104; Mon, 01 Jun 2026
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
 <87jyslndo4.fsf@igel.home> <CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
 <875x44o9hj.fsf@igel.home> <CAKC1njSn_rtCj8ii876PNQTk0nsCTfWsb4DzdymufHVthh1Rkg@mail.gmail.com>
 <871peqgp9v.fsf@igel.home>
In-Reply-To: <871peqgp9v.fsf@igel.home>
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 1 Jun 2026 10:57:41 -0700
X-Gm-Features: AVHnY4J9AUNhuz056EYoPs-ULzO8_fe_9tgwbVh_N3bHNsdR65FJv6ifxqCKuXk
Message-ID: <CAKC1njR+dTdvp+BmLGPtgd8dufiUwBtkQ9a-qinELT_Fmi13sQ@mail.gmail.com>
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

On Mon, Jun 1, 2026 at 10:10=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> On Jun 01 2026, Deepak Gupta wrote:
>
> > This was settled when x86 introduced shadow stack. Instead of having
> > new `PROT_`, it was agreed to create a new syscall for mapping shadow
> > stack memory (syscall: `map_shadow_stack`). Scenarios like `clone3` or
> > co-routines required manufacturing a shadow stack, thus necessitating a
> > new mechanism to create shadow stack style memory in demand. Instead
> > of having a new PROT_ flag,  a new syscall was created.
>
> So what prevents riscv from making use of VM_SHADOW_STACK similar as
> x86, without the user visible effects?

riscv uses `VM_SHADOW_STACK`. It's just very simple to use `protection_map`
with just `VM_WRITE`. On RISC-V, `-W-` is a shadow stack mapping. It's not =
same
on x86 or arm64. So `protection_map[VM_WRITE]` simply picks shadow stack
encoding. We just ensure that PROT_WRITE is converted to
"VM_READ | VM_WRITE" at vma level.

see commit message

"""
Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.
"""

As I said other arches have a VMA flag for shadow stack range but PTE encod=
ings
and overlays are complicated.

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
