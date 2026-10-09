Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CF3B2AA
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581508; cv=none; b=sXlXjeIwMFevX7tRM9dHmvFmy33L1dyan82hYcv5K1ZxWH3IDr/J1fUxkyRHEm+Y5o+4szsR6o676A1nAdIn6M/FnFEuJr/JGwt31bv+6fKAjfOLhKblFARptjXpRqv/gR88v1L0HcL6QB+RDcCIiTzH58DvxhbN/B+1RALLzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581508; c=relaxed/simple;
	bh=MPGtv2AZ1TP9v9vFwWHrcMX8pWa9xOPUHHn11lgZnRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfY+dQ4J03WiLEJ0mUaKoEK06y9V5x1Viwu1b/3LhP6h+IPlVohuI59imyA68RNt1t46fgCjbsUuIBrs2mzWCHNLT7TvbX4FJS4VmdLu5uU8Hbc/OWviZehB+KjKa7JNF5wNLtIOfB1VVn5BU2tkxpACAltUzumx1YdnWASy288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ZF+zCTje; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ZF+zCTje"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac8a2ac52bso1295167b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791581506; x=1792186306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4p6ogAoD4/3+XSZTFngUeFwMjFyuyjbsuBs8Y+Bvw8=;
        b=ZF+zCTjeyUHC2rlyUyp3ZmMqqjKnk3rcgiBVY7hlE/O4sJQXqcHSiq0JeOpcKkoQBy
         RuPVzzjsCYsobo75DZoSmb8Yat0GJhmGMaW6vS1EyQFoFTfv+jHfEnKzgDwcxLi7on0W
         +KlhRfA+TQ0RwD8wuhsg7E5DC/T1wdBNo8dScd+bRzdLbDX+WByGRhOqxfHTVm+E2vM5
         hvZdOBhzLBvocsSsVAA4RcXNTjPRSd23VSQUx0+fKllU8z+Tc1NiqVHIEuLvEEeKeYLx
         +oouUZhqYz/DbzynoemC7AUuoEpvX4ib+kHEYA0gg1yMLNQYafDIpS/q3KVOdm3NmoEW
         0QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581506; x=1792186306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4p6ogAoD4/3+XSZTFngUeFwMjFyuyjbsuBs8Y+Bvw8=;
        b=mArVATxh9X2M0HVK1FarQnWm/ejD61eq36i9Jfq1SWJZIYEk6oateFobwXzPPcbadV
         9XUdN+hj6Z2uexR6E6Y3uXDUET9QiplVD9HXSKz+Zx2jaypYRv8dG9a22w8rlehzOaH+
         2UvEvLJk+GNtTCAFwpLyFRxe0V0IXmrchTM6PP8baZfBoVc/6Mkwgo8r2J8UyrHQqGwQ
         jgdGmYUeTw175ORQwI622T+qG71tS85g6Pg8K4mFsKWyMn08qgGYq41N/l3JL7v2TGM/
         DEWMeYb1zQV4wkXmmLZbbg77Xl3BxeZF5/O9+mkdUiYb6BxZWz5Jf6tiuX/Na//fTGpX
         +MSw==
X-Gm-Message-State: AFq9FYKVGDw3+/ZAMdPNqC//7Pi3cBr/xQ2R+Npql+ePEtD5ybYsWs0p
	j9TfpQzaJJGIj2Ysz3HrDEOLM+4C3DQ2UDxGXxTHCrpFtrS3aQwn0sms8jyz0/vr9yk=
X-Gm-Gg: AYBFou1pSyBInAiuPh5+TOsVBbcm5JkiApeO9MQ45yft3GjX0UExoYJsQAPnbQUX/Gs
	iD1unp+m1hIfiJJ4kPw91raYcLJcVrzqR+1jsHNumpImqjAsaNYxJzSSrpDd9T4PpmeQ+TZWpJ4
	4Cdj/G5KMsAcGxWoMZM3BOnb6cWcz6CnoIXKEbR/RtfPhhlMa6ho0Ff+pyhurl54XeN6SEJ9N8G
	h7DII0fztEr0OzSHTx9HBQVejg/vFqo+AmKD0xVd8z9b/+SYyVpnUb6M374em1B3ezvLQF1OrwQ
	LHokRZ+wocQ28L3bZsSHVpsuJ47wX3NfU+Wc5jSGryfrMmg28h77zZiCpelKXMqLZ48K14EcjGP
	0QhOxo5ZRA3/y8bbK61/0q1qPnkECjp7UZoYEaK1KKfdqqX6UPVnIdwLiqHCDniwVy8Wy3n8xqG
	KKejcdG4OrUw17gS+UEbtXJR3RPl1M9FsY6lUnkVmdDACRdFccx1k93DCtnFzuqdlb3yLakhAAN
	AHxisZJrDTv1g+FdYIKkxLDtYP39MkVU8SllGB066xHK3K4sXYcE0QXVqlIQ1GumCUCDLIsnUMF
	HWCSaL0=
X-Received: by 2002:a05:690c:5886:b0:87f:32fa:aa08 with SMTP id 00721157ae682-8b07ed55c46mr8287527b3.14.1791581506448;
        Fri, 09 Oct 2026 14:31:46 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1b7483sm12296467b3.11.2026.10.09.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:31:44 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 0/3] hfsplus: fix timestamp wrapping and support timestamps after 2040
Date: Fri,  9 Oct 2026 14:31:29 -0700
Message-ID: <20261009213132.997851-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
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
internal extended attributes. Such timestamp is stored as the maximal
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

Viacheslav Dubeyko (3):
  hfsplus: fix timestamp wrapped issue
  hfsplus: store timestamps after February 2040 in xattrs
  hfsplus: add KUnit tests for date/time conversion

 fs/hfs/hfs_fs.h            |  13 --
 fs/hfsplus/Makefile        |   2 +-
 fs/hfsplus/attributes.c    |  85 +++++++--
 fs/hfsplus/catalog.c       | 110 ++++++++++--
 fs/hfsplus/dir.c           |  49 ++++-
 fs/hfsplus/hfsplus_fs.h    |  52 +++++-
 fs/hfsplus/inode.c         | 299 +++++++++++++++++++++++++++++--
 fs/hfsplus/super.c         |   8 +
 fs/hfsplus/time_test.c     | 354 +++++++++++++++++++++++++++++++++++++
 fs/hfsplus/xattr.c         | 202 ++++++++++++++++++---
 fs/hfsplus/xattr.h         |  32 +++-
 include/linux/hfs_common.h |  13 ++
 12 files changed, 1118 insertions(+), 101 deletions(-)
 create mode 100644 fs/hfsplus/time_test.c

-- 
2.43.0

