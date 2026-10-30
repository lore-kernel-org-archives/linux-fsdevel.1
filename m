Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376864;
	b=g6aFqlAZlZcNVwBt/Wr+VYB4y5ciFCemsmEVtLnyHnUn42Q48xxM2EvEUaE/Tzz6m9M3
	 XZ64078EeN17R6RxRHF0kt1HycCPB3+qxMCt81Lskw/jFjjMPU/FtkDrHRzFJWaE+zK0f
	 kigUxZV9dMAtsUe3VGXIQYqVA28/rw3IrXTV/clNwsIyLCYxPhfiEMT0zhDrmMbONSxcF
	 T+EfPQ6oj0Q55VNVdSc7hIgu1xpmMHgrX07EUL512Klxt4YqrrAcafFktot0O3zu8DqSa
	 TPbaqTq4QKfBvAlyM55JAeIMizLleN5+7MLf6/+JY2mQjpcPsZz5xSvuir4nDXwxKlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376864;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=tFTs+PufgXSK9nOJaTZUTT4iab3r1Qk3f2agilJ2GLg=;
	b=N/Y99H0bcevgFTgZnOD1rcV7QdMHA5g7NohAOl3zcyhSlMrPbheBgc180vO+JzovwAaM
	 Gv1Nt5eOBIL2Y85o10aN8+WKVY+72+r3/FgRkks+Fks9hRxvBBOhrocRza62d8F1/3cDy
	 rUBCUQtEhwPKVpp3dwQ3S3jOhGNYwrX3H1/xLuD2XdlUlvLBUx/zw4Q7TJoOxbVQTNaZy
	 ILq5LWg/oD8njyhjz9dAelqdv7tfSRKU7wAyF/sE5UmZB0wn4d/NdjZAfbzTrBjFF0fjs
	 S4RjHtjxQeFWkdMvWfu070CQ4V4YM0jdNy56k9HCzsU6FAnDOGlv99/5SCBNnj8fzlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlfNWylk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17247606A31A;
	Fri, 30 Oct 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlfNWylk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8868F1F000C1;
	Fri, 30 Oct 2026 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376863;
	bh=tFTs+PufgXSK9nOJaTZUTT4iab3r1Qk3f2agilJ2GLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AlfNWylkhz76ZAI0gkWifQgQOh3qrNamrTw4sM1vybl7vlsP7l+ubEJjFjIWSuVfr
	 HLTmc7T7jpIxWc8dcugb+S0/nceEBBtx0NmM3yuWUk0+soMuKrZTIAM7mWKnfWEp9v
	 osokb0BrkABQEEha66jWW2JHMT69cwpkF+Nv8BP92ISUKYpR0F6ml7RdShJDmWkhLq
	 qaukrVnB4aV+kt6fLWYvtTCXheIgyeM6+BrAPXzTyN3xtfQP3DjY2JYN0tEY4JfJKV
	 0BU/VIr1ptcNKPB5gnnc9FfFU+b2ztE60nl1Iimrqxsfnf3WGJAh0QBvnSP5CJFpFB
	 cRv2axtvj6h1g==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261027015813.841821-1-nickolai@csail.mit.edu>
References: <20261027015813.841821-1-nickolai@csail.mit.edu>
Subject: Re: [PATCH v1] fs_pin: do not trust the pin after a spurious
 wakeup in pin_kill()
Message-Id: <20261030-woran-waten-anflug-817705035124@brauner>
Date: Fri, 30 Oct 2026 17:14:20 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Mon, 26 Oct 2026 21:58:13 -0400, Nickolai Zeldovich wrote:
> A task waiting in pin_kill() for another task's ->kill() can take
> p->wait.lock after the pin has been freed, and can return with its
> on-stack wait entry still on p->wait. With BSD process accounting this
> is a use-after-free of the acct structure when umount() of the mount
> holding the accounting file races with acct(2).
> 
> pin_kill() takes a still-queued entry as proof that pin_remove() has not
> run, so p is alive. But autoremove_wake_function() dequeues only when
> try_to_wake_up() succeeds: if the waiter was already woken spuriously,
> pin_remove() leaves the entry queued, acct_pin_kill() frees the acct
> with kfree_rcu(), and the grace period can end while the waiter sits
> between schedule() and rcu_read_lock().
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs_pin: do not trust the pin after a spurious wakeup in pin_kill()
      https://git.kernel.org/vfs/vfs/c/f3a6dae67c9c

