Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECA4CCDF4;
	Mon, 31 Aug 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193251; cv=none; b=JC3taejSSV6rcp7OvY/VsZMYWPSwgqSiRU14N5OQ/E8nanntPGPYX1o+DYXQ+fAg2jsrQ2v2mPXpCh69JN/0DliGQ1qutMpauNPOR/XYXu/o8CkfGMDxZXNiocl5Hm18RRUdS6FxouHSue0GFzIxrZFlkhGVma/9gudz/oN3bBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193251; c=relaxed/simple;
	bh=tI1sWrR0uNh0TXdJTPbEYJyehu63ytxRVKdQE/GQYG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zf+W3KWIL7KKUl9MJAkP3mkm62VXDiUBh2gvY2xsz3T+7UuM6K/uQhMLC2D7jy5KIhwMIsXgCHwgyP05nx2/+NGOiKx4wnXlsK1wMjYx2CDWPlUMeBdTxz5bMQF7SFmLzMHYW3G5zcI98Pglv/xN1tc2AOoCoQbQn64i/WDZARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMQrHkaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMQrHkaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141811F000E9;
	Mon, 31 Aug 2026 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788193249;
	bh=tI1sWrR0uNh0TXdJTPbEYJyehu63ytxRVKdQE/GQYG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PMQrHkaFWC+D3XenUSOXVVfwJVpDfELNYu8xlJ1JAOFrd7/+ae7emP9kKi2wMufD1
	 kKKvd0RrxU0mVv1Ydumxvl9FhXN7zN0OaRcZvzTJYWqqishBG9YRCE36yDOyLZ+V1q
	 bSLBEjZ9VX6Z5zoYcfJYpDhCi22Gh3ZpHgzi8/eZxgFgRaeUUqOl2Com7wLTnpsBVE
	 /DCvBLhCVDVlXid+J05E3eZHof/yRpY+h8pGpd7T3SW21wzBTAZjPQjuDVFQa9Gxpv
	 bqfLxYDgETax8eKgJb+AJRdYcQNHDo68H2FCGD47951r6aoe9PfpsXDR3D18ivb8XD
	 5nK8yvkH889qw==
From: Thomas Gleixner <tglx@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kees Cook <kees@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz
 <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Eric W. Biederman"
 <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
In-Reply-To: <ao7iQ_wOLghOvTsq@redhat.com>
References: <ao7Q8miiuLAPVnWv@v4bel> <ao7iQ_wOLghOvTsq@redhat.com>
Date: Mon, 31 Aug 2026 18:20:46 +0200
Message-ID: <875x0qclcx.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 26 2026 at 14:55, Oleg Nesterov wrote:
> Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
> sequence in begin_new_exec() up, right after de_thread() before the
> "if (retval)" check?

Yes, but that does not buy us anything.
