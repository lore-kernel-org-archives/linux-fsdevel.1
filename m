Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132573AC0F1;
	Thu, 14 May 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742328; cv=none; b=PkCOfdHLURZtdrSJiyljuY01knC0v3HHt+UrdzJlidgQ/a3BxNQ6f5g5HTtVWkXAXkkFbJuxUqdHjFusdqbkEYl3U4pdnujeFBEXVP0NE3eZGwqadvsdeJB41tKJnqpcbQxo0oHrc/88u2zGLyxkVciZ7YYVYs/HFgnJAZFRgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742328; c=relaxed/simple;
	bh=dDYmA3RoObOLbXsdIydGP4VShSzTBmZgn96swZRjuxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDsJbdFziN8d9Q96M+O8y4S00fL5JkHe3FIu/Dv1k9b0Mi/Aqu6JovRyWe7Enec2oSl5gnxMhC2XNppA9/X7x89zWQsse8ICfFh5MHJ5UvJNLfjT7t3Z6IZSXImRbHpfU5/JHNwHrR9caRKfkx4T/1xkj7CKvqs0YVNNUhGZjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vj9iaFju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vj9iaFju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A78C2BCC7;
	Thu, 14 May 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778742327;
	bh=dDYmA3RoObOLbXsdIydGP4VShSzTBmZgn96swZRjuxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vj9iaFju/UQkIiswrnbJmaYBNdIJ00XngbW0xa5W0EEdRNGTTDvof8riDbgl3fwWa
	 RFiZaFomWV3yQsrsqABy8p0aq84mTqk/6t566bC7QpIS+qlY6nhqnHUUiNfjH1biu3
	 UcyqvuoXZ/yOGue2LrKMoGUd51lacTyUVKq278ak=
Date: Thu, 14 May 2026 09:04:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Donjuanplatinum <donplat@barrensea.org>
Cc: ojeda@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, jack@suse.cz,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: seq_file: route seq_print! directly to seq_write
Message-ID: <2026051429-clutter-supreme-e42b@gregkh>
References: <20260514053724.178321-1-donplat@barrensea.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514053724.178321-1-donplat@barrensea.org>

On Thu, May 14, 2026 at 01:37:24PM +0800, Donjuanplatinum wrote:
> Currently, the `seq_print!` macro formats output by passing a Rust
> `fmt::Arguments` object to the C `seq_printf` function using the `%pA`.
> This involves crossing the FFI boundary, parsing the
> format string in C via `vsnprintf`, and triggering a callback back
> into Rust to perform the actual buffer write.
> 
> This patch implements `core::fmt::Write` for `&SeqFile` and updates
> `call_printf` to use it, routing Rust's formatting directly to
> `bindings::seq_write`. This approach leverages the bounded string
> slices naturally produced by the Rust formatting machinery and copies
> them directly into the `seq_file` buffer.
> 
> By mapping to `seq_write`, we bypass the C string parsing state machine
> and the `%pA` FFI callback, streamlining the execution path. Since
> `seq_write` uses a bounded `memcpy` relying on the explicitly passed
> length, it perfectly matches Rust's `&str` semantics and operates
> safely without requiring null-termination.
> 
> Note that `fmt::Write` chunks the output into multiple `seq_write` calls.
> If an overflow occurs during a partial write, `seq_write` sets the
> overflow flag. The `seq_file` subsystem inherently handles this by
> discarding the current record and retrying with a larger buffer.
> Therefore, this optimization introduces no observable semantic change
> to user-space.
> 
> Signed-off-by: Donjuanplatinum <donplat@barrensea.org>
> ---
>  rust/kernel/seq_file.rs | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> index 518265558..16ba1fdd8 100644
> --- a/rust/kernel/seq_file.rs
> +++ b/rust/kernel/seq_file.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
>  
> -use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
> +use crate::{bindings, ffi::c_void, fmt, types::NotThreadSafe, types::Opaque};
>  
>  /// A utility for generating the contents of a seq file.
>  #[repr(transparent)]
> @@ -32,14 +32,26 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
>      /// Used by the [`seq_print`] macro.
>      #[inline]
>      pub fn call_printf(&self, args: fmt::Arguments<'_>) {
> -        // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
> +        let mut this = self;
> +        let _ = fmt::Write::write_fmt(&mut this, args);
> +    }
> +}
> +
> +impl fmt::Write for &SeqFile {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        // SAFETY: `self` is a valid reference, ensuring `self.inner.get()` is a valid pointer
> +        // to `struct seq_file`. `s` is a valid string slice, guaranteeing `s.as_ptr()` is
> +        // readable for `s.len()` bytes. `seq_write` handles bounds checking and does not
> +        // require a null-terminated string.
> +        //
> +        // CAST: `s.as_ptr()` (a `*const u8`) is cast to `*const c_void` because `seq_write`
> +        // only reads the buffer via `memcpy` and does not care about the underlying type.
> +
>          unsafe {
> -            bindings::seq_printf(
> -                self.inner.get(),
> -                c"%pA".as_char_ptr(),
> -                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
> -            );
> +            bindings::seq_write(self.inner.get(), s.as_ptr().cast::<c_void>(), s.len());
>          }
> +
> +        Ok(())
>      }
>  }
>  
> -- 
> 2.53.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
