Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE019C546;
	Wed,  8 Apr 2026 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689242; cv=none; b=JwMwrnaBsUUuwyR3hthjG2ELKYJEA8m7wUgLQF1wxsu7eym5EVNX2xhcYQsXOlkkYdNRRP/U2W3VQNWEuv4iEyuiAfk929RL+2J/q2sXm7vDqvKtbln8MdGsKckJMefKRAGAFrd5D85M2ic/qI9e42XBGkAfU4lkrJZLU/UKApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689242; c=relaxed/simple;
	bh=NhJw6q0gi1AJ0Eqrmwa0aStOE4sMnw2UXfKUAmkW/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+ZDMrWuNtxialsNvvFSZJCEYoQiKJgdqD2SfO6649x5A4dMeh+3XSwpV4xzxe8hyiNBP5EFfJpUjK34bfxhnWvRYNsWDuR5QvPReP0YBXE/usSuHyWPrtaFhOI0sXhoLVrhn8E/TWS/5IFztzeb3Jv2R3133mNoBatRAbaS/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A8aTMNJ7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A8aTMNJ7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PegINYa0h+KOZ1s/Nlcki64fdMwXffd4sRvBFCuLlN8=; b=A8aTMNJ73xvWjRfbu5blXNeAAb
	voFtcs/LxOOdxqVVVqlLqYEvcCJesvHuFJaYxaYgLYyeQijKSq91tUU6F8VRsD9rJa4DxP+qVW33K
	EBI4h/g4Hvnh0Ddk+O3rObXAvUf+wwLmH7j1ZOT/PcX/69nxEHzLpFXoG1HBOcCAgR6D8UV34N3D8
	wZAkaUT1CAM1oTnO/WXO4OkZdPzmz6Xsc8NkJjveTtRZ45m8h5CwXQgk6FPCBtfLKibyhlAuZsymJ
	DSxeDgVJn02UuZ3OXHB+TJeLSmyQsS5rAUjwxGkgoXydk8np1zhQ7uqFBmFTKkofLjvPZPDKJl5J3
	cWHgq8sA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAbwc-000000010WU-24UC;
	Wed, 08 Apr 2026 23:04:22 +0000
Date: Thu, 9 Apr 2026 00:04:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: KCSAN: data-race in path_lookupat / vfs_rename
Message-ID: <20260408230422.GK3836593@ZenIV>
References: <61ff6def.2d0d.19cdad1307e.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ff6def.2d0d.19cdad1307e.Coremail.luckd0g@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 11, 2026 at 10:54:28AM +0800, Jianzhou Zhao wrote:

> Concurrently, a separate thread traversing the filesystem performs a path lookup and inspects the same intermediate dentry (the rename victim) within `step_into()`. It tests if the dentry needs mount-point translation by calling `d_managed()`:
> ```c
> 412: static inline bool d_managed(const struct dentry *dentry)
> 413: {
> 414: 	return dentry->d_flags & DCACHE_MANAGED_DENTRY; // <--- Lockless Read
> 415: }
> ```
> 
> ### Root Cause Analysis
> 
> The data race is triggered because `d_managed()` executes a plain read of `dentry->d_flags` without holding `d_lock` (or using `READ_ONCE`), while `dont_mount()` concurrently modifies `dentry->d_flags` using a plain read-modify-write operation (`|= DCACHE_CANT_MOUNT`). 
> 
> Although `dont_mount()` properly protects the write within a `spin_lock`, the lockless reader is oblivious to it. KCSAN identifies this as a data race because the plain read in `d_managed()` can overlap with the unlocked portion of the compiler's emitted store sequence in another CPU.

Who cares?  d_managed() does not look at the bit in question, so what's
the point of READ_ONCE()?  Split 32bit operations or not, if

thread A:
	lock
	x |= 1;
	unlock

thread B:
	return x & 2;

manage to depend upon the order of execution, compiler in question
needs to be tarred, feathered and shoved up the place where its
authors heads are.  Sure, theoretically A could be compiled into
	lock
	x &= 1;
	x ^= 1;
	unlock
but who the hell would do something like that?
