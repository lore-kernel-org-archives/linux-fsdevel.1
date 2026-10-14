Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF471624DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938269; cv=none; b=f3GzXo6JyXP/A/tki7iAOMy7cywsx5SpU9mBRBJuAnRwVUjTsi5UQesDrEF55MFPMtQVCBm930NCA3F2pi5sc/YJExGsMiqt7ryiYJ5vCAM26Df2cagNMW6B1MLNIS1w+GsyrMZMzQkonCdvcXpGgwXbKThkcYyEZB7NRvE/kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938269; c=relaxed/simple;
	bh=Q23tQ3SZ2B1Dx4ohTp7xlh9bW8f3X69VWo/3Jr+qyaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu3ic0uun0VmJBY9pOciOmXT85TD2K/Ns6TWkwT8b+G6hfd6OqhU9xFq3Xkglzqe1yL0jYLK83VB2yyaPYgCZGNUcRZVMFZjqjkiFYq34rFrJQllrTV39b+FHaYK+pvUv9S/INAM7aFSYCaa27u7T9gwztOAc9gmRXI6fjm8Sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=wfxZx8BY; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="wfxZx8BY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67718201466so2733351d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791938266; x=1792543066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XCHmrcl04IDgYmvFgY/qxLo7KM5J6liqv+fdlxjCx/8=;
        b=wfxZx8BYDj8lIlS5IZjBs8zysmPKRegQ84UodXO65PXqeYyKo6rmlhLvdJ5HH/VdK+
         3xaEj9rrHMpv5N7ivWkBT1S0NBfxUUyCNxTKvHaA+lBrJWn7WJsu/pvOZichuPRfW6rG
         1Vyu7XcTEfPtEg4H27KibSApSQq7KBdlsecCscxH59aYnDkpn/7izxOteCSmOlhCBRLl
         YA4wm/JT6f2/nW0mSU4Cx76Vp3kR1rTUiZG5BfFdW20hm9StQ2UamOuyXBAENfHKvKS3
         XR9wZQXNmV2ZkcZnmJTCHDaCaHWYBoo9xo7dxx5diupHJ7NYMBxEF9hIURg4uNMEISIk
         5sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791938266; x=1792543066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCHmrcl04IDgYmvFgY/qxLo7KM5J6liqv+fdlxjCx/8=;
        b=0mqZ+vaYukgAWE7yDsYy0tXi/YpSJwLWVZPIonmrZkCJftIg0VB/PWov1odMrVZEVr
         JV5dY/4wVkNFzThuYmZ5cM+B+Sx4trmqzrpjwYQQ15pYDZ8YTRQS0KyPZGl/hsaTjLq/
         GsBjRkLTDGUo1pLm7WlZyTL15ZVVgCn9CBUcIG/D8YuXvTlCOAeqAdilurtAtbQYnbql
         7ZpijhOkFq08v5zKz3ObMApIO03s/IQhfruOq+14TyjC3yA+jHIcvk9WPljnPqu66T4d
         J1UJVjFDV5Rg2RnNCVP57K21SpHqYZTKrkr7F/ECHp3VVo4BlQdhwxp7G0U6aa3h4V5R
         ljtg==
X-Gm-Message-State: AFq9FYJoe3ZzD29kDQMAFiPHWBwaX6S9aKhJaizL/cyp50QGFWmgMC7F
	JvA4WnSWm2lbE0gtfXmgWI3AFt6uvzC2a9YVDCZfETyOglnD5j/DqoDqLzsarRLTpmhqZd95ymF
	b6FsrZ4g=
X-Gm-Gg: AYBFou2plyEkOcPG4mdIc8K4PhPZhKqtOgqwGihB0Rvf3ySIQA1C0JQ5acptyirR4tt
	50ksvn24U9JPqCs2mjrf1DIF/WUkgijbiLq07lcMvUto09Xhoxk5qR2CxHnZN/QJoGz6rY4xDO2
	l952h0zmxwReY6mU0BL8aHLrFnh3fXduN3QpSjThQFWRw9+BRedF6t/C62tx6B8TbopU0QRafPT
	hWGI9tFNAkgvdhzHd5/RmPQihTYAUpWECHH89dmNwIMVPXiN9VETq23qisyXI6O+LmdWTBAO4hN
	p66lRd6iJKi7x9jLFEvR/7KNhpVLMhFkt0OgXOfADeMo70tz70L+zz8Qj/7w0U4vLEjVr8YrSOi
	nSJhnEW5yZ3OmHP+CR9kupXgxEhPKHbHdS1eiYkJs8VtNiOB5AXUyBg2wa48BRIYtqLDXm69eIw
	z/hcRVi1qZCFHNMJ5EZ2cezJZeWOHhVEzDCU7FKATd/2hj9mJI8txTe5ex78LUofbaWU0tywf98
	A1uN5QaWs5e5SI9MkN7bKCsJ/nZ5GCgAD5062bmRVsJ0pYXVPGy9AAdqnu2HeICLYf2+FXRASQi
	lV2q3HRP61p9dU9mvRIjnFJM2KWE
X-Received: by 2002:a05:690e:1187:b0:675:a278:10a4 with SMTP id 956f58d0204a3-67936b0ac7fmr5643557d50.103.1791938266141;
        Tue, 13 Oct 2026 17:37:46 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:98d3:ec2f:c938:3bc1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a15c13sm463194d50.7.2026.10.13.17.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:37:45 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 0/3] hfsplus: fix timestamp wrapping and support timestamps after 2040
Date: Tue, 13 Oct 2026 17:37:28 -0700
Message-ID: <20261014003731.369728-1-slava@dubeyko.com>
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

v3
File time_test.c has been renamed into hfsplus_time_test.c
and file unicode_test.c has been renamed into hfsplus_unicode_test.c
with the goal to exclude modules name conflict.

Viacheslav Dubeyko (3):
  hfsplus: fix timestamp wrapped issue
  hfsplus: store timestamps after February 2040 in xattrs
  hfsplus: add KUnit tests for date/time conversion

 fs/hfs/hfs_fs.h                               |  13 -
 fs/hfsplus/Makefile                           |   2 +-
 fs/hfsplus/attributes.c                       |  85 ++++-
 fs/hfsplus/catalog.c                          | 110 +++++-
 fs/hfsplus/dir.c                              |  49 ++-
 fs/hfsplus/hfsplus_fs.h                       |  52 ++-
 fs/hfsplus/hfsplus_time_test.c                | 354 ++++++++++++++++++
 ...{unicode_test.c => hfsplus_unicode_test.c} |   0
 fs/hfsplus/inode.c                            | 299 ++++++++++++++-
 fs/hfsplus/super.c                            |   8 +
 fs/hfsplus/xattr.c                            | 202 ++++++++--
 fs/hfsplus/xattr.h                            |  32 +-
 include/linux/hfs_common.h                    |  13 +
 13 files changed, 1118 insertions(+), 101 deletions(-)
 create mode 100644 fs/hfsplus/hfsplus_time_test.c
 rename fs/hfsplus/{unicode_test.c => hfsplus_unicode_test.c} (100%)

-- 
2.43.0

