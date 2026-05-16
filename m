Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD05380FCA;
	Sat, 16 May 2026 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778918269; cv=none; b=JmFz2kS8jJTfAcmeN0qx3G+ngXun51OQcAq3mE+2h3+1bcQrkDts1hmheS1HElox9eNI/P2860XukgXXprlwqwIPNbjK2MBjZ1IzAlh0KKd2DZlz5dhRjBv/xgWo4PUUG3RnZ+fCukVrA/AMY9Q9AzujAAJTZOJWhwkAFn5kWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778918269; c=relaxed/simple;
	bh=iAUjVQSKoUaTTlzRPNfeYZ+6WXBEMjbuvlWpaPcm7LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNn/OT/p39zKZsviU54A8I+SdQopCqmIHU5rLBPdsYjc7nwgrYBNjM5RizHy6iVIGClCAdgr0+WCgSq2AKobmsRZKd9fELgL+kl84zkWjNGDp7NigwVJgFTgNT5SfwiJpWoERm7PyXDcHSrh7zIf3ieewcmTTA+gp3ZTx96ga3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=szV1qYcl; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="szV1qYcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1778918260; x=1779177460;
	bh=Z/lZWv0wWrjNhdje0b/XBQ8qVvF0a3h+Gwef0Tbdup0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=szV1qYclN8411NDY8z7BfeyIT0//JXa6IQs/8WpCsP1YegIzfTDoOHe2lwrIa4u/Y
	 8JfQqeMMRrdGifhga/6a9e2piyWlW/E5iXOg/poQ202WGLxo/N8mcwLQXrx1/ZUNLf
	 J93rRhn0+pQTXuqZbQBVirypdu1iOGBrvDw0p6bvK64fN3mcaNoDrAVBRs6XUTj0Ue
	 lgjgTnY6YjFl4Hujf9hoEMz2fFHjPWv9l6YMkli54iNO4JZzJoWWj1o88UYhwy5XB5
	 UJFkSTwIcVd28WWeOhaM3KuqMHVgQ4EFV6UCego/aHnd2hksVuy3xpxpNb1DcvyziY
	 8/EWgT/teiIUQ==
X-Pm-Submission-Id: 4gHbyR26xwz1DFG9
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Yifei Yao <donplat@barrensea.org>
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	brauner@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] rust: seq_file: route seq_print! directly to seq_write
Date: Sat, 16 May 2026 10:57:26 +0300
Message-ID: <20260516075732.316054-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260516040812.477347-1-donplat@barrensea.org>
References: <20260514053724.178321-1-donplat@barrensea.org> <20260516040812.477347-1-donplat@barrensea.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 May 2026 12:08:12 +0800=0D
Yifei Yao <donplat@barrensea.org> wrote:=0D
=0D
> Currently, the `seq_print!` macro formats output by passing a Rust=0D
> `fmt::Arguments` object to the C `seq_printf` function using the `%pA`.=0D
> This involves crossing the FFI boundary, parsing the=0D
> format string in C via `vsnprintf`, and triggering a callback back=0D
> into Rust to perform the actual buffer write.=0D
> =0D
> This patch implements `core::fmt::Write` for `&SeqFile` and updates=0D
> `call_printf` to use it, routing Rust's formatting directly to=0D
> `bindings::seq_write`. This approach leverages the bounded string=0D
> slices naturally produced by the Rust formatting machinery and copies=0D
> them directly into the `seq_file` buffer.=0D
> =0D
> By mapping to `seq_write`, we bypass the C string parsing state machine=0D
> and the `%pA` FFI callback, streamlining the execution path. Since=0D
> `seq_write` uses a bounded `memcpy` relying on the explicitly passed=0D
> length, it perfectly matches Rust's `&str` semantics and operates=0D
> safely without requiring null-termination.=0D
> =0D
> Note that `fmt::Write` chunks the output into multiple `seq_write` calls.=
=0D
> If an overflow occurs during a partial write, `seq_write` sets the=0D
> overflow flag. The `seq_file` subsystem inherently handles this by=0D
> discarding the current record and retrying with a larger buffer.=0D
> Therefore, this optimization introduces no observable semantic change=0D
> to user-space.=0D
> =0D
> Signed-off-by: Yifei Yao <donplat@barrensea.org>=0D
> ---=0D
> =0D
> Changes in v2:=0D
> - Add `#[inline]` annotation to the `write_str` trait method.=0D
> - Fix author name and signed-off name to use real name per the kernel's=0D
>   DCO policy.=0D
> - Correctly check the return value of `seq_write` and propagates errors o=
n overflow.=0D
> =0D
>  rust/kernel/seq_file.rs | 32 ++++++++++++++++++++++++--------=0D
>  1 file changed, 24 insertions(+), 8 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs=0D
> index 518265558d6..d7dbdadde60 100644=0D
> --- a/rust/kernel/seq_file.rs=0D
> +++ b/rust/kernel/seq_file.rs=0D
> @@ -4,7 +4,7 @@=0D
>  //!=0D
>  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_fil=
e.h)=0D
>  =0D
> -use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, type=
s::Opaque};=0D
> +use crate::{bindings, ffi::c_void, fmt, types::NotThreadSafe, types::Opa=
que};=0D
>  =0D
>  /// A utility for generating the contents of a seq file.=0D
>  #[repr(transparent)]=0D
> @@ -32,13 +32,29 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_fi=
le) -> &'a SeqFile {=0D
>      /// Used by the [`seq_print`] macro.=0D
>      #[inline]=0D
>      pub fn call_printf(&self, args: fmt::Arguments<'_>) {=0D
> -        // SAFETY: Passing a void pointer to `Arguments` is valid for `%=
pA`.=0D
> -        unsafe {=0D
> -            bindings::seq_printf(=0D
> -                self.inner.get(),=0D
> -                c"%pA".as_char_ptr(),=0D
> -                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),=
=0D
> -            );=0D
> +        let mut this =3D self;=0D
> +        let _ =3D fmt::Write::write_fmt(&mut this, args);=0D
> +    }=0D
> +}=0D
> +=0D
> +impl fmt::Write for &SeqFile {=0D
> +    #[inline]=0D
> +    fn write_str(&mut self, s: &str) -> fmt::Result {=0D
> +        // SAFETY: `self` is a valid reference, ensuring `self.inner.get=
()` is a valid pointer=0D
> +        // to `struct seq_file`. `s` is a valid string slice, guaranteei=
ng `s.as_ptr()` is=0D
> +        // readable for `s.len()` bytes. `seq_write` handles bounds chec=
king and does not=0D
> +        // require a null-terminated string.=0D
> +        //=0D
> +        // CAST: `s.as_ptr()` (a `*const u8`) is cast to `*const c_void`=
 because `seq_write`=0D
> +        // only reads the buffer via `memcpy` and does not care about th=
e underlying type.=0D
> +=0D
> +        let res =3D=0D
> +            unsafe { bindings::seq_write(self.inner.get(), s.as_ptr().ca=
st::<c_void>(), s.len()) };=0D
> +=0D
> +        if res < 0 {=0D
> +            Err(fmt::Error)=0D
> +        } else {=0D
> +            Ok(())=0D
>          }=0D
>      }=0D
>  }=0D
> -- =0D
> 2.53.0=0D
> =0D
=0D
FYI new versions are usually sent separately.=0D
=0D
Onur=0D
