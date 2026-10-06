Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9438378828
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284937; cv=none; b=Z1IQskubwgnwE3YB2wJHNZvjsEvLQDsF0pjlzFPG/Ye5q/wsfUrXWKXG7jnKZNaC/Ew2q3Q7BnpS0BaMDJ7IZcFgePTSonCB6JgDC3tM/Te/PSBJ8X6Da2jHnL3zwMtOcUsmR/5/SRTy6mAJRi294wdw4iZ6rjto0s1yvOFLtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284937; c=relaxed/simple;
	bh=9jg34RBP8r6739oTXOAoMXrDYAzazoznzOEcMAKk+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPq7HOYae3CJfygExFEgxKBzByGehgLy0HM6pZr+XHJmtxBatCAQZWK/vto7HairqhSvjWGzaV5ozXiFJwK7tXLl8i/TSzk6Wy0OlSNHXuzY7Ct6G46Dv/VITnBGr9mU5IwLLyfNbTyPr/vVllMK7xtg0B++YNyW3/kASMz8+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWMnneOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWMnneOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB561F000FF;
	Tue,  6 Oct 2026 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791284936;
	bh=tSNqM6h7qiHQET5ED0aWKUs++ILk2Spx6my3posENKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWMnneOnjGocILa3F9LOddA3AGGnfF72b2Uaif+jU8cltM4XGhjATU+OjtAwm6e1b
	 svTy1x6SP3bf5bFMsuzJXa+OSoxH2SuVoaA9wApnHQ5TLLXkOzoZJo/s0Ax/Pfc/5v
	 TXYTddiiL39SmD7VhwNjCVqQPmuDDpCCHzFCjHyr4Dbm5VPArGpWIpgK6fx+RdTk+h
	 9vZLdi5o+r7PLtl5lUuXgcxuD1kJemWnaax51orWiA4+tW/WUc8dgyhsJullSLDx6X
	 PbhOFZxIfDWlKYpxAEaLVf+nu95ldWuilB6N7pcu346kbxy7ajb6gu8DkkyqCCtjej
	 RIF9maJDJ1h4w==
Date: Tue, 6 Oct 2026 13:08:50 +0200
From: Gao Xiang <xiang@kernel.org>
To: brauner@kernel.org
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>, linux-erofs@lists.ozlabs.org,
	xiang@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	viro@zeniv.linux.org.uk, jack@suse.cz, hch@infradead.org
Subject: Re: [PATCH v7 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <asTWwqqx8RQfD9r7@MacBookPro>
Mail-Followup-To: brauner@kernel.org,
	Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	viro@zeniv.linux.org.uk, jack@suse.cz, hch@infradead.org
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
 <20261002163225.1258203-2-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002163225.1258203-2-giuseppe@scrivano.org>

Hi Christian,

On Fri, Oct 02, 2026 at 06:31:43PM +0200, Giuseppe Scrivano wrote:
> Rename and export it so filesystems that need a custom superblock
> matching policy can reuse it directly instead of open-coding sget_fc()
> + fill_super().  No functional change.
> 
> This is a preparatory fix for the next patch.
> 
> Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>

Could you replace the previous patch in
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.4.shared.super

with this version?

It addresses Christoph's previous review, I could pick up the
updated branch then:
https://lore.kernel.org/r/arY9FCatWwCw418K@infradead.org

Thanks for Christoph and Jan's review here again!

Thanks,
Gao Xiang

