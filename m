Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FC38550E;
	Wed, 22 Jul 2026 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712171; cv=none; b=l4X917L1GPkpIAAB7V2TQCD5gg4nnn5hkZ9wlfzk8yelv7l2qnah/OQltrQNNInb65wZPJHE71DuhutK/Xe23vWnIzvWyoALN8qRchiiGeYAd2taMwSzWoKqUOgM4GGjhqvLOKPVZhHmRfTN9itCbWTNWEu8nj8FWCt2+103occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712171; c=relaxed/simple;
	bh=zf27/xKAU0Ly4z78SR4zKhEN3wUkaUJ3TFHdjq7VTqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKXoqizC8HVvWuLKdF5izY1gN8IZxJeQ2nY2ncoZr+p+HM/DfwdmUD6enUuSakLa59ghIjozVmnhr20we0/dVfrzhoL2yjf20+cPozLMrO2w3Ctot7TsWniDuHOXTiD742oQ31cXhmoLEMvnJNiSC2m/FwUZh0qTshrxru5hHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTD2d9RU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTD2d9RU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4991F000E9;
	Wed, 22 Jul 2026 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784712169;
	bh=EcOvp3Q7nAVDBqppT5EzGjlWjNXlbf5zPRu2eNQMmu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WTD2d9RU57iUS8LpjnPBrdl3FBEr5G7woZF2P4oRfbNKzW9qzxuBnOjn5pcQGqboy
	 DbdVnN1Si8tZ8Zv6UkYvjahJcjDOZ2zb+R5m6Mz5MKqRJN8gIIdWUpDslGuECAPTEn
	 11VzcyXV/HeF/Rd+aglHSE1suw2pE+/o3pdNiz7DwbBLQEUKMy9PGKRwVVljRJdjlm
	 r+pDVEEvwvfEzJzPdiwzWKw208YFL1wqrqD202v8xN1ZQ0izLdtap1OgMsRFzCJ9q2
	 +SNCOzbVOrUzgrE9WWayF49+5V2lBPx3/M+5SIqU+S22qSOjqT8v5kJ7RvZ1/3AVGS
	 Vp0LZuOTcxfiA==
Date: Wed, 22 Jul 2026 11:22:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ze Tan <tanze@kylinos.cn>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: Use READ_ONCE() for d_flags in
 __follow_mount_rcu()
Message-ID: <20260722-habicht-heizperiode-geglaubt-5623b5193536@brauner>
References: <20260715125102.1051791-1-tanze@kylinos.cn>
 <76kfuey4pj2af3zwzbo7a3i63ooxhvzpc5q6k3iyl7mhhfszsa@6vhknryplnto>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76kfuey4pj2af3zwzbo7a3i63ooxhvzpc5q6k3iyl7mhhfszsa@6vhknryplnto>

On Wed, Jul 15, 2026 at 05:51:45PM +0200, Jan Kara wrote:
> On Wed 15-07-26 20:50:57, Ze Tan wrote:
> > __follow_mount_rcu() reads dentry->d_flags without holding d_lock.
> > 
> > Use READ_ONCE() for these reads to make the lockless access clear.
> > 
> > Signed-off-by: Ze Tan <tanze@kylinos.cn>
> 
> Hum, so we are somewhat sloppy with the access to d_flags. Strictly
> speaking we should be using WRITE_ONCE when updating them (and we do in
> some places but not in others) and READ_ONCE when accessing them. OTOH the
> only practical problem is KCSAN complaining, the problems that the compiler
> could somehow tear stores to the d_flags are IMHO theoretical.
> 
> Having two accesses without READ_ONCE more or less doesn't really matter in
> my opinion. Cleaning up all the d_flags accesses would make some sense but
> I'm not sure it's worth the churn for mostly theoretical issues (I believe
> Al or Christian was against it if my memory serves well).

I don't care for the churn but personally I wouldn't oppose the change.
