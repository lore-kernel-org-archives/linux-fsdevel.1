Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973901;
	b=TELyulqFtMXiHN+C8vvJGmnb/YkQk+pvGLF7m6ndvO+pO+zYzgaxVatwb+fn/2gBRKmD
	 5W2C513P/iqBj5jnWMkazA+fFS5tssy1LmMxI2bac7JN8eBkI9z+zA5LDg5FjmtzBPl0Y
	 LMNERcVrBjtyjpYja/fgs39x/4mOOqjmEQQAqwtOZVJcG1+Cz9wR4XznP8btf+/+qcGIa
	 05tmX/b23Kafwo1GjG3jhMZtTV6ctsguk1CdWgnJyBhiCh9MW5YvpnoEndqPgEJkae6iL
	 xk6CPHoED008wTdR0Ql2wDhItylyOyaan/Mlnl6DYUgveD/mhONwdw2Am8Q/Cx07h5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973901;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=BFyh7gp+o016bXpgBZp+EsYFLDasvIFAL9T5pdIp+Ps=;
	b=xJc8hpmJa/g9S6njO76BS5j1WZTM3XPpOfLr8QI8SdCakmvAjDAKzL09dLp6YYU8336u
	 cVT8blKT4msZgSuHkYUVK/i1AF97XGyQrp4qXqz93svDldj27KLcjeL/r4BzglfRV1aWe
	 NcnlzKPpGDpQuNfJIk5aLMs2BuzwGcoZtmjk0oyZBfEaUC/Lu3qRO5+ZjLnZXQimmyEUc
	 ZdxC6R1Y+Oz5oKY3TD1YJHQvDpt0c+FQADnghN5Co+BkGZiDz/Tr+ZMTGWTl0LdwJV2Mp
	 hNtWvfSgRZdy4iiHOcSAeJpMo1vbdd0IkIbSbckOcTiVuJIEjBTBuXgKSRimNnuB6Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfqG7UhS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5892606A337;
	Fri,  6 Nov 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfqG7UhS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCCA1F0089F;
	Fri,  6 Nov 2026 14:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973900;
	bh=BFyh7gp+o016bXpgBZp+EsYFLDasvIFAL9T5pdIp+Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DfqG7UhSV5TRi2BXS5aW56SkpSsQr/WUtWH78JtI3M1ibFWnCWj4xvbxmFph8kNfc
	 U1zj24pZwT4D2rrzLfebx6Dun9lllxN55qA5I3pCUtuQeBWz3aafYle43TMR/kT1RD
	 IF5PYUnGjrz+eevm8nptixY972LM10NBFDU751l3b0/sH/+//t60R0/6KadUyf91IB
	 oiJQ2pECW+58czQZRLcX2Widu9ZK9xDnX18bt6oPvG0ffYXRVAQ4lfwJu9zG/GPE9d
	 VJTnViHrsVooFeUrJovzLgPscT3uYudwdqtjFrDXQAayIa6PZdQ58c+GY2X/F20v1n
	 VMz8CLLFk2owg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Avi Weiss <thnkslprpt@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, 
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261031095922.3577591-2-thnkslprpt@gmail.com>
References: <20261031095922.3577591-2-thnkslprpt@gmail.com>
Subject: Re: [PATCH] splice, net: avoid MSG_MORE when the bvec array fills
Message-Id: <20261106-adjektiv-sachkenntnis-ticken-2977341c9d92@brauner>
Date: Fri, 06 Nov 2026 15:04:56 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Sat, 31 Oct 2026 11:59:23 +0200, Avi Weiss wrote:
> splice_to_socket() leaves tail at the last included pipe buffer when
> its 16-entry bvec array fills. If the requested length exceeds the
> available pipe data, pipe_occupancy() counts that buffer again and sets
> MSG_MORE even though the pipe is empty. Small TCP transfers can then be
> delayed until the cork timeout expires.
> 
> Advance tail before checking the array limit so the occupancy test
> counts only pipe buffers that have not been included in the send.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] splice, net: avoid MSG_MORE when the bvec array fills
      https://git.kernel.org/vfs/vfs/c/8eaa35c6c29a

