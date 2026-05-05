Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4C2ECE91
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979588; cv=none; b=WSKB8owPzktQCMXJwzuidnNe89bUajtazbpcTXHhsTX6t60rMuPRPs0rZ7WyiwFjGwWp+ZWHY1pFyoD45ubx6idPSJKIJBPtPHBER2lLQd4K/rShVezkeuehLEfzKvR9Pu1xigXlGGlIOi0OTNrhl/Oj+wafncVGQ36KFSfqipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979588; c=relaxed/simple;
	bh=bL0oPCKQKfXVk7I7nA9PujVriVuw8xDtuerHvQi6xV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaE76ldAjbQZ8MIGQq8LHU96cFPqmcR7J2UgB1tqtytIcZTYxDPGAD73xMgszKQn6eeQnEWhTtPf1XH3dlxEti/jcAQxhNzqBgs5+pZu+JfkW0vBMPKoSDcu9MbfPO4pSB3d9yuuVZzNbE5l7AvTInPknEm2MikmfbRJoW1Eem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WME1J2Lt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WME1J2Lt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3028216f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979582; x=1778584382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeJL4p/1hA/fUCWuNw2juyWWdFBKuFTt+VDUIZEBMPM=;
        b=WME1J2LtB8ZKOBfr/9VbSTbP+kzWMN+UqRYqVeojqyQvHpGy99C/lRBV9mqr/KorsK
         +OQJRl8KJ/j5kshMpD1qET+r1ZU4GevJsAeh4ZuYhks10m/vzh5ChFQy3nxqG1UaJzd4
         khzspjHx3kUmycZb021adyM1wXH2wNl3pEu2vbGIY1pUeE8yJlFKq2OL+UkiJfeLkGwk
         o1CVlFFPRd7SCbWbFAUMIoSfFxBUbf6uiU9kYp0PD1WUY7zzw+224S5oYrFDMsUxXVjz
         Nif1Wl9ChrQtfZQlMLVhVwd5JCQzKwXG/NdY88Qegq/dVF+P5Y6hG+zDiFv6u1VYQAWm
         +uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979582; x=1778584382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZeJL4p/1hA/fUCWuNw2juyWWdFBKuFTt+VDUIZEBMPM=;
        b=FNH7eb1Ct8KRhnM+bG1sFvIkSgCE/ykJJ4uu5l7tN8RUQqC7ps8LX1KSWQ9xXDlY7S
         nR/5gdYVBJcQARd9X58tL4WR5QANfVm0THbHADYdVNxkvgQphT3DWugypsKAfuiGNhgC
         hryvtJWkpQL/Vfavzvwn9FzBPJN7l62yV92D8/yZg/AP5XSZyJuLou8nl8IVNy1MBwkD
         QWAVaYM2wZqL6/Myl3RLQeKrpSXr2MXxJYIjxbcuKhw6qjay7whCVRM4hXp9YgIX9Ibp
         wj/0fr6ESGcpEknu0KT92/iUWsxV93Egm7oO+RqxEe3Uc73mXmoL0Vpb+EjMqiX31tQE
         brVg==
X-Gm-Message-State: AOJu0YxVNvewEhcYhHkYebg0RLES1HiCjWu6/oNqNbWnEPURdSOC/2lL
	U9gxyICvxYWatARiPboTke1qZpjdS+4yMtvvVzX2TayPYGHQgiZ/Y40=
X-Gm-Gg: AeBDieumq1piqTyc8CduUK3VF3VWhOJvIabQz0p4w6qLzhowvIq5ifqp/v02b55KlFq
	PC1kVGpJh1garfjJjXn3McfouFu5vhJpskuUAD5VvrXQSjhnMHtQq+9qnmpEApQ0CoPo6NwM9q3
	mQlgj/kXYDZbNC0njpKArgoyxLU0iyzU/2veWG28313nQvKhYj0ybqdoMP4QGoTaMBFbSkbHmPE
	IuKWOUlhGLu7bIjO0AcT7P+0LGKoICd+ZFwfQAiTReqxsZUsMYhit6oly9JnXSojlTzR9lJbB+J
	HZgt9BCZsV7jC0ZNrhpEYPT1b4NvhYAMTqt+2lBmqIXz2zXwz4dbczvA1gP5bFR7e5mm50LIPy3
	ogVaY740upBwRVJ6tb5RoTzozKhD8mxB94UfU3g5+ypumX/QhbEIQXr0ji2IJTaMAJBvXRLOKcU
	ZQeA0=
X-Received: by 2002:a05:6000:1acf:b0:441:2473:c30a with SMTP id ffacd0b85a97d-44bb5c425d4mr23628093f8f.31.1777979582334;
        Tue, 05 May 2026 04:13:02 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a488d8sm3786183f8f.12.2026.05.05.04.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:13:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Tue,  5 May 2026 11:12:58 +0000
Message-ID: <20260505111300.3592757-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505111300.3592757-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
 <20260505111300.3592757-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

check_and_correct_requested_length() compares (off + len) against
node_size using u32 arithmetic.  When the caller passes a large len
value (e.g. from an underflowed subtraction in hfs_brec_remove()),
off + len can wrap past 2^32 and produce a small result, causing the
bounds check to pass when it should fail.

For example, with off=14 and len=0xFFFFFFF2 (underflowed from
data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
which is less than a typical node_size of 512, so the check passes and
the subsequent memmove reads ~4GB past the node buffer.

Fix this by widening the addition to u64 before comparing against
node_size.  This prevents the u32 wrap while keeping the logic
straightforward.

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c          | 2 +-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46b..9571f33b91085 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c5..0e4268de9e60e 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.47.3

