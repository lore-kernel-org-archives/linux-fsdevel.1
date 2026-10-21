Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579378;
	b=bkUXehA7T3b1+raezUT7+mFm0Bjy4mgaMyrKvEr/ohNZ3WACu64v+6TCjpFsGb2AxgYm
	 LZFjZMUILYlWQpc+eZINRWDvPjlzcHc9/9aucetVsW8MLIAI5frVhgPYMg88PTcf2WJgZ
	 XPY2m9JN1VNXuUHyGVQe1DGOgJXkuYJLB0Rl8mHuIXMjHi57qJFZ0VQexowkJkuNc+KxU
	 46RurqafZ74vVhdpNMJ86jqlHmOj91pF/WDG/zZniDxBgphrpG8ENMX6hISn87FVDiemd
	 37HFpHuNGe2/dfJAPFmFrPvXgcA539uDyF+00IfyiuY2Mj9sjLcZUnFOHbilIettH8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579378;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=t90tvZS6oZQr0j8LPs+bmUY4QvpEatggf68p5mbwtZ8=;
	b=3GfDjo6kkFBDZjNECPkB+1JTpySEXdBajlccOPiVYji5NSXEIWMTy1mkoVx6x5BK1pNH
	 WMb4/vVpBECgpwjuBnUSsG1Hgx7wK9x9uWVRRfX6Na8/Z2dfO+5hEho1QuTusYuyZKJrp
	 Paf8cLrANQ7wwsmZQxMlJvaHkvky0JVKWlgDc4Zax3KUYZcA3l0cnNzmaFUtpvzIY9Qwb
	 KzdPa3APxs1m3Uov+BA1LbAyHbj6Usq797emjqloHNEyYWDhyeCuW7PHDfIRnp0WaJv84
	 vZoXnf8cEuh96vlre+g5QbPp82ucpQdIxGC+oMzadiGAPsDDJJZr4dzwuDu+eucf2dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsB1qgjp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D5606A322;
	Wed, 21 Oct 2026 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsB1qgjp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842F41F000C9;
	Wed, 21 Oct 2026 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579378;
	bh=t90tvZS6oZQr0j8LPs+bmUY4QvpEatggf68p5mbwtZ8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dsB1qgjpAnBJ2mwnX25B8XCsTjcViWTFyHTFd7hup+WM3+qNNpPq1BwW+MfkW2NcY
	 p/Hkc4u6LeNdbJudbAQczNqkA8JIqDCIqrWPm624L9Wk47A94nph6qSByL+DKfu4HI
	 U7kehuOF0Mmdx7K3hCQFFWlvukGZIwXKZSL/IamhVOmqW4L1YR7/v2VebS296RWIUe
	 83+MfF7pLtfVjL1nDdMKPwWlzzQ/l327Iz20SogXjgDAQth0twB7INmV+LRItF4N7G
	 utHNp5FTlFWPQtuA2F86RuSzddMuHiAFNXG01gS2IdqMNR/cMQ8rMIfrw/PyTRK5Td
	 HYJ2APtRDYzfg==
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] pidfs: do not report fields that do not fit into
 the caller's struct
From: Christian Brauner <brauner@kernel.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261017020634.792390-1-nickolai@csail.mit.edu>
References: <20261017020634.792390-1-nickolai@csail.mit.edu>
Date: Wed, 21 Oct 2026 12:42:51 +0200
Message-Id: <20261021-trauen-wirft-hegen-847ed3b60f61@brauner>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pTFgFr7+/hXlFUZ+wq+itkgyJLMrzj6irJNX8yUZYyI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmK6bNL12jeIUriqpeUujV05YuumCd77jzkkn799aO
 VtJ7FSYWkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE7iUwMjzx9boXu5Q39Q7H
 u8z/mzc8WL5QkOVVx/37vl2HO6Q0PvYxMty5rbuxkkul9KoVd4Z9yozaCULrrlSd7vr1yt17V+b
 Kdg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> The documentation of struct pidfd_info promises that "If the structure
> size is too small to contain a field (requested or not), to avoid
> confusion the mask will not contain a bit for that field", and asks
> userspace to trust the returned mask when deciding which fields hold
> valid data.
> 
> pidfd_info() does not keep that promise. It builds kinfo.mask without
> looking at the size encoded in the ioctl command, and
> copy_struct_to_user() then truncates the copy to that size. A caller
> that passes a 64-byte struct (PIDFD_INFO_SIZE_VER0) and requests
> PIDFD_INFO_COREDUMP or PIDFD_INFO_SUPPORTED_MASK gets a mask with
> PIDFD_INFO_COREDUMP, PIDFD_INFO_COREDUMP_SIGNAL, PIDFD_INFO_COREDUMP_CODE
> and PIDFD_INFO_SUPPORTED_MASK set, while the coredump_* and
> supported_mask fields behind the 64 bytes were never written. Trusting
> the mask as documented, userspace then reads whatever its own buffer
> held at those offsets. The same happens for a 72- or 80-byte struct
> and the fields added after it.
> 
> Clear the bits of the fields that lie beyond the caller's size before
> the copy, in the one place that knows both the final mask and the size.
> A request for a field that cannot be returned is thereby answered the
> way the header describes: the field is simply absent from the mask.
> 
> The added selftest issues PIDFD_GET_INFO with the first published size
> over a full-size, poisoned struct and checks that the mask names none
> of the fields beyond that size and that the poison is intact. It fails
> on an unpatched kernel and passes with this change.
> 
> Found by formal verification of fs/pidfs.c against the kernel binary.
> 
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Notes:
>     The three size thresholds follow the field layout: coredump_mask and
>     coredump_signal end at PIDFD_INFO_SIZE_VER1 (72), coredump_code at
>     PIDFD_INFO_SIZE_VER2 (80), supported_mask at PIDFD_INFO_SIZE_VER3 (88).
>     Masking the request bits early instead (before the coredump and
>     supported_mask blocks run) would save a little work for such callers
>     but leaves the bits set in the task->mm fallback path; clearing the
>     result once before copy_struct_to_user() covers every way a bit can be
>     set. No stable tag: the only callers affected pass a struct size
>     smaller than the fields they request, and the consequence is a wrong
>     mask bit, not a crash or corruption.
> 
>  fs/pidfs.c                                    |  8 ++++
>  tools/testing/selftests/pidfd/pidfd.h         | 16 +++++++
>  .../testing/selftests/pidfd/pidfd_info_test.c | 48 +++++++++++++++++++

Semantic changes and selftest changes in separate patches, please.

-- 

