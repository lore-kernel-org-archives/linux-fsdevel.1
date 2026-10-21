Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594599;
	b=FLc/eJ3mbwRnvf1zFQv1Ucekej6OJ5Kn4aQ4af4o8hzV49/KXg9uX+Uum5QYacxNwLJf
	 3nG6SGky3yARzRbygl1+23n6H2mtcecw5/mbhDkJp8naqrgvVJ3+iMpOm6oSfakOSt4vj
	 qCnACenKjVFLqEmAPMEi32iQ7CA+eUlP8Jbzp0LzeVe6pdmUJLdQ8Q87I7dJ1ofK9AR+c
	 puHNnGiEdNDSw+4G9q1ni4TAKeU7IalgAFgSf33ZhVaORyIXNfUBgK8EK2/C0HphnmI35
	 93xQ75u7j+1SkMWlj+XqvHlHg/rMkyP6aitN1PHNqKAtvYg1N5mTu1E5YUyyGD4mmUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+D+uYFURRsfo5Ok/4sB6xpuqajcrbQ8BvhCvpo4B0eE=;
	b=ijO662BXRV7JJmClx0Cnutw+qUWemaSYmChmRn/chd8oNUZJZn2jAxl8lhpdI0ul+Ari
	 Ls68k0rGxhrB5/WlvlJVlBa3FpE/19MBYVdDFf9J+oPuhNtRzQrU6NENQboYi6EgqI0T+
	 lkPA5D7p+IP94AF1d0qllsTXEBd7PMsbZWwVaWbv6JJKVnJC5uO5+aWvD2Xg7jy213obI
	 rff5NvJKGmZp5hDDVnnHxwV1sfOKzwMuH77fqmYHpyKRh7n3S1Yj2I0KnPivrRZhk002t
	 qBZ6WKo9+GVJJmY9Xtwk7y1EgR+Gh03oKJS5ORLK/e3dP0jHfxfnasHPYvluYdnoONA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TZCFEfcK;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6B606A333
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 14:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF6B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=TZCFEfcK
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b056d58f2aso7618977b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792594597; x=1793199397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+D+uYFURRsfo5Ok/4sB6xpuqajcrbQ8BvhCvpo4B0eE=;
        b=TZCFEfcK0jcKKDGnj4MbvVG9coLx/enabViFZuQu6y5ZdCGHFoH1JiVFuMjS9GjozR
         O1/LzvuMxYQBF0lGf9anI7JeWzTiGCwx3NOAuDN7vNU3D9WS8fXGJzpOMeQp8KnbZqt2
         AjOutoqH4BB6K1WQgIsiSu7G7q50JtamVQ4fB1EY/iJ12LNZDhkF/Dx8Sgx/umnTqZiz
         wr8cl0arj5vqLBxmve4T8QvrIBReKlwCGgbw5xWYTzny5cLzhk5JNCFg+i5VoCrjKs7C
         0aZYmfrbfmIagq8BgFriXPImGEppjBBV2mgpzkG5lf4IV1xaPS7EXm1ps17BND0Gdvut
         97SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792594597; x=1793199397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+D+uYFURRsfo5Ok/4sB6xpuqajcrbQ8BvhCvpo4B0eE=;
        b=UOZ9Bi6ibhAGkpeLByBmD8Z3rTjTIOC86Z5gHzCp1P9Fjn8BnNWrFmimcWvzfr3eKr
         +2+oFkCjTfm79kVG8vo3xR/Od2IQymrVaOi0bMHenBXYUbEoHxZEmIIe06BqyqFm8uOB
         yxPMLQjY1zRaQvWIV12sO9MWXOUwibr4p8zu689YZdFmehSwcUTa21PTi3x/upJ84UXg
         eAt8F+FWaKQVn/eMguU/7Yjoxa+GWsm3pVI0FQt8tTNp7XTRgxIJEnlkRi0YGNr16nWb
         oilTrDMz9AJfFJzA+wDkgbToX88WB5492lVDD04Bqt+7EI5Im10l92eaQCTwTy8+Thlc
         DhrA==
X-Forwarded-Encrypted: i=1; AKwUvBxSjCmia/gctxWbzWft6DCKxWVbVYgpD1Gfw9hIdZNV4MC5pPdtvI5hD9i5qJp1rxgTIZ5rbh/GlBu49mrS@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0xGVVBiYwqbphIMJ2yu7p49ZzNOrzESxeb7gTHYSwVT/XY+tA
	fDPtYtjtMAq61VRS7J9PSZK9bokRcMViu/BULIbhx0E7dbr5CzsJEFrEjcUKlAjeWYMhl2yg3lK
	7grkBsA==
X-Gm-Gg: AYBFou1q09C/Lhi9SuWN/tACIEct19jSVPMMbllunozuE0CsrGxKTXke++iirt0h0Wf
	R9MX0/ZF2B8ie4ys8Ar5HIvDMB1/hd7W9COOBEAGXyOH8byGTvBl7cVUnYWBVBTJzWcKj9zdZDr
	SisiPM5pnFzw35AVRpCr3tLrQpPjsh1vtIbHqixQ1lJQVDL0cxs9aIEtXoSVlcnIioaSx/AQiGC
	jCLvppDiwnT0uNvjm7SbWqODwBfs5VnOcAaYrPM8PjmzkZM+eT+dekhug3ge8abExZ6Et0bkUN7
	+Kx38P9RKxq93rI5A0WjiT3TsGicVJ9PiWx8m43E54Cp4P5TNH5YgFNMphL1crGU5hXe0KS64JJ
	SpzmjEBHgnH3Acv9IZ+oeKiHlQvb4hBw+3DmiPCJNvy9A4KBScV0SXGVu2L4DqdaGppv+y7Yrsz
	ZWCn7ylVz6TygQumyG+copLOLS6v/xsrchRq9XzmUD0qHKcEUIEwg1fhN+RJHfPWpJ07Vfv4J4P
	tNDBZV9PbGXXzedYydLn+dIAhyagk+yXhYtk/UciSF7Ys27NabxsJlOvOVdGszid62tTT7aGY8R
	ttYmVU7uBGHs6E1TYJkFjw4q
X-Received: by 2002:a05:690c:c0d8:b0:89a:63bc:8d7 with SMTP id 00721157ae682-8b1340cc1e0mr8889117b3.97.1792594596537;
        Wed, 21 Oct 2026 07:56:36 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300c00d3sm12495757b3.22.2026.10.21.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:56:36 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hfs: report errors when extending files with setattr
Date: Wed, 21 Oct 2026 10:56:27 -0400
Message-ID: <20261021145627.288953-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

hfs_inode_setattr() sets i_size and calls hfs_file_truncate() to change
the allocation. If expansion fails, hfs_file_truncate() restores i_size
to the allocated size, but its void return type leaves setattr reporting
success.

On a freshly formatted 64 MiB HFS volume, ftruncate() to 128 MiB returns
zero while the file remains empty. When the requested size fits within
the volume but exceeds the free space, it also returns zero, leaving
the file only partially extended.

Call generic_cont_expand_simple() when growing a file and propagate its
error. Keep truncate_setsize() and hfs_file_truncate() in the shrinking
path. This makes failed extensions report EFBIG or ENOSPC.

Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Keep truncate_setsize() and hfs_file_truncate() in the shrinking path,
  as suggested by Viacheslav Dubeyko.
- Replace the generic/736 and fsx runs with a comparison of the whole
  xfstests set selected for HFS, as requested.

v1: https://lore.kernel.org/r/20261017160612.3740256-1-hengyul@cs.unc.edu

Compared unpatched and patched v7.3-rc7 with identical KASAN configs.
All 805 tests selected for HFS by "check -n -g all" were attempted,
using freshly formatted 2 GiB test and scratch volumes for each case:
                passed  failed  not run
  unpatched       109      27      669
  v2              109      27      669

The different results were generic/113, /394, /464 and /795. /113 and
/464 passed and failed in replays on the unpatched kernel, and the /113
failures are the same existing workqueue warning from hfs_file_fsync().
/795 failed on all three kernels in replays. On the 2 GiB volume, /394
passes without the fix only because ftruncate() returns success after a
partial extension; v1 and v2 report ENOSPC. It passes on all three
kernels with a 4 GiB volume.

Also ran 39 functional and 18 recovery cases per kernel on 32/64/128 MiB
volumes. Content and read-only remount checks passed on unpatched, v1
and v2 kernels. All three had the same 12 post-ENOSPC fsck failures;
recovery fsck checks were clean.

Functional/recovery cases and generic/394 were repeated on unpatched
and v2 kernels at the hfs 7.4 merge (dd7b15aeac80), with the same results.

 fs/hfs/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2aef3c36a150..9bdaa60fc392 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -684,8 +684,14 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (error)
 			return error;
 
-		truncate_setsize(inode, attr->ia_size);
-		hfs_file_truncate(inode);
+		if (attr->ia_size > inode->i_size) {
+			error = generic_cont_expand_simple(inode, attr->ia_size);
+			if (error)
+				return error;
+		} else {
+			truncate_setsize(inode, attr->ia_size);
+			hfs_file_truncate(inode);
+		}
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 
-- 
2.53.0

