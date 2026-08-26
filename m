Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946B2E62B3;
	Wed, 26 Aug 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760407; cv=none; b=ifWPuv0VBW/wTFo8XY1pWKAiBkaMIt0zjmmpcoYzFXEuIEeoQwST0NVPS/mUnIcaVbMqJo4CPFVnLV6b4osPdvSEKxT2d8miexLHd+4w4Mxi0rRN0QFGxd0ULn7DIbUKRc1BMRo51DJ7tI4DIpsEZjWL0rLK3OOtH3fw9L9hgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760407; c=relaxed/simple;
	bh=DLaQXXhE3GPjz/WkKul8E4zcEVrz25q2RRBTZmkJ/Y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rye/24FlC2kFb+Bhl8dEjL5CJrTACAQhHbz9iYzrhbF9ti87t/PCPttXNi/KYOAw59cMdQGE5VLUilOu8MdRzrKk5A7RVFrg6nyNj0oHbvkK0zePKKYwu7KRQ9OHZXGM4W+enL2toXGty8Zfgfb0zn9AADD6q4s2yVJxWbzaBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6Ip0lEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6Ip0lEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E01F000E9;
	Wed, 26 Aug 2026 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760406;
	bh=qzCRwQtZ9/wP7Z02N7Vz+vk0AFHWhteXZEZwfRjGIOA=;
	h=From:Subject:Date:To:Cc;
	b=D6Ip0lEqBo7TaC0vEm+4INQXvt0ORtVzNxM0nL9cPiyvLdL7frUynU9l8nVrh5Hbi
	 0DZOfCM9+5b/Vcu2UMnl6mVjQzxwSIy1lFeyN7ApPIueIAThUeKE2Q0S+xVYxRAjGE
	 oJlaVUf6Xvy9L97Re2YL+83yOceM8rQLqjAwTsD6aK2RunFMDywrj1WllEmuoF2gkA
	 tD5KYw8TK6MEIiuyAAx/X3AcTlG3KIUWTAC1VwROaBRfNJnwriTuOQzWUwVEOD8gGg
	 um0nJVih40tK8jMVuZBOsdUj1qcuaS+l6xS72VeBbqm5Ae3ZkcqA4RZcJAfxeSrqXQ
	 tcRvDlIEmmeGQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] powerpc: remove spufs coredump support
Date: Wed, 26 Aug 2026 18:06:39 +0200
Message-Id: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQ7CIBCF4as0s3ZIIW0lXsW4ADq1aCyEETVpe
 nehxuU/efOtwJQ8MZyaFRK9PPuwlJCHBtxsliuhH0uDatXQajXgO6Q7cswTowuJxvyI2JHsHEn
 d9/oI5TMmmvxnV8+XX3O2N3LPStWFNUxok1ncXE8VFTsq/qioE9i2Ly3jLmaiAAAA
X-Change-ID: 20260826-work-spufs-coredump-4e14ce185587
To: linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DLaQXXhE3GPjz/WkKul8E4zcEVrz25q2RRBTZmkJ/Y8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT18wvLGFte3TRnstVy/Q9fUwR+BztJKG36qChdzPRor
 zMfA8/TjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksvcXwT/lGGFtVRkNJQt3E
 M5lHJdmWTOFgqDh38P1l67uyboI7DBgZzv7X/zd34swfVvwGk+PO7Pb+/mwHv+2R3R0Nzld2zLi
 3iQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A task that dumps open spufs context adds a bunch of extra elf notes
describing the SPU state. It is the only reason do_coredump() unshares
the file descriptor table. We could make this conditional on spufs but
eh.

Nothing can consume those notes anymore. gdb dropped Cell Broadband
Engine debugging in 9.1 and binutils removed it in 2.34. That's about 6
years ago. So no program can actually read an SPU note out of a core
file and probably never did in recent history.

Note that the IBM Cell blades that shipped the Cell processor were
removed in commit 05bf59fbeef3 ("powerpc/cell: Remove support for IBM
Cell Blades"). The PlayStation 3 is the only platform left and nothing
there produces or reads these notes.

So remove it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      powerpc: remove coredump support
      coredump: stop unsharing the file descriptor table

 arch/powerpc/Kconfig                         |   1 -
 arch/powerpc/include/asm/elf.h               |   6 -
 arch/powerpc/include/asm/spu.h               |   3 -
 arch/powerpc/platforms/cell/Kconfig          |   1 -
 arch/powerpc/platforms/cell/spu_syscalls.c   |  20 ---
 arch/powerpc/platforms/cell/spufs/Makefile   |   1 -
 arch/powerpc/platforms/cell/spufs/coredump.c | 183 ---------------------------
 arch/powerpc/platforms/cell/spufs/file.c     | 114 -----------------
 arch/powerpc/platforms/cell/spufs/spufs.h    |  12 --
 arch/powerpc/platforms/cell/spufs/syscalls.c |   4 -
 fs/binfmt_elf.c                              |   4 +-
 fs/coredump.c                                |   5 -
 12 files changed, 2 insertions(+), 352 deletions(-)
---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260826-work-spufs-coredump-4e14ce185587

