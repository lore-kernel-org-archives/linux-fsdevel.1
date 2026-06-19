Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA638D419;
	Fri, 19 Jun 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873937; cv=none; b=VhcYpwv3V+nDkwc2bVlYo+C1YdCkPW4wnDZQmx1i2M8rTmwO7BV8T4SrAjmSfzWB11j8ssSPoshdX2SpaK0+ytOkBoLGajBRZuXnoTlEaoaijkVspUVTsujid/xuJpbyPBwwpgE4OJUe4jA6Uw1ov1S2FI4yA0i6Z12eD63JtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873937; c=relaxed/simple;
	bh=fc5aoZP7eIkRLqNRisFV62d/fWTQWLLVZYeLkaEWyX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz9tFT7KHkiIaQ3D4hgL1Ch9DCuC9g3frqTJqzR3tNi1AhhVBaQ1RgL0tDEUmhlKsR5hp6yGW+7bze6rrlRAm+YwvX38QBvKe/Wv+wScagD+L9x+2o6X/NvPM4NOCoWRGvOhNRiKWuwtoHS+E1lR5oio2PjjpyiF2MkfgrroS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dexk4e6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZgTvm7j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dexk4e6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZgTvm7j"
Date: Fri, 19 Jun 2026 14:58:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781873932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc5aoZP7eIkRLqNRisFV62d/fWTQWLLVZYeLkaEWyX4=;
	b=Dexk4e6hg2eKGKLnV/oVAMAAI76IdnhcFfInhmcRAH6qV5PoP7+PZ/YAnYEzW1MzANqACx
	k09WFJzVnSawU5KQTytVypDuKMmMMAtJvXkBrQaMLHQWEy55TmQ7FDtHV39BSYpo6zXQhJ
	4Me5179VRaqPb9+H32UfYRjYU0qUkKpsKw9W00sNJXIiJ3c6f8BdC/SkWJe6ofyGDvd7WL
	BwoxfUrUtOKGJ0rud0h+nEcxUXoVt/WgjUvqJRUyFJQjVMoYL3siOYcJeFBU9Rizdv7WIR
	4QQbu9BNErSca0ZYZ6tKpzOy+se2/J/9oVpx6DakVZb9JzS5FcTc127Z+h0Vnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781873932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc5aoZP7eIkRLqNRisFV62d/fWTQWLLVZYeLkaEWyX4=;
	b=mZgTvm7jD3Z2NAcxmxmDVerTEEjxf5yKGJh1YGtcQBdIlU8beFsgsp7lYFwlCl0NvKT8Ii
	nim87aROr8+evpCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	syzbot <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()
Message-ID: <20260619125850.ngovjcHG@linutronix.de>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV>
 <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13>
 <20260619083916.UMjUHmaq@linutronix.de>
 <87mrwqd7eu.ffs@fw13>
 <87jyrud75z.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87jyrud75z.ffs@fw13>

On 2026-06-19 14:52:08 [+0200], Thomas Gleixner wrote:
> rt_spin_unlock() releases the RCU protection before unlocking the
> lock. That opens the door for the following UAF scenario:
=E2=80=A6
> Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
> Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
> Decoded-by: Jann Horn <jannh@google.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
