Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00B2F7F00;
	Mon, 27 Jul 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145266; cv=none; b=HYzQilJrjKK+GS7wY1tK+xbYkg8I3Y8yOaTWa7CIRfqFC5xex1zS7Z24Cp+bXF/jSgkYq6I99+aXDBjdKPFCXF2QKolnhfsVENJ600F+1qMGO9etGf42i9u+QXFhgODn4bK3pdLz43gZ0GBrUXQl1aNQT1hMQz1icQtu3XHqUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145266; c=relaxed/simple;
	bh=wsRbU9sCZjs0Rrp7qUKiCZTZh+YDJQke24MlJNELvco=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DDZcgjLJPen6Gs9dgS9r7XyuJMDkyF7le7Nd3IVM5J6924dwm/dnW4A8kwFuVYBRJV4LIGVyXxmmsv0CbcxuD16sez3QLzBskes75xzg90SqS6D7baYMLbZSfXfzmaL/MfkY0fS34BHeASRbveJjV8l5RBDQluhTOCHmWd7g830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfUErfJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfUErfJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE061F000E9;
	Mon, 27 Jul 2026 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785145265;
	bh=h1KtGJh/H8DtrXw+EFYt4rytGfK+Dd9+WsYLWovTkiQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EfUErfJVPts0dA2RsHzN2Wnb/PfwHFiR0h01JTrqLFtkXsR7HO0DJ2pDbvD2JD3uq
	 FFoP3+2wX7McvKug79DobXnuGnyeIE5hHRhrrXKtSByg5SIKveMoI8Jg7noCgy/axX
	 lAlSXXmDKJ8vXvzNdAvDy15y4V86WvoN82uP7TjE1+/XW78/siKiVrKiUcjnqoPTt4
	 zddgKHk9dpeL3wUbdnOKGWnylEzHwsy+Z3m8+ImCNzduzMVmA+nxtnivjnCTMYi0Ao
	 Waj8v1jm/nN49jUmbbGjqGtx5YaX+BzggM1LZeuZ3yqz/NHVfqq4XzATQ0N7t0paIR
	 r8mrR77qOWrkQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] audit: free proctitle in context so it can be set
 by fork
From: Christian Brauner <brauner@kernel.org>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, 
 Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
References: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
Date: Mon, 27 Jul 2026 11:41:00 +0200
Message-Id: <20260727-freischaffend-anzapfen-checken-00706290941d@brauner>
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wsRbU9sCZjs0Rrp7qUKiCZTZh+YDJQke24MlJNELvco=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlq68vuBwr4vxCdoNupZGdV0H9pfonZx/1zT0z7QRPj
 UszU+vEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkdzH8D2qbb1tZdyT51bLc
 /ztF5Rx//ZOY4Op3R2hXT6O4YsfaDkaGqRIbN03MlPl2a4OrU9WGwoKK/wZVTr1h1c9+f4t4FHi
 eFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Original title: fixes clean proctitle in audit context on exec call
> 
> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
> 
> Suggested by Roman Dolgikh https://github.com/rmd4ctf 2025-06-11
> Link: https://github.com/linux-audit/audit-kernel/issues/170.
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Acked-by: Christian Brauner <brauner@kernel.org>

-- 

