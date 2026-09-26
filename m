Received: from mail-dy2-f14.google.com (mail-dy2-f14.google.com [74.125.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE218388E6B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396963; cv=none; b=HAPPfEjRWR8JaVqXHPjlGth2ypOfpt//jBGLOse9/xWL6PL4mbQin0K3ZX/S4d4FTb6Pwvy86dvL3tL/odOIt57yYzLonJBbtU9z1Y3+Tn93E268Ib9i94U9VON5LzYEW5wVyMpYG9GZjMFfU0NP6HScGJXvripGXMK6KfMYfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396963; c=relaxed/simple;
	bh=AmjAixs8IBLCEzpahClBNbu2H+CLMuGIdnJO6gvSlkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jj8E5d2xhb2CiuQcPcOVxtc3EHGKVu1WJBWa6b4Qf/fooXlylK1oE2xaJ+ohp+UaxNpJoZjV//Xwd/ZKmfZgcC1PZDD+QOi2Lsp314or+cGu6Nu6ezVJRtMQnlmCxuiZrbon5oPNR1Zc/AotmasytgE6yGbTfmTSz8S7TLen5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsQISLs1; arc=none smtp.client-ip=74.125.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsQISLs1"
Received: by mail-dy2-f14.google.com with SMTP id 5a478bee46e88-328664b7528so1373342eec.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396961; x=1791001761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHcmLp5DVfoHotMAHwEml13kkU5IiEY0fdjQX09eX9g=;
        b=BsQISLs1NWvOJQ3t8kBVUQCsP2kLm4re+DRcusyZ//Bu3+lVQW10dSbleaGYw8ZbbD
         R6BAUQBEZviiwIv/+f5QaJW1HMAg8B2q9LiQcXB8LIAwrZKRew/+HGV8Pu7Yo8CA6ns2
         TCCn51TMW6CDA1KEly2Lwja6udA9v0ebzItm9dvMwDYzzD5MCMxWA1vI/4KcJUkB5wCG
         yVJkblk4qOM2tGKPLvj1YIL7CYryCXswyaMtLFE54cFyqoidPEBtzJRZP1CohbVfSI1z
         9y7/J3YNv0U+yD885hwotywITRAFrs9Cs46+Yk183KRub1wuB6WVnOBLJikLBXD753or
         dPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396961; x=1791001761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHcmLp5DVfoHotMAHwEml13kkU5IiEY0fdjQX09eX9g=;
        b=ZaTR17K5RdAorNhwaDZ1xzhcctwGUdjgQFD3qhmAqIGWxHKbjLu9BoB9Q+IuwGt5JF
         jGipeWEo1MDfp3rvy5HPQERq41LNEKiAqLq936GafLK+JW6hpwWBJ1NOTicSMNpxyqjU
         7iYjjnoZyvzti3Hlpd6byAOmHgOXCP4jVearPA9/CMR5zNmMCjmg6lmZTEZVW9AKkeUp
         5fJlVvPs/W/GpqqjHljDVNKESG9imYzXf5U/9hx+e9Tbsxk0y62QL9RULlHMOjqv/2x5
         iXWblq9B89tdzQXgyH/nY2cs0+TJyXBFSbupxmm2xCQDvFMOHx2jU62oBmOMyurrdRdu
         utGw==
X-Forwarded-Encrypted: i=1; AKwUvBz0XGNQKFKhBOHfBUege/yZu51bL/MQgPZ8kX+rVnbOedHckWGXLGrOLorrH9kokl5B1sDmlLE+C+nc6eDu@vger.kernel.org
X-Gm-Message-State: AFuF++liOQR3sBNiRcbUxk0c0qgu3NQipgyN4hIbqfgkrRdAr8TnKrTA
	wThyqIyJwP/3/mi1flgAim61sD7Eh7/xX5823jSmkGdS7NPvH+Bpc1L/
X-Gm-Gg: AYBFou34/txTGbdYZrRocHYxf32VhC/nYJIuEDvLEdC9Onqv3cUEbpYSfMLZMsw83KX
	qLGiM2BMQPTGQPm6K47H6Djkv1ThiUlfyyHHDoV38o+nDQR99sQffDF3uawfsnKRIpFVNRL6nSI
	Hzy3wJfAdOZl8FUa2ttzncOKmSe2TR/ftYeyF1+0xF57AJ6RPVgfbR4vSzQ0ztohkwGc5ZgJyXj
	IeYTQGab3k0ydCeCwnqZfrHTWGi9Avi6DYoVMSsBklHOjDxQsT+WXeLYWs+HPPcR9YPqJwx0odJ
	f3aOpotZlTyIcsfLkKhvJd8jii2Mu0pihf3Qt7ZEE6p6sWTaPNFBYx7y5tc6CCByWIqBDzVgdyC
	T2EgehmzBiDR6qXU6D6JJW1mVfCgxzOgpzwhMXc/qLA59mWyYS+WYCN3VSrQOkFT16xidVgvLZV
	eHDRad1ifI2vvqsuPurW/c8PvlYmSdtmMXBLNrF0aVkqxmWofaubWBN4rwWCn418yIHoQvs9A8y
	YbPCzBgn/zxaU45fnvnpoj9lFhSkz9EaNytW7KHJi8g2uTeuF5AZ7K7LOQ6zY2y6Dj7wqTOQwyL
	kXrTCQ+us+LSsweMRMaptYxJIdrN+7wKxyYUXYfnrtzZ6sz2Ye+RuWb1xbc=
X-Received: by 2002:a05:7300:26a0:b0:334:8fb7:1e55 with SMTP id 5a478bee46e88-342708b50dbmr1593391eec.17.1790396960614;
        Fri, 25 Sep 2026 21:29:20 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm6342963eec.10.2026.09.25.21.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:29:20 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] isofs: bound the name conversion and return long Joliet names whole
Date: Sat, 26 Sep 2026 12:29:12 +0800
Message-ID: <20260926042916.3277409-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Honza, this reworks v1 along the lines of your review, on top of your
for_next: both converters take the buffer size, the callers pass it, and
the buffer shrinks to what they need, without size asserts.  But on long
Joliet names it deliberately goes the other way: 1/4 returns them whole
instead of cutting them at NAME_MAX, and 2/4 reports the longer limit in
statfs.  1/4 also corrects the v1 history of the PAGE_SIZE bound.

1/4 is also a fix.  get_joliet_filename() keeps the converted length in
an unsigned char, so a Joliet name longer than 255 bytes of UTF-8 wraps
and is listed under a garbled short name that cannot be looked up.
PowerISO and UltraISO write such names by default (up to 110 UTF-16
units, 330 bytes for CJK).

Such names are rare: in the Joliet trees of a few thousand archive.org
images, mostly CJK, Thai or Indic, none is longer than 255 bytes.  The
images I wrote with PowerISO and UltraISO (under wine), a crafted image
with 111-unit names, and the survey scripts are at

  https://github.com/matthiasgoergens/linux/tree/isofs-joliet-long-names

(or I can post them here).

Why whole: as with empty directory blocks [1], I'd follow Windows.
Joliet is Microsoft's extension, discs with such names are made with
Windows tools for people who read them on Windows, and Windows returns
the names whole, including 111-unit names in records that leave out the
padding byte.  Scripts and CI logs:

  https://github.com/matthiasgoergens/isofs-windows-probe

On Linux, vfat and exfat already return names of up to 765 bytes and
report a limit of 1530 in statfs, vfat since f68e542f3478 ("fat: Fix
statfs->f_namelen"), and the VFS itself only limits a name to PATH_MAX
(verify_dirent_name()).  So what breaks is what breaks with vfat today:
copying such a file to ext4 or tmpfs fails with ENAMETOOLONG, which cp,
tar and rsync report before carrying on; readdir_r() and inotify readers
sized by the man page fail; and fanotify reports the event without the
name and hits the WARN_ON_ONCE() in fanotify_info_copy_name(), for which
I have sent a fix [2].  1/4 has the full list.  Cutting at NAME_MAX
avoids all of this, but lists names that Windows does not show and that
can collide within a directory.

If you still prefer NAME_MAX, I have that version ready and tested the
same way: there 1/4 cuts long names at NAME_MAX on a character boundary,
2/4 is dropped, and 4/4 shrinks the buffer to NAME_MAX + 1.

Testing: a KASAN and UBSAN kernel under qemu, 19 images mounted with no
iocharset, utf8, iso8859-1, cp932 and euc-jp, each with and without
norock.  Only the four images with names over 255 bytes change, and only
with no iocharset or utf8: their long names are now listed whole and
open.  Everything else lists, looks up and reads as before.  Under a
Debian userspace, ls, find, cp, tar, rsync, Python, readdir_r(), inotify
and fanotify behave on the long-name images, including a crafted one
with 111-unit names, as they do on a vfat with 765-byte names.  This
replaces v1 2/2's claim, whose test never ran the Joliet or zisofs code.

v1: https://lore.kernel.org/all/20260922155524.1993425-1-matthias.goergens@gmail.com/
[1] https://lore.kernel.org/all/cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n/
[2] https://lore.kernel.org/all/20260926020851.2938961-1-matthias.goergens@gmail.com/

Matthias Goergens (4):
  isofs: return long Joliet names whole
  isofs: report the Joliet name length in statfs
  isofs: pass the name buffer size to get_rock_ridge_filename()
  isofs: shrink the name conversion buffer

 fs/isofs/dir.c    |  9 ++++++---
 fs/isofs/inode.c  |  3 ++-
 fs/isofs/isofs.h  | 14 ++++++++++++--
 fs/isofs/joliet.c | 27 ++++++++++++++++++++-------
 fs/isofs/namei.c  |  8 +++++---
 fs/isofs/rock.c   |  8 ++++++--
 6 files changed, 51 insertions(+), 18 deletions(-)


base-commit: c8437ca3d4386af1ae1f2869643e82fdb9c1f0f5
-- 
2.55.0

