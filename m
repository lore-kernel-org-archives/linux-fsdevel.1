Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB893A1E8C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550029; cv=none; b=Vb+ptFFbFO4Rz3qwBjiRV1ILHwVkcSTBXvtHVVGyD7NmXo/x6E4h7ZMNgp23R2ShVi3cNRRyddQ1Smw72rip5yPI3rsppW3XP2ab+62EfGy2qCwpHfsGADLyGcZ10PMrSEgmqxJqg7YI51A/JT7kbZaGj8qDoAmFYa4d3gnL3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550029; c=relaxed/simple;
	bh=rVbvd4bv7mDAAqh0GdDl+u0SYdnMSCMpcIgxmE4O7ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKUb0kgCCgoW12dfi30Ff5M/oZUKRsafdTiVR30sKCzWOd4L/z9BowZ5oAO575KFfAnUIrH5hNZCSRFKOzi6WOZ0dp/MiBZf52tJ1BWomYDZhR/qISlGLy/BW3OJNm+xkJsFybJxXBY9SRZq+ipNqlYkcIYEAoaLAB85BQODMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ftq1qbgZ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ftq1qbgZ"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43b96365ea8so6048274f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775550026; x=1776154826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kx+2Tv9JDtmSU+rSqyJqfSQqG/oOHQtiFW0gIqT8o0=;
        b=Ftq1qbgZBt89KoqsaWsqKsAx9TL3g090+GKLGgIS77wJKplVFvXJC/5DTvk1iLoe27
         HU6OqZAXHl1sAvvilIvh4jXzzrM2COcMaDz6lPaPLuuP46nib8eqmokgpYKJuvAiAUWg
         LqRJwc54vgjTPJvUnBlqMsTydIxX07M6DAUfUi8T40l5VBDFLwzMQOrUdqrfJSXuuKVn
         zNBmWyf5qXcwDtsxu/2zc/JwM2VYLOXhAHOobrv7+jT/4MFFGDb6Uf7/abwvzVTvRhEe
         cLWPOoPaAlWupDjLIkHxEj16QCzrI/O/89Nqmxr9HfB6ZMNtm8ReWo9Kuu9tJx+5d95g
         cUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550026; x=1776154826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kx+2Tv9JDtmSU+rSqyJqfSQqG/oOHQtiFW0gIqT8o0=;
        b=WZPxVHem5Ut61918Ietanz0C9V2ct8j4fE0OPIqjmU4c6rS/hD0C/66QZIHGtU9Nzy
         yCc6VCkGwV7gPP+NzzFSMW/QzXhTdb5qGM0xw/UfaIYuMQ1GcajxSemXgtL+39CkW/Wi
         jNWPW/HgTYqVDMPE8r6k6ivrQD2AG45hFpUsn7fhG4IrAalxf1AzXv9V5i3JCbbMks7H
         T10QnZ8O2BaaWRKdpuncCg7uZgfakFSzegS0U1/uIuBMfgtnpY3giyesU8rIykAZdy5c
         yT6Ueg9lYeepZZWScnhRD9bWsKvA/HzX8PmpPLtaSxAlrbVb9W0CzbkcOkW3PG0XuFW3
         WNeA==
X-Forwarded-Encrypted: i=1; AJvYcCV7vjrOe3BFOjA2b6dv6HzmHhH8A5+cMWxIyhbVuPGrP5ojja5ZiOyAHtijY3iBU+OVdEySVxNALTFQSYpH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1bPHR+6+t5npbk/tp2w8MH9Z2iRPXTR2BnNbqhsje+ev0pDZ
	ZdZtN2krmOHJeyT+HuxLejR6XalRuiwFf+cJ05Uq6k/gKsHlzSAuh1lFleedKrm9m84T/0s8STA
	e/F7tL8pBoerI67kAtA==
X-Received: from wrbdx3.prod.google.com ([2002:a05:6000:e03:b0:43c:f2cc:5fbc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1789:b0:43c:f8ce:269 with SMTP id ffacd0b85a97d-43d2927659bmr23247121f8f.2.1775550025888;
 Tue, 07 Apr 2026 01:20:25 -0700 (PDT)
Date: Tue, 7 Apr 2026 08:20:25 +0000
In-Reply-To: <20260403233900.24640-1-t1bur0n.kernel.org@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403233900.24640-1-t1bur0n.kernel.org@protonmail.ch>
Message-ID: <adS-SU4DzxC0ewnS@google.com>
Subject: Re: [PATCH] rust: seq_file: add puts, putc, write, and hex_dump methods
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Cc: ojeda@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lossin@kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Apr 03, 2026 at 11:39:32PM +0000, Christian Benton wrote:
> The SeqFile abstraction currently only exposes seq_printf via the
> seq_print! macro. This leaves several commonly used seq_file operations
> unavailable to Rust kernel code.
> 
> Add the following methods to SeqFile:
> 
> - puts(): writes a C string using __seq_puts()
> - putc(): writes a single byte using seq_putc()
> - write(): writes raw bytes using seq_write()
> - hex_dump(): dumps binary data as formatted hex using seq_hex_dump()
> 
> Also add HexDumpPrefix, a Rust enum wrapping the DUMP_PREFIX_NONE,
> DUMP_PREFIX_ADDRESS, and DUMP_PREFIX_OFFSET constants, replacing the
> raw integer interface with a type-safe alternative that makes invalid
> prefix values unrepresentable.
> 
> Signed-off-by: Christian Benton <t1bur0n.kernel.org@protonmail.ch>

What is the use-case that motivated this patch?

It's possible that Rust Binder has some use-cases that can be converted
to puts(), but I don't think it has use-cases for the other methods.

Alice
