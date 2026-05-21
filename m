Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC1374E42;
	Thu, 21 May 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357931; cv=none; b=q23S7AD4QD6FM/YwayvzxxOTF0oy2pblVN0xISYH4QYJeB6XyOZ06lgckijeUY3PLfzJHxkNYGfWwMj5UcjKrjhtE0u8TJp2aWBk/2AYMD4rf+sdxGe/bWy2hvPzHoM3aAchkVBrOTcIqKW31gp5KS0nKWlMP+nnMGYQ3eDsZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357931; c=relaxed/simple;
	bh=fffifc7k2pVN1TO0FTCdPbYXigpe66plUPPihJ4rFQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YIw5DeCVCsCGeNQuSzgr0QT/ddlSwM9pZPD8mYTpwkScKqhPk0QLOUzzk9LUBI5xlXxv1MSK3hHQLu0DfiFq+rKPDp0KarHGlY8N2Qz4OWonfjHJWh3SO/fMZvJicPybQeMdRXB7bzOr1FaN2EzC+XgtMXjZwLpI06VfzaOjbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hV8EMzVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JXwSp49h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hV8EMzVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JXwSp49h"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779357928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCORsnrvQnCk2S6R9UpHrOMeIDrvzcT9DimCW5lUVfg=;
	b=hV8EMzVzXKVLF8e3+V43rajr7lIgblsv3JYsUR1I6Z2yxiLfGFb0AGxSYNj4eRSDVduaks
	NXVTiHTEbwffTJap0mGVngfT0YWi+rh2xtfhhtkKt0BpFsq1vCpoOPI/OghbVwDAZsMqVU
	7tTWYjwJVFJi6VmGdRZ1LpdHHDTJYJaB4nt/BbQK8jLZaOWrpjtaYmSBepbH9bbNdo1Yjx
	fFYBFEe/f0IcuGI+xecFAWRLYtZIdPuGN/PdEtq73LSBhcO/tNvcLZFnJN1VtSUWvKREl8
	AeD6TnztUGzy2whBrZuI+eC2HwWaOq2kSNPRihw48F8xUupqkjIkkLgNSKydLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779357928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCORsnrvQnCk2S6R9UpHrOMeIDrvzcT9DimCW5lUVfg=;
	b=JXwSp49hmYdee/RoUHqylk51uBG0Vw8ltsRdQQGb7d1u+pXhJfd8I4Ewziw7paJfpwSpJ6
	tw9ULrRYt0SYATBw==
To: Mateusz Guzik <mjguzik@gmail.com>, Bert Karwatzki <spasswolf@web.de>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
In-Reply-To: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
Date: Thu, 21 May 2026 12:05:27 +0200
Message-ID: <87bje9w00o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 21 2026 at 10:53, Mateusz Guzik wrote:
> On Thu, May 21, 2026 at 12:52:44AM +0200, Bert Karwatzki wrote:
>> With these reverts next-20260519 boots 30 times in a row without error, so
>> it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list") causing the
>> error.
>> 
>
> I think the patch below will do the trick.
>
> If someone wonders how come the missing unlocks: the original patch had
> them in place, but when I was rebasing on top of the RCU-ifing commit I
> figured I'm going to do guard/scoped_guard in there as well. Later it
> started failing as the compiler did not like goto retry out of a scoped
> guard area and the unlocks did not come back.
>
> tl;dr there is definitely my bug here and it is most likely *the* bug

I was staring at the wrong commit then :)
