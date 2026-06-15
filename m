Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F685392C27
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516683; cv=none; b=l9y9IKJkAtVMZ/vfro0A/fqrC03kJCyA7fKFYnAXr0Hb/HZqDALRTxfIxilcMMVGdNRf1OEW0ikrHNIS82Ux7rZp2uvBq3rQKSMEbfH6c2AN+woLZVXgSy3WNWmC3OukSepE3yL6F2tytpS1ZqUWYG5OTD5ac4CH06oNxpW6Fys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516683; c=relaxed/simple;
	bh=e0f3MIR23Hql10yXbA2qZJ2ZxlM2l6fSFMfs/AKccE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCM07PoQi48OXG2FEw5yqhFVWkPNcjQd+gM0OE3IepEVzvntslnKKfhrhXBNwQc26Nt/Ci/SxQMT2p8zsDrHy7zfZX0kbPvNlTZuJrX6eOlAkYBbuPMbcTGztqaocW+JsbQ2MXiYhDk8RBF+OBJ4Z6wegBAoJKL57oLF26Fssjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0gz2zBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0gz2zBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280A21F000E9;
	Mon, 15 Jun 2026 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781516682;
	bh=e0f3MIR23Hql10yXbA2qZJ2ZxlM2l6fSFMfs/AKccE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g0gz2zBrh4y08qcV7aWa1oWrskMyI0GujrRyta/kwKL863COMUBAWHasaC6hqdGpP
	 PplDfSI0gHohqEZIPzNF6yQYZvIuuhkGxabvlNcqrVR8J03tU13oROn6Ysb91/JgSr
	 08uQz4GYy7oTvY42V8ma9x65tAi/0fS+A2cWYmx6K9FtN43tpWfBetJ9fquUo0KDvS
	 WTJwAYJhdQdvvMmty/VlMInkQNvLNC1NX0uZ8b40WvwcH9+eqcuufRcQYe/+bF5W2X
	 IFhbVSgdBQy1tukZj7/ptBK9EnoEDKWxiZlLjRXNKqWkY9wemasa6pZP2/41Bh/7lT
	 zn79CT1aU5DIA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,  Al Viro
 <viro@zeniv.linux.org.uk>
Cc: pr-tracker-bot@kernel.org, Breno Leitao <leitao@debian.org>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] configfs cleanups and fixes (with tag on correct
 branch now)
In-Reply-To: <178149513829.2410512.294347582100935655.pr-tracker-bot@kernel.org>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV> <20260614223951.GS2636677@ZenIV>
 <20260614224400.GT2636677@ZenIV>
 <sdEHmxZEPCEPfinStEnqABhCu9DYEGckR2mM_dxt1yw28lRf99EEZwGaGFrzI0in_wlMynNhv9z7PIGgeiZ9ag==@protonmail.internalid>
 <178149513829.2410512.294347582100935655.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 11:44:23 +0200
Message-ID: <87qzm8f894.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<pr-tracker-bot@kernel.org> writes:

> The pull request you sent on Sun, 14 Jun 2026 23:44:00 +0100:
>
>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs-fixed
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/de02909ae81aa4fda213d16915adb5e1b088a7db
>
> Thank you!
>
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/prtracker.html

Amazing!

I was sort of dreading having to go through all of this to make heads
and tails of it, but I put it down as a task that I would have to do
within the next few months.

I guess I did not have to worry about that. I am happy that I did not
have to handle that, but I am also stumped that I did not have to handle
that.

Thanks!
Andreas

