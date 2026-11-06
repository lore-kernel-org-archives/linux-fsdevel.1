Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956925;
	b=jWpp5ugImvCAGRqJVZjvL2PWHaAoeXba6BsbaSgdRog6Ha28/ajMxh8El7RlD63PwILz
	 e/7jLM/1RnrffcP6LCB3/x6Yw1b9EFytU+ctjMFAStiqcfJiKZmE46i1t1kWLIh+HSVBn
	 usKpavb+D7ju9s+Ug9lGtz0A9aSZdb5kcqdiwOUhiHH3r6B9EcEneJeQMFnOlt36pq6Af
	 3sAMH1RMzSA4JAPV8SKyrCwq+6PypmfyFn2tOVwHs6bd2k7P91o+AnGqNRss9VPbFHVeV
	 S4Q4IbSl4pnlXYMOkyl29L57j8bQICrKB80TZGyFQQsh1d0uy8Mg2I7wRU22VD1D6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956925;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TmTInOdBW2S88oUds34DqgFhVrod/eStkNJs0WetGwk=;
	b=3NsZyZj4lE/y99tad5FeWDqsPR0EKkTYNWayum/JGn4r/XX/Pbqfy1XpxESHzFN6gIoA
	 ZU932Wa8wbllopdSRanghGGdsxN1CmpIiTk7OmhFR6pJ5lMG4EPZqQ59Jr98BcPi+MUys
	 F9ZEbFdQ8nxIxXiB3XcGpg5lU15s3nBiUpYc03Gi8xG6wEa+DxQCXv1dNwviw0S9wZ84m
	 Swq02BezPm6cYRiyaDPW31BBALHQDZvfd/kX5zf0LzdtUL8FJ/wChipWVwNr9PVQHLewQ
	 94XMJU9fK87zbll1kHBf95Ay7qolPqToet9dAsghf2KcXlh3nnlAxDB5atoG4GeS+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5HHW2pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318D606A32C;
	Fri,  6 Nov 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5HHW2pU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651F1F008A1;
	Fri,  6 Nov 2026 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956925;
	bh=TmTInOdBW2S88oUds34DqgFhVrod/eStkNJs0WetGwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H5HHW2pUxekXofpc6Fv4C5hcrSkxXSFsMYSAh7S8prSqKcDY4UeSSs1fPx2A+rMWo
	 2i+g9Y5nH+1A0lxynudwpu9KBFzfFvWgbnL/1xym2fOm8xXqZbflTD9WRvB0KncBaU
	 /88dluHXESNwx4+O2LU6jqhpsHs96Xk3clE+2WqPYHI1x5A8n8iDYnYJ9MEYMyqGRy
	 jxjdzT4yYA51JDM1q0sC9m7gno5W/7JuBhXtLfxbnJ5nkvQDy5DvmUknn3YG+rVZX+
	 UCf19B+QkVXPNf5ZLSAqJ0hCsKdqWC4c7VKj7W6NejuqIzfFNMukmexSMeNmCrdGop
	 0AIHXmbeQ/hXQ==
Date: Fri, 6 Nov 2026 10:22:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [Bug report] qnx6: unvalidated di_filelevels in an inode drives
 a shift-out-of-bounds in qnx6_block_map() - UBSAN panic at first read
Message-ID: <20261106-einstellen-herzmuskel-behaupten-26599d61136d@brauner>
References: <tencent_6946E1A60E7EAF8C6439BD988E45D5F9580A@qq.com>
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
In-Reply-To: <tencent_6946E1A60E7EAF8C6439BD988E45D5F9580A@qq.com>

On Sat, Oct 31, 2026 at 09:00:00PM +0800, Guikun Yang wrote:
> A natural fix is to reject the inode in qnx6_iget() when di_filelevels
> exceeds what ptrbits allows, and to tighten the superblock check to the
> same bound. QNX6_PTR_MAX_LEVELS alone is not sufficient for small block
> sizes: with ptrbits = 7 the usable maximum is 31 / 7 = 4. Happy to test a
> patch.

Please send a patch. qnx6 is orphaned and reports for orphaned or badly
maintained filesystems have low priority. Patches don't.
