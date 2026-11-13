Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552820;
	b=g5ZLd1q8J4LtoLsVjVQKzGsozJnq9k0nD6pcvUSQM+OhAfFadIlkhCVFIi3cv7dVRsiA
	 OHenZdSFGvz5r7YfNJ8UDvAQCWOqRvwQbsh8mzWu/UWJECdAdsH7idterm/qBQjQF0a6i
	 JAW7LkhpaL9Ce755ArBTLtBb5yCkiJVRESXcutkrFLMvOH7V+1uSwQmxbyXO8AErdgwtR
	 hzHApA56DX2amI99cDRgsgd3TWogeBcoqDY+t79FMz6LQ+JRF9rxwciuqcIziAk7ydZUc
	 9hcPViHOo/5GjiAOTnz1XjFp/FbRmCOZGdWjKGr88MADoqnIP/i/Y9NXHfv3nd6dNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=;
	b=B0WsP1C4QJ5p8NWjDdg1zxp/beBHYoxEITM/0IbnToPnsXj5vA7dvDNQrd/O/i51C3Si
	 cvcp/TxYiXWaxj5hV67Uz+/oTnXtH0KwmQcQUU7yZYgs38KOHX2V7T1sxN256NpNi8uFl
	 9gi5d1/cThB3WHEB0tdzi50e/r7vKC9j0OzKiTSznwZ1Siuwid9w/l+YLGkjjMWLX1ARp
	 p1HUp9iVITR8MIdWOfTNZSMSjBpA6LmMHj0TX/abkm5H+9RXUXzVvtn2xUjRn4e5fuFDS
	 +law5hLFHBrMXFKcRjPYlSy3LRedvZ3IvGiYv8BEQiyr0xWNvGPU/AW56EcnH4pRCFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AzJ5O9Eg;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B7606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 997B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AzJ5O9Eg
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so373711eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794552819; x=1795157619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=;
        b=AzJ5O9Eg7CElXOQSfNUvkl1pHodcr3JeY+WWo4T461sGTFGkDovclOGVoJ1qAjVIa+
         bm3ihCFt+/Lk2wVulzZZebLLW0iT32y9Zje5X+6zCGVmfK7HgnYdLOmf3Vp12nCyR8on
         g/2N9B2ORQ7/Si3T3NAsyavlK11MovPa+T11BBdBUGmg1uvWUPZaG7qIpkcvisWo2Rq9
         V8XymPHbFWNcsv/Ssgm6kzjBRpieyUvABF6aMSHRjxj1dmiEzUvFgQdK/kBvwRsg+k1x
         NcZwGrTm9RO9XiHUp46BFeAT6JQXr9v8BiR+HyVVPUNGEgtoTOCTsLrPaFclXH4Bhyre
         hYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552819; x=1795157619;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=;
        b=ceUeKpPD3yR9AkP4QVmtGOLg1IDYvV2ESAxKMLpv4+/1FzEKHbIPOqDF8mpNEYBO8J
         5qDV8ZTL1b+E5ge5uX78fm1kcuJ/Ut/7SvEVxIniPttjyy0nR7EhTYTRBVwvbVG0MrgG
         wtJOWIlqIbhIoKn7pitmDIZObGhC8/2/rPUl2uIXmwVSE25Cq13geT1dV0VKD+ZezkWb
         4XgTKKN8/rTlalzORbI6acrjSKvxB8G27qE8B8R5c+U1iUifA+Z63iIRjFJNAmNsxSMq
         uVCDIuc/9vns4fY/IZBhbh6nggg91PhZXgKqotwJ1kP4R7LqQ6P7tbFaNg/0B/POWaNk
         3Vhw==
X-Forwarded-Encrypted: i=1; AL+hErH7Z7Noqk/d7V2DobfHFq9HnkAcIvQyf72DNHWMnSR1OUiZP7UZEnjllUdV/CzgfqxAStoBx6PSibNIp2i4@vger.kernel.org
X-Gm-Message-State: APuU4Z+eORG2iG+EIl/6UFawpHX24qt8yC3qy+MqnnsrJG13KnV8HxLJ
	EMfL7XZ8GNKE9BXOxiodYQNFjEwyLOJ1v22/0aCwMajlN6beGiawdCRjphakoPMHeWv5mnFFyMn
	cV5d88Ed3eDu1jzoxK+mZQWVzefVTzN3cpDPz0Q==
X-Received: from dybml12.prod.google.com ([2002:a05:7301:150c:b0:36a:209:2e4])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:80cd:b0:377:82e:2d79 with SMTP id 5a478bee46e88-377e093ecaamr4738406eec.9.1794552818284;
 Thu, 12 Nov 2026 22:53:38 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:29 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-1-sarthakkukreti@google.com>
Subject: [PATCH 0/3] fs: reject casefolded names that fold to ".", "..", or empty
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, Eric Biggers <ebiggers@google.com>, 
	Dmitry Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

Unicode normalization in fs/unicode strips Default_Ignorable_Code_Point
characters (such as U+202E RIGHT-TO-LEFT OVERRIDE and U+200B ZERO WIDTH
SPACE) in both UTF8_NFDI and UTF8_NFDICF. In casefolded directories,
filenames consisting of 0 to 2 ASCII dots plus ignorable code points
(e.g. "\u202e", ".\u202e", "..\u202e") pass VFS path walk as normal
multi-byte components, but fold to "", ".", or ".." in utf8_casefold():

1. Looking up ".\u202e" folds to "." and matches the on-disk "." entry
   (de->inode == dir->i_ino) in generic_ci_match(), triggering
   EXT4_ERROR_INODE ("linked to parent dir") in ext4_lookup().
2. Looking up "..\u202e" folds to ".." and matches the on-disk ".."
   entry, returning -ELOOP via d_splice_alias() (or triggering
   EXT4_ERROR_INODE on the root directory).
3. Filenames consisting solely of ignorable characters fold to "" (0
   bytes), causing distinct ignorable-only filenames to hash and compare
   equal and creating entries that e2fsck flags as corruption.

This series rejects casefolding and case-insensitive matching of names
that fold to "", ".", or ".." across libfs (d_hash, d_compare,
generic_ci_match, and generic_ci_validate_strict_name), ext4
(ext4_fname_setup_ci_filename and ext4fs_dirhash), and f2fs
(f2fs_init_casefolded_name), while preserving exact byte-equality
matching for genuine "." and ".." lookups (such as NFS ext4_get_parent)
and opaque byte fallback for invalid UTF-8 sequences in non-strict mode.

Dmitry Torokhov (1):
  f2fs: reject casefolded names that fold to ".", "..", or empty

Sarthak Kukreti (2):
  libfs: reject casefolded names that fold to ".", "..", or empty
  ext4: reject casefolded names that fold to ".", "..", or empty

 fs/ext4/hash-test.c | 12 ++++++++++++
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     | 11 +++++++++--
 fs/f2fs/dir.c       |  6 +++++-
 fs/libfs.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h  | 29 +++++++++++++----------------
 6 files changed, 91 insertions(+), 21 deletions(-)

-- 
2.56.0.611.g1030f0b940-goog

