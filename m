Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377887;
	b=xDfxDg7TUOg28WNiYZz4MugUNADTnasEWXsAUwpGTU1E2a2q/lLHtk8HRYjuHMRtEkG7
	 8dxFiaOMuAjf1wOcszRip5585/sANt8M+rQu5MC4tLKsfJoIm4VzFf4uy7nzUrG++NltM
	 /rEeKQn+EOd3IsDbrgRBIF3HX7LzrHxqitv0myNAcCZsQWmvrHYwnViQN6mhIyF+2dkGQ
	 gE/rGNyQ0pSXQEsHN+uTqKqdrw49ZH0wL5tPJ3+hgjkBt+MTXcu6ckJomvH7Cry5ExAbm
	 wOemv1OoABt7FSzBtk9HgzTFMwosck3Cr/EA2sFhcSZq7F5xvK6yWQzIrEngVz/4q1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rG0SZOJUD+UDX4BM0N+VO3Xd23YMkjh/ivpV9JyVGdk=;
	b=PDbpP9ouEDGVaVhlVsur811bbODASRdWkni60/3SjPvxE91PP2UbSI6ylRSKEBOK6JmW
	 bUgXCLEYh3fZdCncUGQtNy3rPpZ9Bq6cqT36fE2wlOKdz1IeTyG5xOG692eYFL/uep4Zt
	 2p3hsR4SQy1g3W39erxzQtJOjGu8Oj5K23WF91wJq+NxtFV5aNSaOD0te8gx2CJzeG5li
	 FOrrJ+AB4cSBh/KGM+ZTxw4FtefcYir4e0/noaY0L2b52pBDqfd49xn9VTngolAkM58xB
	 kkHuysmPIshJkCaXbhvtwPXpLECRfRoBr2/1+U/C7lgLf8uSQGw9eFOMcO0bfGCtjDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTYd1YYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D80606A31C;
	Fri, 30 Oct 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTYd1YYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847FD1F00A02;
	Fri, 30 Oct 2026 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377887;
	bh=rG0SZOJUD+UDX4BM0N+VO3Xd23YMkjh/ivpV9JyVGdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jTYd1YYNtdR5crYbqtrNGV6ynmioPL7cvA8FRwauM7ZRs6YYWSeeD9W8fxL4hQkO6
	 i8AkpaTulrzpGX8N6RdKsno0d7tgh7IN7KlBb0VrPqCO7V7az7doav0XOQe31WG4Q6
	 iXlaOeCV3pj62jgjcv+BPVwqtMYRbMGoAEKBBR4XR0q9srVOWJL9yZTaigPZqjPZQx
	 /uXg80aUIjE4Q5WpivMGv4AK+gWupHlFf3WnNdwHeh3XrvrL0xwWlOvj86IkQ/FNrg
	 suW51zYBj+JbUhImzTglJiBc5SyZYuP16NaDbJ+NxANq5ycjJ85bE8FLHsvhJ1mkfC
	 ewvI8GHLaMIew==
Date: Fri, 30 Oct 2026 17:31:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] pipe: bound new-page copies by remaining iterator bytes
Message-ID: <20261030-almosen-kaleidoskop-alpinsport-aa25b8e28d7b@brauner>
References: <20261015085326.340074-1-liqiang01@kylinos.cn>
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
In-Reply-To: <20261015085326.340074-1-liqiang01@kylinos.cn>

On Wed, Oct 15, 2026 at 04:53:26PM +0800, Li Qiang wrote:
> anon_pipe_write() requests PAGE_SIZE bytes even when fewer bytes
> remain in the source iterator. This causes copy_page_from_iter()
> to perform an unnecessary extra iteration after copying all data.

This is an optimization not a fix. copy_page_from_iter() already clamps
to the iterator count, so nothing is copied twice. What you save is one
kmap round trip.
