Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371EE3C199F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868162; cv=none; b=AJnwd8ZoFQk/sP/BLMOAUPX4Jbn9ViNzLNX30eB6SvNC/2LoZdR17wi+PST/MLvh49ecyz8uAT230JxnMdDHKc19jY0q7HQ3VxddRjnGsXLEWDxvd0ruEwEd9m8dFXtXMbDsCyjsFrKiMr8jWZktDmfoB8EMdvHvV5a6etB/YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868162; c=relaxed/simple;
	bh=ztpxb9hQu5tkAcfN8a3ttcSKgHCqdHEOgG+ht9Crucs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKm1+WXnafPLbEKljS6DVP3/qiuve773CW59g2CJY7dARdbrKh0FEVUwVBHsYSAjxG0qyHUd/vBs8i1vUjOtKz9WNuh6s4tCtJrDR7wSo/i5NPIBKD+3pK1j0b5ObAeIN1XC/bdAuFtpPSdVR+vnWxN9P5MgJACANKg/FhYFQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KWLNfZyT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KWLNfZyT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso2438330f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774868156; x=1775472956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=KWLNfZyTUDew5pKHGEzu5wIh8obf9BqzptRNC3vIFgpX3OGXUGiEEKsVgsQVNq0bWq
         ecgW4Y8M03OHJ91GnxGf0Mrp/dVNNioYYp1O4NW7URegBp0Jj0cMgcYVqDMBL33Zgfs5
         MJ+Lcwnq5+f7V+ui6zg+u62bqhsgJ2RJNNIebiTHBsSeEEZ309V7YzaMjEbJiLU7qkne
         fO/99ktPPRcJkKp8M8XHjDWqApGCdxFfY3sa6oN4RCf977JN+XdZrdqKDG58xp3jVHZE
         y/Su+JlXEehLWODdC5h6kO/jteqKofiihGyztQ86NY55YWNZHugoMeo26AOxbVALqHzX
         FQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868156; x=1775472956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=Fkt/zD7WbCMrcfpJLVOMGr6ErHR1uba556QiyESfJTGOT3JzbDHn7aF6imsVTeGKNn
         hW4FzBwCtVEQTM8656x+aNvBlxPWSic+65MF1PcqlDk4Gkbhio2hjs6RJu2YWswWnuzV
         jJxFl8zBv/Pm9R0FkZWy50BuPE+QzBJUst9FfdFspGH+KqDRWxRk75PqqogfvF5AFIUU
         bBO4PwQrstzrJN/UGsk4qZbOOPX9y1/IecGi5TSqiM0fuEykuQB6RS3qfavXE6359tgg
         QEiQfYiqWkWKlSl0pVkUt5BI0Hk87yc2SQSzAklhuZtvqizNQUvwfA5tMuvlVK9SS5I5
         auJw==
X-Forwarded-Encrypted: i=1; AJvYcCXARPs0MF4CqPH86tjZREujMm9hW2vIp8w9cNUFh0yixKRQ5MU82+0kY+0gPodKTV5trZ1dCDmchXXjGEyb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw14uK1zE4mFsqHB/eJycl3enSpKtBjeEirsmtwf7btWWwIrsC0
	YgXl4SQ1fse17CvBRevCu3RHPTXE+eOIQrycbO9GmSCb9KbLINdy176kfe/KC0Bvl3s=
X-Gm-Gg: ATEYQzwBBVdKLrNikuVz23gdETJRmOHtJ8NXItOcAI8yJ8jLczo8523voGEp6hgnnMi
	gVEF5EWAtfzhDH+l+k5mdrdGKPi4dY+al+V4pexmBKODQE6MtZGFRXQjlICnuA8+gysPYhNzeWX
	O9c7Uw2cyn20nO9On0RuiGvDUMGG1U+tskaPYVG397PaX8ZRJJk3nhwSG52xgc/W9ZXBLOOqSYY
	6VlfLUrMAAG8tLR5Gedwipw2nLj8xzpPiIGS96wbgbxzgXpx2TXGAtdBYn9A8oLZ72DkQNIKVYq
	/cu5xpQtanZvJnPV3qUb0KeyxdFiaiPOZkHN/DBw5hXihI91ZvIcYNkj5Osk1+JGD0Es5iiM/5N
	v4c/4behgwPII8VUZ5b76y73hiEHmkHlrimcVxXzOseiRO2fDolUZ3kau19CyAYVL2PoP/8u8sZ
	mqGe9SUBWNvMBhb3GivnxCVOiijYPKhhltdYFBrkE1rgyMlNNvYojFfSiOHN6fV7Wcfq0VrKCOb
	54mxNMi+TR0y+2jgFvm+LU5RW8dNVJL20hvQQ==
X-Received: by 2002:a5d:5308:0:b0:43c:ef4f:79de with SMTP id ffacd0b85a97d-43cef4f7b6amr11247379f8f.16.1774868156221;
        Mon, 30 Mar 2026 03:55:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm16371655f8f.17.2026.03.30.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:55:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfs: add missing folio_end_private_2() to netfs_pgpriv2_copy_folio()
Date: Mon, 30 Mar 2026 12:55:48 +0200
Message-ID: <20260330105548.1371339-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This deprecated PG_private_2 copy-to-cache path can leak folio private
state on rolling-buffer allocation failure.

netfs_pgpriv2_copy_to_cache() sets PG_private_2 first, then
netfs_pgpriv2_copy_folio() tries to append the folio to the tracking
buffer.  If that append fails, it just returns without calling
folio_end_private_2().  The folio is then no longer tracked for copy
completion, but later invalidate/release paths still block on that bit
in netfs_invalidate_folio() and netfs_release_folio(), so the folio
can become permanently stuck/unreclaimable.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index a1489aa29f78..ab73fa62378b 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -55,6 +55,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	/* Attach the folio to the rolling buffer. */
 	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
+		folio_end_private_2(folio);
 		return;
 	}
 
-- 
2.47.3

