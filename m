Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF630D3EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871702; cv=none; b=Zbytu8Sy3fcxyIRfDZty9W9QEJ0/RR+StHHT1hPZIrNazBgKedQcTzLHNoL6XBb+8vj+SKgyTXniq5PN8PrcrmcsV+x18R2GpXfyRaCHLKCNwiG0Be+mQ8EhOqMtX/wWwDstymCELDbQKiU5lGRBGMKFlWC938nxnyG79ttxkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871702; c=relaxed/simple;
	bh=j9NsMQY6+A3l8VVEIXujM44ELrEHRaFD5Gc9617Exb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=be4PbdgD6VefPbNbMuuzDWEP489gJuFk4HhDdMXuu4zA3SkD1hUGv+VuJhMQvGDw6zZGepT0TYZx3CT3i7P5mGgSH+68/7VeUIA7PUz0POG1tHiHyz1f7Qe63ACgRQgUTijSklxEbYJNTczN81ep7LVJMylP8QX7O0dyOWqBWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F44/1spK; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F44/1spK"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755a6109c1so3796023d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790871700; x=1791476500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQOSzvISQSVIJGCB1nP8Dsz4NS571X8yv9VyUYarZJ8=;
        b=F44/1spKl8GWD0P0XJsnUmWdV3oJLm8DJxySMSccGtgryiksGfM+WmKRdl/gu2u1aH
         iQzPszTlAG9hDKcRRcFQUunzhH29PYvK2jYJhaYSQFpY+TiyHbVlER1tF0hvzHX/Osjl
         IFGTmcMqFuCD0Oh2EIp/aqMWBhrozB3sSXuigDn/HX5fm3kNPU7YelB09GQuMfbcha/+
         bwBpY4tRrS3tEapBOdTxmSlZqv3gGr8BNpvpOqOZT72MmZp6Wnn8iATT1MX+zqv1Wuy+
         afma/OxXNj1SPEQecAYq1YJJ9lqarSWYSMGSHkOF0v09/Q49llmVXWYpijCh9kqGrCi2
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871700; x=1791476500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQOSzvISQSVIJGCB1nP8Dsz4NS571X8yv9VyUYarZJ8=;
        b=dAYlf3fV5WFmP77POabN5/s0GLWSvtxjviz2ofMEXlsXD9rjrwV3l0iVsZFnlrmd2i
         o+cDzA2rrUbrTobzp3I7Re9RIGpB6Ow8pXgZP2fwsXJnl6pV7ZW6Ttn5/RF+LlzjpiJg
         WkyEe0H1oR5SQlOHJSy+9otcdubAJU57AKlg8HL44qkuwUDKDJhIMUUiQOjviIvyrdg0
         vphRxAPmjSLoKF8XIZfRr2QlR5czBrNKczglW4ZlVpD0fqB5el2uvAlBj4lAyc5wP46J
         Lsu/YfOA1juDt97A3bOr+HKH412KnMeS6Ap1wmoqj/PP5r2MldzuuSr2Z4IOzejtG+YR
         /qjA==
X-Forwarded-Encrypted: i=1; AKwUvByAUjQgbedKMj43OpG1L09ju9ba6gXPvrTTSXBDm4YFqCU/DCib3SHvw8SQklbS/1dvVKroMCurTqSSi80q@vger.kernel.org
X-Gm-Message-State: AFq9FYLT0Bhg979gfVCW8yU14XEeG+5kXP65+5/BuzVNMbyhHzznTwNd
	tF4rlSySb/Y/cPUH47AFRl8fXFz7y4HocHJueySsW3OOVoiIGuvt0VQx
X-Gm-Gg: AYBFou2vsqZs/8twbR2i+F9M9ruGXb4EPCK8hSqFuyt/U3NIyVOy2OcKrDycD6A4VzK
	+ERQroS0pbY8HMR+HMPofeWBk/eaI0fISw0bFf38bmjJbPj98eYWoQHQtJ4OGPkZR5qGI8eKKZs
	GqoeItTBiWrgVjlK366Zm71JRz3Q9FJsXDU9Tz5qBrzuyjxYZO1oz8PCss46AVGgCMapuiuME/h
	XTaiJZkQt6TPvaWe+Jk2RI4DElW0x+Bti9ZaufigDfxntGVmPrpk51b76P5D4E5Sec5AJ3Q55Gj
	syfee8y85BIaAPQURttVfh+yeSEKuJ65x6c1jPB/mQLcO+CqVRiD7OlF3rJMPbKywuIQMfiAcvk
	QzpLzp9J2wVkPUcc4834+ZjgVRW8IV8Wm1W3zYNa2/35AJXnN3bZtVaMrESi/EIKWLoqjIwV6y7
	8j/+qwFL0OcaEBbUrUnayh92odfMgiJhtrXnmPS+94mP3Em+ElmdKzKOmRmCFurbN43ZZK51kQO
	QUQOzG7Y5CCKAVLYOsq2d0LHt3r52jBke5T2UC9sTIHfBIIXhQaTaN6ysFPDsJaMoHZS6CJAoYP
	5FTt2Pm4FoJwlTW+ubFlAslCRego+9FHSRgGVh8BW8aJC0oX67GkIje60Xc=
X-Received: by 2002:a05:690e:190d:b0:675:4333:4ac4 with SMTP id 956f58d0204a3-6768332b2ccmr3244194d50.6.1790871700271;
        Thu, 01 Oct 2026 09:21:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676918388b4sm1243584d50.8.2026.10.01.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:21:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hfs, hfsplus: validate the partition map and wrapper before following them
Date: Fri,  2 Oct 2026 00:21:33 +0800
Message-ID: <cover.1790689266.git.matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_get() and hfsplus_read_wrapper() reread the volume header in a
loop, following a partition map entry and, in hfsplus, an HFS wrapper's
embedded-volume descriptor.  An entry or descriptor with a zero offset
sends the loop back to the header it has just read, and a crafted image
hangs the mount.

v2 checks the offsets where they are parsed, in hfs_part_find() and
hfsplus_read_mdb(), as Slava suggested: a partition must start inside
the device and after a new-style partition map (TN1189), and a wrapper's
embedded volume must lie within its allocation blocks, which start after
its MDB (TN1150).

Every hop now moves past what it was read from, so the loop ends and the
work it does is linear in the size of the device.  For a new-style map,
a non-zero start alone would not be enough.  Take a map entry in every
block, all of type Apple_Free with a large pmMapBlkCnt, and one
Apple_HFS entry near the end with pmPyPartStart 2: each two-block hop
then rescans the map up to that entry.  With a check on the start alone,
an hfsplus mount of an 8 MiB image built like this was still busy after
ten minutes; with these patches it fails in about a second.  Chains of
small hops remain possible when each map has a single entry, and a
64 MiB image of two-block hops takes about three seconds to fail under
QEMU, the same as without these patches.  If that should be bounded as
well, v1's limit of one hop of each kind could go on top.  The
generator for these images, with timings for an unpatched kernel and
for these patches, is at

  https://github.com/matthiasgoergens/linux/tree/reproducer/2026-09-30-hfs-part-sanity-v2

Under QEMU, v1's reproducers now fail at once.  Plain, wrapped and
partitioned volumes made with newfs_hfs still mount, with maps written
by parted or, for the old-style format, by hand.  So do hybrid CD images
from genisoimage -hfs and xorriso -hfsplus.  Wrappers written by
newfs_hfs -w, for volumes up to 31 GB, pass the new check.

Changes in v2:
- Check the entries in hfs_part_find() and the wrapper in
  hfsplus_read_mdb() instead of limiting the number of hops (Slava).
- hfs: stop at the first matching old-style ("TS") map entry, as
  hfsplus already does, so that the start returned is one that was
  checked.

v1: https://lore.kernel.org/all/20260926084010.569552-1-matthias.goergens@gmail.com/

Matthias Goergens (2):
  hfs: validate partition map entries in hfs_part_find()
  hfsplus: validate the wrapper and partition map before following them

 fs/hfs/part_tbl.c          | 27 ++++++++++++++++++++++++++-
 fs/hfsplus/part_tbl.c      | 24 +++++++++++++++++++++++-
 fs/hfsplus/wrapper.c       | 16 +++++++++++++++-
 include/linux/hfs_common.h |  1 +
 4 files changed, 65 insertions(+), 3 deletions(-)


base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0

