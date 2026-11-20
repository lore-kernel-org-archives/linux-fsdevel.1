Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137164;
	b=sdBvU7LvN6D4092HSvnAUohnap121am1mCeytjHcyv3HA/baKkuzcbR8sdv6AW4I8STy
	 iqU9j8iBLwrVxYpeJSgUxchk6IXGhHfMnueG/c3TwkMS2PiAb77LH4lA5lcBM56OZ3o5G
	 quZhm7u32w44NuvH1H/9eeet3k88pR1mxhBZPHe21MT02JZkQydrYXX9CTDagMYJyOSqc
	 lPnMA0c4uFf0/TBjAuMkvmS4ArQRHCtDTKs12fT8odUM3bKKZyEovqSMOAZ4Izc9D6LNI
	 7yRLdOarPMMqlBOFDESW31TT3RhJtkzSOskB+jFUgiczoHjD9YE5Y2BC+Yflh5k61qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s6SOaYq0WwPayBGOQDMxeAlx2ejhwMGEim74amxhGOU=;
	b=AHsrPIeQXYkBbnNlLVvkm7tf3syC8HOUsTuChZM+9Oi6rIz/Z/rro+PXG1KF71Jz9kk8
	 7pQkKoqY3s16MwfdcG141otuNC8/Q4CnYXL3DyAhl6qVVZ9ll7S2PeIRSKqYLRnviplu5
	 VHVqYH+c2Ild7dbxj8ZzHCfyF8o2LtD52L42lsQvEfdZam0YGNwjmt86Cy4kxK/hkL2Pq
	 50obIkKLlV6N6n/TyTWXu62b6GlOc/JohKYeptRJ2MJ1Wb/01YMgTCHYwEyPDV2VJJiQ2
	 O2YLF+IXzEZbYQtH5xGwQQgHMq4KUJf8uZ6vPS1i2i4ChOQGzKXVAuJSh8EdoQGZu2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l7wvJqpP;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAD606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CAD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l7wvJqpP
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4f4095a7aso3727567b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795137163; x=1795741963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6SOaYq0WwPayBGOQDMxeAlx2ejhwMGEim74amxhGOU=;
        b=l7wvJqpPn4BbLP4AEMApAVF6ZO9qLL5B6SsufSntxbjTEhax6MBBTlnR8psXnJfcsV
         e8n4qW63t9LXfbEEoHmFpGU7KqJbv6mPgn1P53Jerc7s/SVv1VWr5GvyoVQD11Vo8+yy
         IRqxcRBYiUZwEZfrUtcl/LGklFOhqtFkfQSYSwHi7V6T6OltHUGrqg6boyVeYwswywbD
         DuIkg21uPnFUHfMhmpCup0CBWw4pX16A6FsvqLuSuPmfpDZ8wOizJErJZtwsbQqzSMl1
         8dpWI3ubitsmd+4F7hi0JO0C4cC28E4BaABJVQATYQMJS4F2zAiuEbkP/bkbr1wI/axu
         wl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137163; x=1795741963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6SOaYq0WwPayBGOQDMxeAlx2ejhwMGEim74amxhGOU=;
        b=uElra9PNlv4AXfyTok13RoEQdHfi4e7EkrgscImp0EUJnw8G27czWqxSX56USgQPGx
         0jAD3OSXofQQCuy4UoYh9Z+VapGu0B0FL4ivB4AmyikBL5lveuN1G+Zlr/tbce9kWwTc
         z69HXlgO7guuycLCFIAVLJbXtADOQePEsVhN6KL5tpjd8WOan/z0OEdI3Ii5Kgu4oq1D
         +Ow+v6LbgWnSVNKnTTpAnAQ3/Ajvssq4xW5FPtDzbdeAiHfj3QAsGNxIunwUbGf27lyO
         F51aZVSwR4Re+uCJKVkerwe9FV25556V001E7EatAZXcu/S8d7rX6KNbye+uhtldIFEm
         H4+A==
X-Gm-Message-State: APuU4Z9dds3eBkKCFNJzeevtwFXqLL0MLzu6IanQCr8bLQ4/PPoTKHN5
	cyWCDXDyGFEfIqMeDM0gxqcICzwF3zV1rU7iNz8FBq7umr6YhOc6QgrcYsMI1F9X6gcImH7hbrf
	iI0LZcbE=
X-Gm-Gg: AZFdTZeZLJfKCu/dAmVIlkT6HtaGmwjupReW+f5rhCw01TCpgVINGfjzHxZ6OhyYMRO
	FDtTZQUYih9CTNC+fsm6NhM6pjoCu0LtJgk7UBukoNjJvhHIEZMc00S/+HsVhqytjpHYkOOTCTZ
	CobUgM3WE7JVUbBqsxxiH9/UhkoXpKmgTvZwJoxhm6JsWb9lkCmhBEpRquadpwgBJLwnKZE0p0T
	RVp7hZPK/KapusUIU6BrMkZDOI+ouWuBLUcrhFYJw7gF9imZ3bxUhwn34Hm7QLUfBELYCT1x/9e
	3QAI6xedAW4iLE/V3hqGxnHgGo0GgU/VcZIDFGnplY9FQ4BiC1d/U+nwAAj9ZW9WAbieBZsLgyl
	dQfprrkE2d1RBn610eC7ESY1d41VwDISkhVv6fdjvmFvb7omK/wzvA9a1foJhlYcIl1J0CUmn2j
	ion2O4U353knbcQMjRoP6JDrv/mNzAY4tqs6VIOzpF4EATDXjnQzNdGkkaeRCChWJ5oHdsGQTAR
	ZlG9QH3uDieXUi42i9GcgKJW2evNV4ObEbaDtJMVr6BQgfKsh1wzPiXylXmTa3g7uqymDp3M0pN
	JiZvAzslXwJTv2LN5V1Q0UI0R0kCTRu/lmgSkqke1wupPWrqykB1wKcR9zOuVMNCqqCW5Z/ZZCn
	scUWwoxiztm+ujilwKOHY25tNSw1WNkzHzSG2ifmyT0gklwRKEev422AZ60SPQcPNVzNi
X-Received: by 2002:a05:690c:6512:b0:8b5:1232:645 with SMTP id 00721157ae682-8b5204dd623mr10895137b3.31.1795137163280;
        Thu, 19 Nov 2026 17:12:43 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:a9a8:c05:b82:7f12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb08csm7461207b3.24.2026.11.19.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:42 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v4 0/3] hfsplus: fix timestamp wrapping and support timestamps after 2040
Date: Thu, 19 Nov 2026 17:12:34 -0800
Message-ID: <20261120011238.789758-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS+ keeps timestamps in 32-bit unsigned on-disk fields as the number
of seconds since January 1, 1904. Such field can represent the time
range from January 1, 1904 till February 6, 2040.

The current HFS+ driver treats any on-disk timestamp under
HFSPLUS_UTC_OFFSET (January 1, 1970) as a time between 2040 and 2106.
Also, it calculates the on-disk value by means of adding the time
offset to the lower 32 bits of the timestamp. As a result, any
timestamp before January 1, 1970 is converted completely wrong and
xfstests' generic/258 fails.

This patchset fixes the timestamp wrapping issue and extends
the supported time range beyond February 2040.

The first patch corrects the logic of __hfsp_mt2ut() and
__hfsp_ut2mt(). The on-disk timestamp is interpreted as unsigned
number of seconds since January 1, 1904. HFS_UTC_OFFSET,
HFS_MIN_TIMESTAMP_SECS and HFS_MAX_TIMESTAMP_SECS are defined in
include/linux/hfs_common.h, and hfsplus_fill_super() sets
sb->s_time_min, sb->s_time_max and sb->s_time_gran. This patch fixes
generic/258 but it restricts the supported time range by
February 6, 2040.

The second patch stores the timestamps after February 2040 into
internal extended attributes and raises sb->s_time_max to
HFSPLUS_MAX_TIMESTAMP_SECS. Such timestamp is stored as the maximal
on-disk value (0xFFFFFFFF) in the catalog record and the real value
is kept in the xattr as big-endian 64-bit number of seconds since
January 1, 1970:

linux_hfs.create_date_u64
linux_hfs.content_mod_date_u64
linux_hfs.attribute_mod_date_u64
linux_hfs.access_date_u64

It is Linux specific extension of HFS+ on-disk layout. However,
it is backward compatible: Mac OS X sees the clamped timestamp
(February 6, 2040) and an extended attribute. If the xattr is absent
(for example, the record has been created by Mac OS X), then
the driver reads the maximal on-disk value as February 6, 2040.
The internal xattrs are hidden from listxattr() and they cannot be
changed by user. The creation date is supported by the same logic,
including the hard link records. Also, the second patch fixes
the issue when the Attributes File, created in the middle of sync
operation, is not recorded into the volume header.

The third patch adds the hfsplus_time KUnit test suite that checks
the date/time conversion logic and the extended timestamp support.

v4
- Rebased on the current hfs tree. The creation of catalog records
  has been reworked meanwhile (__hfsplus_create_cat() is shared by
  hfsplus_create_cat() and hfsplus_create_cat_uni()), so the creation
  date xattr is now saved in __hfsplus_create_cat().
- Set sb->s_time_max to HFSPLUS_MAX_TIMESTAMP_SECS in the second
  patch. v3 kept HFS_MAX_TIMESTAMP_SECS, so VFS clamped every
  timestamp to February 6, 2040 before it reached the driver.
- Mark is_create_date_identical() as noinline_for_stack. Both of its
  calls were inlined into hfsplus_lookup(), whose frame exceeded
  1024 bytes with KASAN (-Wframe-larger-than=).
- Tested on a KASAN and lockdep kernel: mtime, atime and creation
  dates of files, directories and hard links (1950, February 6, 2040
  and one second later, 2050, 2106, 2200) are preserved across
  remount and fsck.hfsplus reports the volume as OK; the hfsplus_time
  and hfsplus_unicode KUnit suites pass; xfstests generic/001, 002,
  013, 020, 075, 112, 236 and 258 pass.

v3
File time_test.c has been renamed into hfsplus_time_test.c
and file unicode_test.c has been renamed into hfsplus_unicode_test.c
with the goal to exclude modules name conflict.
https://lore.kernel.org/all/20261014003731.369728-1-slava@dubeyko.com/

Viacheslav Dubeyko (3):
  hfsplus: fix timestamp wrapped issue
  hfsplus: store timestamps after February 2040 in xattrs
  hfsplus: add KUnit tests for date/time conversion

 fs/hfs/hfs_fs.h                               |  13 -
 fs/hfsplus/Makefile                           |   2 +-
 fs/hfsplus/attributes.c                       |  85 ++++-
 fs/hfsplus/catalog.c                          | 108 +++++-
 fs/hfsplus/dir.c                              |  50 ++-
 fs/hfsplus/hfsplus_fs.h                       |  52 ++-
 fs/hfsplus/hfsplus_time_test.c                | 354 ++++++++++++++++++
 ...{unicode_test.c => hfsplus_unicode_test.c} |   0
 fs/hfsplus/inode.c                            | 299 ++++++++++++++-
 fs/hfsplus/super.c                            |   8 +
 fs/hfsplus/xattr.c                            | 202 ++++++++--
 fs/hfsplus/xattr.h                            |  32 +-
 include/linux/hfs_common.h                    |  13 +
 13 files changed, 1118 insertions(+), 100 deletions(-)
 create mode 100644 fs/hfsplus/hfsplus_time_test.c
 rename fs/hfsplus/{unicode_test.c => hfsplus_unicode_test.c} (100%)


base-commit: d4558e30b83d14f59e9cac85d9e83d662491de51
-- 
2.53.0

