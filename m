Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579148;
	b=hIs2du58GrOJNZloODnuPcGwCU5x6ZU87w8riFMLagXi8Cm8xgeAE5L9j0H13KO7nl4H
	 BebZD+ySbNrI1xzF+fKO4Cu1fr2pNPZSQyP1Ma98OLHqcQ93G0AqN5wGPEWgVnbuglIGS
	 OKKYvmKMCBfe2w3QgmDBj2NfxsdDS2deQXdIvfgcipIIWAqcVAv0qPPShgfaRz3tvgIJ+
	 5IJyC3QRJf1gE0A1mXTx/CPVtJcuafkTqEg3KQfzwlP6CqN9C0rdWX7Fmdy1h4WCzbvqG
	 TSkxagqun48awibp2HH37H6tm8hrxD/pqoya3Dlm+p2u63QcczCLfUq2Qmjibx2nJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579148;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qzItkW3qABLkgzSm8HT/u5rwEuJC8InOKPTtRdx/4EA=;
	b=nGR2I513wjCjiTbIUuwHeU0wz4/slTitChe82PMOTdRCYuXzSlZcn6IVVjY/9QVllE4+
	 zaIBOEabqQFxHUzt7Xwtk9FsHEq+UcHlLmNb7ZQFrXt/tYLgIRTLByuMTBC2ATL0Iqs31
	 fb4vOrq4xGjHq72B1DMqvd217nAWII1RNXTZ17Z+wYaqDl9yoxKvOOk7dxcmXCk+RTTuq
	 ACFr87OJEZ2GbpQDM2hh+sM/fO8AlObxcpNyRgskRt84Vr5WtWH48ZOar7T5lO3mtlzVe
	 xbNe2EwPXfFYB5z4wyugGt4/Kj1qR964+pJHQ7k/aMcrEf/lD24Con8j29EvkN4bE5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYadNbUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED655606A31D;
	Wed, 21 Oct 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYadNbUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD331F000C9;
	Wed, 21 Oct 2026 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579147;
	bh=qzItkW3qABLkgzSm8HT/u5rwEuJC8InOKPTtRdx/4EA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IYadNbUfuvxSgYhhs1tHWzyjFPapOQuz9tPUamdSDBzA/fyp5x+JRkNdp7GcjGeTI
	 tKWWDkiQjMcNJ7mStaOx9U4n/aahL4Qih71SyhJAKlUnIi/rvdD9N4luo1xbFdIJLK
	 lYy+LT8c9D8JBBPeckcaD64DtpHdKqfoHtJkhv0XwQX5oUwH5FxdjJUD5FVUCxjUh1
	 e63v36xC1rw7oSthqxLHvEDADAtkSNgQMvjvTOUDINTYIU1nMw465PH6w5Xkm1KbyM
	 +hi+gYFl2pPHO7pJUsUOxtQuC7GygsKMg6au9FInK/cGyl3gBZd2TN6muuPN/C6iln
	 qEEo9Q1qhJeuQ==
From: Christian Brauner <brauner@kernel.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261018030342.799383-1-nickolai@csail.mit.edu>
References: <20261018030342.799383-1-nickolai@csail.mit.edu>
Subject: Re: [PATCH v1] nsfs: check the trailing bytes of a file handle in
 bytes, not words
Message-Id: <20261021-minigolf-lockruf-kosmisch-8a8fa236dd46@brauner>
Date: Wed, 21 Oct 2026 12:39:01 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M4CebLiLHCP85ip2GP1nTAk22k7weh7LAglnHUwF6pA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmOYRuy1oysOkOL1jGX/XOaatjQ7tV2FyYVv5w2TR9
 JuPN5oHdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkFj/D/9zDh53r+s+f/sHr
 Xrqw773xL9/umQxyu402/5o8bfaHnHcM/1Nn8p2I+cvAtO7i6Yvx7wW1NwT9bLwysXFCtum5wmv
 LJ3ECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 17 Oct 2026 23:03:41 -0400, Nickolai Zeldovich wrote:
> nsfs: check the trailing bytes of a file handle in bytes, not words

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

[1/1] nsfs: check the trailing bytes of a file handle in bytes, not words
      https://git.kernel.org/vfs/vfs/c/08a7d685fc61

