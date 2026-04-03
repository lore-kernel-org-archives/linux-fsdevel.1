Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFE285C8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257578; cv=none; b=RUPvxZSOC7k5utDzkPfsQco+Oi1/7T2GG3H3Fq1i+yRBDLGfKLHjrXTrFm6gp/oce1JHUy6VsSh3gmJubIZ190hS69VXOVU3VQEkWw+tGos9p/qKgEh6iND78TMw1r2vBkRoqzHGOdYyxgHtO/4g3aPXkBREZGr35ADdfkcVXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257578; c=relaxed/simple;
	bh=pvbSOYF3KFeQhvZWqc60K1gTwqnA7im6/bs5xNZxqNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HywM6ZjJc84yW452q2xbwaiNJ5weg+XxehbXugwQuI1Be4maZJYQIxbKltNLepFzp+Hkc37DrDK2LN++SDolcBnKbPyaOlMP1ALuQuMeyJwX+7JA32l+vaySABbm9Qtmz2TVHp3LzHklhRaw63BMWLEJXu4GqhDXUB9KWwlxf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=p/YlebWA; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="p/YlebWA"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7d4ebccf7so2128455a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257576; x=1775862376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzM6tPKkuV+K3fWiil6mj2XI3cNMVZv97y0FPMb8uXk=;
        b=p/YlebWAK3bVwzf9vwD0yIjYWqiijcll7o/HdcAF00DAMbpeaSLDzdFRty0JmcYBEL
         CXN6trMq8IwPcHnSb6HGrg8hH3q7d4DpsY0u/4OIivOWaLmyNYlZn3JRWc5c/5wjlEA3
         ehmAuHlrHsimQooOlF4jC3LF1NIy6+38hj3MySwB04BkVODW76j0KmVXQ/N84SavXTRM
         dR15n39BDLuwCPmcOIGmUl9w04ngEqafX25oawNG8JJlOSdEb6o0IshX76OTIWqSahSM
         QIxfG4aOBDdmWyfwTkTUceJx2Fw0XvhrH3hKuvHZIVaKucvsaMJMo4bNGiVZaNa2oaNS
         Zpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257576; x=1775862376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzM6tPKkuV+K3fWiil6mj2XI3cNMVZv97y0FPMb8uXk=;
        b=MZ1ulc0zrnKQ6xvsuzj6/HJZG90gmJdMEYPWnjMLWQYGa4xofy0gDbSFgA8s9MzFml
         g43mxcPfsoPxlRpUKLw8dcRmfMr+isGPpMxZKbU2zzVRIV+Ni7THvYjBj1lk1aOEBt8T
         vWa9dQdp17570oDawMdzF9tl0bvBL4B1c8htVPRqQ8Do2USOA6govBIufEUtruSb5vDX
         Napcy3y1Ki/Qc5IqHJmXz45324bzwykek3FscbTizFw3tKBelNTxKakXiounjg5MUDez
         oseRb8Va+2Eljjqkx97LgCsSysULpgAmrAIXfrLUTDJCb8sX3i2HS+GsJNLXYzWKxTfx
         7rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUiLrp1dguPVLrg9Kfag8RN7Y1piMaUCxe+7Em/mszN/cog1rXnWepWO0c9QXzHbIHocO7GbmEk70eNIjAG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88j9iw//tnK4mhcmmQXOqvry9U+x+hlQprKi863Rox/CRdILy
	gA7wnPJCh3/HiQSuGZpHOTPszmedBaDU957hh4RMXGARpQN2zuECNKuCcF8uuSKT+es=
X-Gm-Gg: ATEYQzz1bJCcMi/2+MXCcGVl80+tRmWvCy8fszMb8znY/WyT/jGhclMZvAu29TeQ0Hf
	W/geEPhAaJwTgJoY7imKOGVawlhCOHiAu83pkFvrArP8EsH+6A7GirR86w+eHH0Dyd7I2aRpXEg
	i0A3W9PsHOqv6gjUSwZlTHSUhgxRSXusfMruOKcF9H32v+TziCK7F/oZozQsb01B90Y3LSzaHMf
	1RH8icow5KU18feF7THbvojCPv4ankU0mUEQuBKRwgWh5z+94z8sSTfyWI/dqwVpKB1Gld59Kbx
	ka2/iWA/9uIUxuYamVaG9PTbXB4xD7qhjemOZbyjrpfss15rd9iWXwEbhL5FM4zVk1uBuHoC8HV
	aC/nzbQqkViC2lzPOfoz3Bd1P3ujOZe2MZVnwrlHU4iB94EYQxSCw3DCV8EdWvOeyUDVX5n/EEv
	llJuDmsByRiVJ/shTP/CHYV0Ncc0SRVFSdbdst1T4E2Wr9Skr2Vu/k9juDC1LMtciZOUZvEzt8Q
	WeM3RTL3UraChJsGo5j1kI5
X-Received: by 2002:a05:6830:61c8:b0:7d9:b58e:55ed with SMTP id 46e09a7af769-7dbb754734cmr3656051a34.25.1775257575962;
        Fri, 03 Apr 2026 16:06:15 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:15 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/5] hfsplus: fix b-tree logic issues
Date: Fri,  3 Apr 2026 16:05:51 -0700
Message-ID: <20260403230556.614171-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic/642 failure uncovered multiple issues
in b-tree functionality. This patchset fixes potential
race conditions in b-tree functionality, error processing
issue in hfs_bmap_free(), logic of alloc/free b-tree node.
It reworks hfsplus_create_attributes_file() logic by introducing
a specialized method of hfsplus_init_map_node() and writing
the allocated map b-tree's nodes by means of
hfsplus_write_attributes_file_node() method. And this
patchset adds calling of hfs_bnode_unlink() before hfs_bnode_put()
for the case if new node cannot be used for spliting the existing
node.

Viacheslav Dubeyko (5):
  hfsplus: fix potential race conditions in b-tree functionality
  hfsplus: fix error processing issue in hfs_bmap_free()
  hfsplus: fix logic of alloc/free b-tree node
  hfsplus: rework logic of map nodes creation in xattr b-tree
  hfsplus: fix generic/642 failure

 fs/hfsplus/bnode.c         |   3 +
 fs/hfsplus/brec.c          |  32 ++++++----
 fs/hfsplus/btree.c         |  22 +++++--
 fs/hfsplus/inode.c         |  15 ++---
 fs/hfsplus/super.c         |   3 +
 fs/hfsplus/xattr.c         | 127 ++++++++++++++++++++++++++++++-------
 include/linux/hfs_common.h |   2 +
 7 files changed, 156 insertions(+), 48 deletions(-)

-- 
2.43.0

