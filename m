Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF972246BC0
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933769; cv=none; b=BNlFgtUw9JWO4rB5b8qDQyMPM12MfD5CfgNitkRWJeJllIvO/crSC0eW9GyXnViywONaaFV1gTi0jSiZco9nMn0lgkwWv/DGgXCDRxRazgKtr0Qw+77kikgZET19wqwbBeWAYdnpB36SuilONOqQl3MWEuh/GMuIVyoLiUL5ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933769; c=relaxed/simple;
	bh=5RZ0q9GBw4BddYSwEQNkwJXmfz6KXYHDKBEbwwKM0JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWRwv/JVjW1FTuK/NhQYdhZEd/8B0ZmAXzTZxLpewfBteJxodRtWjS+eVNZDbvPi5LJX58PCNEGhWJve/9w0bhtTysJXA8v7sLb42fvfEp+NF351cn2PxmvjA3sjtdR2DGxDhmCT3Oj8kiDbDMFPCHtIQyL5cOPX53tQivUh3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgUD4ahP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgUD4ahP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-841ad134423so138491b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933767; x=1781538567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Q/wvt/PJjPoRpqikIilrV4ar4F5+3eDDF7cIerGlQ=;
        b=LgUD4ahPxdF5NaiU0WEZZbgfkggO52m200neWx268U31JwYsrWphwF1ma6WuCBbSmY
         vY/Wu2Y+XQ6oNI8Vv9/tObqzEXLaqsHn8D5lM+9jBPpimeVQnZMTj6BsFtyyShdO8frs
         IRXLs3z9r9F5UIrR/Tr/BE7Jd0KV7jxj62+IW0dkKEofpKEU8hB7rEE7b9FXz71yZgGd
         VtmAWk6l2SdgVMNbSUJYAoMtlhFfrbj1Zy4O7x0l6uxeYTKLfdTRBUd2HhpqP2orX0Xd
         81Vom/b/opotP0ok5jLko5T6HUksK18+KlTn2kIgGaGB+gTUJcUCNgMT9+0eYqjePnxG
         3TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933767; x=1781538567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9Q/wvt/PJjPoRpqikIilrV4ar4F5+3eDDF7cIerGlQ=;
        b=OoFzVbcazF7wUbWl1BWFcuZqPnaLWTidMdwPOOWlIvguPWkNUkWp6RmdPNm/9TKM3v
         HC5aOy9FHAVCK3IXaFZuGfEIIBdVs8Pib4nHSySRskvfpWF2yJfd6+Bynmr9EGqVd25J
         0uTkt8nC27hpXHGv/Q0/okA7ob5pUNLFIreeH0+cgfCkdcoD9commV2qrrzxdjhsaFd4
         a/BuW8ZcAwrUVw0yFekraw3cuLfJZMRTcsF/kZv6OKXrZFUU3fTDqJt4Qs9FbN6vuEey
         OnUWitZY2CoejFrGCk5Jf45lECQCU+pppgcWbeocfZ/6CCKLyJe7uWBYWhzQKBiSl0EO
         IGBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fQj7E7x986RgxR32khOUgk5zbmFiOksiVvRZtfxP8Bk5vg9Y5XiTiEFb2UESBk7d/gWdueTwHfewM4LaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyIy3Y9ktn7nNMfZyl4Ge2FgvDmWnMCrUuPGq2SOUtx0Gb1gwpr
	/sVmGE/L3+sVO7GQkg5xFLI9rkiqF1vXprS8BJ6OIsyEI/yikeJg0bxd
X-Gm-Gg: Acq92OHdPcIXCc8K16y/qnPx3cf9zpG5bq4LvNZyMepRAXV7h4rmgBJiJ4uPsebengi
	d+Nnu0D6bgs2tAzPzQGvjrZJ9pNvW9PqCgxQ8a2f7E4z0lM8ftmxhpND6Q07tfOJRyg0HGGSVtG
	lhBJ3WetcRpm/Pd/RpOvSuH5gecgyhceRSVUJLnwmSBRKIE9Robm+DSIo1iBjpz1N3edz/O05QT
	gQNrm5SHPMfSv0wVZIx1ej4z8hruByDr976/RYvQruqiG8nmNYcYLP0XgZ8pO2uww62qAgGpw73
	GBBhVcvDDUqRutACSX5bA4yYnbszcU1xBrAftiKpACkETyx08YeXG/lEULxH8ZQxtKdIqQqbmYQ
	lv19QEn+UPHeYyNjyWnTJSzmlRIclfjiHSIgJlhdLDTKWuxAg7lJZykdZ515DAQYOcaLtxbk0Zf
	kd54TKx4zLDZ/vUW8kMHBGZtwqfig=
X-Received: by 2002:a05:6a21:6f89:b0:3b4:6f05:8301 with SMTP id adf61e73a8af0-3b4cd48fbd0mr8679527637.7.1780933766975;
        Mon, 08 Jun 2026 08:49:26 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm15937526a12.18.2026.06.08.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:26 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v6 0/4] ntfs: finish resident attribute lookup validation
Date: Tue,  9 Jun 2026 00:49:13 +0900
Message-ID: <20260608154917.2703739-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v6 of the remaining NTFS resident attribute lookup validation
fixes, rebased onto the current ntfs-next branch from git.kernel.org.

v5 was generated against the temporary linux-ntfs ntfs-next test branch,
where the earlier lookup validation patches and the initial resident
$INDEX_ROOT validator were already present. That made the final
allocated_size-only patch depend on context that is not present in the
official ntfs-next branch.

This version is generated on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
  branch ntfs-next
  base: <b3f6cd1d54aa>

The current official ntfs-next branch already contains the earlier shared
attribute-value validator, the volume-name error handling fix, the volume
information search-context reinit fix, and the resident $VOLUME_NAME
validator. This resend therefore contains only the remaining official-base
delta:

- reject non-resident records for all resident-only attribute types;
- fix the $INDEX_ROOT grow and shrink ordering so header capacity never
  exceeds the resident value visible to lookup-time validation;
- add the full resident $INDEX_ROOT lookup validator, including
  allocated_size checks.

Changes since v5:
- Rebased onto the official git.kernel.org ntfs-next branch instead of
  the temporary out-of-tree test branch, so the series no longer depends
  on patches that only existed there.
- Patch 4 is now a complete resident $INDEX_ROOT validator. In v5 it was
  an incremental allocated_size-only change on top of the out-of-tree
  validator; the resulting validator function is unchanged, but it now
  stands on its own against ntfs-next.
- No functional changes to the other three patches.

Testing:
- Applied this 4-patch series on top of the ntfs-next base above with
  git am; git diff --check is clean and scripts/checkpatch.pl --strict
  passes on all four patches.
- Built a KASAN kernel (CONFIG_KASAN=y, CONFIG_NTFS_FS=y) and ran it
  under QEMU against fresh 512 MiB NTFS images: mounted each read-write,
  created 12 directories and 2160 files, then renamed, removed, cleaned
  up and unmounted. Repeated three times; no KASAN report, oops or
  panic, and ntfsfix -n reported each image clean after every run.

DaeMyung Kang (4):
  ntfs: reject non-resident records for resident-only attributes
  ntfs: grow index root value before reparent header update
  ntfs: update index root allocated size before shrink
  ntfs: validate resident index root values on lookup

 fs/ntfs/attrib.c | 49 +++++++++++++++++++++++-
 fs/ntfs/index.c  | 96 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 111 insertions(+), 34 deletions(-)


base-commit: b3f6cd1d54aa279cc4f47aa27939ebe517a2c390
-- 
2.43.0
