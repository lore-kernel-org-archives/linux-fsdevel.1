Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955079;
	b=elCI29rtrQSnpdpxqfgDnIslaoX+Rf0RQGMXMxX1M5RLn6/zt1flgTgWujLQM4mW1E3R
	 bgNSklHqPxFWqR0EMR0G6uz6UW7qYNY+jjwCBYvDcNyG74/li8+YhtSiw9657R6U0qSSz
	 LrjY9r/tT1eblyPdyAbjpg84/TgvnB6rLOrM9Ut57ww0MN1s4JqozDRojnPu04MHGWASg
	 jOAf/RYR29YGEIMWAltNEKat+kIZTenQaxr3nPR3sygj/GFURCIikGOToSI/sAzTjWL0k
	 GXIrRcz0ZjvS4EXM8urgAI1XKIzse/F4DljLO6KZ5W87fWP0WmsYFYr2qBy0CNccOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955079;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bxv1AXtY27SokZ7Ue1zSEVKHZv/rz6ZdN6nwwoZjaXI=;
	b=F1W1D3RKjwr3iFuDBY8vNSrEc2APcHkCBkQfMQ6zwhzbo9IUUdslhsU8BoKv1wbnV+P8
	 mJt4jxwnGAxZGtQi6vKAxpr3CppT23AHJfOaUIBApluTOXdCbdCAVKGtatdTwitHv2Gfl
	 wBGqOKrTKR7rW1eptoMboBZSAGlUYP7cfofUsDpIFnReXBKduf2VV2SRl/uWobdH/2ZXp
	 lKu9VTS4k1kfTbz3bdPB8qKAUtj+w+kve9orUJroVfcncERZ+KIWo/ifiGD42J4PWwdRC
	 wzZbI9rOTLk174YhbsRc2qqDZg6OuNnoY3fptH+YcAmK6TttuMlh0T2zADCNEdkdptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QDk1+/KU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C8606A33C;
	Fri,  6 Nov 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDk1+/KU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742EA1F0089F;
	Fri,  6 Nov 2026 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955078;
	bh=bxv1AXtY27SokZ7Ue1zSEVKHZv/rz6ZdN6nwwoZjaXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QDk1+/KUIdpy0YCd0c8uSYogw44PsyHaKS7Jhn+aSkx2F0eFHa83kOCps0YiN41k1
	 hWSInLT9hJpgyfhOOaXEIDFp6kEgs6sb/luqdqNz9eosCWVxanuxaxGgwxMVAVRlsf
	 Md+fvmpjdzcpzHkalt7whpIWntGjvRpbCwj89RJUCgkqZf6eKZDpWIuMrcLDWknEcH
	 xhDikzqLGvfYTTT8dZlqIu0DDLuBqybK7WmT2V/60fbIy9KyrTpsHClF6m0BemtthX
	 wNJUR1eV5TXIAGv3PEgpiiNVDG6M9Yp1GQYQoKqXM/yMJGsHLT0YIp4S9eOOiXlL7l
	 tQcTrssTACBtQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: kernel test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261103025322.2549225-1-rdunlap@infradead.org>
References: <20261103025322.2549225-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] fs: porting.rst: use literal string to avoid
 warning
Message-Id: <20261106-baubeginn-pinkfarben-einschalten-15d8963cef55@brauner>
Date: Fri, 06 Nov 2026 09:51:14 +0100
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

On Mon, 02 Nov 2026 18:53:22 -0800, Randy Dunlap wrote:
> Avoid the docutils warning:
> 
> Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis start-string without end-string. [docutils]
> 
> by quoting the const pointer in literal quotation marks.
> (Adding a space between the '*' and the '.' also works but it looks odd.)
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

[1/1] fs: porting.rst: use literal string to avoid warning
      https://git.kernel.org/vfs/vfs/c/daac2c45354d

