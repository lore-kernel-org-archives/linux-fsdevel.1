Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5D39E178
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461925; cv=none; b=Lbla6jDK+Q4rK/5P/H0xr9GsBcz5Jw0N1RoGRKGh5ZdTn/gNZWQlQ+0ox1FfeaGK6J8Gakr1ZkSFi0f7F4JtU9hWV1y6AoW8ABgk3XvucZ1+/NgCNl87lAm3zjhKX7qUcAPrVE7ExJ4Yb4Ms21J38VVqs0zNL0Sz0PpXPAV09kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461925; c=relaxed/simple;
	bh=GBujbVPEZZVAXqyMmKyk7DmWYD54fxkCTBG8i9B3nLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxWEdZ0cQLRmi9FBnh9ufPY1j8IkM+MJ3DG4xlnc+3xYLX6AOGZOWhi4uJC1jNGjG50DKxq6ZoTDLPVz/S6GSuLYnLgMRgSWDoQ3nN3Xxp2PuNNLvUkmOqVKmTSBVrbfnA//Y3HUFhMxiyanEWPE9imXSlWHvLKL9YFWv0f+pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKRuD18/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKRuD18/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so61223a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461923; x=1784066723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXHfyIqqoCUhxJYSOeiM8oC7bsZMutyw8cAv10lODWA=;
        b=kKRuD18/7jSByQul1X0Wju+R05n1WGUfof9NhhTAO5oZK8KW+OcoUGrPWnJRcw+m8V
         rp4sTMk+uVJRPIIqh+ariSOahUoKOgFX8tobkODymSXznhtCE82/8LEYfxnmdarellLT
         Rhk7BJ4A1Jv6sTbDvkb0vo187JCa0msqdIez3eUc2ngKg8TshOQYFiH9EAVLMOVKsIDj
         LJpKDPfHpG2rh8yxZ28uqWHo6i77e3gSAZYHXMrm5Be5krJAG5oswXJcz7Gvx+qYbArR
         l3C8eM+XFDh6VsCs5NwHR2HzsupvyPlSBP42eY1oD2WEUtuBDEM25zhYrxTkhRkN1QH7
         mmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461923; x=1784066723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXHfyIqqoCUhxJYSOeiM8oC7bsZMutyw8cAv10lODWA=;
        b=sERQsJq1zp9deJIhBpk4mAXyIfd3eVh4Rku1ioXzSLQFmW+jEnAHTGRJHt+V3ZpzAg
         s4IKg6V7Wvw3fVbSKjKcLRDoqe0TW8WXbpYinQrmxDuCwdYQzyDQ5x8SzD8JITO3x5JS
         PxuluU6LUp/qPQ4nNqiDfkW542EcSwqFa8/vrTk1/4RJTjfaEYPVwdfA6hcsPVRjeN9V
         ywWZvQyDlS9ow8NPeXwsmLgf5Lknog4/19q2/XSDxBHlMGtNIRAQtz8KBKNgHQ2t/sdR
         K6Ive7n2jzKH6cC/gPMxyzp0EnQLPj05S0tF/QVrTuX7Y8ENGDQLCWi4XLKyI/yZzwBr
         E54A==
X-Forwarded-Encrypted: i=1; AFNElJ9cy1g9gEtvj9hE0i1IUem4UE/Lazd3mGlt9maJU07G4mHvzNubbrTwJ+bIdA04Kz5uJxsool2J8zVKUenS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzczmtue70mcBi1Dk2B8FF6yp5LeDYH2ncR5NrP298ah9kfmkXD
	wDyclOeeDefpXjWTgtXCX4INFub4uf6pZnXFmkSkQVnJRRUtzV39W1IK
X-Gm-Gg: AfdE7clibmC9hD3rUM0+l5880IO5R9fROsxj45njeyKXeafUNQxKieKnqN+zwxWxCxo
	vLdFI7dMn1pmvYaADCPOEEFYB3iqWcu14GGkWtKJfEmhk7AcZqtu05wTyHpV4prV/WZgdNDrYdO
	bdGfGgR8DGLuWKvSJ5T5i6UBcwssF+HaCdUVWl4P7UsuvqrLxO7fPi17Dh3BPGBGXB/TTtijrXH
	Mao+m23Z7Hpeo9HwimxbVAjpkN4FvRQ3rlhbKHF2ojcKMqlUY7NpzOz+EtTe2Am6SprLQKX2dRH
	jOEm4DWI7UrEEJutt+hZh+WCkA28V/3UMzoYF9+KQ2iBdgltHZI7BGSjDU7K1cHK+81cNkfLBUb
	9tASOS0AWW016T2sqEhJOx39KUY8m1Dppv0KV9XcZJkE5kKzX5LskMA+vh3eUJpXjiUva9pSXk7
	bL5EcPXyA6eEazZlZW1MPxfyghj43Y/b8NHXKJ2lyUDHJmWkC3gKuR9JjW5KD+8qNf
X-Received: by 2002:a05:6820:1517:b0:6a1:50eb:211f with SMTP id 006d021491bc7-6a3556c65f1mr4916216eaf.67.1783461922784;
        Tue, 07 Jul 2026 15:05:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a83eb2dsm468220eaf.10.2026.07.07.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@lst.de,
	miklos@szeredi.hu,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v3 3/3] fuse: use iomap helper to mark folio uptodate
Date: Tue,  7 Jul 2026 15:04:50 -0700
Message-ID: <20260707220450.1200943-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707220450.1200943-1-joannelkoong@gmail.com>
References: <20260707220450.1200943-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuse enables large folios, a large folio will be backed by
iomap_folio_state that keeps track of uptodate and dirty state in an
internal bitmap.

Fuse writethrough and notify store paths currently set folio uptodate
state with folio_mark_uptodate(), which touches only the folio-level
flag, but on an iomap-backed folio, that leaves the uptodate bitmap out
of sync.

Use the iomap_folio_mark_uptodate() helper to update both the folio
uptodate state and the iomap uptodate bitmap.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c   | 2 +-
 fs/fuse/notify.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a72959dbcf12..ea4a15a7635a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1319,7 +1319,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full folio, mark it uptodate */
 		if (tmp == folio_size(folio))
-			folio_mark_uptodate(folio);
+			iomap_folio_mark_uptodate(folio);
 
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index 29578104ae6c..1ba763705d91 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -2,6 +2,8 @@
 
 #include "dev.h"
 #include "fuse_i.h"
+
+#include <linux/iomap.h>
 #include <linux/pagemap.h>
 
 static int fuse_notify_poll(struct fuse_conn *fc, unsigned int size,
@@ -192,7 +194,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
 		    (nr_bytes == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, nr_bytes, folio_size(folio));
-			folio_mark_uptodate(folio);
+			iomap_folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
 		folio_put(folio);
-- 
2.52.0

