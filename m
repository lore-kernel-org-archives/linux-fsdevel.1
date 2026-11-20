Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210506;
	b=pQ/QtCEmX3cUgjWwlCoApwmru2rROyV3YAL9FrDky4ha0DuaM8yhlLHQjRmNJymWEKbL
	 Fa+p2rdonCbMFWczJ/BExnm3waAswRPDst7efROLxEP2k2Ksb2jk4LdgWOQF6LHtjNdJd
	 2W/mNWfJEKFggPKqfElggVCdo6dbjdcFFOnqEIlPOoYHjTTm4UebBndOvH2Hr8BVM/oNG
	 FlevZ4JsgOR0g8aeIcHflsnkU1wtgQwnS2J7s20nSCObzr7e8HzMsNyuuASFAEBhTjH6G
	 L2IolDvyhlqs7Iz4C7M4kdhESnBgCfWB2gn2fmONB0cHZmbDPKCxd2bkQOypxWT+zUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9R3ZLhcWd+PyIs3KHNEbwXU/BNW+LbCk0X8KOdAMGQc=;
	b=BS6iEwQdEYa68bapWzdVIrvezervHfo2qzoH5eBFLMxB4Fj0BWXxoKWvT1kSYKS2Sn1m
	 WdzeX0sUjWQx2OgLkAkL8xie4dyh6s12jjQ2nlUpsrlAVWLGyzuwo+m8iLZ3QrMycyfSo
	 ufOmt+XSpgwoiLR7GyN/vFa9X3I+aN5YJ8isxflEp0IRCqsPqEBHBAEV6Hxg3GxmtUpG3
	 FCjretMY7gD+rJ6f1UBIerUV53f+R7YB4UAi+gXHoTPTaBD+DUMPGcIcy74JOtTXBOolT
	 0vzVJGlosVW+EjyjRvVLMVgl4B+ogEQVPLceQMqJRUyk7KZRtIpMclraNVNb19ABLkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+emX5Zr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EC606A33C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+emX5Zr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5231A1F000D0;
	Fri, 20 Nov 2026 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210505;
	bh=9R3ZLhcWd+PyIs3KHNEbwXU/BNW+LbCk0X8KOdAMGQc=;
	h=From:To:Cc:Subject:Date;
	b=W+emX5ZrkDZ3nBoWf5xYBw+S/stLSCqJSQ1QZNUws4J4zHl4uu2r7d/MwQ0HRDx2E
	 zZupdBZgvFf21x73XiwB4Gxd5tgYw6ds5ET3WODf9kc6kO+i/M3mgbrTVfYkTGAGFo
	 loiFazftRFnEK921aYp6V7iVuw0O8cz/IM29SzZcHyR8nbkbd92lFScsWjye7JMx2m
	 RwXvQ+ndKmljsifsPjGkHbQqNoWZyWfsPbm/GFdFSwvx3ABLDm3sRQabXoVRz9lVzo
	 3GB09bu28yHByCLuh4Yh8s8pp9nY5Z0Eoorn/EESGZPjBQwWsZaacgqvqUtyQDyngL
	 emWQVovRnJ79w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 7.4-rc4
Date: Sat, 21 Nov 2026 06:35:03 +0900
Message-ID: <20261120213503.580799-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.4-rc4

for you to fetch changes up to fb5289b697c965581104bafdd875b969a1db3e79:

  zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits() (2026-11-20 23:58:15 +0900)

----------------------------------------------------------------
zonefs fixes for 7.4-rc4

 - Avoid potentially opening the wrong file in the case of an overflow
   when converting a file names to an inode number (from Guangshuo).

 - Handle potential overflow of RLIMIT_FSIZE (from Ding).

----------------------------------------------------------------
Ding Feng (1):
      zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits()

Guangshuo Li (1):
      zonefs: check multiplication overflow in zonefs_fname_to_fno()

 fs/zonefs/file.c  | 9 +++++----
 fs/zonefs/super.c | 6 ++++--
 2 files changed, 9 insertions(+), 6 deletions(-)
