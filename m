Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCE30F94B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021604; cv=none; b=pN6i0PRXulEfbd93Nx0RaD/lCMxoRc+ImH//xexWE/vGopkWvghNrQ+/fL6H69NTGArRayw5G/zepPbOLR5eMGg4dEk3HFeeudvf3eXoMIGbT5w3R6UEsPeBvMe+wIc/C2sWzVCwMsGjx0ZhAlFuK3myB1X6+QN6ANmlLHiP+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021604; c=relaxed/simple;
	bh=GwROMAbL1+3sx/8u0qfvwRD001YOTNzn+0GG0fwmm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfuTUwqOTnvkHX8U4NGAIwrF3D1VVfGHOmiygN9i/fLl3kaJ44JnQL/XUtu43X7MHl/krscPl3xrM+qG4cJipbptnuzfrwvpH238P8eP07bGmOPjGOZ4MWgBb+RW13QUA2KeAMpznPkyrHGxDhrBuJtgZH5VE7LcsL52tViJn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxUJclKI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxUJclKI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHGZP+Ia2jZJX0fG/DYe08+rcAKSfGFkUL04ogz27ZQ=; b=ZxUJclKIzHQ9FUhb0/gcMAlpAF
	PJeLRKsHinqvtQcMJbKRcaSBkIdyoVVPiKHgOkf3HWUwAs7z6hY5MIfx9YAyUjVO3MgiOFTQV2IPX
	QkOjOLhohv16xG/D/SpQ9oXD7/JpXi/PrsHHMxYV4O+B2Z+UqkPnPTyKJzKt2JutCyzgA2ifQCdEf
	USyCE+4UR43vOis4YgWYveJ8KABy2W2slH1RtMO7n1+d/xkMjrjMV1+Han7BJlqkwtVo/wLAF10lb
	xVw7ksHgWJ13XyVFo7feQMm35RJM1inkZXuEY2aP+wcQp+rjQqnn+ZJu63Q6K0L+5bawkIikOdgqR
	fZ8rWt0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vr1ej-00000002KwU-2vH2;
	Fri, 13 Feb 2026 22:28:57 +0000
Date: Fri, 13 Feb 2026 22:28:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, hpa@zytor.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	werner@almesberger.net, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260213222857.GR3183987@ZenIV>
References: <20260212192254.GO3183987@ZenIV>
 <20260213173427.112803-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213173427.112803-1-safinaskar@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 13, 2026 at 08:34:27PM +0300, Askar Safin wrote:
> Al Viro <viro@zeniv.linux.org.uk>:
> > We could restrict the set of those who could be flipped, but I doubt
> > that "could ptrace" is workable - that would exclude all kernel threads,
> > and that could easily break existing setups in hard-to-recover ways.
> 
> No. Kernel threads share cwd and root with init, because we create PID 1
> with CLONE_FS:
> 
> https://elixir.bootlin.com/linux/v6.19-rc5/source/init/main.c#L722

knfsd does not.  There's an explicit "give me a separate fs_struct" since
it want ->umask to be independent.
