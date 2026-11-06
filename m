Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974097;
	b=o6tv8Au37cQg+lLDRmA/8XSfjOoZlWzbyeeOeTQlPaOI+ReQkaYqyBb/V7lVVPkiXoPD
	 wZuWk01HJtUcyzOvVGehIOKsDVefZFOzuKMK9PRm5RotVghhixwsR8yE0+CUeE35OlT/D
	 acNxRBT+eS4QUd5CmBFOqK50iyEp7zqEDciXZGxcZ4YM4E/Gn3X9kV2+wLSkTWBKeJjjM
	 BOM7xMpDvlhFzsbzMP4xu+DDnCdvMckh1RGgPsw2KBDA07f61yceXfs86qum5FjZJjuoW
	 aJHN/mjRKn7KQyi8km2Hgxo0Zte6nPRDXK3GKsMO9cPQOpHxYwCxs7hV0N5qye7E2lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974097;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8HZmgLYGzClHR0aDQci0yoL1gMD6nTmTkstgLN6HwNs=;
	b=klu9X2SnOk0yOd6eLO3BNpm373wGhuS9j6jJPdW5o9wlMKvs7No83QNijLXkec4Ph1rF
	 yxsHOANMOBLWFol+REweo3/ao8dVEs2ip3ZpIkqk8H5WXVzaiQpHT7nZQT0JLA8yDmwzv
	 fXm8bbLS8rRdG7LHHgEfC1e5DiVEbtdNbOmY/JJPfgor3T0ypICvtun2nc/K0HfPDm6xY
	 1bnjDLHNLgrdBE/59IjvySrj7QDdCwxFJ2d6yJ7FIUXxUkpMP5/h/RJbGAiaWusrtwU82
	 JPqcR0M6zlJPi/36UQYPt8gkt0e3TDONyC2vd7D3WpbMYaFn/BUG+5mxxOI4bhMopHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjqeVlsh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5EE606D80C;
	Fri,  6 Nov 2026 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjqeVlsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF951F0089F;
	Fri,  6 Nov 2026 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974096;
	bh=8HZmgLYGzClHR0aDQci0yoL1gMD6nTmTkstgLN6HwNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CjqeVlshTKe9+fAg0yLJVn8Q3M9Bj+HK6dEp7RdsY5ODKFPlHFLSZXsTB7/NBLCHL
	 aSWn8FClEZ71rCbT0RCIudBXjxGEsh8nzspTcW+gNDAj4P8sBGpDwZvlY6CK9TkjFH
	 MnwHo4LfWx9QA+8Yo9A8mIvdlAvL1DoEbRp1hQtMoF3ry3jaJLw8wyxof5g/G/75Q1
	 8LI4VzYpktz5IgYTqIUFNe2tn0LoFgiLtXd5UCgR+AdELcETokqAMmpLW28lliKwAZ
	 DmzTSCFB1WyhVbzm/frLvSiFwIrOF6CoK+fUCRvjeBp+ozks7sETCeazGHIsprPdWW
	 6Be4laao/2U+A==
Date: Fri, 6 Nov 2026 15:08:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 35/38] proc: sysctl: don't hold the tables while
 readdir copies to userspace
Message-ID: <20261106-raufen-heilfroh-abblitzen-d77ebbf36816@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-35-59422ed3e465@kernel.org>
 <ntnca5ndnjaoi7bvfh346zek2jphi4kfmaxv7yd4bqfrfcwjl6@2wdnnptu4igg>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ntnca5ndnjaoi7bvfh346zek2jphi4kfmaxv7yd4bqfrfcwjl6@2wdnnptu4igg>

On Thu, 5 Nov 2026 13:55:56 +0100, Jan Kara wrote:
> So I didn't really carefully check all the details but overall this looks
> sane to me. Just one thing that was confusing me is: Why is sysctl_dirent
> separate from sysctl_cursor? Wouldn't it be more logical for sysctl_cursor
> itself to start what it needs to pin the entry it wants to restart from?

Because they have different lifetimes. The cursor lives in the file
between two getdents() calls. So nothing in the cursor may be something
that unregistering the sysctl table waits for. So it only remembers the
name of the last entry and the position behind it.

sysctl_dirent is the state of one call. It does hold a grabbed header
which we drop before the call returns.

If the cursor were to hold the header too then every open directory
would keep the table of its last entry pinned until the next getdents()
or close() which is the indefinite delay this patch kills.
