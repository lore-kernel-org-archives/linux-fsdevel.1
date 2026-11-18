Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006882;
	b=cutoVI+GcgRe3Wfe7pmWbxcvi/2BtymwNlwjHhSRmc1KzXlr17I0L9vL6Isqpa5ypJjB
	 Pfcko30eR/ylicCkf4wLFRwnPuawBMY3Iu3WELnI0znVbRqhfaBo4HvHWlQlEJgjyillJ
	 cu8J4368d2EJGAdm0WK+S8ihcSEfi71q+UMx+uNqIeJFkow5j6YpDZokkEY16ulYeXkAa
	 DnNLTHqu69TyeY0u35Nc6EpQjiO2Qed6nn3a2lTAuTeQhOdJxt4+DhAPQg31p0rjWERvr
	 HplZDMVbrFXh8IQcj1vQaMsg9be/CDNuJKzVAw1bHWqsSft4sLjhGasBWGD9yYkp2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006882;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=GEpliVII4aS/WvWnXApv5elU2gIs/d0QIGsfAPWqOTw=;
	b=ZyyyNr114l9pTZ7vjKss7QKKXzyhTiSDVGNyjjdgezPjjMS7/21vMuARLp0hM+O+rRlo
	 yoTUiNcJ8Fu13Ep76GMTdY6keC22477qABnAw9SiwgO8RloSF1aKQqo6UGdvUfhXwFJ6a
	 c6xRdu/4xubyhaMP5ZJha6Kbw9R9LPqyI6pJVXoVqk+B+Ix32wC5CZMbaqfEVBWYuvto9
	 Nr+wqJEnGbzDN+zl5QY6BvylFeZ/Fs4yuOdh5b8c3qZbrvwltX1mZP8OMi1a4qPBZVIHR
	 oU8fhPDza+DPoMkTpuLh1My6wSQm7LO8vk6F1jJ0x16TtEvtI8SCavd1RYWa6egpDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1rXnv3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E36606A31C;
	Wed, 18 Nov 2026 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1rXnv3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C231F000C4;
	Wed, 18 Nov 2026 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795006881;
	bh=GEpliVII4aS/WvWnXApv5elU2gIs/d0QIGsfAPWqOTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h1rXnv3aQy3A9JCYxFnQDBpfPZx2ptbKd/E7DSS9E7nPIoCNFyPFRmy2e9qqrVjrK
	 ahOVgk2StRsJL3J/YWQ5I4z34vNGkCaGoI3QJG6kKr2o7NozPAIsG7FU1TAD+y64Kp
	 8eQ31nCgpradkHA7UBErdf7msnfKJC4pYynu8WWYHLIm0VRm+QTHg93DCXeK2nyez/
	 tLjjkMO95dVQ8xpzoFyMEzUR+KH0luDWjGeDQfggMb5Cwq81boIJSCSgYiJF8dVVcs
	 0Pb5K+tW0Ptb6u0/Aw9NZTH0geM26bftRs1wf4r+J/d+W18hLL9pCiNwXwmy4ejfxp
	 FUeByXC/KJS9w==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Kurt Lin <lylin1023@gmail.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Alexey Dobriyan <adobriyan@gmail.com>, 
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>, 
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261113154411.568272-1-lylin1023@gmail.com>
References: <20261113154411.568272-1-lylin1023@gmail.com>
Subject: Re: [PATCH v2] selftests/proc: proc-empty-vm: handle CPUs without
 protection keys
Message-Id: <20261118-ganzseitig-vorkam-unteilbar-1f0ad26e3468@brauner>
Date: Wed, 18 Nov 2026 14:01:17 +0100
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

On Fri, 13 Nov 2026 23:44:11 +0800, Kurt Lin wrote:
> On x86 CPUs without protection keys, pkey_alloc() fails with ENOSPC,
> as documented in pkey_alloc(2). protection_key_support() only expects
> ENOSYS or EINVAL, so the test fails on such machines, e.g. an Intel
> Core i5-7200U:
> 
>   protection_key_support: error: rv -1, errno 28
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

[1/1] selftests/proc: proc-empty-vm: handle CPUs without protection keys
      https://git.kernel.org/vfs/vfs/c/21cd133d5875

