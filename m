Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100131B131;
	Mon,  3 Aug 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781987; cv=none; b=QblT8uvH9EJQGkpBUYObOTUR4o/EavNSsNn3kGI/z6IV6op3cWCAG/lrsp8u6lAoDT1ePoLP8Qta4EgUkdnNYYmkL8sK6+AT0EU5UOWFi1Jnk37QbqEnibhOc+dGHvomvjtV371zkurPuRIfL1KLnhgS9TiBgnFIt5CBUhUEfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781987; c=relaxed/simple;
	bh=g/4U5+yWKOXTchWUOK/o8+Qskb+qtoUb94h9uMG6d/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MdZmoHz76ZLw5H9R9TZcvqtC2g8OZI5lXybrL2s30wKIGMvxrhf+pDjFU85FPWq1xYCNn07iZUmgUUH9+J907rqbNeviVyvd/MFp8W6o8Y6XF5UZdMcgeZWysRLUNtqS+XW2LbIUNRYg3PbC7iGAIGpUyqQ8iZraqmZBx8RSECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJvBGuyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJvBGuyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502801F000E9;
	Mon,  3 Aug 2026 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781985;
	bh=cikCkmDxa6cXYcyZ62/+LzkFni9DDwJmQwC1Z7pkwR4=;
	h=Date:From:To:Cc:Subject;
	b=hJvBGuyXuW2AM+8P8A9jDULsqfaIy7TeqkHlB1KfKkSTp4TIcg6UgHmcD07Jx+Wgt
	 tHqzYU+RSJWUe0TG6wIBMCZK33yQ2rr87j2ElU8ezV9B1iMKNVx0A+S0FKVgRObp60
	 5eWHWjwGKQ8grJ8Nlg8y9zshAckowzrCGO/JljiBi+BJCtONElmGo5TXReAhiKhrC1
	 +lqZMW4fzKQ6YiHBzh3gS8s8vZqiZeZpSz9u546BSDVZq6kgvkhjugJTH/zMSoP4lU
	 EBHAonTRy3obWhlUJvRts6NmL7gv/5Jj5VwHqSmBCQZaEJG0E7fh0yYlHh+kQJrjgP
	 WFcbL0fBUVhGA==
Date: Mon, 3 Aug 2026 11:33:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] fsverity fix for v7.2-rc7
Message-ID: <20260803183304.GB2062@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to d2f96bcb89d36d488a10e3bcf819b98536968286:

  fs,fsverity: remove check for fsverity being enabled in setattr_prepare() (2026-07-28 21:25:03 -0700)

----------------------------------------------------------------

Fix a regression where truncating a file with fsverity enabled started
being allowed on kernels without fsverity support.

----------------------------------------------------------------
Andrey Albershteyn (1):
      fs,fsverity: remove check for fsverity being enabled in setattr_prepare()

 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
