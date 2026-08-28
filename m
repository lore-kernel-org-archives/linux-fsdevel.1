Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DB38D6BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895934; cv=pass; b=SLx5UVOUpOkZlUgKXmIuXh6AeLp9rIHJVlMMoLbaDh1MdUy8P9+cKHPlgywgqV2ET1xbLj4yZD/uzjPSecJedD/6jtdfwLY3LF1ClvuHgaOF5sxx9F/zmx08gNnNvWI2QuWC7dIKBlAuSNsJnPNP0BJG+AVYZbBT1XYAL7TPOrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895934; c=relaxed/simple;
	bh=T2fF49gHVeJcSZd+NSxaC89BuaAnThHgWNNz9fV8otM=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=kwSri6frsJ9tfRRPLZuWV0ltLpzyQ+XcZhAEIh59Hp8EEXXm9FBw0FHAKvR+v7Vko0p+qmWZp9KHvqYzyoClH0s0zBDEjI1kr5HjcFHsstMDPxpmGjdYwh/2eCCWWnkp4Qr/4Jaq89pACwwcebe34W1xMFu7sEmYL1csjcMhiak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=TgJTwuob; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="TgJTwuob"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d71a50caa9so8200855ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895933; cv=none;
        d=google.com; s=arc-20260327;
        b=Ehw94oE1RTTtq+G5ogRd9H35JGuEhqxFUjLnwZY91064bvW1Crlr/UpnTWaMXaxh7g
         B4LyfDZ4xyb7dzWomeFiYEEerfXXciD6cik3BSnd61hJPG5lOMggQnmngROlhWJ9t8iV
         PPUZnIJhdRfUKVecR+LbXYWD+aTRgYh0Sd4y+qQYOAav4XMJCmuiRlVud416MUamPRAZ
         8VwKGTS/F11GNEGs03fgVq1gUv9PMAf55r1Up1w5+JoCRDCT5pkv0pBWz6RftEnz4yO1
         nq0EMd/aa4HDGbDQjKxhHvPDYWHmr3NsPZKLkW1h1B8izCUKT9MBhmIoWuP7X99yjtrI
         uI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=MrP3fs+sBh4JTGYQXlz9sQdw6xaaN4KOuGpsYfS+xWY=;
        fh=ktgSSe/nX+9FXGmY7lCsnlx1wKBUNNvvrwuPQna7Jmg=;
        b=aoWjT0Dgro5qCYw1tths937jvwTlLitpgQ4kWDJpPfs+zVct0c6HmH0AVjLAuWNZeN
         1dZ5FmJGYsPxi+FAMXNf1ACDLq4IPBH3KhyPUbmOKEm3Ug7hLVPJGEFm84+N0FFpT5yj
         78CIMRRH6bFr06qOj8DdBXmrCDMlLsxMR4I7/y0HcHymKKRZPoz4ITeZzY0cy4Ex1aBh
         gekVGl9A9meGyybUYDKn0x/x3d2GAkFQywiX6nc7XDxsejh1KhQjN9CfXE2S5xCDY9tZ
         OhBSQnT8gWD3WjzrDdETbMxgJoQdOLufN2wtEgl2UGZM1jAV1LxY7KIRcxqIQVWlf5DA
         IfrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895933; x=1788500733; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MrP3fs+sBh4JTGYQXlz9sQdw6xaaN4KOuGpsYfS+xWY=;
        b=TgJTwuobKCkuJdYPd23NEYVYRyDh2zDf6AUyRDFNFhjRzYhnxqxvGUyCuxNdtAxV5k
         qsbqI8nI/fRm5yPGBRuO66XcCrRlsrkAe6i5713LSidVjiSl13IjjKWARBAqRSbBIPLu
         j9MKcz0FsBUh9Vo9zdaontGSS/H2PAnMCIJA6xPmQPDJgfNisreWftVolsQ4GeC02T+H
         bpPeJGZYJJRChV1lW0ehl/psTexPnbT+0zNmFfui+9YG0Ieddol5jDkakRn119+DFOb6
         4L4DIxW2jcsMTRZgDY0gtTPozewIHi0WsW+Hx/4dmwmd9g6yuUbIaYB/SMHyW6qKjz5J
         HfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895933; x=1788500733;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MrP3fs+sBh4JTGYQXlz9sQdw6xaaN4KOuGpsYfS+xWY=;
        b=Cqhs36+c8a7FM0HYxwpjUPdHGVzVjYewSCINrM7lWXonKupVftTBcLiyN6ybB13sCs
         +vLqzu4fot59stGzbONVCnW2RFCdtIp+70TRHP8QnpLtxdqKntWIT31001rw6mi3xL/T
         iX2+W0k9+j1C9Vbarx9uTqsYVjOy/gRz1f2+IyEs0ntrTIsrndNmhL/GTMG4aRclMXgF
         7kwrn/YfFG268E6siQ90DDiS4XTRXcHqqBSAQfI/IV1lOEJsPlSlm3aJQTl/YgEBjbFm
         nr3JFBSY8MFBW12+epvlufItQHMsemAf0MER+DiEZYp5bm7OBxDmUXkD8OchoHMytm4k
         iK+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZmH4ayCbz5xsxY1lO6sFidfIi/PdwdZveqAcsNvIWl1VeXhzn6cqXuPvOnmRtp5g7T8bvsUeUSvU12FqP@vger.kernel.org
X-Gm-Message-State: AFuF++mdQwllWdPjCKUzENc1z3B5mtqL9ElMejK/VNbwcUW/KWQOAtY8
	XxCzvEaAaevlwwKGTyS1ZKNLsKGgHwds5+62ciPfxntqhEfkBHAePCmMRwm1QYu4MOY+IfP47V+
	MxnbfpRglNyhDpmX5wpb6D6m9vDPoRKIrqPISbpFh
X-Gm-Gg: AR+sD101cKrw7k7BI6wYwcPunwACmI+RwvuCwzUnGwWCecP4EqIc4cqxNlQ9f4l4rjk
	UEO38Pk+nW+Lzy2C3F8+/23LFj54t9tsRda4TAs4rsIdftO0dCn1w/+M4j6KSviI5dnOCCai3Ao
	W9sEKzyqaaYNZXgozKYWgmtz7Rv40YDMPHiHELqBYEq5l+7cu3N9MbgVZ4rJmYu2JhxTRd1x6IM
	TxsHVx0oNgY/vCJJmoxIcZ2Y8B1MMgxH18WBz0KoH45W8NQfwkEuizRAAcLnW49BM4lBtVnL4MS
	Zbgb0nDDFflR79XAYZWgIA5nxjvJgFywz+1kzR0wRxuhz8zMvA7OjK+bkqI5lQlO6iQ2+5F+L9V
	I9WnCSWiQCab5EuEYmyvGGMS+FjPxe+Vd
X-Received: by 2002:a17:903:15cf:b0:2cf:ccc2:6088 with SMTP id
 d9443c01a7336-2d74dc21be0mr93296435ad.4.1787895932178; Thu, 27 Aug 2026
 22:45:32 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:45:30 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:45:30 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:45:30 -0700
X-Gm-Features: AcwNN1XQaQsSGB_JtPRDptCarl0A2Bdri9F5yBjxTPzlaSSBJSLu85_ntTJbXo4
Message-ID: <CA+0ovCiKb8axo+R-RsqzGbUsrVE0AcLbHqy=+-c9oSMCAqL1fA@mail.gmail.com>
Subject: [BUG] WARNING in ext4_journalled_invalidate_folio
To: "Theodore Ts'o" <tytso@mit.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/172-warning-in-ext4-journalled-invalidate-folio/

  __ext4_journalled_invalidate_folio(folio, offset, length) < 0
  WARNING: fs/ext4/inode.c:3432 at
ext4_journalled_invalidate_folio+0x4a/0x50 fs/ext4/inode.c:3432,
CPU#0: syz.3.369/14887
  RIP: 0010:ext4_journalled_invalidate_folio+0x4a/0x50 fs/ext4/inode.c:3432
  Call Trace:
   ext4_journalled_invalidate_folio+0x4a/0x50 fs/ext4/inode.c:3432
   folio_invalidate mm/truncate.c:140 [inline]
   truncate_inode_partial_folio+0x33e/0x8d0 mm/truncate.c:249
   truncate_inode_pages_range+0x5de/0xdf0 mm/truncate.c:416
   ext4_truncate_failed_write fs/ext4/truncate.h:21 [inline]
   ext4_journalled_write_end+0x8f2/0xc70 fs/ext4/inode.c:1608
   generic_perform_write+0x611/0x8d0 mm/filemap.c:4346
   ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:316
   ext4_file_write_iter+0x298/0x1bf0
   vfs_write+0x6f3/0xda0 fs/read_write.c:688

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
