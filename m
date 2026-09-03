Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801722370A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394873; cv=none; b=Oy3mQHniTDwQKS58TSlnQP6mbt7vmMYMFHnK8dFpT3xT411NRgOSowD87ENm9ugf+Zg5AO0N97T0poba/1BvZGAupupV4hMhnsflf6brhngPcUoqAJGK6j6iyMcl2iM/DV4YyNzYa8b14WF2gS9ZDNa45ctWNOnGCV/ms7+jOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394873; c=relaxed/simple;
	bh=mjFAKiXB7ZAxn25FoteH1IzY/8IF7hq0XuQIZiUcbvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVX3hfa3+f+iSHCuYbngNU0Ixr/LchbRiCI+4lTmg+DOmPr2dxSvVwbeHdmUE5CgnTaVIFSZIPKBGdUyu88pRGBHK2ve4V9UfqVuPKEc9eetBFWmnvMwksbeAr1GxBfmE9qgCMOcbYCK3LxBzteoswdXkzb53KJsiDBNEWXsiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/77lARf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/77lARf"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485538d3499so1265488f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394869; x=1788999669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4p+kVOqrl9TNdjQ0Ytm/XdNA1rDd6yPAPDCtXX/9+oM=;
        b=R/77lARfp+Sb4OkbWjeEDxOY/ycfah7we/aWQIz9auOmNaMqkLIqhsxAD1lsT9AMRE
         D3mpscDv7Z0WMVZlg4HIq2xgT95HjiCbA1/6cPuqQh6gr/i42zPBngLivr35NaRu4poz
         6MKBJAq/ZnOOqG07h6xNfPBroFVeyY26x2JyA+JO4D1fbppwwofGEKOHHB5jsoSZkvuT
         1C+aeg4ZAvlZGTt4WwWu0jKHMqAHEpc8D9SiOb3zbWLXE4ISpP52Q4oK6hgPYe8rSZyP
         xttsit+Ee+w7eSPeGCdP0zDYmO/hdHQIxUrjoT36kfkFibMi4bPdJ2KI5sLOTNz2Q6jZ
         EgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394869; x=1788999669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4p+kVOqrl9TNdjQ0Ytm/XdNA1rDd6yPAPDCtXX/9+oM=;
        b=CtP/7v1ShTKgz9KpsRNd2parFMtaaf4O7o2nz9ERtjsqOXAy5VanVr3qY2reIOzgAM
         ZJxh/oAisxPVaof0fnWe4JYUNXTCYRvo0ekzLFBgCjQ/vPISudcTAg/sOcDMSSISV0Hb
         D72rXDQXJGuTAtps3KkhzQjOMbL+tBkta561dhhzSJFZdokoYNicxKEDPwWAmWGFo3zx
         NxPG6ltyzjp8BzqHoT2WW/Xz5Wc1h3Y5y5qS1nHSOsLnk4m+fRPiu+y96Mep8jD4Ba+L
         P9D1M+lhoAkleZSxhKmRo8XyCoIndGh9nEj47MgbosZKWip8vTrWdkal+Wlm9pggvHrK
         IgtA==
X-Forwarded-Encrypted: i=1; AKwUvBz13Xd1tQAXdHj6q1/s8sMeutr69T6ZwkidYlG+haMVw64yxJGDj3DeJjrq59nM/wMDnl4KPugCzr5y/FhV@vger.kernel.org
X-Gm-Message-State: AFuF++nCPvwGI82VvditeH96rNSWrCg+lD0ldDdyJUCbMWmgWJZnSaO2
	fzlRHMkgZuyiT8PPlE+Iqe5YxEU+kcOX1AmJi3O8xkjd6Y8x2ljKoI90
X-Gm-Gg: AYBFou3p7sWz1qQaEKVLWIa9lrRuNTePEHKwGm7GRfQrNCnpujwJDPVzHkjbQ8XBVdY
	9TSPz00JUFA0/ucTgOKyIGinSXIZZ2v+e5qHpBGdKh0A0fvpZXLRtreM8ObEF2dZHv4kQDllWGW
	ACC8FxyBWQZ5/iZ2Reh/Z+uToTfUYHePgD7RIwd3vpyya5mG1qeN2bJB4alM14sni0Xtg9o/8o1
	rb1tjO5KvIg1rk3xnN5UUEYluVreyq0flkqB0GcTi10N4zJVRxPre3O7VyS/rC00wMALUsh+G6N
	2/Y0b8dvZdBztgnRSwibPhd4PUhHOQkXS6selkNzP0XBsxN1oE9ATVm+kCztnnY3dFAgrb6JlDu
	nis4OhqOqOe+I5ICXdnfzMvAPH+W8m0H/7xaBpVNA57aFqp4nF9XMHRjceNP59yzDMfTWx0bM20
	0S51RWlRxP1eNIK3tVSfX31P0ezxL6O4cc2VwP1Z8gNXtk/9bl5dRbbqnaKMWwWIA1vBFJ+JVAk
	kTN+VMUGiSluLOqBxD+dFj1T39b2ia46thcUzYtCvEbntAGAFsJLYTSGDgVT5lF03Kw9K4u4i85
	eXmWZQ+AQgEC8xTfmgqrKbmPZDpVfrw6YBDTOXTdkscGwoNmJwjcuQiiFHy4SzN0jQxu/PIsas2
	cMFKn
X-Received: by 2002:a05:6000:22c8:b0:484:4779:bcdb with SMTP id ffacd0b85a97d-48488deb822mr15780139f8f.6.1788394868328;
        Wed, 02 Sep 2026 17:21:08 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a1c2-c401-11b2-c123-0d12-6c0f.310.pool.telefonica.de. [2a02:3100:a1c2:c401:11b2:c123:d12:6c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea961sm9709743f8f.28.2026.09.02.17.21.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 17:21:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs_pin: publish pins with RCU list helpers
Date: Thu,  3 Sep 2026 02:21:00 +0200
Message-Id: <20260903002100.34822-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pin_insert() initializes a pin before adding it under pin_lock.  The kill
paths read the list heads under RCU without taking that lock.  Plain hlist
insertion does not publish the earlier initialization to those readers.

KCSAN weak-memory checking reported acct_on() callback initialization
racing with pin_kill() after the superblock-list publication.  The
corresponding LKMM model permits the stale read with plain publication;
the RCU release/acquire pair forbids it.

Use the RCU hlist add and dereference helpers for both pin lists.

Fixes: 2798d4ce6160 ("acct: get rid of acct_lock for acct->count")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Reviewer notes:

Tested on arm64 (Raspberry Pi 400, Cortex-A72) at cf72cbb39da8 with clang,
strict KCSAN, and weak-memory modeling.  Concurrent acct(path) and
read-only remounts produced one __arm64_sys_acct()/pin_kill() report in
the baseline.  Disassembly identified both accesses as pin->kill and the
write as modeled past pin_insert().

With this patch, the report was absent at five times the baseline
exposure, while unrelated control races continued to fire.  The LKMM
plain-publication test is "Sometimes"; its RCU counterpart is "Never".

This demonstrates modeled reordering, not an observed crash.  Plain KCSAN
also found no report in about 400,000 acct() cycles.

 fs/fs_pin.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fs.h>
+#include <linux/rculist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include "internal.h"
@@ -22,8 +23,8 @@
 void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 {
 	spin_lock(&pin_lock);
-	hlist_add_head(&pin->s_list, &m->mnt_sb->s_pins);
-	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
+	hlist_add_head_rcu(&pin->s_list, &m->mnt_sb->s_pins);
+	hlist_add_head_rcu(&pin->m_list, &real_mount(m)->mnt_pins);
 	spin_unlock(&pin_lock);
 }

@@ -73,7 +74,7 @@
 	while (1) {
 		struct hlist_node *p;
 		rcu_read_lock();
-		p = READ_ONCE(m->mnt_pins.first);
+		p = rcu_dereference(hlist_first_rcu(&m->mnt_pins));
 		if (!p) {
 			rcu_read_unlock();
 			break;
@@ -87,7 +88,7 @@
 	while (1) {
 		struct hlist_node *q;
 		rcu_read_lock();
-		q = READ_ONCE(p->first);
+		q = rcu_dereference(hlist_first_rcu(p));
 		if (!q) {
 			rcu_read_unlock();
 			break;
