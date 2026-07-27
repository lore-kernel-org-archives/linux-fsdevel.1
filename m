Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D506372B26
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186443; cv=none; b=jw0swvkM+2jlU6mHN5HhkU5Pd2eAoZKa8IqMPAUBVGIb3MXWE/5QvxP4T+WPH7IDQB8bgF/S5l9hpJhPiYQYGFeB2moG6QU43nDB7edxsChDUs2H4RjrmuaH8PTfoUeRiXIh5UxFQFVnHoNZemp22Bc//Y7rsqA27DyD+Pw84ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186443; c=relaxed/simple;
	bh=+gR5A1J1zjg+Bi7DzRGdnN3q58y3zgJk3D4u+2n6U1M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kjpb1lFA3MfORjH27PgjqLptfOlZDaaMejF7fSHHAg+ypkwZx+FHcBQWVePdw7n8UkWgYRmpw8lJrh+mjdlzM8qplTv7t7g2TI6kKVpW4X8vitcp+lewTfxtQUIoUbzOfU1XX54b1a5DmVuLZAysFBlEv10TazqPkkYuSFNTY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeDIir23; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeDIir23"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cea6a46766so53828075ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785186441; x=1785791241; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cq4WhpWtro5HMYWN8eGcK85O81Vkf5GCoUxt3vXYelM=;
        b=GeDIir23skhlWyNMI9awLh9deeE9nKRlnTr1FucKU88LvG1rdtQLu+tWfiqtUfdEad
         6R6/R1ardnM/OCE8FTOOt6BrvOu5YjZ2CHQhmvtCE9RZPd0ywLB+BzW+VSZRjhAVq3rb
         Grk8c9jrXqk8ivRk2iv1yDWLh8N2MO0IHhoGsmGdSyVIwOPYlaQspuHimNeRRN+yFV/2
         ywPiw0TeIwW0tL3b6t/vwvNoO1rJdYTHM36sf0CLRny1xLf4LETfhFWwmY1+xTcn6Hzu
         znwOgBVtGXsUy6Px5vI4lDsSd6IJVCfGktP9t3k1n+OVXeXqp+Yk9cA8FLa5ysYzwP7y
         ApjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785186441; x=1785791241;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cq4WhpWtro5HMYWN8eGcK85O81Vkf5GCoUxt3vXYelM=;
        b=ft+50+XmXLr9b/J1pNY3XwXoBo6TGCL4GUsZx5HiaHfvYVXY6bDNgCjzUuoNC4HeCG
         fNbDd39iYotYGFRRqFwAMj9tezhKuoywSQk5V1yt7AYV0zMO+PuVsoyr9TLOPKoVF4lO
         6fOozJpQ/TCh6whUgvuA250HoQDGwx3Kk7n4aBkvJ8QmWmvMFEY5YMjPQNeNxbRqDQh1
         pI0JaFBbEfRFd9BRMQ5DwszsFedCqgd7jgD1f7uHJCLmct0yzDlcwlVWOnIdTSVEL7uK
         xkHdaELEIF6ecM5xphz69+rWdO1Tb8ws+YLtwoqu/S7LpxGmzEyhXLZRRSKDMSQ4y3po
         GSaA==
X-Gm-Message-State: AOJu0Yzc4RaXRHHEppB98NfRKgfKNWE/2kPNwwxfX7o8aBo51bN0byn8
	xMyZu+lpZ+7nKFVPjG63FOPmprpozMUeK/xa3gIqrqPkaR6daoX20iJsbdRMIVKELaDRbbLfiRo
	MSrreiCoMeg==
X-Received: from plbkq14.prod.google.com ([2002:a17:903:284e:b0:2cc:b904:3255])
 (user=psalian job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c07:b0:2c2:bd7f:ccd4
 with SMTP id d9443c01a7336-2d00f2fec60mr7906895ad.21.1785186441218; Mon, 27
 Jul 2026 14:07:21 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:07:18 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727210718.125872-1-psalian@google.com>
Subject: [PATCH] fuse: mark DAX VMA page protections as decrypted
From: Punit Salian <psalian@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Punit Salian <psalian@google.com>
Content-Type: text/plain; charset="UTF-8"

In confidential computing guest environments (such as AMD SEV-SNP or
Intel TDX), direct memory access (DAX) mappings between the guest kernel
and host-backed FUSE/virtiofs shared memory regions must be accessed
using shared (decrypted) page protections.

Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
when establishing FUSE DAX memory mappings. This ensures guest page
table entries for shared DAX buffers are explicitly marked as decrypted,
preventing memory encryption faults when accessing host-shared DAX memory.

Signed-off-by: Punit Salian <psalian@google.com>
---
 fs/fuse/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index a15c464c8d19..00e316a7f805 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -826,6 +826,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 	vma->vm_ops = &fuse_dax_vm_ops;
 	vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	return 0;
 }
-- 
