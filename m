Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7C399365
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833322; cv=none; b=aCPC7m92aej6U16TkLjmCtbmmjqaB2iEUdkuvMJi/f1ZDDGj+ikspxHYfqvvAaHEhrJivFu83yX8gQapcGPDE79LzHWGvWsnYFtUHLumQlAFiOgAl0yEzfr3KUha21H6lGztJ+m3j7s9NYBPrJSbMKzNo07hZnCrJnoYV8bUT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833322; c=relaxed/simple;
	bh=Ozwrg5vtYkvUjByMh8Q7JYkkU7wDlbu9EjlFXZuBF3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mceXUeo12zLcVHClPRIzgky+wI+xG+TyrdT/EDEzo/x7/LYOuDQy0dmiF9tjKtceqZ17ZYxQ+J1peHr21C9pUneTB3wNbQZnPxkCcpJwoF4dBpvvNoOceHCyZ5THJbIAr6TaMCM6F+0eOQb5Dx6KRuChorphMK2YuQpdCNRyt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtyfQhQu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtyfQhQu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9cb97e178so26826375ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833319; x=1783438119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKTgauuOYaFio2lSDyUix5l+tJ8GaI8cbBppvZ2p7Hg=;
        b=VtyfQhQulJeqamxXY3z//tstQhbwvBqdRhjXCRoy56qGTeqzmYcfZCyS2HmUoUrjLh
         5QOYj6Sp0C3QJQMvDketkEY7s00IwUXAyaXaWtck2qrA+QMTAT142AnvfUWRf3+Zmq0L
         mxhor0kIihQgW4J+ypWaO9ZihkBxRg7hHgXAe50ZvCJ8AgnhwkIuTmFqCxyS+AqL1gSr
         lUgNwwlGgbikWT+uQS4JAxeu1zWPiHVd2kmMgZTtUGeKyM9Orvb6GGVfBmnqRKWhKtvV
         rZpvK3Hm46uAE0WyIvOb9pJxY7blafFolDXmT+rbVy6slScU+YLvwJkWGewUvhcbBK5P
         ijnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833319; x=1783438119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKTgauuOYaFio2lSDyUix5l+tJ8GaI8cbBppvZ2p7Hg=;
        b=HHn9VoSkk6YNDXuAz+iHsMVfDWN3SORA2E/UA5BnlVagyFnuvWXX1XWsBRDkUdLegv
         fxx42Evw+g/wRu6q/pR7B9LMk9eUQKuHpPEI3QM4Eq59RMzXGxXdOuCKMOYrY8g0isqY
         fOIHAK6iHRbd5jm+9D0hXV41ddxEYLS2DfR4V5BLCFNROUExyGtFOWTbnQWNEUX9Ao4s
         KcKz1r/6J9PaZJ1DZZdrGqFYPAhl8gRg12gy59nHVkJYEIRqVhqmjJpuaLYcBVj7Guvo
         nzNs7LpvPBtADrEtu8ZDvK85plbMkCd5kj3ySQTDLuSZeg3o6gipUlvQ+flxfSvnieGS
         IWwg==
X-Forwarded-Encrypted: i=1; AHgh+Rojl+Dli/CTUXhibDnFe3veScGVkrjaB/2+kBulQJm1qOi+GeHrmRy7IHyvj9uLgRRWtgKsFwQfE9IyXuzo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvua1WkkNtQG7+MV+06KA8g3oI4AV49A0JTInVpPG9R+CWRC2z
	yv4qTdBdCgKbKH4mTWMm8/gWBej/pzf2YgT+hydkifnOx+87HVkRSIMt
X-Gm-Gg: AfdE7ckAdqkFltk1+VFFRDnwQ2ipFf4o9KfTOvucH5z+DX6Lx+n/21g3U4IzUUnhydO
	rAHitf63pS+wEcpBoDY5crjK7vdBwvQOjJQuQsytCqqKAnJtaua/Qz+BbGY5dJ9qLpns/lTx2um
	fKPWuUHjPUdjFRFlrdel72Jf2hwVF0VhFeiu2ZBsreefBPBwTRWTTRarCHL8y+OcaSdB9eSA0O8
	Lx8QHpsAsbohdvwCiXEoUnukf06HZruiLyVngg9pVRiv759VZwbyxqgkvcvrczuMCC9MsmyFUzf
	+Zro8O1DsKq8B1bh91UnYST9BOsXH7wcDo8xOUzZiMHw6s5D4Ggzc1a3Ap5lkiaMQI2+RmwWUDc
	xHNYqES3fEK+XrNJ7CdIZuHJIT8D2opN7OaE86SfS2usyB1xUFZwlLL8HkNQ3b00mBaRBmuabYv
	mMemE4pauwrHYL4xkk2VAWD/qp0SoiEfj9Qj6nIFADqacIScNoJr3e1ILEAydFZ42W1q17+DK6W
	djxiDzQgDzJqXb+MBeXopmSJGByNw/Vxj+v2V5fBTXKZnkSKXGvJKMDD3UmN1p+4Oz33t1vnNV6
	5z+gpQLVdlWtpOPk0gES11d7VQ==
X-Received: by 2002:a17:903:fa4:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2ca2d3d28admr36079005ad.0.1782833318526;
        Tue, 30 Jun 2026 08:28:38 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.d33bddc1d573818c7-tp.internal (126.60.158.34.bc.googleusercontent.com. [34.158.60.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4bae1e2asm10501645ad.73.2026.06.30.08.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:28:37 -0700 (PDT)
From: Aditya Srivastava <aditya.ansh182@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Tao Ma <boyu.mt@taobao.com>,
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH 0/2] ext4: fix race conditions and clean up locking of inline data writes
Date: Tue, 30 Jun 2026 15:28:10 +0000
Message-ID: <20260630152812.1706-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

This patch series addresses the remaining race conditions and locking
issues involved with inline data writes, implementing the clean
state-communication design suggested by Jan Kara.

Previously, `ext4_write_end()`, `ext4_journalled_write_end()`, and
`ext4_da_write_end()` checked the inode state and the inline data flag
directly to decide whether to finish writing inline data or to fall
back to block writes. This is highly susceptible to TOCTOU race
conditions where concurrent memory-mapped page faults
(`ext4_page_mkwrite()`) can convert the inline data to an extent
between `write_begin` and `write_end`. Since block buffers were not
allocated in the inline path during `write_begin`, such fallbacks
resulted in kernel crashes and NULL pointer dereferences because
`folio_buffers(folio)` was NULL.

The series cleans up and resolves these issues in two distinct steps:

1) Patch 1 introduces state tracking via the standard `fsdata`
   parameter. By marking whether a write was prepared as inline
   (`EXT4_WRITE_DATA_INLINE`) directly in the private per-write
   `fsdata` during `write_begin`, the corresponding `write_end`
   handlers can reliably decide whether to call
   `ext4_write_inline_data_end()` or complete a normal extent write.
   This eliminates the race-prone checks on the live inode state and
   gets rid of crude fallback/retry hacks.

2) Patch 2 replaces a potential kernel panic
   (`BUG_ON(!ext4_has_inline_data(inode))`) inside
   `ext4_write_inline_data_end()` with a graceful retry error path.
   If a concurrent conversion clears the inline flag right after the
   `write_end` checks pass but before the xattr semaphore is acquired,
   we gracefully release all held resources and return 0 (VFS retry) to
   let the VFS safely retry the write from scratch.

The series compiles clean against the latest linux-next/ext4 tree.

Thanks,
Aditya

Aditya Prakash Srivastava (2):
  ext4: use fsdata to track inline data write state
  ext4: replace BUG_ON with graceful retry in ext4_write_inline_data_end

 fs/ext4/ext4.h   |  1 +
 fs/ext4/inline.c | 14 +++++++++++++-
 fs/ext4/inode.c  | 22 +++++++++++++---------
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.47.3
