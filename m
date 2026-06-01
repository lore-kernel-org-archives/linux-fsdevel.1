Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEF308F3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330952; cv=pass; b=dVx+vonkMW3y1eOJjkASo0Q6g+Au+enOIo3feV5QmfE1n4sHUA4zqBDZRJSKBKXUlRPNTDxoUFDwmvd+BAwtOqStt4afNQeXZBCAmpvWlxWmajSwTuzA1A8He0gYGGFHaMZsIYCljjE6BiDw8+zDyNBBFR15qZ9Sb/G/X6ig6AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330952; c=relaxed/simple;
	bh=1CJ/NuXAzZ5JX1S4E7zNfocykkD792/QQHjbajG/YH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj3NOH4hBVPQSk24vIkCXZW8izY+Pw8jbsI8czC3VsO+8dg0RYNzAO8hIy6opwehL1MhYWyM4+rp/lPWNkp4r5gr5v1iCB2FcQqRG30SP23R0EoaEAPCo2lv3LJPvGRFUfHWzNdu1aUuBlwUcDMmUgNcJA+Y2kBiWdJRjzCJVmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=ZZc4dK9u; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="ZZc4dK9u"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660390a8999so4845314d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780330950; cv=none;
        d=google.com; s=arc-20240605;
        b=DqjCDIzBHY88qwCJQYj1HUHjwqWjPf6k0gFYGJypfRk7qNqNkPNslhmPVVZdWN9ZDH
         FlY9HFeYnGtK11nqXhZl6DzRT0iQ4ZNFaJ5c1lgyy2xcVA9u4NZFilUJCzIRA2IxYcSR
         +3fITddyj5VROle0hxs85c1ntiC+oDlrpMX+EfjMCTsL0lkAsyQ9+Z961UgZVByqTFaa
         e89oEJW/tT++6uqVTuDGS/u4fJ10rwLkhGdKuJqFN8UwXioWfcj4Lix9LeD8o7qUaAgm
         kKVRdvJ3vHVIHWs7v4Thk6omAvz9hziMnfgIaYejsuYLAw9ixmbTc0UQ8XOfk4A+XALP
         0/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1Wsv67Vk9GRUFlRdxu2VA3iBYDzYBLeu5jipj2Jvzw=;
        fh=VOCqshOgpbHmSEb48wSSMBE3WP2hLY0emEXbcBlGmfU=;
        b=VNIefaWNLwDs1GGXeGXVWfBn73SunetquUTnNEQ0jz3bnZO6OBq+Y0D0kuWuiyici+
         Y6xXHqKKJ5x53id1XJ3xIAwgDzw4+lbL6n2HRJdfU+tMGbDhsui/MEnVeOgerOt0bx1V
         japBb5j8Twjm+ZvzlwATtvHSlg7YuFCJvzGj8Lhf7o3diOy7fU3hWme+gbanrQi8Ubgm
         DVJEnsCuvrH5SF4EEld7yxlh4KG/85ZrGU+zRse94yzcFHNmqO3g312s3Idg69bH4iPQ
         9c9zVt302njoZ/8wyfCFivFR7Rb+wsqVOWA9CFnHZ6RJnQ/HaEp/NZu27f29XYYZaTMh
         KYDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1780330950; x=1780935750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1Wsv67Vk9GRUFlRdxu2VA3iBYDzYBLeu5jipj2Jvzw=;
        b=ZZc4dK9u05zgurvFAOaOLR3nhhDSbBr+S0195BgZYoqbIqIlom8Nx2pPajSShMRWJy
         QdzjY6nQLIXKwZhJCSe2tmhnJVCpn+3Bb8vRAIJg8hyLQmfNUg4PJ2b8qs0YkgOLtVXv
         eZPL5bYGUUFcAPc5espEdg9PPKDaHdiA3e4gjDOvfEhEPLClW9TfGMYlFawOpYL2YzFm
         30xDKK9jFOBAOdSGq/49sOl4GLJKaKqlcBIeFqYIuI4ha0ZfZ8fKfbxzOsV36f8seF/y
         jdyArgOGWI0KueUMJu1rnZunngQBfCNjtYM31rfBwdEHd8GppRPbWi+ugrf8E2MGt9rv
         fA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330950; x=1780935750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1Wsv67Vk9GRUFlRdxu2VA3iBYDzYBLeu5jipj2Jvzw=;
        b=i1JYJhPuGqlivhXKgead9FTEAH4ra0QtoWl6dsZW6kPFX8Y0tFXs8INCybGSS4txGC
         u318S6oidtJCms2O1vyd7AQeT9gt9BC9b8Z5dFZZwXA5dLS2a9Wht6HhGD9TPCPh6I5E
         eeBc9yBtgrQJs96DkZysLRYCLkNv692L/wTR7LG/tkZ7kHdTO3A6iePpeQl8PR+/KwyW
         lMEOzUX8WOJdzVjN/JN69RUJW3JZoGjSfE7mVYb/VoyfS03hT19NYqh9L/SAjnZcXDJP
         CouImpNr3ZYU5liCJBkV5yH11ND3l1Jn21oSKnySLskrx1qIAP1EEbcpzQMpXXP72aAm
         rORw==
X-Forwarded-Encrypted: i=1; AFNElJ8l6WJh60d1W09gbLTDFFBVmMvoSxSv6Ei2w4czpCgW6M/PrIhnK28A6lBky9X686/r/5eIsLKLKkyv9br+@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnWd5IfAujwGo5Gpif7gADGkzrSaxzm7nHSHD5+kpBqfleah8
	v9rVLHVoI5wbnIxvv1CR7kyLjtF+sj77nDSlyWYFyKb7lvj/EXFGru6aMkPLqx8CxOHgHJs04/i
	0IpowXTUHcfcMF7CnbpceF4OO2eBQbtyTf4EvgH8GHQ==
X-Gm-Gg: Acq92OEa+7d4Nl76jZyLAbdu9YWejT37oE4TpzXGAk16fNu0FAPbkD3vif7q6pd2XlS
	rxd8ZFm2BD7E1Ngyb276xjp3KRTOI+8bGr4rsJ6mUoxhPFhBzAN1OSZsDTCNI+vEVlhevF77N9t
	WyVlWyu3W8sDbAonKv+V8hMKYdoOpEAzSRPzfC4eMwopQeoMrC7zPWU8cydo9yq9m/to/5BlSUs
	4eFoX5TuMxmLEx+W0ahjfwyymwWDPUQU2n/1D/CMxNGyni80I0aUOjlH0wU1+kV55WAILcZCvji
	sgPmzrSMDGSCfHHIO8ahbGQCnmgXGIUrJ/fslQQFB8/W+BAHYDg=
X-Received: by 2002:a05:690e:138b:b0:660:7b47:24cc with SMTP id
 956f58d0204a3-6607b474ddamr5466859d50.1.1780330949770; Mon, 01 Jun 2026
 09:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
 <87jyslndo4.fsf@igel.home> <CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
 <875x44o9hj.fsf@igel.home>
In-Reply-To: <875x44o9hj.fsf@igel.home>
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 1 Jun 2026 09:22:17 -0700
X-Gm-Features: AVHnY4J6Ejb9kcuTR-Xh2mJuobUXOxxIDSAgxNY81YZ-jI0UDO1cEHEz8fOc8KU
Message-ID: <CAKC1njSn_rtCj8ii876PNQTk0nsCTfWsb4DzdymufHVthh1Rkg@mail.gmail.com>
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

On Sat, May 30, 2026 at 2:47=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> On Mai 30 2026, Deepak Gupta wrote:
>
> > I see two ways forward:
> >
> > - It can be done in generic way where incoming PROT_WRITE means
> >   PROT_READ | PROT_WRITE irrespective of RISC-V. Although others
> >   (x86, arm, etc) would have to weigh in.
> >
> > OR
> >
> > - mmap04 LTP test can be updated to expect either of "rw-p" or "-w-p"
> >   whenever only PROT_WRITE was specified.
>
> OR
>
> - Add a new PROT_ flag.

This was settled when x86 introduced shadow stack. Instead of having
new `PROT_`, it was agreed to create a new syscall for mapping shadow
stack memory (syscall: `map_shadow_stack`). Scenarios like `clone3` or
co-routines required manufacturing a shadow stack, thus necessitating a
new mechanism to create shadow stack style memory in demand. Instead
of having a new PROT_ flag,  a new syscall was created.

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
