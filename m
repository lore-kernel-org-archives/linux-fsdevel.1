Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FEC39282C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699748; cv=none; b=m/0xF2R+WGwQigntzIeDlAQtMYshZq/Vl2mq5a8QGPf4NZuqTnR4HEEderx7/QIkyUBPrUkmLKOZFFdebJpqrRqvItaQU02m/b2WHL/8xH3LeqvanxCfkN6/qu+4CVLEXKQ3Sxnqz9B2iDpXVPCrGVBoDNGaUr1NEL8WRdMLCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699748; c=relaxed/simple;
	bh=gc/XI5HxEC4PKxsI5/WSreIkFC8b7uoh9stcxnuKnN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJuXHgcTYXiH7xuRBr440hXrYX1bOT5Zp8Xv4CCarB29JozZ41XGgbynFMxis/2A2glRKBjHBhs0shKf7OWPlDsDM8EK3kJhZSLDp18QMXvYQNACqU1qn47/kHZGN2ZC4l1/jUdG6mmMKcYtF8Jevz2XQm4QiR30N47/zKW0Yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVMYQA2S; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVMYQA2S"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e59dca659so81349a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699738; x=1790304538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPm43STPG/fDQDyOfj6yzMa2YKT8zVqw0iMraAd7aOE=;
        b=PVMYQA2SjI2PA3tDMrhmFbvRVwwy6fSs3TC4aAGiWQ1VIR0zI5W3AGNMF/miisvfTv
         2YzYvgKBqAM/6h3tmaTFemQSwv2ucThf+syMWtaf5fsvaQST6A11dycyVz9yBw/RpjcV
         oaDhSb03ww4rGccuZ2bB14G9HeuqR21+AyhwQrKm5KQdAcgQbsWPD7hmVGq6fa6qU5xF
         +IVtA9/F54LERdWaMtCNkDyyLg4lTojJJGqJhT4cStwA31gDKKiLVDKKgOlHTCNWRDQR
         EfhsbOZtsgrZ9XdQXxZI8xKCYgxqgfCIBZE068bOzcf9W5E/X9tkN6FVP679moW5FQHw
         piLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699738; x=1790304538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPm43STPG/fDQDyOfj6yzMa2YKT8zVqw0iMraAd7aOE=;
        b=qxaQthn8i0K3AqJbo5yxCImWj1wZ4Hf//11Qxh2PI3b1RlhjkQ5X7cNrxqjLtpVSCL
         1vFmo8UhHgvlp01qVVCGPQtB8CiG58W65kCyN/+5i4tWi3MAp+ZYIQtoCX5x+12VtjBU
         /otONDh8e8+t0oLlbSebiAi7RkZgbhxNdZSxKgj5AAxvL6/Uzy0UxXrzioqP33VhFUWS
         zWPaLVEgqSFCbjTWz6lNRheefBSKzTOj6gz173rac/3qbb2AAAf9z+cPuuB+QOwtl0IT
         YcWbygiyANcoj3n/asZ8XHu4VRSJx+1YH4MatgTIf0S/X97YrilkKN6qBXQrspB/O6Eo
         +kFA==
X-Forwarded-Encrypted: i=1; AKwUvBwIU4NyQjugRHdt0zPY4koK8A7BhEZcLn78xZGnQeGQSHlaVzFDvt1GwXGd1+H6oCXZeMK+zy4Jl8qz2JTL@vger.kernel.org
X-Gm-Message-State: AFuF++nkPtd1JpqrnP7/aqurM/jVtldJx5q5UifT97HHh8xpjTnaI+Tg
	aGlaUzwKtxqJBqrU/i6yDk7gfECIszCZw4WrvODBpBRaxlxTrJReU93P
X-Gm-Gg: AYBFou3IjzOM/XUlKxo9+Gu2Ex7evtzJryTEFXx3XKcVXxao76y1iW/WUYvuvVPNBB6
	u6o2DFSyUvznE+F7qf/WcozkkPrV8CWmNlU1T6t3Du2zMNnrnQxG4jlPXsBYbbK53iJWolJyq9/
	X2mLyj+ETF5C6zJPVwORP/YYNwylsBghvulu5XkElaOSlOSNEVdgrFJcP1GzmgCTlnYh91bQYRK
	3gZSL4AJITQdrlMqhZcdaxU/JWNFpL7OovHIKbzlmJB2t+SmuYAwHHoeQWFF5fztIz7euSZacxe
	90kAb+Vnfu6oW1uEOH53bBpqqH/yaVnCyotIwk6oaw8+qv4S2TpgjGUd8O/zZ33N9O2ExpECrfE
	05mU9UWTkxzgHzYR7tc2ldWCkzfeEg6xOaQGGYySWOWpgW6zHC8FkObGkutTCyddaXhlNW8gxEH
	pANLnaoh7KPvCyipBruZ5mA2WxNBtztO4MlLcrY7QLnlqOa30omShPpKtoyeyQLmbwwT5Qa58Dk
	62Ad66ONOIilRZ4Xv6bZP4BjQ8xPzJEZDQQxp6iwz4KiMD4
X-Received: by 2002:a17:90b:2d87:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39e54d8ecdemr4317714a91.5.1789699738525;
        Thu, 17 Sep 2026 19:48:58 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.48.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:48:58 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	jack@suse.cz,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v3 0/3] 9p: handle long directory entry names in readdir
Date: Fri, 18 Sep 2026 10:48:48 +0800
Message-ID: <20260918024851.51229-1-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A host directory entry whose name is longer than 255 bytes currently
makes 9p's readdir fail with -EIO and hides every entry after it, which
is how this was noticed on WSL (Plan 9 shares of Windows drives).

Patch 1 drops the copy into the fixed 256-byte p9_dirent::d_name and
uses the string p9pdu_vreadf() already allocated, so the listing no
longer aborts.

Patch 2 then skips entries whose name is longer than NAME_MAX in the
9p2000.L readdir instead of returning them to userspace, as discussed
with Dominique and Jan on v1: the VFS only enforces PATH_MAX in
verify_dirent_name(), and nothing can operate on such a name afterwards
anyway.

Patch 3 applies the same limit to the legacy 9p2000/9p2000.u readdir.
It is a separate commit because it changes behaviour there: such names
used to be listed.

On patch 3, to be explicit about why this is a behaviour change: the
256-byte limit lives in p9dirent_read(), whose only caller is the
9p2000.L path. v9fs_dir_readdir() parses with p9stat_read(), where
p9_wstat::name comes from the 's' conversion (kmalloc(len + 1), no
NAME_MAX check), so legacy really did emit over-long names.

Changes since v2:
- Patch 2: say why the entry is skipped in the debug message and log it
  at P9_DEBUG_ERROR, the level of the strscpy() message it replaces
  (Christian, Dominique).
- New patch 3: same NAME_MAX limit in v9fs_dir_readdir() for legacy
  9p2000(.u), as its own commit (Christian, Dominique).
- Dropped the Assisted-by: trailers.

Changes since v1:
- Use my real name in From/Signed-off-by (Dominique).
- Split into two patches (Dominique).
- Reworded the subject and commit message of patch 1 to describe the
  existing readdir path and clarify that no allocation is added
  (Dominique).
- New patch 2 skipping entries longer than NAME_MAX (Dominique, Jan).
- Dropped the bouncing sripathik@in.ibm.com address from Cc.

v2: https://lore.kernel.org/all/20260916135403.15789-1-853555@gmail.com/
v1: https://lore.kernel.org/all/20260826064819.52523-1-853555@gmail.com/

Haobin Wu (3):
  9p: skip intermediate directory entry name copy in p9dirent_read()
  9p: skip directory entries with names longer than NAME_MAX
  9p: skip over-long directory entry names for legacy 9p2000 too

 fs/9p/vfs_dir.c         | 31 +++++++++++++++++++++++++------
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 28 insertions(+), 17 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.54.0 (Apple Git-157)

