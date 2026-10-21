Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577234;
	b=iVLc31gwpaRR+UkddnAVS1srcH5LjMrpmsf8440OCmUY9xudeUPQrHkHSSMzP7eb1yKP
	 jjIgdCk4+WRoSwe7+wdjjC6li8BsTyIs0lvEqyYYEtDGjP1P/bOWV1UCCnONf5GZk2e9P
	 H8sE8gosBHqFyq/sidkvaQbwrYFDmmSwSrisLust4NXoGoX4+lvJMG+nqT4J54xnXr7JM
	 xC33jx+OVD//2meq0NyuOKnTSjvey1yov1jyFgI0Oo15HRCbh43N9DJu0jtqLNhdsMzTS
	 IB5K0S7YC76lVYlZ8ANWIbtAGoW40FZU0ooFD5wHkDCWhP7JQ8YfBJmP13Wy2QqMDXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577234;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Fk9BUgVP3kFs8DaV6RE1g5NRNic25h7mvyC2Ggzh2Ms=;
	b=Asc2szViPzzIkLsO4DZN7dIXDcAyqzV/VyEsQ1OGWtBApPN5hzSDeZb6cpoY03Ugr5KG
	 C49mfmnoLBvWplHhsCdMavpIQKcHBPv2PJBS1ZdbRRqcrvgkGd3WBWXyJR9mCku9xCu3R
	 PGMWNSIwsCNV0DQDnGKnaZv6JFpI5z4Yj9zofd20DSxGSUBNTgmRqodoSZAG3Vd2NqU5W
	 3RmpQZtcPw/QCmI0JKmsOUSe/NltO6yCguqBN8XEx+HODYmoORztw8ELONUDk/c2ER+H4
	 NdVtF84fdr+2AZxnlQpLIGVPfngGApbd0AkdDTxqtVmzz7A9lch/pdCV2nz06CslvBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2gaiVid;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05C606A321;
	Wed, 21 Oct 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2gaiVid
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EDF1F000D0;
	Wed, 21 Oct 2026 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577233;
	bh=Fk9BUgVP3kFs8DaV6RE1g5NRNic25h7mvyC2Ggzh2Ms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T2gaiVidMkdJYfFZMzgA0HSwLCLUxR+CmrFY5tBi3INv/m8BgcZfhEZ75oNOpiO1K
	 BMe0pHXTtQlWZnAQp8FJfJb6Kasy+VDEbXDsWf/njZqHL831nsin6gZl0FOrZot4eW
	 /c5qnNXx+phD4OgxDAFFQF8mERyQc7Oednop6Mz2W4uhw21mwZb7oeIV0YMZjH7/gk
	 6GB3cDYdbaTZxae9h1HfE7ChT86Ny5kab5LoDJKthSdHAOv7FBg0reGFfkbiHCyP29
	 24oTIhrh+Q9zTEUayK8lffXu8hv38h7Cipv+mDwuZSDqoB/jc7CeUf6I0UP2of6yDG
	 1dkx200fytxFQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Hungyu Lin <dennylin0707@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Joel Granados <joel.granados@kernel.org>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261020152857.48989-1-dennylin0707@gmail.com>
References: <20261020152857.48989-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] pipe: reject oversized pipe-max-size sysctl writes
Message-Id: <20261021-hemmen-puten-annonce-fd4c4f71c8b3@brauner>
Date: Wed, 21 Oct 2026 12:07:08 +0200
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
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HCLVhoCs/ougNunOEXYScB4Ue6L47tWUWzfXCm/Hyvg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd6DvLfWC6YpXIO22T5xbz/u8V/izZvcLZ9djKi2+nb
 Uy8prHlYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEVk1jZJiybCP/0vVn5HJW
 mXKkFl6+9XKH7+pXlv84j05cmfTh2/l1jAyHwo7/FOiSvJP0eOrBmudNciXnPhe+rPtmdfHHPs0
 6iX5+AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 20 Oct 2026 15:28:57 +0000, Hungyu Lin wrote:
> pipe: reject oversized pipe-max-size sysctl writes

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

[1/1] pipe: reject oversized pipe-max-size sysctl writes
      https://git.kernel.org/vfs/vfs/c/823a9699a475

