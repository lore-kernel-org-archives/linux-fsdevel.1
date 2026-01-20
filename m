Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39938B7BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943545; cv=none; b=rDCUcSYH2WH+bBYewFL+95c+8FU7Wa5/9Cg+gCHIM3jqMlBgRD07E7qsYCDeM2ZCrwlck1OpYTg3dFbnwd5omJ90nBMR9JX+7QdbsjjxZKEuAmXHOjZWvWDalIimnXU+KOIsi/GLHMWU+5sIGUahYLuhX5n4PzGmHKplRUhfAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943545; c=relaxed/simple;
	bh=9Hb4itBmM7QG0OG7QAJ/drk7AcH8Pv9JQONdYrhw0rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPC1xNFo6TLhxQLJT7auWhbMcMM5hQwea9kb6+VmhaHXE6BWQw6aQP+CRylEbu3mVCBq916PwDAu3pERUFP3SqxBKJA8XwAE4Y4LwccFe0l4evcBUyBAEUqxUQgslbpA7MO+ba+ts7HO7CBAOoo/k7/MOFVbEG4GtikToBeN9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmwFunZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmwFunZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D65EC2BC87
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768943545;
	bh=9Hb4itBmM7QG0OG7QAJ/drk7AcH8Pv9JQONdYrhw0rE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FmwFunZnRys9hilFeVUFvEIXR7+MkqmsWKHfJsC5v6YPJ17Mno0okJwAG6oFBXVxW
	 gNt1Gu9YjaicIFcnvntSnENK7FwLJWoka6faHVxVVhvyDBZHzuOIoDfens5LxvHyZp
	 y0tiYXM9kWYh0j+Zt6PhPug6tJpn84Lr33fpVRAjaex2H/rP7JkriuWLDjsAC6yttE
	 Jm4t/KU/29U9o8A+akUeWE8t0uc9lBiTxnqlQqF5XLn9MyeuyDZYDJhsaU3x0Pcp9j
	 GLM/qbuTqDT2WKvDJRh6xsn3U8XQX9cGZZ1QUhAPgsTVSN8F0WxxwJ+1dJVky1BPtX
	 w4NNEQJVNRRDw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3831ad8ae4eso49975741fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:12:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMnZPcYOMGUeD0oTQtLKgKdB45c7FqgnfUmEEOPEQQCXSokEIWx6ktyOIp44GlgTeWMCpcZ1wNJKpIpXSh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5vtEbRJpwJFlIG3Hu5Wp2C7DWlfLIhxhEZmvbKMhJdxRtODO
	9xmR7qG/mkyuU6XfbJY+ov5F1crHRwcJXXqSuuYnZp2reaR5Ak7TBESvvUsxiMp1nbVxGEHWFCU
	Gqx2QS0KZq/zOK5WCoqF9MDeZIb9XoMc=
X-Received: by 2002:a05:651c:1b0a:b0:383:6e1a:2e19 with SMTP id
 38308e7fff4ca-383866b9b3dmr35915161fa.10.1768943543691; Tue, 20 Jan 2026
 13:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net> <20260120145912.281977-1-foster.ryan.r@gmail.com>
 <DFTIA7Y3MZFR.3LEHVWENE4Q4R@garyguo.net>
In-Reply-To: <DFTIA7Y3MZFR.3LEHVWENE4Q4R@garyguo.net>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 20 Jan 2026 16:11:46 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9mOs62Q8zWuH0=bKEQBFQxDopx=O4qUKjh4bWjnv8bWqw@mail.gmail.com>
X-Gm-Features: AZwV_QgKl-PO-9h8l5pa3WZ-1EbUENoaDKQryJ3sZTExF6M_ZN8MqxKAgD0GivY
Message-ID: <CAJ-ks9mOs62Q8zWuH0=bKEQBFQxDopx=O4qUKjh4bWjnv8bWqw@mail.gmail.com>
Subject: Re: [PATCH] rust: replace `kernel::c_str!` with C-Strings in seq_file
 and device
To: Gary Guo <gary@garyguo.net>
Cc: Ryan Foster <foster.ryan.r@gmail.com>, a.hindborg@kernel.org, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
	rafael@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:17=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Jan 20, 2026 at 2:59 PM GMT, Ryan Foster wrote:
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > This patch updates seq_file and device modules to use the native
> > C-string literal syntax (c"...") instead of the kernel::c_str! macro.
> >
> > While at it, convert imports to the kernel vertical import style.
> >
> > Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

device.rs was done in
https://lore.kernel.org/all/20251222-cstr-driver-core-v1-0-1142a177d0fd@gma=
il.com/
and seq_file.rs is waiting for a maintainer's ack in
https://lore.kernel.org/all/20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com/.
