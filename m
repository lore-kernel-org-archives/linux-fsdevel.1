Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101B346FA7;
	Thu, 21 May 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354519; cv=none; b=SfLOsRjXM7OSNHaM/HHXXLdJgNdXhbpslxKOni9aakzlgc8lLaoxLvtqTQQZpHzSPv8ntCExVJJUHIDgANIQzf9MF3CMhvm3bNuNtu2geKUwbMUqM5TagozYXZa1h38xpjlfrBtbVWElfkWUl1oUNO/EFExXd9quC3ZqbkrraXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354519; c=relaxed/simple;
	bh=D9s4XUk2q78Dh2xG5jvn6zmQODh8/q00kukvmipx0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaFPyltwSW9oOoAZbRiPDLHbYewyhzSyNANglXq9f9du+opO/E5mpwkKDaiZWWSYo5WimTDvKdHBfjdt9nuI+Fmfv9F8V17YeFlzyHE2H09YRBLKnSbhC2svjmsGeBPV0o5toLT0peRs6kj0Tkk3L+ktAlrnHwlFRIgy3eMl7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pou1pb8o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ngOOJATA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pou1pb8o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ngOOJATA"
Date: Thu, 21 May 2026 11:08:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779354516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9s4XUk2q78Dh2xG5jvn6zmQODh8/q00kukvmipx0c8=;
	b=Pou1pb8owqymfepEvckmQWQrjZq3oVWcC1q93Trw1z7wHWGCA5TSdFv64K5AUiSGhMuYZj
	vDVvZQdw9Zr3x9wprkzypE2PQSZzCkVES8FD4YLLgULS15Dxs/BCKSYvyTJrKZW7gs7AzT
	2poAAYypTE0zxyuHed18bx4ivMhKNwj292DdRr3vPC2g1gwbmvg76U/v7n0nsVarTIg+AA
	WnVe21RAAqWPAxA3TePVdOScS3wv9J7GaBXCAiq4FMYtKKe25QmSIRKOcvGtQogJQ56MW/
	lqS8ZeCu2VSpQH8tbW2bHaPpL/RvvXC1iOT5c/aZDpufKOU/jx72DT86cjcXgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779354516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9s4XUk2q78Dh2xG5jvn6zmQODh8/q00kukvmipx0c8=;
	b=ngOOJATAtKaEQHO9IP/NOZc7Mm6p89cJJ1zx9Gg5SXi+Nhjn/Tdf+zejDKeGYIt8zzi8KD
	y+MIXHjvkCiIrdCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
Message-ID: <20260521090835.hz0aIRaQ@linutronix.de>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>

On 2026-05-21 10:53:03 [+0200], Mateusz Guzik wrote:
> them in place, but when I was rebasing on top of the RCU-ifing commit I
> figured I'm going to do guard/scoped_guard in there as well. Later it
> started failing as the compiler did not like goto retry out of a scoped
> guard area and the unlocks did not come back.

futex_hash_allocate() has a scoped_guard a goto to again. In case it
helps.

Sebastian
