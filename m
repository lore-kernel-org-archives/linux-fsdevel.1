Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B393A5E97;
	Fri, 14 Aug 2026 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713130; cv=none; b=nb+Z/fhCmNNHvRiRe4BGpLBzGJ0Nja67LorAntGmGlgo3hLrWnhC0fy9e+HPuFeFXfWbfrxf8VCQtwKasoF+bkunS42fxgdBOt3q8IOxwlsJaq8CBcScq1YZd6Cub2aC86Cge3RCqKjoCzda+GDZeON1Gn/zgo+UOoZ8oH4kyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713130; c=relaxed/simple;
	bh=3dElseMhm8ubWD6/A2DzmuCzw9trPa2usUj2WrCR9Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXG0uuCCkV60Ma8NblA/dS7sRVcBtZt18tMMHegqg2a7ooRO36gpdbs/Lm4babnw8UZAP5kkYFNjWAKYBi1+zHoAAE0zuXqU0Lp5mr3Q94b4m8+0AkCWyUTedB7TpxjQGZjNOyd8aqVfstzFN4KmLpE7qIbsp7h2Sd93D9wN6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/r1O2P6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/r1O2P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312FA1F000E9;
	Fri, 14 Aug 2026 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713129;
	bh=ngAhBqNHPld1f3GITTTmYtS0uZ4/XL6tVuIrwrDLQW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/r1O2P6GUZA+n/3vH4I7v6cxOA4H9vxHPdPnCZv5CWp0e0petFwKmGOOtI2YqoOe
	 /s2kHar9Fusvt5sdNHYM1nfsqZ66C0jrngyqMLjpsX8wLXFg1XA4xJrlpjX1Op3jPH
	 jmVxCPeFkAufS+xciuOXdTNdPPf2Huqo/2cVhCPzXR4vHfYwS+c/G2PZIypwZWN+t/
	 Ilw8YLjdrbk+oUxYKacKMws0C/akEwoOzgG0aaq/N9trSoyZ+wz2Ny8yUbO2aTUGjM
	 E3ImFSTqfFMvDyJh2NRTYZuhTK05mPg/0PLwkyFMQ7QNPJCSBJUGd/iw3zRX7A4i0f
	 686OzyR98IWwA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/18 for v7.3] vfs fat
Date: Fri, 14 Aug 2026 15:12:03 +0200
Message-ID: <20260814-vfs-7.3-rc1.fat-26a476e80678@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=brauner@kernel.org; h=from:subject:message-id; bh=3dElseMhm8ubWD6/A2DzmuCzw9trPa2usUj2WrCR9Yg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi6jMmNOhc252X7hv9PZFB+wXqbq+2sD+tkdneYxcY weTstvfjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8y2H471kw76v6vCum61+x blN6khvyb5kgY+WEa05Lqvc4b3h+cisjw6PrDXOumbxkVfx6cEnA3DNl12e/FbkUGbxtyeJP63g dD/AAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This rejects names longer than NAME_MAX in msdos_format_name(). The VFS
only enforces PATH_MAX rather than the length of an individual
component. open() on such a path component reported success for a name
far longer than NAME_MAX.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.fat

for you to fetch changes up to 9d7ed813ee5ff0d469bd99630828ed6fdef4e8da:

  fat: reject name longer than NAME_MAX in msdos_format_name() (2026-06-30 13:01:05 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.fat

Please consider pulling these changes from the signed vfs-7.3-rc1.fat tag.

Thanks!
Christian

----------------------------------------------------------------
Zizhi Wo (1):
      fat: reject name longer than NAME_MAX in msdos_format_name()

 fs/fat/namei_msdos.c | 3 +++
 1 file changed, 3 insertions(+)
