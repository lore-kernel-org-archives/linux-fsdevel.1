Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B13921FB;
	Sat, 20 Jun 2026 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781991951; cv=none; b=DEa3AQ03+3xzneDfLx578KguNUo4gvS2U2uI2EDX8pB4uEm0iVIhltCU4coV5L/HLxflNLzxb1Fk8nqWzntgEYOXtumleVJ8fTKiVcd9of5oRtCawX/1IsqpVUlpaFYb3X9VX0oMDB0n/Nv9Yzi9vw9RiwI0ccKHDVBEuzSqz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781991951; c=relaxed/simple;
	bh=rphwMtfZjMmupFJOJjYB0AGTUDwhzza5yMdZTQAHrvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/2LBCVrKLS/ASli5gMOkLbou29hoR7sCUGZtG48JTL4CNNi2JceKNMc/9+H+LTThF77xZvpeZB0PFMleFrEisva78ejBD4PyFgfDK7pt/6gxOfU2Ercf55sckx0iZ552zBgxdZjfz+I+HTW+GpR0nmJ0RClspmqXkgEt+D3F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ36Ofa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ36Ofa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B67A1F000E9;
	Sat, 20 Jun 2026 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781991949;
	bh=rphwMtfZjMmupFJOJjYB0AGTUDwhzza5yMdZTQAHrvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NJ36Ofa1NSKmyS+MmTYE01luQhxXqVX+kKw1nOkolYxW//pw9EYpK4tdN16H7yL4g
	 z36Mfp7TSXI5NW3vtGJYvsI6pzrsa52r2+hFi7z8VLc1mLP1Qb279soVns/G6YUg2U
	 wYnCseS7+cK7QfHE9BHzCxd/XGWFG81WpjV/7ICKSaHG07KNMY76yaiQ+D5X+FfucA
	 rUC1jWLggVPJC84mGSL3+in/KRMOcOjaySgxtdIjRrG4BNmmzUuz6/bVA8gWqQgoUI
	 eK0ORreT0j67tWmcQcYha7Ox+cjnodnbHjmYkzERy81L7KQJTTIou8IY8CtJjL9yCX
	 takVxGC9hn9/A==
From: Thomas Gleixner <tglx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jann Horn
 <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, syzbot
 <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, kernel list
 <linux-kernel@vger.kernel.org>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()
In-Reply-To: <20260620064404.GE2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV> <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13> <20260619083916.UMjUHmaq@linutronix.de>
 <87mrwqd7eu.ffs@fw13> <87jyrud75z.ffs@fw13>
 <20260620064404.GE2636677@ZenIV>
Date: Sat, 20 Jun 2026 23:45:46 +0200
Message-ID: <87v7bcnawl.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 20 2026 at 07:44, Al Viro wrote:
> On Fri, Jun 19, 2026 at 02:52:08PM +0200, Thomas Gleixner wrote:
>> Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
>> Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
>> Decoded-by: Jann Horn <jannh@google.com>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: stable@vger.kernel.org
>
> Looks sane.
>
> ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
>
> If RT folks see no subtle problems with that, it ought to go into mainline ASAP.

I'll queue it up tomorrow and send it Linus wards ASAP.
