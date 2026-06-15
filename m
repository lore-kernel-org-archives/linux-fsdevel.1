Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304483B14B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551552; cv=none; b=Jp3Cab3VDo0c2TDE+UNkkLTBFLkPJihOIYnA1xi3rfrz+OOgSaXyWC5wvf6MyB9XyrTyndDyawICcqU5qBOaSxAwLoPLjCCxCP7lOd/q9dFI0poVatNegHOs44QqjfNEpIM46Sjo91d/oXaiWij8csgGX1OrXkJ8NT6nuRSq/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551552; c=relaxed/simple;
	bh=OJZViyVPt1QqmgS7B0y+1mdM6kIavZqS/c431IH9kQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgoNeDmUQ1E8AW//9Dq7hfnEiBjD4WT9GcYOeAPrKC6X/8/TyonhQKa97gLa1Keo4T74KdUQ1A+W3HxmwhVKMUR0QfUKGahydYgbCMTncR4GabSoTJXLKodQsQs8SfXYcamIdfyBtrmPFc8LglaRnPq7nPgSqkp/TrsZgappPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DEJoU6HE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DEJoU6HE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IdQAnjfDQ3Na0fYCuvZTPDsx+8hdTxBdKvm+4qTm+rA=; b=DEJoU6HE9T54SpvZFlnEuY3mtQ
	8zZ/3fMOYWfYM10P80XzMAp/Gf9soD2jp2ej9nOALOXhnJusVkvftkVDaO4hgydmLZ2hKPW77Kg5L
	IuMUDkiKefdznR1I/dpwiV4sZzuY8DUNS37XNsnsi0TGoKfcgaIIznrsqH7MFjU28D+wh8PKjKt/P
	I97j71/a/B5TOlRYxUL08UtpbnIK9yAv/E1D9qLR2Ahebspp4nlquv8KHJ6VmdZKZQSTQcmD22Qtf
	FDe4WT0nkX4YEm0juLstvtcKOQivxqdYAq45k2494oHkzmflCFqDdW/z642torA45pgXexd8SFzqL
	XNbUMMKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wZCwG-00000002SCo-0YiX;
	Mon, 15 Jun 2026 19:25:40 +0000
Date: Mon, 15 Jun 2026 20:25:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pr-tracker-bot@kernel.org, Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] configfs cleanups and fixes (with tag on correct
 branch now)
Message-ID: <20260615192540.GX2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV>
 <20260614223951.GS2636677@ZenIV>
 <20260614224400.GT2636677@ZenIV>
 <sdEHmxZEPCEPfinStEnqABhCu9DYEGckR2mM_dxt1yw28lRf99EEZwGaGFrzI0in_wlMynNhv9z7PIGgeiZ9ag==@protonmail.internalid>
 <178149513829.2410512.294347582100935655.pr-tracker-bot@kernel.org>
 <87qzm8f894.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzm8f894.fsf@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 15, 2026 at 11:44:23AM +0200, Andreas Hindborg wrote:

> Amazing!
> 
> I was sort of dreading having to go through all of this to make heads
> and tails of it, but I put it down as a task that I would have to do
> within the next few months.
> 
> I guess I did not have to worry about that. I am happy that I did not
> have to handle that, but I am also stumped that I did not have to handle
> that.

FWIW, configfs-related stuff I've got for the next cycle:
	* use ..._recursive_removal() for all removals
	* build new subtrees isolated, then move in place
	* kill the lockdep magic, since deep chains of locked directories
are no longer used
	* kill the "is it ready" thing
Those are already more or less linearized into #more.configfs - not the
final form, and there might be some reordering, but basically there.

In local branches, should go into the mix by -rc1:
	* saner waiting for mkdir in progress by rmdir et.al. - doing
that on inode lock for parent directory is not a good way to do it.
	* a bunch of cleanups.

Stuff yet to be figured out:
	configfs_depend_item{,_unlocked}() work; the rules for clients are
less than obvious and in the current form it's seriously racy.	The few
existing users (all 6 of them) _might_ be OK, but I've no idea where to
start with safety proofs on those.  That might end up slipping further -
I hadn't tried to contact the folks who might remember the underlying
history yet.  In particular, configfs_depend_item_unlocked() had been
posted in early 2015 and merged in end of the same year; unfortunately,
it had been changed a _lot_ between the last posting and actual merge
and I hadn't been able to find any traces of discussion anywhere.  Maybe
Andrzej Pietrasiewicz has some memories of that thing - other likely
participants appear to have moved on ;-/
