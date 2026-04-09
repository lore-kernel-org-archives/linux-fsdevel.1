Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07237C90F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771634; cv=none; b=GrbgpjrduSEGnsVrSEmLucppCwK5rIQcxJ/k9LSMd4g29I+RLCuD0c+rus4ea3pd2Tgt9C/uIVbvMmyD3sVMj98RbWViKgTgLdA8q/PcxzWnrMAuwEG/NtCqEMQpYCfaMl8VSc8ARDUaN5JrieAad3deLHqadAIzUe9gj0sN4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771634; c=relaxed/simple;
	bh=vOmMTTrnJ28nXJcBb7x96HAc7TDQ7T2eVafbHphbkic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2SGvlCqhJkh2TgOjBu3zf75Lbu/GCGqFmvE17se1CSoP/94ZkYxmAMQPEzsCHmrnwvnVhLcXt/EXutejX4UBLBmwEpmufWacsxlc/Y1S0EYbuE1vNyWPToZPZgaSwwDY5oxWomESqNPtaabVESdQVzTf1yKtzyRQ/AisyKrVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XpX5V1en; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XpX5V1en"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=3OvpAPHvHISNcf3juZcW5PgcatZgawx6vh8QvkZ1njA=; b=XpX5V1ennZIExvL+9xrSDkJE1u
	4f812k3GDVuqwogqapUDbR0n6SxYUsmnDxl2cX/40UZSvc7fM/SZDlAL8cCQXhmcj2fxs0UkLVUR4
	BmRe9Wpw/Pf97hdRT8UedfE/RnVsigCnBzVZ6aCo7gB2QOYXPyRneXprJbbK9JoqSpQCzRIiFffLO
	NgE48Jotr3v16c6lW6X2/UyEWQFDhofNMw6ZuZ6Jh5b04k9StXA8tkqpgJwLCmNKx3OO2ElydGd+K
	lfSR4zzusra9NfXGeoi786yjo3EnLfH7uM5ivF2L2JdLeRYaZw4J1WwCYoH9MxvDAi3WznemcOpbL
	Uk6T6gGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAxNW-00000004KVL-02N5;
	Thu, 09 Apr 2026 21:57:34 +0000
Date: Thu, 9 Apr 2026 22:57:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v3 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
Message-ID: <20260409215733.GS3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 09, 2026 at 04:10:41PM -0400, Jeff Layton wrote:

> head_A ↔ UAF ↔ mountinfo(1) ↔ swaps(/) ↔ ... ↔
>   head_B(STACK) ↔ status(5962) ↔ exe(5962) ↔ ... ↔
>   stat(8808) ↔ ... ↔ mountinfo(1) ↔ UAF ↔ head_A
> ```

Wait a bloody minute; *two* UAF and two mountinfo there?  Are the links
in that cyclic list consistent?  ->next and ->prev, I mean.
If I understand the notation correctly... are there two different
dentries, both with "mountinfo" for name and PROC_I(_->d_inode)->pid
being PID 1?  What are their ->d_parent pointing to?  Are they hashed?

> ### d_walk Escaped Its Starting Dentry
> `d_walk` was called with `parent = /proc/4530/task/5964` (`data.start`
> confirmed in stack frame). It should only traverse descendants of 5964.
> But the dispose list contains entries from:
> - `/proc/4530/task/5962/*` (151 children — sibling of 5964)
> - `/proc/4530/task/6830`, `/proc/4530/task/8808` — other task entries
> - `/proc/1/mountinfo`, `/proc/1/status`, `/proc/1/net` — PID 1 entries
> - `/proc/sys/vm/overcommit_memory`, `/proc/sys/fs/*` — sysctl entries
> - `/proc/pressure/{cpu,io,memory}` — PSI entries
> - `/proc/swaps`, `/proc/cpuinfo`, `/proc/kcore` — root proc entries

Not at all obvious; there's a list from another thread mixed into that,
and we've no idea what had the root been for that one.  For that matter,
I'd check ->d_flags on the entries, just to verify that those are
from shrink lists and not from LRU - the fact that these UAF still
have pointers to plausible dentries does not mean they are from the
same moment in time; if dentry in question had been on a different
list before getting freed...  That's why the question about ->prev
and ->next consistncy.

And seeing that procfs has zero callers of d_splice_alias() or d_move(),
I would expect ->d_parent on all dentries in there to be constant over
the entire lifetime; would be rather hard for d_walk() to escape in
such conditions...
