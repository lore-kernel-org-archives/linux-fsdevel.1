Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794652140;
	b=RBn1fu2nvRsOJp0crmm8s5Rjlp2+odvKmaoG7ESqxak78PFg3TlU38+ic3KJKfP0KYsQ
	 n+arEu7ONiZqqcfw6YMBTlkX2vpKknhEjow78aj/PomqaFTfohbcvaFWI8I1vdEyACmi9
	 4zMMRgvyPcQiHr2YwhYrjq6rUFU5i3GGcJkQjF2Bq1wbI64wJ5ZTtPWfNXv0Ao4faRayi
	 7bclnrV4n1p6JyiWcH4yTzTReKgfqjDG/dBIiz++JlibHNCv80E+Kaf0CURLFb7LHzGnM
	 YPNlJQr8cR4sCvZTJNZSvB3RbNoQc2GEB/hxXv01rTgfzi/4J+Zi0lD+2VSjwoVt7oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FXrtt5AcPJ3oF0h2d9fXFeKPAxGtake0pU13yHQcboM=;
	b=zcOzVfifRQmLvF6DCkbcq41dTq+QIZ2uCfUpQLyRHbqJN2VrO8x0XofXQff97OIGiTVT
	 8hThMThIEFC06J76MTsn7hnoDjXbBKerp/TyECe7l2kMDah0g0jalA2QKFt+xHdRLtUx6
	 NkhuGtX1L9HX0zx7iCWnXUQ+or21AXVX6wtpwh2XPSq3O51bYyU4tG8TnCiKQORz5U2xU
	 W4BYtkToN3FWTQrEcqu+L2eAwuqxNFxlJUVUZt0igXz/qfc68l5jldqQhaj2g0wpp0xvC
	 DIq7f5a8+fv7lci4rRKLra0SIZk65lYs+pQT15GarIWPC5OgSXL5PkQW1pVJSczZNYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3fxnZ4u;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AC606A33A
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 10:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A74AC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3fxnZ4u
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c506a231b88so292251566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794652129; x=1795256929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXrtt5AcPJ3oF0h2d9fXFeKPAxGtake0pU13yHQcboM=;
        b=S3fxnZ4urHbGQaknWbzhn575EndlJWklEqh9m0aizdD+yBSSyzmqENhXFHF5GHw2be
         wjAAspR3DOykarz5SOL+xZOAGjW9WqyFhKD3OZvGMrfsp4MCu4fOY4ENVgqq78+te6t1
         D5wKyvuu331UiNBDnwDBPWK1eUcsvluVM4BAhGKpe/uhlh3pSBJDXGw52qiluoP+/J9x
         k9kDclhHKUTYj3Uqfj2MGWNuRfmlXnDZ3I6b1i9T57YbafLtpTP2ehTSRuTNFXthNVdB
         BWg8Fjl8bOo48DYuPkDkjD6h0FXjpL4c9WsxSPAYRwoFVVxOiX0mj99dZCtRrEVT4eSs
         KNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794652129; x=1795256929;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FXrtt5AcPJ3oF0h2d9fXFeKPAxGtake0pU13yHQcboM=;
        b=pgo2yn4whLHbgxNYbp98p5j3pKupTYj4gwdTo7pF4QpS7jkQ55S7zmOFPtiD/WAG9T
         4ydR2XbDC39GqEOLE5BeQpOqzTgG5P+V6Dv/ojII9W7Sju8vyARKNaN6fFyXIwvJnuUp
         uu3VWIU2GLAamfZ9mLz6UShrfCOTEee3EihdNVNiEgGiqQI27UFNJwFQFSGJOqOXqlCr
         88u85ogJob2KgoNvt1PdV07RLVzLYqsIc/ohIU/P6euf+Yfi8r32l1u9Dhind86cle3f
         08tNofayUcHHCZZNNgZJV59J+T7FwvNE++3d4FSdF/3JYDxPaeeFS7r3s2gGuH1HRbga
         77+w==
X-Forwarded-Encrypted: i=1; AL+hErF0DfZgNPOdcXQA72CJEsILcYEu9yYhktCEjswFFhgvfHZz7xTvgKgD8aIKJaieBsDnSuCngDuMRQlr8Duk@vger.kernel.org
X-Gm-Message-State: APuU4Z9v/+e6/egeoWFUTj9rqU2odv5WQIJByb4P9fJb1u0o4BUiN+v+
	Qv2+F7udmhDe05SgaGSuTk7EXJc3oh3yIHWuEEjRSKjWvDHpgwETz7Z+tbzPpjJw
X-Gm-Gg: AYBFou3fEX0n+7kNreIwPDBnHB1DCF2o3L1cHC6H94oNA9zATjoQBda1JvDP2ZUER0Q
	4X75gVHKGyLluCDdpq1mzq+9l8//sPWqGO4Qj5QHAXprJ/7N5GokVEX8wQgyMYfnRDgmciz2Mxy
	4fwY+dxzuEzQnFTbraI5FfvsTqfTP9iRiWuA4aEoWE7tbTI1xrvyF6vRVSrkg6xfxWFzcHyoz+E
	jW+XNyXHAW6CCqsMJF6vPcsyB/ptXPvhcXRlPvXyqnKjGo8UtTIPK+5o9HQRPnonpNRoaRSjQM/
	CPBxudTrO2pfkG2mCai8SEj4cdJmvd1WMggn0omLxTp9cgIQGN3Wqp4X5pII520sXN++W32MFTK
	HpJmpvKWB1RPzUwwFX6nWusfMAgoYvH6K6ZwHNSJFBWm/5FWlCcneekEXpaS0CyEWPhj1VPL/0j
	aJmDQ+h+LNHGyXQiHP0CdJCZIfcURzOIswI6b4SAzGtaz+mKtlfDvr7Cls1sQg7eg3UWv8jnUeL
	cwi45q+QyK9sjTFNqZQ1Ivs5kAaKHncVBibquigmROHRlUvc3kPf4FHpdyccqhw8Bgf4P/+E4pl
	vfq+zH328AzLgkNIx+nTE7D7aF8yjaWXs2ZneVgLzljP63fbPlxBffvCEy4OpEJpLtexE4vW114
	cG2Q852/Ra2oW
X-Received: by 2002:a17:906:99c9:b0:c50:95bd:e491 with SMTP id a640c23a62f3a-c50964377d8mr492804366b.28.1794652127818;
        Sat, 14 Nov 2026 02:28:47 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b79146sm198656966b.68.2026.11.14.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:28:47 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Giuseppe Scrivano <giuseppe@scrivano.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 7.4-rc3
Date: Sat, 14 Nov 2026 11:28:46 +0100
Message-ID: <20261114102846.574470-1-amir73il@gmail.com>
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
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 7.4-rc3.

- Was in linux-next overnight

- Gone through the usual overlayfs test routines

- Merges cleanly with master branch of the moment

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-7.4-rc3

for you to fetch changes up to 748739f3171ed1c44a30a98b0e0341b1a8d62d31:

  selftests: overlayfs: reject different lower idmaps on same fs (2026-11-12 13:38:59 +0100)

----------------------------------------------------------------
overlayfs fixes for 7.4-rc3

- Fixes for data-only layers (composefs), some for regressions from
  v6.16, which relaxed the requirements for redirects to data-only layers

- Fix a use-after-free in lookup of a hardlink with a FUSE upper,
  reported by Sashiko

- Fix a mount failure right after unmount of an overlay with the same
  upperdir

- Reject lower layers on the same fs with different idmaps, which could
  decode file handles through the wrong layer

- Minor fixes for a memory leak, an error message and readdir d_ino

----------------------------------------------------------------
Amir Goldstein (5):
      ovl: do not read the flags of a put upper dentry in lookup
      ovl: fix leak of lowerdata redirect on ovl_get_inode() failure
      ovl: do not check the deferred lowerdata redirect on index lookup
      ovl: do not allow nfs_export with data-only layers
      ovl: report the requested redirect_dir mode in conflicting options

Daejun Park (1):
      ovl: bump the impure dir version when linking a file with origin

Denis V. Lunev (1):
      ovl: release the upperdir/workdir in-use locks before the umount sync

Giuseppe Scrivano (3):
      ovl: do not always clear absolute_redirect
      ovl: follow lower to lowerdata redirects from any lower layer
      ovl: return EIO if the lowerdata is missing

Jérémy Jean (2):
      ovl: reject different lower idmaps on the same fs
      selftests: overlayfs: reject different lower idmaps on same fs

 Documentation/filesystems/overlayfs.rst            | 24 +++---
 fs/overlayfs/dir.c                                 | 20 ++---
 fs/overlayfs/namei.c                               | 61 ++++++++++++---
 fs/overlayfs/overlayfs.h                           | 22 +++++-
 fs/overlayfs/ovl_entry.h                           |  2 +
 fs/overlayfs/params.c                              | 91 +++++++++++++++++-----
 fs/overlayfs/params.h                              |  2 +
 fs/overlayfs/super.c                               | 52 +++++++++++--
 fs/overlayfs/util.c                                | 12 +++
 .../filesystems/overlayfs/idmapped_mounts.c        | 45 +++++++++++
 10 files changed, 270 insertions(+), 61 deletions(-)
