Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1434C6C;
	Wed,  8 Apr 2026 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689395; cv=none; b=hBRwAAv9LLZhSIp8TJ0YnJZZXL9A5/AI5Nq1ZTmY2EK1jmNwhzXJ18iC9Y1yNBagxV7b1fNcqrsKh4LT5cDPVxfJ0ZfVNLNvK+OVKvU9A35AA8AgspKv1HASh2RNo83AJFN9uqhZuR369SJDuwiE6nd/xPn6CdtkE11DP5gBYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689395; c=relaxed/simple;
	bh=HGH/CaGjXVe5ro9i4eT2LA0gRl+8MhTOemwm+NFdil8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgmKv2EP4R0XZZwKJL0rzd2xrAUklGE30JRFQEMiSZ52g/vo9r8ZMcx2G3aVxwVD17/pkiMBR3kfCFdWEzSL/foWtL8Y5i8ADX+ukNbFlJSiGHBEd3VyGd4mPA2q5JFZO8k33O2wrk8WC3LqHAjx+kQ96l2CkPhe256/WpvBbzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZZagrmao; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZZagrmao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eGZk97INaPHC4OtA7J6syilwTyNgGgk/numJF2tw3rs=; b=ZZagrmaoNhaiqnrSTgbcPUerZd
	VMI2kud5Cmrb4d+L8keRJCpwNEBfDcIQNQCO+377vMnf4la8tmxY80XLHEu+2GSEhYrs/BP+yW1Jx
	FpADlHFNa8U3yiY+bLH/+bkmBEFZdC8ENF0a8gEAPbLWqAcavsyk+pY6NQ4KAFNKi7LJxNZ5M1PpQ
	852Yv1yAPBGLSBwg7e7dmP/XJpR9e6p9b6IOUGVLIvUMXubJy+7QW6+XDfpzSIHnnFPpUJmQ1BgXh
	g/lpS8LumLRSWP0HKlPv2cPuwpnH8e/rnzo1ELm532ze7qM1G0AuicZ/V3CGS4vyfdAhyo2bEbaAU
	+JSU/KIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAbz7-0000000114M-2gOW;
	Wed, 08 Apr 2026 23:06:58 +0000
Date: Thu, 9 Apr 2026 00:06:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: KCSAN: data-race in path_lookupat / vfs_rename
Message-ID: <20260408230657.GL3836593@ZenIV>
References: <61ff6def.2d0d.19cdad1307e.Coremail.luckd0g@163.com>
 <20260408230422.GK3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408230422.GK3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 09, 2026 at 12:04:22AM +0100, Al Viro wrote:
> manage to depend upon the order of execution, compiler in question
> needs to be tarred, feathered and shoved up the place where its
> authors heads are.  Sure, theoretically A could be compiled into
> 	lock
sorry, cut'n'paste from the wrong place; should be
	x |= 1;
	x ^= 2;
 	x ^= 2;
> 	unlock
> but who the hell would do something like that?
