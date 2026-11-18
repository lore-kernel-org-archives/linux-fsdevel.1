Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005508;
	b=WHTHSQamc0WYQUmf3vonGONiJRQNHc3esc6z4OELyI54wrN+R89Jllrq3d3NOfmM3/1g
	 5b6WjaF3PCrGJoh5xw6jKrdpsm6FJevU3fsYw5pna5rj2MAL82ZAYeg+9dpFLJBXNcaOV
	 cJCrKJFXbMy7k9HfKznODR8b6iK37mSLsRIEOy7v2NrACSfp3N86HgdptPY7nPskOh+oX
	 Q7icAdsh50KrEYLAkhuJZO8k2ZKNwQ8VV5GrqlHM286T50xOlQI/cuOoLbQS0lcQ+1zlF
	 yacpX/TQJhRSCsiQ6W0k0K+nLi7M7HoHvLq5Rv+xEnS5A2a7ATo+T5XlR6tMhjmiz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005508;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ho58HpP74KkSdDCOgNJUu23o5pb48Elc8GwOWNOyHd8=;
	b=XsJw24bN4vZH0bqpF6PlexXP4N82GQS5X47BlhOw4SXg7LwioxBa3wNYQ9Ep6pL8HhCd
	 o2DaktntEUIpswrZzKQmpQICVGWSLDIKr2wexm0u3JdnZqLK0euZ7zHwXu45vzmk+mEQ9
	 DzoiwKK6mjNSjW3cKokL8/soAEB/r41c5zTMFvklcfxn1UgmElxJwhzYsd1JekS81Tlyq
	 fJEs392NOt1DOPbzhU/tHglr956XyPokD7c3DFag6Nxtqb2l0T+4zCsykmLZA0YsNLnAJ
	 5EBNyxLOiuEXUZCAfrySJpixGBPN1buZjYFRRBMe6zBcRKzV5c8DgPKOc4SlSuepjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJwcMEIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EE606A31C;
	Wed, 18 Nov 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJwcMEIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEBC1F000C4;
	Wed, 18 Nov 2026 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005507;
	bh=Ho58HpP74KkSdDCOgNJUu23o5pb48Elc8GwOWNOyHd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DJwcMEIZi5PRrYcC28h2f1l5Gx3Ui4dojk3/EfALG1iTKRgWJz0SIknEqF4mnL7v8
	 6Q44/kJr+AnJoC6/Ai9Sn+EgRvAP09cmWmkilTb89di0Ncm35lSr9ASxygQ7CPO2r+
	 SQLhQYvKSYciciJYUAfwQeyHcBUxsEDxaAObObCULkSnJv+Fs/kOZt424lphMFo/lj
	 N3v0Ub9AK99XeOny2LykqCd4nIghvo1LljQcjK2p7JQG5UXNTSD0X0Iq+oSwRjZ2SN
	 C6sG2ZBV5ixmg8UOW2d/Sq8bxL4Q69zwLwCtFcfzHVlxIJbCbjHTnD3zVFxwgosRXM
	 Q/X/Hl5jW/BAA==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz, Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112015047.114119-1-zhujun2@cmss.chinamobile.com>
References: <20261112015047.114119-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] buffer: Annotate the remote buffer LRU occupancy
 check
Message-Id: <20261118-hoffen-fenchel-helikopter-61c9226b83c0@brauner>
Date: Wed, 18 Nov 2026 13:38:24 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Thu, 12 Nov 2026 09:50:47 +0800, Zhu Jun wrote:
> has_bh_in_lru() reads another CPU's buffer LRU while that CPU may install
> or invalidate entries. The local BH LRU lock does not serialize this
> remote occupancy check, which KCSAN reports as a data race.
> 
> The check only decides whether to send a drain IPI and never dereferences
> the sampled pointer. Mark the occupancy check as an intentional data
> race with data_race().
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] buffer: Annotate the remote buffer LRU occupancy check
      https://git.kernel.org/vfs/vfs/c/d72eb13a6fee

