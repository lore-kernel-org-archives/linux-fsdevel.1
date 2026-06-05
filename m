Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8631F16B;
	Fri,  5 Jun 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684772; cv=none; b=HL8BahgwRBzNMpIeLZzXjJh9HSMjStY0RzTP/F4zQ+1rUn4pe0aSjjvo1l9uqzwD2SIUwcKZtGvHNd/8m1y6UGEdis8/dvGAphfLvR0flBFuDgnML7Hw+VHpZ1Wlz3mPhkAW4X9VL5FCGPa/RDNYataV6MldDW/rQFCVQkLRzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684772; c=relaxed/simple;
	bh=8LYY4G8fSVhEvRCImMv1/qg1dw88tVWrADn0cNxWiv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp+Tfal5s557zmQSjZzeFeth620tA8yAyzN0MrxVCkImSphc2pIAaE9l907TjoFo4TnVtjistIVdByh8TxUGAkO7oONpiDkbxI6wzm9nEy1xo/94SG2AdRF4A5LM06i4kvsKjKIteZN3UhTuMRZDYwRVriSuDGL4dUECx7RQj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eZ3G2LXp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eZ3G2LXp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CNmJwLbsrrfoYaLQ8RjJVvgRFmkbbDKB94U1v5YM/p0=; b=eZ3G2LXpLyWPiLNj1rgb1xI0/m
	Ly6vKgfir+UlE+6eMJyTGxRo5DTa2RGDYp64Tn5qjeoMHWdEMCqRs74ivqpP2qqEaYdlT2nAq9abA
	aiLm3ALM5fpAcnPDV9Ip11hkKym8HukDWtfZXEnO3CFwXd2JDqJq+4yOJjsc6H6iJtSh/H5l2t4y+
	nmeX5JRIqm+EocqRev2ZcnLV1n8H81OGbupjQtrXPOeGJb+OrCU6wKx1F/ZOqvbaDvFv2uxYiYKaH
	hemQ8GNEzFActvHol0pB90tEik25B+k4I1kZydNZzMGBoodbfAgtwv6prr4f5Q/q13BSZZpMAcQ3A
	w2f241hQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVZS3-00000008TUF-0Nga;
	Fri, 05 Jun 2026 18:39:27 +0000
Date: Fri, 5 Jun 2026 19:39:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:more.configfs] [configfs]  2bbdcd7eab:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20260605183927.GA2018146@ZenIV>
References: <202606051115.319be2bc-lkp@intel.com>
 <20260605071112.GD2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605071112.GD2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 05, 2026 at 08:11:12AM +0100, Al Viro wrote:
> On Fri, Jun 05, 2026 at 01:52:28PM +0800, kernel test robot wrote:
> > 
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: 2bbdcd7eabfcd3a5bd2614ab75ece19323d5f4c2 ("configfs: attach the subtree only when it's completely built")
> > https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git more.configfs
> > 
> > in testcase: boot
> > 
> > config: i386-randconfig-013-20260604
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> D'oh...  Minimal incremental to deal with that would probably be something like
> the delta below, but it's probably better to have configfs_add_subtree() return
> the resulting dentry instead...

... as in updated (and force-pushed) branch.
