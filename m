Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53A3DE44E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239182; cv=none; b=hDdExeTtbFGE4WmgBN7VKwD9x0Q9dCbrMe4KHkcNT9IRteSx/kvoEnHwaMMx5dEJDMDeX8TMbwzRxymvdipS7w8sY2piYEKOTxejktCCycE3QCgzTuU4NpYPJFz/a2/ER3JZehcKqqkPhd2CNbRZaOiGu9tiVGJNId2OyWB55kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239182; c=relaxed/simple;
	bh=HNLbeuAgbJcHp3Q2f0PgdwdpgSxtX1CaPvnT8Dj/M/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QuI/sGmeqGILt2TlWJ3IKcJbuZJPAAVR8tIjK3tJOW/d9GdDLENNegTmluvTbzfuEfiEaoAi9cr2ZaF9DSHi7tv2x6E8omVY6b+UtO8hovcBvCR75WlkgO07bQ1vvfnex9w5Fv2A8lLBdXFmXPACkAy/EHa6FbUyI90HQN9TSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pveuWniF; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pveuWniF"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e65ecd557so11223975e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790239179; x=1790843979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dsz6uRel52dQEjbVAeMCIiPl3yIqAf1n7uTkjuAAjJI=;
        b=pveuWniFKOhQqdW0PSjLVBPl8ZK6kYxfY7Hnj+MQYsIBJOk07/I5uPANTdy9v307rp
         6ets14OK9UGo2UB+qmkLqGfwAhO8mVJRNXL7XBG85APLUgsQKXGDm6oOTgNQv9vjvfC4
         0yC5RSWbQKcp4zch99+9dowNYyfiLUyGYUBmfW4h0Ns5w+01tLwn1W8MYfFGDtb24IuB
         ZES1eLatGDTkFJX6tkpbXR7BeAObmFJXWMxn1kBxZ3B3Lc6gxt64ewEQxoijeATtozR1
         5mIfaX09WNLXppfhRKSKJpEiEJzE64wiv6YqcchoExKCCpVOeJSurng5uIgxRvFZSeEP
         rs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790239179; x=1790843979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dsz6uRel52dQEjbVAeMCIiPl3yIqAf1n7uTkjuAAjJI=;
        b=1JpGLzWVg3FQVLPGuJEFkiGvjCDRg27sL2mhrablb/5xaTHhJzQ0i9JUx+Hr8ez4FN
         dr5Q+RIOb9mPuWK8czIs5Gu3w0Uy31rNc/YMEk5NfetMTgBgUHfLN3T9niG+Tjka+H4Y
         kSsnV+xWlMcYzQs24YCDoDlauvuL826zB4BkC6H9ItfV6asxs75MK3x8CQV8aOZIKHdy
         rw3TiypJo+B64+sDoMk/PRFTtXUYVZSsJl5ff3zb/MoXNFJxLhwncGaV5vfMvba3g6ZV
         UrjaFP48loku6Jrm5E4cotBkSOnR1+BXDNzmgSPQzqGRmhmxv2y7of+0KmzmAEhM8iBl
         kphQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBUveTvNByOKfnflMuLpiFt20yRYhstVWogoIOC6skCqVnpLhZMSaVfsTrZRakOi0e/1L/QHYrSAgf0OHG@vger.kernel.org
X-Gm-Message-State: AFuF++kth+J5fwWWLjnzxMEJLniSw9koLYTp1RTIHmvy3y7xgD4fStbg
	7WSSgLuelFIRJJZeweqFypFy29VKQkkoTbOwwxDwlQ+TKM97siolzDD8VMpuVbLrrfGOJAV3aLD
	IwvOnaoCTpcVfyOqtLA==
X-Received: from wmpc22.prod.google.com ([2002:a05:600c:4a16:b0:49f:e4ba:89d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e14:b0:49d:1de5:ce0a with SMTP id 5b1f17b1804b1-49fe66b43ffmr27830245e9.13.1790239179196;
 Thu, 24 Sep 2026 01:39:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:39:37 +0000
In-Reply-To: <20260923022339.3340694-1-georgeandrout13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
Message-ID: <arThye_219ruNbM2@google.com>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
From: Alice Ryhl <aliceryhl@google.com>
To: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Sep 22, 2026 at 10:23:39PM -0400, Georgios Androutsopoulos wrote:
> Several Rust file descriptor APIs rely on `current->files` being
> available. However, `exit_files()` clears it while execution may still
> continue on the same task.
> 
> This affects `LocalFile::fget()` and the
> `FileDescriptorReservation` operations that call
> `get_unused_fd_flags()`, `fd_install()`, and `put_unused_fd()`.
> `FileDescriptorReservation` cannot cross task boundaries, but remaining
> on the same task does not guarantee that `current->files` is still
> available when these operations are performed.
> 
> Guard the affected operations against a missing `current->files`.
> `LocalFile::fget()` returns `EBADF` and
> `FileDescriptorReservation::get_unused_fd_flags()` returns `EMFILE`.
> For `fd_install()`, warn and abandon the reservation when the fd table
> is already gone. In the drop path, skip `put_unused_fd()` after the fd
> table has been torn down.
> 
> This prevents NULL dereferences through these safe Rust APIs after
> `exit_files()`.
> 
> Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`")
> Fixes: 5da9857b127e ("rust: file: add `FileDescriptorReservation`")
> Closes: https://github.com/Rust-for-Linux/linux/issues/1256
> Signed-off-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>

This looks like it should ideally be on the C side instead.

Alice
