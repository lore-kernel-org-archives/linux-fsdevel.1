Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5F39769D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336607; cv=none; b=dAgBJPDf3yyr9+GpAkIHqWrjEdalz7nocGKSZf45tYkI7WpYdHbgRp16cwyYc66L0m64RTcDF4Ok9EYK97RmXMTbZDFegtqYSx52Hzq5840/lrFWBNE8JbvIzzZgBbC8KeMEYsw2whua3tWgB1bqyIFAjUYM83ddlhL/qjix2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336607; c=relaxed/simple;
	bh=y9mBjKomb0Ohkd6IM1SyNj7gf9HwdR8XKDbxFncEYsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGRDjyyCpRiWrELkbiJcTYb5sXq9BPmt5iXoyEXXtp0sI30HRybAKQuCJdlr5/axqWfpIwN0OBlixgLfFciJx65EuZbF2Ke1cugjmf0/dOhVrTmo/k1iRsGLVvpAIMhVcsvEj3sfvKxV7Rt2bu0lMGNapn5ps7cxZ7TIcWesYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0OdHXSY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0OdHXSY"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d8f70cb0cso1259382eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336605; x=1782941405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrkPDqL0gFKAbIEy421Cyoc2/0k9xEhoVlRCYbqGho4=;
        b=L0OdHXSYy3KHxRwWNlq8MbIwXVf8sWAQH7Y1S/QQ91SwKXcF4CZWQppXyJEx6rVttR
         kxJYh4xpYSMpMmrsfFqGEMHb4sYEwTVjogrVjXntoOuEdk6N9s7KY9hARyONnAdCkWz0
         5G5DZppj6NkXsyrAfJ6/0wKEgEd3iFOGmtl2fPloyGxxzXsnicIDkPyEPiinXt9RFKYF
         fe44Rc3FFotNdx3s7VbsxngSKI8gT9ATU8tB4Hk7ZGNQPZ5rB5WX17uWEn3Sf5UjQnOl
         05HiFhFynn1+iSWOxuK80+YjXokQvNX6FdfWEA+0c2xH2sOyN3LPCDzvxPJ1uoNCd03U
         Bd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336605; x=1782941405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IrkPDqL0gFKAbIEy421Cyoc2/0k9xEhoVlRCYbqGho4=;
        b=SrWjgvC3M9iE7JXke9KL8YBniOq9sJRVraJxQPCGmx4ol1aKIdaoIJob3SNFaRaToM
         OdwAm9mRRNjY581AguQw9K+GdBz80MvrJE1ZVr3UJ59pzZpCbMFpwbMVW1ODpw9aWgR9
         nTL0l3BraIPrbgqd1iPyOxPFCR/Q2Lb3PcFz/ffldfCqKqjoL0GAts+fqWbFGLK0k1dn
         abgenGtMKvoV8GppPx57P+QBPphTiKVvE3OvWrSCPf9PB8xTNDoq8akGx7fNXIdykcrp
         UDKlgQcEGw08SnUuhtU0Sh/8DgoqZl92zImQx09mXE9C6RPbUG/i4FBRM6uS2KIOb8nZ
         8CcA==
X-Forwarded-Encrypted: i=1; AFNElJ9WPJGragVTo0sDZwaTRESt1gyx6JUxccnk4K6FfZ0mAtSSW0aaUKFXyZ9vxywLF6avzoZPjTf0Py7Jzu5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7KouwwToeIK/gfstUVDkrdsJkE2oYd8OoqDZkBhPnHWpuZl6
	7vabXGwhZaFlWY/asneRNHi8IWiJ6TAVvwRokp4m80SPaU+xs0EoS2Hd
X-Gm-Gg: AfdE7clPriXZ/W/qAROihMA0hjFtEv992zOzZhINNnhfRWjFeFvl47iNgOPQ4+H4Cxb
	Yg7njkbHx96wSkGvJECQeIqv4cB5DaHTJ99Ro5fMmGZ0Z0g0NM7ixTYi8hLLaqGTQ7nQcsgSUCp
	IO7c/vJYNbUhCRxQZ+vB3n33Qz0SiA13KVNy79d4eB2qrGW6fb8lre7F4Vm0hAtlNANmxYvTPES
	sepzjmNVIf13Ttpshh/1aCLSTvmBNgwzPWJk6a2AsppuPmrPKWzZynx3asSvcr5UIfrT224CMlB
	8osGmNNEMCbAL05oPwl+0k3kQhVvIhfa+yJzl/YeirCRpobSLYftFBjqGxYUb+D2htrQ/PpZ7d+
	J+/vU/sUHWx4GjvCUfJrKjAEkXdm/vlJBeFd4tsW8x8imu7E7E1OKNWZGn/Jr3P/rbvHDymgrjz
	tD55g8f4Dm92ewyidD/FV4hj+DXXHfdpQmraEObCcwv6xT1vALSY3ZoEVX19hAYhM=
X-Received: by 2002:a05:6820:1c94:b0:6a0:bec5:a32d with SMTP id 006d021491bc7-6a122e2a1a3mr3797504eaf.1.1782336605122;
        Wed, 24 Jun 2026 14:30:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea0f9dc3sm10031295eaf.12.2026.06.24.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:30:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v2 2/2] fuse: use iomap helper to mark folio uptodate
Date: Wed, 24 Jun 2026 14:29:25 -0700
Message-ID: <20260624212925.1668662-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260624212925.1668662-1-joannelkoong@gmail.com>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c   | 2 +-
 fs/fuse/notify.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..26f27e113e9c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1335,7 +1335,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
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

