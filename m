Received: from mail.barrensea.org (mail.barrensea.org [198.12.121.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442826158C;
	Sat, 16 May 2026 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.12.121.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919688; cv=none; b=s232uu07j17l+mZTWd170Pk15d+XGggR0VMD1X4pRJLTejbPezEP7+m5KoqdDAihPcn+WKFaTsNkBmD8/rrTWYGsEEue4ErxycC2SWTgrOmvBwHmpmqtEl4Q1RXgLxk/L9JPwlkDOBiLkURkdkMFonZeDA2aKVdmiE59V+NUf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919688; c=relaxed/simple;
	bh=Rmtf6hPPoGvhi56QdmF/yb1DHICI0bqtdBsa/ATa9EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEHZnndmhIPr2VE/ml56KWSY4pLhq4Y+PnilTjuXiOj4hrxFExaRwQULUCUP13tdynwHvsCvYxcLH9gBfJBLVYWQU5OgqQoGamVlVPSNASyrxowmrTOOMSNecc9mZqhj51AaR7OY02gBFF3bCQmtquw3QsExcZTalW5YkTtHsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org; spf=pass smtp.mailfrom=barrensea.org; dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b=KX4zCbQ+; arc=none smtp.client-ip=198.12.121.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barrensea.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b="KX4zCbQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=barrensea.org;
	s=mail; t=1778919685;
	bh=Rmtf6hPPoGvhi56QdmF/yb1DHICI0bqtdBsa/ATa9EM=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=KX4zCbQ+dV2NzahM97WFQUXhUUhGStuweCm4qHNTKq6VYmgplZ85DURew/FNUaxXK
	 hLnWQlQHqg8nh6K5+Kl5F0Z2a8J7I46/kVoC7rcJvUzGAlNZ7bGeq45Mf2FneSdxKL
	 iZVCz4+9hDz8hVz4kWhUXucckdwlTXEc3tsAP2uab+jouml84GsSn10sHqigKprAFY
	 5cxO7YDZ4egFQt9JBNf3fbc9nRyhcmklm66NuHPxpmsxj+FtrJTx3/lfbkGWHDueSF
	 6FY5pDQal/lE4XLL5Rdhqokm/u6LZFLgFpKVcbe02Xp7FCwuYykYDCHbEv7CF9zzPY
	 0HVbgs4rksIHg==
Message-ID: <faafb47e-9502-4d4b-b14e-b8a5668af355@barrensea.org>
Date: Sat, 16 May 2026 16:21:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] rust: seq_file: route seq_print! directly to seq_write
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, brauner@kernel.org, dakr@kernel.org, gary@garyguo.net,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu, viro@zeniv.linux.org.uk
References: <20260514053724.178321-1-donplat@barrensea.org>
 <20260516040812.477347-1-donplat@barrensea.org>
 <20260516075732.316054-1-work@onurozkan.dev>
Content-Language: en-US
From: donplat <donplat@barrensea.org>
Autocrypt: addr=donplat@barrensea.org; keydata=
 xjMEaARgVhYJKwYBBAHaRw8BAQdAE4YYAvY087RmMqUb2UWln7nkubSOnUSAh/m3CnVcFtfN
 J2Rvbmp1YW5wbGF0aW51bSA8ZG9ucGxhdEBiYXJyZW5zZWEub3JnPsKTBBMWCgA7FiEEHJ7u
 5UyO1agwORyHqfaGMtJZQOYFAmjdDr4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQqfaGMtJZQOYqOAEAqM4JYAwmdfbk3lM/VGuIS8dqMdtcAir6RRTk+ZIW/C0A/RopYHZe
 9buCCs66P+5FxKWFt/MKYNAcvH9qzpEshhcBzjgEaARgVhIKKwYBBAGXVQEFAQEHQG+Zl9aJ
 Dja5XCz6E9h5en0HcEEPhgVatcUlRK1VtF54AwEIB8J+BBgWCgAmFiEEHJ7u5UyO1agwORyH
 qfaGMtJZQOYFAmgEYFYCGwwFCQWjmoAACgkQqfaGMtJZQOYUHgEAs+TFK14LweEBbre1rZsH
 ZNdGD46bduEhzW+flBnNlXUBANunZfeAeBz6OfVgcILJXFtQnT8RPCbGR3xyOW35++oF
In-Reply-To: <20260516075732.316054-1-work@onurozkan.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the reminder.Got it. I'll make sure to send future versions 
as completely separate threads.

在 2026/5/16 15:57, Onur Özkan 写道:
> On Sat, 16 May 2026 12:08:12 +0800
> Yifei Yao <donplat@barrensea.org> wrote:
>
>> Currently, the `seq_print!` macro formats output by passing a Rust
>> `fmt::Arguments` object to the C `seq_printf` function using the `%pA`.
>> This involves crossing the FFI boundary, parsing the
>> format string in C via `vsnprintf`, and triggering a callback back
>> into Rust to perform the actual buffer write.
>>
>> This patch implements `core::fmt::Write` for `&SeqFile` and updates
>> `call_printf` to use it, routing Rust's formatting directly to
>> `bindings::seq_write`. This approach leverages the bounded string
>> slices naturally produced by the Rust formatting machinery and copies
>> them directly into the `seq_file` buffer.
>>
>> By mapping to `seq_write`, we bypass the C string parsing state machine
>> and the `%pA` FFI callback, streamlining the execution path. Since
>> `seq_write` uses a bounded `memcpy` relying on the explicitly passed
>> length, it perfectly matches Rust's `&str` semantics and operates
>> safely without requiring null-termination.
>>
>> Note that `fmt::Write` chunks the output into multiple `seq_write` calls.
>> If an overflow occurs during a partial write, `seq_write` sets the
>> overflow flag. The `seq_file` subsystem inherently handles this by
>> discarding the current record and retrying with a larger buffer.
>> Therefore, this optimization introduces no observable semantic change
>> to user-space.
>>
>> Signed-off-by: Yifei Yao <donplat@barrensea.org>
>> ---
>>
>> Changes in v2:
>> - Add `#[inline]` annotation to the `write_str` trait method.
>> - Fix author name and signed-off name to use real name per the kernel's
>>    DCO policy.
>> - Correctly check the return value of `seq_write` and propagates errors on overflow.
>>
>>   rust/kernel/seq_file.rs | 32 ++++++++++++++++++++++++--------
>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
>> index 518265558d6..d7dbdadde60 100644
>> --- a/rust/kernel/seq_file.rs
>> +++ b/rust/kernel/seq_file.rs
>> @@ -4,7 +4,7 @@
>>   //!
>>   //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
>>   
>> -use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
>> +use crate::{bindings, ffi::c_void, fmt, types::NotThreadSafe, types::Opaque};
>>   
>>   /// A utility for generating the contents of a seq file.
>>   #[repr(transparent)]
>> @@ -32,13 +32,29 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
>>       /// Used by the [`seq_print`] macro.
>>       #[inline]
>>       pub fn call_printf(&self, args: fmt::Arguments<'_>) {
>> -        // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
>> -        unsafe {
>> -            bindings::seq_printf(
>> -                self.inner.get(),
>> -                c"%pA".as_char_ptr(),
>> -                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
>> -            );
>> +        let mut this = self;
>> +        let _ = fmt::Write::write_fmt(&mut this, args);
>> +    }
>> +}
>> +
>> +impl fmt::Write for &SeqFile {
>> +    #[inline]
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        // SAFETY: `self` is a valid reference, ensuring `self.inner.get()` is a valid pointer
>> +        // to `struct seq_file`. `s` is a valid string slice, guaranteeing `s.as_ptr()` is
>> +        // readable for `s.len()` bytes. `seq_write` handles bounds checking and does not
>> +        // require a null-terminated string.
>> +        //
>> +        // CAST: `s.as_ptr()` (a `*const u8`) is cast to `*const c_void` because `seq_write`
>> +        // only reads the buffer via `memcpy` and does not care about the underlying type.
>> +
>> +        let res =
>> +            unsafe { bindings::seq_write(self.inner.get(), s.as_ptr().cast::<c_void>(), s.len()) };
>> +
>> +        if res < 0 {
>> +            Err(fmt::Error)
>> +        } else {
>> +            Ok(())
>>           }
>>       }
>>   }
>> -- 
>> 2.53.0
>>
> FYI new versions are usually sent separately.
>
> Onur
