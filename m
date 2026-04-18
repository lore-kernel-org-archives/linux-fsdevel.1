Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854914D719
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519608; cv=none; b=mqxJiRMuCATkhuGE0Y+fT7LKM39WoTpnM5FH1ozi1WrqwgONPO3iR9EQB1B8omq+x0IQevcZX8IBiCXK1VdxblhafDSDFqlONfcvQVU8AHgX4+hl6MexgnKNwOT3eNPQXswrer+ZGnC5W9yso5xmHC+qjw/gpW7MOXPRVe3U7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519608; c=relaxed/simple;
	bh=8MGctQEOIhl95n3bDj3JshVvxuraofGdmA3XHCuYTQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1+qkDm1gH+i1g44HVcbtqACYuXbrOR0bf7TziPCHTxoYwp33QraoJY8krQlyjJfSmcwBoDfqzpIMnn42yCbPYhnIo0NIxonORGpOit+xbMqFDQDkY1vIioxT3RkYSNEoGHVkzzzr/uPlYNkNX/mgdqcReQH1mzN3bYoOyJF+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6toEGRi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6toEGRi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso22910855e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519606; x=1777124406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdkJlOycHCsM6bLsz9d13zXHPZkF37qpGvGtla3eQ2s=;
        b=q6toEGRis1owxKyD/wRGaZVaYoLucP4EvAtysMDofGFo0zQCJ5G8XLOYSolU8DRUnL
         pCSqRAYzQgZeNkd1y4LJo3mD/0gySFqeSWbpTUK7wa+QOV9EX9H2mSt8cegwdivkQT0U
         gdqXpp0XGmP0DQVUSbeOhkt03qhEJ2JMksPszzz3QeeCmlubm209FJ7MCeZf+V5r6Xxl
         4oJFcDBU8P+zP4ibYhZMeYIEeoor4yWlRhDx2ZSnkDRLcHw95D/snvkjCQn1qJIw0QIr
         DUsTiqoT68OGzYRjcIxBMvbBWO0wWmiDHUENBZfTzoz1buuBZyzX33vC4K9LgRU8nEhg
         setw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519606; x=1777124406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdkJlOycHCsM6bLsz9d13zXHPZkF37qpGvGtla3eQ2s=;
        b=TVeQnkE93XrT54CvEJU96CH1/VPSlo20L/puFpoZDlNZges2wex1EfaqSTaESUSh71
         LEpkcoBA6w2KOTaZZC6h4dJZZzK6XH7oMR8ux1d+s/YVreyzxcQVAx/18dX21thCbC3X
         Y1RO9V14jbAVhm4yNOltRYaCLC2oX0A486grNPq8vm3riw/8sue2sd++JbvebSIpxP+k
         FeDWLBnq9xBXcFGnCzg1b4AA9eZf8j/o1SoocbeMLz6Sl0rvCUJUgz4hgG0F0jXDSb5w
         u/f7emNbSL2bb9T90HX/Ga7THmy0GRGJXxWw+wMkXbEHOTnrciwZjBWTGscRnc+OPvzI
         TZaw==
X-Gm-Message-State: AOJu0Yywp7zrn+nFCYxrrCDJ9IgTMNIpr9TJFBJ1R04C6x+AhD9QCuEK
	FdNLgjA15uy5ukR+cWyIyQfx3bRa0MLy1JA6s9IN+07JtaNHJtAG5uI=
X-Gm-Gg: AeBDiesw9mbRW1n9X1O2/bLMVHZ9AVwd/VxLMaEcgO50Ao9Jcw8M4TRLBL3YO/UyVq9
	UAyDM1JRbgYWw3jhpKpR9NMhkRN9TFcfAentoH+OliCGYsCxGWUfxfocHVLRZxu3jHeeXFiuwMv
	PuiRTODfrGvt2ROI9rEEJ2X+y/lhqp3bq/64XUMnK5rB+k496z8sR6OIbsywDHRjqJt1O8uyZX1
	3zOXLiqgsd6qc9RPg58IG7SNLW+W3fZIB6M7B/jPW9j9fzFiU5OouofkM1GTg8zDdTAqO/08qvU
	wNCswjUnCZnHqpT9U0mE3FK4Y9XmWkOXnmwS4e9DnyArdLmtZvgzPFFajH4GBWaK6r7WG3ealD3
	0DgNThTEsTpweUi8VGRZzujM99xvalGoMIoAk9wmheoFElrH5KVqDxUSW36x9pgwBKSQfhL2M0F
	wFIoe1qJ+KWAY8575g
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488fb889385mr87201475e9.5.1776519605846;
        Sat, 18 Apr 2026 06:40:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm88527395e9.2.2026.04.18.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:40:05 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfsplus: zero-initialize buffer in hfs_bnode_read
Date: Sat, 18 Apr 2026 13:40:02 +0000
Message-ID: <20260418134003.1719393-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bnode_read() can return early without initializing the output
buffer when the offset is invalid or the requested length is
corrected to zero by check_and_correct_requested_length().  Callers
such as hfs_bnode_read_u16() pass stack-allocated buffers and use the
result unconditionally, leading to KMSAN uninit-value reports.

Rather than initializing at each individual call site, zero the buffer
at the start of hfs_bnode_read() before any validation checks.  This
ensures the buffer is always in a known state regardless of which
early-return path is taken.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/bnode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff5..14d1af2c7ba93 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	struct page **pagep;
 	u32 l;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
-- 
2.47.3

