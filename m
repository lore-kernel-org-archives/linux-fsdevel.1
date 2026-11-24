Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560818;
	b=HxSb29BYKN83O0njevIiHoMNUQeVsj3xb1Xua4fgbjXZrVUOm67NxIzt+Xvs3N5S/VRT
	 wj6HboK6knBx5BY49MfO6ZIMToFXlggX4CN800jJSED2y1s6YW6uJoaa4zfZJy2xKyTac
	 zR8AlO0eYBpZaVey4sluHCpepFSX8Bi/kFmhjQyBkFI69XvdLohehcF9V6kmVIqs5sQzT
	 TOAjAHR9WJ+zH/nKCU7sZZoQCQyuPlbhGd00eQcVpWwSOs23mdeegs1NV90D5vi/ez6+E
	 fCvmIajv50Rmy16nCKctVINOfv885VVHhAjF/V86c31uckKlY27Sd1d179qNrt+9UGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rRSOKMys+ChZsGWn2lfJK1W6irwANpM0c+wZFPbSVKY=;
	b=y/X1gpxG5P6gwmEEWYXmoseCRFlNIreaeUQfe4jupzLkWrquib1rApam0BmFjVFzlbB3
	 bEMql3gslW4uujKpq0UOe8+emaE9xkmzNl7ieY0OiRiXPhXbcqgDlRcxr88hIozab7weT
	 lacYZ8hHICwsri1gLjr2f43O3xXL3uPyeGJomQi4Fv6yTgm+K9Bi90diJZjCLKb+Kl7sV
	 qLIP6k+pRiSFSjW3jy/ERdkvLGBFGc+pyCt/S0m5EZQeJ0Oz0eFt8ONOeM8I/czOLn1vg
	 z+Sclo6VkOhqEPPfGHJ5BZzFDONT8JHIGLlJwNrYWvR916tZe66jnSEq0v5do1P/I5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pdDD4G9w;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5A606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E5A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pdDD4G9w
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4c685c751so44807357b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795560816; x=1796165616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRSOKMys+ChZsGWn2lfJK1W6irwANpM0c+wZFPbSVKY=;
        b=pdDD4G9wQQvg0OnT+Sgn3MMa5xhGEXFufERhDMIqryAXKTU9Ovkx7gwjAm15p76ZRG
         l1abnle3/eSjHgOZd0QE+OVKUi+u4BeV67K2ROy/QxxAhWUiuZKg5ul+G7Ed3IXICzdn
         5JB+X522+h/u2mVmOhJg8LBBiWR5aM9iTsLWV3TNZ2AVd+zF1NPVKLgiMxTrbWFlDm4Q
         L0A+PVc782F3LmYvBaQJtMqdwn2APBRsRF4P2yndUMK6uMqWVK9EwBRk2Wk7oP4xrg4V
         tTUQmiRzB6sw934utXnQLGOye2nf+HS4nplhXnG2WuK61JIUP8kXtaVUX315toS4hPs5
         vlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560816; x=1796165616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRSOKMys+ChZsGWn2lfJK1W6irwANpM0c+wZFPbSVKY=;
        b=vhA8MKjk4DZye0UgRDSTNZ3nVvEujw33XwCr+0rGb774Pi1bou8RpMR2K9vnVIMIzp
         kzhBGjrv9Jag4cgV/sFnsi9VVE/JZ7Q09gNAqggt6l0BMiT2RWLWz4KF19dUpxVgfvph
         JTAb3z9kq0/yG4mgzO70+AlmkeDWL8yeYsFES06z6taPtutQQAs+AZNLccOPZiKVR6et
         3wMFiRkrREXXNck/oqjPNchdvxcSjVzFKQXED6oRw5wUHWTfc/dgBqYZaQLuvR9s5Z50
         DW0zfYC9ZobLE1p0cQInymU4VMFQxb6GAG4PvJCf7XfdHq/2B1zVqwBQg3A+bGfI+97z
         WaFA==
X-Gm-Message-State: APuU4Z+Ui01FLpB7pQJl4FOPk/jzvRhINgT5pEzlMdREbojUSikYZEnD
	HLMZUzzqvwdeglBya7cCY7SYaSEkcvpXOZjqHcA3IEaIRiANQRwv2igi/jzb4b2N6Wc=
X-Gm-Gg: AZFdTZfSHvAnCdmNqZrLSu1kj1IYjM5sTgr7sO0hG0F/8Yl6ciOXL2Ccnlsq3bM0J9d
	SflfTq4yNJKP5dtsJw5wmDbKWXtt0p1CiqDjHFxqV09wODO1VbQ11UeOrSgFkl/bgutGz8GrIgW
	S3/Ur1xYc86fAp8MPr+aEVe2VYE9XHvdNOGrUL8UIgo7On8dYkQUU/xxlrykgdCoXJ67KK5TRxN
	ItvHyagaN9gSnhyWKFeItFteJRs6mWvLH+pN5TFsgqTctyobH8Pcrlf43ny4lJj0FoQ6pM9sAHC
	Fp8WxQo624Cmj3/Kn1wEhZIny3hnQm9xK2vwPQr9zfGoMeUOikNW7rS+4MLOfhpbiMWy4E3KIuW
	cYB2ZYHc5untWFOXnyrnQDqiLVf1Ms/k6+TelB12Qh10MwbxdovNeZC+WaqsagmtuiLyvHQHlps
	xrrKNU/rZQkyIF5Z/+LAaiQUZMEJj5R1JdrR2o5hCTyfGN+bikUANfdgjDSCAiQQgY+UEWhdev1
	yP0KrHupHySXX0lPdqZsRjphAKV+nZydGSYwtdGWeRqMFjX6DqcYS/+TTKj6ARQpvTR+QSEFH6a
	X5zd6DSUmeI8bVA+kha94RxaWzfnjpfNA9lM4VonnyVHbNdUsYflakMYMbSbUbKmHWa4fJ4M4RA
	gMzSB/w0I7zULVStvf2cDE7zwoW3KxKYq5x3eNMAsv7TsH3OyEfRYIi8vaTYW6F32QGlQ+q8=
X-Received: by 2002:a05:690c:e18:b0:8b4:f333:d5d2 with SMTP id 00721157ae682-8b5204d7da7mr55034137b3.74.1795560816390;
        Tue, 24 Nov 2026 14:53:36 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:c4f2:e852:cd48:35ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b7502sm7706219d50.20.2026.11.24.14.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:53:35 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/3] hfs: fix timestamp wrapping and support timestamps after 2040
Date: Tue, 24 Nov 2026 14:53:27 -0800
Message-ID: <20261124225330.3879708-1-slava@dubeyko.com>
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

HFS keeps timestamps in 32-bit unsigned on-disk fields as the number
of seconds since January 1, 1904 (local time). Such field can
represent the time range from January 1, 1904 till February 6, 2040.

The current HFS driver has the same timestamp wrapping issue as
the HFS+ driver had: it treats any on-disk timestamp under
HFS_UTC_OFFSET (January 1, 1970) as a time between 2040 and 2106,
and it calculates the on-disk value by means of adding the time
offset to the lower 32 bits of the timestamp. As a result, any
timestamp before January 1, 1970 is converted completely wrong.

This patchset is the HFS port of the HFS+ patchset "hfsplus: fix
timestamp wrapping and support timestamps after 2040". It fixes
the timestamp wrapping issue and extends the supported time range
beyond February 2040.

The first patch corrects the logic of __hfs_m_to_utime() and
__hfs_u_to_mtime(). The on-disk timestamp is interpreted as unsigned
number of seconds since January 1, 1904, out of range values are
clamped instead of wrapped, and hfs_fill_super() sets
sb->s_time_min, sb->s_time_max and sb->s_time_gran (shifted by
the local time zone offset). This patch restricts the supported time
range by February 6, 2040.

The second patch extends the supported time range. HFS has no
extended attributes on the volume. So, if the modification date
cannot be represented by the 32-bit on-disk field, then the maximal
value (0xFFFFFFFF) is stored into MdDat and the real value is kept
in the spare bytes of the same catalog record as big-endian 64-bit
number of seconds since January 1, 1904:

file record:      FndrInfo.fdIconID and FndrInfo.fdUnused[0..5]
directory record: Resrv[0..7]

fsck_hfs does not check these bytes. It is Linux specific extension
of HFS on-disk layout. However, it is backward compatible: Mac OS
sees the clamped timestamp (February 6, 2040). If another
implementation updates MdDat, then the mark is removed and the stale
value of the spare bytes is ignored. The extended value is updated
together with MdDat in the same catalog record. So, no additional
locking or b-tree update is required. Only MdDat is extended because
HFS driver uses it for mtime, atime and ctime. The second patch
raises sb->s_time_max to HFS_EXT_MAX_TIMESTAMP_SECS.

The third patch adds the hfs_time KUnit test suite that checks
the date/time conversion logic and the extended timestamp support.

Tested on a KASAN and lockdep kernel: modification dates of files
and directories (1904, 1950, February 6, 2040 and one second later,
2050, 2106, 2200, records created with the clock set to 2055, and
timestamps moved back from the extended range) are preserved across
remount, a timestamp before 1904 is clamped, and fsck.hfs reports
the volume as OK. Without the patchset, the 1904, 1950, 2106 and 2200
timestamps are wrapped. The hfs_time and hfs_string KUnit suites
pass.

Viacheslav Dubeyko (3):
  hfs: fix timestamp wrapped issue
  hfs: store timestamps after February 2040 in spare catalog fields
  hfs: add KUnit tests for date/time conversion

 fs/hfs/Makefile        |   2 +-
 fs/hfs/catalog.c       |  10 +-
 fs/hfs/hfs_fs.h        |  74 +++++++-
 fs/hfs/hfs_time_test.c | 400 +++++++++++++++++++++++++++++++++++++++++
 fs/hfs/inode.c         |  88 ++++++++-
 fs/hfs/super.c         |   8 +
 6 files changed, 567 insertions(+), 15 deletions(-)
 create mode 100644 fs/hfs/hfs_time_test.c


base-commit: becaebec8e0f16edc0fd2426508e173f9d7bb5e9
-- 
2.53.0

