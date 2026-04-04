Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB4288AD
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333720; cv=pass; b=iekxNB5rZ1jdw20cJTxx3Tb59vAVAv68X15l8ddSVyCQ58V3aWNu0tGsFFZz8j/Rehy1wMldsnPSfJb0QyHFOYoyWztKK0uv/AFl0A4Dr1alvZLS5k4NeHi8zqEHXEQcFx4Px4KoqQARmFKqb/1JpQezFQFUqLXfYLf9bHsSw5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333720; c=relaxed/simple;
	bh=3c+AHtrviyyOh7LI+MO6oCv19TXG9AFAqv5+gtj+Ltc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA8eSytg7siQMcEdwuhqFJhuigyIdQxXlraMEOuS/bqkd6U/tler5fqfJRjI5Gdr2b4f/St6nr+Yo+J6YcwYTRvGaFv3jGGsGYFpA8nL+tv2xEHsKX1jNrW6NQdkZWH2YjqHKg6atDT9EgPrPt/m3+LrItJbJcVqcl//GlwqyrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4CIzEoX; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4CIzEoX"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c7e5f38a69so153303eec.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2026 13:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775333718; cv=none;
        d=google.com; s=arc-20240605;
        b=BQdSjVedL7nnsh8qBf819p3ZBoG3VQhqP9wE823TQ+97OSYt5IubcaYj2JAM/W+uly
         r3e7eBLR5mCW5Nzyf+QMGEjea7NdfTgpAlX5K9RxLJz9PWHLWY84dp4zIOvu3xuJar6c
         MuPWd+0Mp9xgecnY/+hM7VvnITd9JRjhXHdtSXVMelrPfuOYJ4RMDsGHapqx4pQyPMPw
         fvB4qfnzkD0SM9KLLYoajVHM3TQC+43TOfJ7yWHUbVFAgrtW015hw8/x/Hqs35ObdeDz
         uS6Pmbp0q6vSoPo1Ck0/ZHY1sq023ReFvhc8pr9CiNFQ0j4K2GEb31gUQ4xP/m/FEw71
         /ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3c+AHtrviyyOh7LI+MO6oCv19TXG9AFAqv5+gtj+Ltc=;
        fh=7y8qK5MPx+BupCCA8GL3GoKbB6QjUDt9/reH5WFmmoU=;
        b=TDmMODlEVSQj6RWP37OcCmrborUHeigowTiWx4RjmpkLkBLDoUyXWY3bdzuVQlftnU
         LPrWLl1QEhMvjJCfj4Ggoie6DZc0n7DgbjCh1JovZ5QKshj9URnDlBdg94HO//wkIFWb
         WroYbk0YBFzNvOmgzVftwJBNMshVKMHiv6HPHDCeLrrHqW/3CHaKCEhRdmFTePPhZn+b
         rsXiMvIIG8BpiIpuc4uAz55SR59C6bHiUGjkgY9uXYXW7qjVT9HvS84tvB/xQ+73Yq4Z
         ++8X0BV5yfSmb2ZrMZvNo8cyrPRjaEuBIT5HXO7Bie9uBOEnLSPLMDKSf3MPzCKovOEe
         zCqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775333718; x=1775938518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c+AHtrviyyOh7LI+MO6oCv19TXG9AFAqv5+gtj+Ltc=;
        b=E4CIzEoXn1QP5zv8A5GmOGpUOXrsR8BeygTzWDhF1lK8BvHCRB9EJbDeH28OLdoAv2
         MQgphLXG1oFELd0NX/WN+fOd37mi/kWTv5qlcYk2hO2zQN62dqsYEuvoReFWqVOLoBjW
         pSzw8SHdcDcstoTtgeK4tcnRn1+8MmOv0lNJnWw0p2Tu/yBo0MdI3yaVOUIBQbZkSf4k
         p5joyAP1vJb/xdPGkLq43zihSLH1s8bX2x4tPZLa2Thuo+f2PLCx1zv6JbOaZsEFLjia
         GlaZ6gmrnlKYnibgJK5JYST5aOffgvRNtsEdfZv4pMDCSYaWF28ibkjwlQ3WXjC3WSj7
         Vi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775333718; x=1775938518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3c+AHtrviyyOh7LI+MO6oCv19TXG9AFAqv5+gtj+Ltc=;
        b=aZJyEV58ZI13bnbgG5eyO21gP7QNsVWw6sitgC8ZgEke9HQuAiFKPEpbxHwb8+yb9X
         oiE2WyG+uB14jZH5j/Zy5bdLdoCih7qxy3xzepcXFI32hj2TcODwAN2H1vfxyyvWqTHO
         BFEqMWY6EkXmHb3aqvrdac/jmRLa80hxyC4yJdrnKY596duM0O0DgYYrGweBJo9/IJ9N
         mStmpeS5mSOyFhHB1jkmq6uuEyFxEWaypmE9glthQ5r+MCYKdfQLUnbLtrHU73BVF9Ge
         VgkN1GQbNV//trKfH2BnZQ4yxLhSYwFQj5NWaLdefOwCrz+fAsGjo0CyWF6snzk53eYX
         TSyA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPsJmkQjJb1l0UAKip1UH6JLh68cF02QkHvAZ4ZvokcW4lfUUzi/4FpPXaA7QaJXWcHJADwQJ1LzWjZ0w@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDcxr8guHqWZwTxn1+Jq8a0opH6WuoxTdT9mzGwhySVEicdib
	hz0fJETNFttS4cb9vSncgzmK8ZHUaz9r4d7Q60Lynsx/zYTRLlGvhyDh5xlGro7OfxQzKrPsYxh
	9K6h0K6O7FXWnTR6ce8S7Cqm5zbZ5L0A=
X-Gm-Gg: AeBDietnBMOkohxeb7d2XwXByNVB2ANa4Y6Uro3kMXwT4D3nOMkYgmV8ULACYKNnTbM
	DifIaWMHQ8Yq0dXNpaqevIhMjbHNNjKRDdVZ9aCG0tTN+X/Doq2IKew7xnh14cmB+fT9IZf4Qtf
	m7LjRIBSCYKHIW7fOm5VKkfHF5EQ7St/pbLe3tQEdOXYlJQRKBC0qTaVed/wR2Ve8SbLDtMO9/i
	AiuCzMBPpfxuWvihfIwIPdR1kvFDsnLDUvACPo4qnxHQ3aWkopyRWe6lHUuWvoae4F+0S2nbcpl
	ozh0Gbz1es+4b2e/xSlkf+2WXclTxwhyEqvHYYKI+FG1hOQroyXmrTu8oi/wlHFBcQVkJlM3C7A
	3PQBPIvOGgLEs2fhC6sECg4PCz21/A7+0/A==
X-Received: by 2002:a05:7301:129a:b0:2c6:2bac:8af with SMTP id
 5a478bee46e88-2cbfc958fbdmr1408909eec.6.1775333717920; Sat, 04 Apr 2026
 13:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403201941.37501-1-t1bur0n.kernel.org@protonmail.ch>
In-Reply-To: <20260403201941.37501-1-t1bur0n.kernel.org@protonmail.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Apr 2026 22:15:04 +0200
X-Gm-Features: AQROBzB7jVGORVSgaQlTQ64ravJhozcCOY2LsF0JF0jhTABPUPOrlHsPSfYtjFw
Message-ID: <CANiq72=SWg8SgW8B65unMJEWyM=m2j_A1JjvQB+KZgMzDURhXg@mail.gmail.com>
Subject: Re: [PATCH] rust: fs: file: add FMODE constants and stream_open for LocalFile
To: Christian Benton <t1bur0n.kernel.org@protonmail.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aliceryhl@google.com, lossin@kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:20=E2=80=AFPM Christian Benton
<t1bur0n.kernel.org@protonmail.ch> wrote:
>
> The C function stream_open() has no Rust equivalent, requiring Rust
> drivers to manipulate f_mode directly through unsafe bindings. This adds
> the necessary FMODE constants to the bindings and implements stream_open(=
)
> natively on LocalFile, giving Rust character device drivers a safe way to
> mark a file as a stream.
>
> Add the FMODE_STREAM, FMODE_LSEEK, FMODE_PREAD, FMODE_PWRITE and
> FMODE_ATOMIC_POS constants to the bindings. These constants were not
> previously accessible to Rust code because bindgen cannot handle the
> __force cast used in their C macro definitions. They are exposed here
> using the RUST_CONST_HELPER pattern already established in
> bindings_helper.h.
>
> stream_open() should be called from the open() handler of a character
> device that produces data as a stream rather than supporting random
> access. It clears the seek-related file mode flags and sets FMODE_STREAM,
> telling the VFS layer not to validate seek positions on read_iter and
> write_iter calls. This mirrors the behavior of stream_open() in
> fs/open.c, which does not use the inode parameter and only manipulates
> f_mode on the file struct.
>
> The method is placed on LocalFile rather than File because stream_open()
> must be called during open(), before the file descriptor is installed
> into the process fd table. LocalFile is !Send, which statically
> guarantees that no other thread can concurrently access f_mode at the
> point this method is called, making the unsafe f_mode manipulation sound.
>
> Signed-off-by: Christian Benton <t1bur0n.kernel.org@protonmail.ch>

Please use `scripts/get_maintainer.pl` to get a list of people to Cc,
i.e. VFS maintainers and reviewers should be included at least, plus
usually the RUST entry. Cc'ing them here for you. :)

I think one thing they may ask is whether you have an expected user of
this new API to land.

Thanks!

Cheers,
Miguel
