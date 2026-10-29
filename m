Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290859;
	b=MRr2ESvNjg2llaWkUkx4gWdVHYjlwde2TADooK0V5O2LT+6nRMxiXpWooezQZsyUgTnG
	 bm0yJSiB2XnFynMSXIjPzHosart9GHifqC3HZEphtxpRq3HVc0vleSqt6hkWu0jCVgm9p
	 ikvTbgq6eClarGnI9MjkDbJt6AWsevuVefKCyFSP4nZcK/aU1kl+MkXMhpc7fIgTEGZkL
	 PJFh0LLoQJIvgXYl93q+LsdFXijFIs0eteWek6W1yzP3aoV/4Zsw+s399TS62KNQyzAVF
	 TQxvt2ckrldA/QtO6Jgl0A0iXAp42bHMMZUU8MsO5/8V6mPUv740K+bWxwwkX1nRgvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290859;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yxnLEz88kcrXq8N3E/2oHjuInKcEQgr1ZtwdFsYS4Cs=;
	b=ddSIUg95pkIvP/EjJ/oKx4lstO/3RjXhAuaObBGkrMwI6g7VVo+D1OFNVB4qpvivIPVW
	 9n+lN2yQ3RihIRQiDkIgwD8lOoe5bT5whjFvFqLYaCQmyJIx7DoKhIiDRZc2/jqsKGRHw
	 FQTCD1l6krZiP1gHq0MR4eLkkuj2HHpXK6IXqYQ4cm0GZoP7CSeUc8zgxF88CWKrlcV/I
	 eaYPWfMnKyazQZzJf7bsjz8NUIWJeKj025Qau9Rg5ZB25lvj9cHO7qbpQo+hZUOyGcDvK
	 cbiD2zR09cuwds19ue4mlPJLJNczH96yUnpBDiwIUJzB4uncTvYibNCyznzuSXhe6yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2vskwra;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF7606A322;
	Thu, 29 Oct 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2vskwra
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1331F01824;
	Thu, 29 Oct 2026 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290858;
	bh=yxnLEz88kcrXq8N3E/2oHjuInKcEQgr1ZtwdFsYS4Cs=;
	h=From:Date:Subject:To:Cc;
	b=S2vskwraZk8gx7DRAFbh3IcnaNYtA4uDUOzrtA7IFr8LlEnFExq0X9Rt4Z4wA+wNF
	 Ywrg0MT0JxMEDKliV1FzB+PzYgQGPg4UFGaehuwoAVvHeDtySiv6vhKVrooUX00AhP
	 BjyursJVx36Pgh9iLqPqdbstaCjvgMCmNgF1EgaK49gLT1XHtXuElZ0UoRGvl+yD9X
	 zF5KelCkcEH6TVi6SXzVmAZKkgwnvecAqQZ1P+IZujXNTz8s4cw+holA2D59aciqjI
	 dhEMuZPOweNHxjm4Bh9+B6Oi3uAnBk+UCaCf3mXYtOANmHecPmbcot/PuDz3o1WH3B
	 xx2Bs7+88rkew==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Oct 2026 12:20:27 -0400
Subject: [PATCH] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
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
Message-Id: <20261029-statx-v1-1-9600cdb896b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3eKSxJIKXeM0wxSL5BSLFAtzcyWg2oKi1LTMCrA50bG1tQCFhl/
 bVwAAAA==
X-Change-ID: 20261029-statx-3f1d8cd8d877
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qZjzog2ZYFAKq0ujNtJHYESLhcObfj0GxOsmO0lygSA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBq43Jiye0QYrOee0yZaTVvDZRihbBxxgBEeJeEz
 ag1FP/x87WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCauNyYgAKCRAADmhBGVaC
 FUa0EACOnsnmxtcenTABbkjOg61+6T8j9VLylMPxKZTipmG84IlpDzlOfUBB/DzlgTplWjWOml8
 ZYJLUxgTiuVVLESAEeKOnrL0LJIMFqGKGjOoIZsIiXwvBrRxnCsJvpwc4t6c54ugJMoTFKy3K4g
 dWqHJ3eMHC+w4SrTrZSwu22nEa5c3u//VwBVbWuWIdvuVyXtQFJaM9SvGxf4XeoubADKaNA0k/4
 YBXrt3sh5qjUAQrFFxz9MCo9lsUm4S8YXE/ooRtxhW9b/EKXFHKO79AjgCoyYkKTQrUH7C5o61B
 w0zfi8/5uYriUowmpL8kod9NtmtnVub3zxniBD0bnRb1N9Ah6XUkRyjDNW12QOPuytDVQAw8/if
 KqWqHdkFRuCcHlw0H696sfZFzApkSc8kSqAkOlMYM/UnIhrdaB84dsTm4j64dNjxMTTZfk8icx9
 V7VnQ5szDx2h0+fDRiVz+5FVs/aopYVki6/M/PHldGd/QCAgVp/QY4pTYAsxA5yGboml0SyDXaU
 pvvIMK402IkMNl6T+bqF0fra9Xv7e7cKwD8G+69kmcWiHzAyF0BI3cHeao8e3e5VzIPOzVskR5+
 iyBUa1tRfzqQmk4EtvMdiLJl7bWcq8ePrBglc9wIXtET80tneOiR+8duIe1L/Ze7B8n58CYhm18
 w736dHVkfopnmIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
from stx_attributes but copies attributes_mask verbatim, so it leaks to
userland on filesystems that advertise it (nfs, ceph), e.g.
stx_attributes_mask = 0x8000000000b03000 on NFS.

Mask it out of stx_attributes_mask too.

Fixes: a1175d6b1bda ("vfs: plumb i_version handling into struct kstat")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..787c13f378ff 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -719,7 +719,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_ino = stat->ino;
 	tmp.stx_size = stat->size;
 	tmp.stx_blocks = stat->blocks;
-	tmp.stx_attributes_mask = stat->attributes_mask;
+	tmp.stx_attributes_mask = stat->attributes_mask & ~STATX_ATTR_CHANGE_MONOTONIC;
 	tmp.stx_atime.tv_sec = stat->atime.tv_sec;
 	tmp.stx_atime.tv_nsec = stat->atime.tv_nsec;
 	tmp.stx_btime.tv_sec = stat->btime.tv_sec;

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261029-statx-3f1d8cd8d877

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

