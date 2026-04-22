Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E183EBF01;
	Wed, 22 Apr 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868235; cv=none; b=Wd8Mck8hs7sChcaFrsd885fuFPY6hJjCirITOhLQYOvevj9hV7oNVX8Y4kHR3a4/bynSmiwwrcXC+MRunW0V/Xq5xb06BFNHc6d3fKnp2F4VQ44d9VF+9rMHPNbAgKdcZH3pK7nqnFKu5tynIFN+yH+rYHKEYaHSKzhyE/bxDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868235; c=relaxed/simple;
	bh=6+hkK4dELGRl7N/ynlWhhxFfAPU2T2jlVJQo1lZVYrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk6jt0Z/CzezYbkU4rbUIwwB9oxuSAPQ92Xeh2t7zCPRkL3GZYL65rCHvDYosUpIFi/fmg4PKhHfRgtw5KIQP2f1h69RDx6NutK19KG0ONLJ4c0wVM/UOYc3T39ZuRS0xbvg1CZc74QsiSu6DuYjtylz3mgeDbv8cKnbSGhIKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kKPwfiAR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kKPwfiAR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G6d/iTV4Ks6K6raHYP6aGnGGem0iUyqT81rwrNmh+9k=; b=kKPwfiARJk/NlxqJwtlLEGrJ/t
	aLAJGqRCsNDj+eccZNBaOattsKDHkbx0jk9fXiZfPBBAE1aHj80GVWyTXvzBOPls5HeBY4F0kezT5
	SWdUBgT3pk3d2KvVDxY2RpfituzDRrLsVb32cM7yeMkDaOWtGSANbEfVlcs8os3/EWX//NnWxRV3R
	FLV2ixt0+p6lc0vCTFcLi8+kOpwwGrwinYKOozRr5yjYYS/chA+VlzDM9vLodpj5l9jy57PFAUIOp
	q1Qz+COKuJrHYl6PfCopbAvi1hGSaXKeXYdvyVEFDRh6l2PfJFLNCgugNQWTyodbMB73+QWSXRjpJ
	4FNWFzLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFYez-00000006B75-0r5E;
	Wed, 22 Apr 2026 14:34:37 +0000
Date: Wed, 22 Apr 2026 15:34:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Message-ID: <20260422143437.GI3518998@ZenIV>
References: <20260422123345.100436-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422123345.100436-2-thorsten.blum@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 22, 2026 at 02:33:46PM +0200, Thorsten Blum wrote:
> Drop the hard-coded length arguments and use the simpler QSTR().

... which is not a constant expression.  NAK.

QSTR_INIT() is an initializer list for struct qstr; QSTR() is a
compound literal for the same.  IOW, its value is an anonymous
local variable with given contents.

C grammar allows both
	struct foo x = {.bar = y};
and
	struct foo x = (struct foo){.bar = y};
for auto variables, and compiler is able to figure out that they
are equivalent.  But the second form is not legal for the static-duration
variables.
