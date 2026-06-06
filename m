Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9182417D9
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761542; cv=none; b=i4K/5gR6tCTmKpm0EK9VcKI9no3cLaNHeJJIIuWUIMLOeSV/Oq5XU+2IUC8slIGJI4/+WSNsxxE6hIN9lyJ5QQimwMEnFmViPjbFNprEDk6TIvZB68DNsAYCSYVx1YMM/nn5lSSxQ4df6ZXjUsw9lHBnuD5P3Z/rSy6ZIq+22K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761542; c=relaxed/simple;
	bh=7ghTaa05473xYvvalIvjHVj3EF6ya7fZwiZEAnYVg1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gca6ZD+M/+k5UOqg5a+Z5s1v6A1j1fE467MLhIl+N20cuBenZJaoKKI+JrXzAoxYdQOjnaMrVG3Y1/EkNGFlT2Xp9uddTxa4YSTOWTlnLHetozvYhGbgj5mfUiZLn3eh4vWE2yPFBREvrNIUb4TirjXfrerOkzRYdkaaEXn21d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcyhl/3d; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcyhl/3d"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so31484205e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780761539; x=1781366339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czfg+3t80swcz1a8qcO171s6OEYhCcJhVqA4VUlsQO0=;
        b=pcyhl/3dlRiZ9ILsYO+hyGQGUihjf3MQsuGlsKj4E7ti45aYZ3CNP5STu2ooU1j+pD
         9u6LDHcmqwp9bG77b/AjUcQ9/iGG/Nyhs99kjnxzbmfL7HYXio0uVRThIIEEcm1hDaWa
         j1DCuwJB3ILnWcdk3ofvgBux3LDhwOmYIrHGuPBjOCLYC8McFpIrkC/YnajMFzqyjy7m
         TdiBjRBMCuRe+IEHeCauVHtNhVCyeYDifwDQHNe4yuMXTP2u1n1cqh0oUhhQWpRfFlah
         GAm2frBEkRNhKCr82k32c00yJZ9HvDCi1fGxc+7ZMy6TPvikbl/3VxIPOBuKsiDr8lyF
         u9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761539; x=1781366339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czfg+3t80swcz1a8qcO171s6OEYhCcJhVqA4VUlsQO0=;
        b=N3WMVQmbG7x5paj4CIjc6jdzpXt4Jvs/5KjBq8HppeY9bMBpsOLZDE64W7XbMc1m/Z
         wIpwXTNwdMDaT0flbDAkTUsXPzbirWkUVCSXngBzo2y0ipIbHVFrXjm2hfhjBXkR3Pj/
         5G446Gj2Jz7s+WWsJMgc/Kj9cSn4KsaLWkmOoa4/ZBIz40vIP1U9APEeCl9++MDjeh+E
         M6Dm3cjZTugNAEfpyxZZ8cowTZIvpAKbKthJsUj4mizhzxCfwotgV+t0Iyn3GOEsUaMa
         a8PdkcULzGIvaoZCMu+uc9JAKlQsiv2Bo26J05V4Q6na0dMtnAL3l8JsrT3aRbZoVWPD
         ukcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5mVudL9lu1O7y0nIyX4Xdmdvn8U+SRAl3tFuQD828/M8IqtMjNtqJi/5asTHALO0nsBwOBjnEY8s6z91C@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrdi9nYYLwRUcEc0b959P+3Rtol1bc3ZfHy51Ca3KbzKF8zL2b
	omIlElAm9By7hNfhJ5+W68otkFxBN0q1eocjPo0Tain4Yf5YCfxEehvU
X-Gm-Gg: Acq92OEgz7py8pKdk5F9AGYJd2BcwNggAg9SkLtdQDJLQqHFxy8fFNnMhUDlNvaXTAd
	vHO9m0eC1oBiVI+Kf0/3cMOGs3vPKsnGMTIn3pCtPqtyJZ0jQhi5ijFZlgbqiPyhyRGCKnjV0Bf
	z5U0xeQJ/1cHLrYs0BXVjR8HU/CBkmne47CxDeYsak4JtnhlMoBQ/QNEQT1rgmu/eqUmpB5PP48
	lghJST1/wYxXHHMcR2t6esHXHLLCkHrRQJe4s0xfyKm16vbqOOofJstxuFV1IcRCNcMMuveb5i4
	3eNK7QTOxwNulo5IOR7Vlcqhef4cfICmZcaUKlMiIuCI960sSlz9Zp2qioDD5j9lxeud9NgIbkF
	qQAXkUB6e73UYAOAFv2xnG2qeW40DxTIjdEPcoi0DegAFJ3yOAAul4lSK995fpHs21OTzbTZK+/
	o03MDrUlM/+XN9uJea0oLrpzylE9AUl9aYvqzKvw6FbHSwtKKmzfHF6O/tMgD4qOyd7+Arl5wZ5
	B+4fr3T1uPhmNrXlDw6kYRHgb7gHygyludMqxsrG9sdcZAIbdpfvA1eUD5bhZ43a4dnV2WCcgjX
	cQ+BJUZw+5kb/NI6vh4f3GTxLA5XiXs=
X-Received: by 2002:a05:600c:1d14:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-490c260471cmr144230555e9.19.1780761539174;
        Sat, 06 Jun 2026 08:58:59 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm212994695e9.4.2026.06.06.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:58:58 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: [PATCH] hfs: return -EIO instead of BUG() in hfs_write_inode()
Date: Sat,  6 Jun 2026 15:58:31 +0000
Message-ID: <20260606155831.506074-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs: return -EIO instead of BUG() in hfs_write_inode()

A corrupted or otherwise malformed HFS filesystem image can reach the
default case in hfs_write_inode(). The current code calls BUG() there,
which turns an on-disk filesystem condition into a kernel crash.

Return -EIO instead. The function already has an error-return path at
that location, so this preserves the existing failure semantics while
avoiding a reachable kernel BUG.

The issue is reproducible with the public syzbot C reproducer linked
below. Before this change, the reproducer triggers a kernel BUG at
fs/hfs/inode.c with RIP in hfs_write_inode(). After this change, the
same reproducer no longer triggers kernel BUG, hfs_write_inode, KASAN,
Oops, Call Trace, or RIP evidence in the validation window.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Tested-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
---
 fs/hfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..4192f660b64f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -471,7 +471,6 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
 			return -EIO;
 		}
 	}
