Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411519;
	b=L01uXQs4ir4EqjfW9lgpHZ0EgYlGPw2VGO0g6zftYvkftWcOFxv0bigOyo6SGcqNF9fJ
	 qpSsQZnC5VDPRu0Q6X4RxlRlmCRKi+cBG3VP20uZOkXPLTjfibRmelHoRC0gRxisLn5zv
	 zOeDPaZnljKaaafNAfye+FR4kp72r3JSwar05hyA9YlR0gWofjIOxweXD0FyMdARQZVdT
	 wA5Alvl4wjDmIfqmy+L2PMLdS/uUwDRJtPLRrH4RwP2egcTt8Np1d9T9cmv8Ah45L6sin
	 QfB39hZ27TWH5ViH2JeDNEwwH0qF2fxy22lqLiXfbnaa2/+wI27+yyMyTHTKCc+MsLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411519;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OjNIO132rg1N7+2zU0Ea30iAk9RpP8+97ayP9nZbNG8=;
	b=S/OJfmU/F8hM70ok/nwmPZx6UcbofRDFTjuYXx+OD/xRFFFwHzZ2qZbz6ULtQtUDOIEs
	 LVOYahUiYEpxh6HrFSZRgVpGmcO0PLfcf5kaU0AmE9kTfxX5mzCsyleTXQbncv3ZEeAI9
	 2+mHaJgbCOyGdEWBljsbGLHLUmy772phOMaCnS8jhJCKeIGgQ/m9Jk+AAyzFJmr1Lok2d
	 t12Sc3iBBnuE0kY3lV4pYwbSRY6tWLVmKVjYpYlF5JQnvF5UPcM5xvHu4n6K5IftUHym1
	 Qur8ICRXdmIUz2ggpn4UuD91thVp63kgLCNHwdnDhTSJhqGgmQhiufyULkHk0HNVt4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjkdJhuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E799606A32E;
	Wed, 11 Nov 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjkdJhuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4761F00A05;
	Wed, 11 Nov 2026 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411519;
	bh=OjNIO132rg1N7+2zU0Ea30iAk9RpP8+97ayP9nZbNG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kjkdJhuD2jrcgJquRpoV8eOkDlu9VLKHWrHaR1BuL86oYyOd6LvQrpUlkB8Rjspm9
	 kLRqMtha3zYxTAUUrkOB0fRmYoENIQ84yNTnijoMRQWPuCWlKcC8n6tfHtucUwQnrT
	 V6OZMh4O3AmfSQ481Hd8YkU8xou53lBprdIVUeC/z9WNZ1+dNaRdYCfv7DAwzagjzW
	 CrOsmtgzZkt64ELJ41GvcvnHNGUbvnhWuKpz1t/RlGeEmi+DfehH7+nCs1WZqI5DhZ
	 RIaHVrH0EQyCYmZiw6M/PYU1woKaaGJjJeTd1Aa+QhFRaRqXazoo98jjHviWDqAE2t
	 RxWv43DbGzJcA==
Date: Wed, 11 Nov 2026 16:38:35 +0100
From: Andrey Albershteyn <aalbersh@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH] fs: constify inode argument of inode_state_read_once()
Message-ID: <avSLyvC7nuCkc15s@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261111100148.3665035-2-aalbersh@kernel.org>
 <20261111152054.GA12397@lst.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111152054.GA12397@lst.de>

On 2026-11-11 16:20:54, Christoph Hellwig wrote:
> On Wed, Nov 11, 2026 at 11:01:49AM +0100, Andrey Albershteyn wrote:
> > Constify inode parameter so that callers can pass const inode. Callers
> > do not need a change.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

> 
> > Notes:
> >     I will have a user with const inode in fsverity
> >     https://lore.kernel.org/fsverity/20261105115532.613467-3-aalbersh@kernel.org/
> 
> You probably want to include this patch in that series to reduce
> the amount of dependency tracking you have to do..

Yeah, make sense, I will include it as a part of the series then

-- 
- Andrey
