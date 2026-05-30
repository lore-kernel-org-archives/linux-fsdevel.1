Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89FC15C
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151721; cv=none; b=nFtfZhpzmmHRWbJDRjIS3XNMVBOxD9ERDA/NH2XOBFU4fnJUZ6KIFKRkYqJ0vAtNHkTZ1HQ8guPURA/wpfc4PAQwNx1zy2FChzMA6aAw6dqBaOgOixfABIUz8dpSK4P1TcJ+zoImkYhL6Nyaqj1Fb7DCDlIRMQYwiWYwXrsYHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151721; c=relaxed/simple;
	bh=M9OAyxu5A3c3jONcZNaN7t/DPKSJJdoUFCLctmE7RRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBYBfVpOCZwZbVQxjnh5sIUfM8D1pvV7KXqMYRxOC9Xajh9vUfHXcvCsOC0rBK1OiVf1TS/jLfuOxQ8xlP66NUJ/qTPL22mFkuUCvC5VnPu6wz63ydXTCJ5nj68RmIhB/OkMsVNDtqmQ2kVj3g3lsg4ICDffhOu3U05loEyLPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnePaZhs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnePaZhs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36be5d44b36so217295a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151720; x=1780756520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyNJ76QaicL6T3QcA409V6goF+vMxduCyaXU9dzsBpw=;
        b=XnePaZhs3c4q/3GJaZ3AM2XTeBP1OZyL9QzI5uBEhVphlb6D4J8q7PnU8GcO5ULO0C
         F8JLSgKyPva8ihVawRdD5wX6t1l04jSuKwiW0MasGcz7GPfFm6V/jYz6p5Ic9eoUBxvI
         If45Wc2b4xp7hJnAm3naPAYjXuRf4ns2HYJZJGWasSFqxrG0IfTLA8bNYiOe2yAOaIp/
         OlU4naAD1YoRPWkEb8HunFvuQkqMgFcBFwYHumCuhUtZR7WKvdyZPyU2dnBS6Ji1qBjM
         io8CmMLBrUi/+AEHiUPf38NArg7J2iLgbrhDrTvBogAsoQhgYGrKL64qPYZirP8zPL3q
         nMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151720; x=1780756520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyNJ76QaicL6T3QcA409V6goF+vMxduCyaXU9dzsBpw=;
        b=kiT9mN9s1GBwR6ZTFYN20bmh0nsNQAhTbpgNAnTQ5yDniIIB6JJmOQO+yYCRIIbZZV
         faPOCqmxTrkWZVoCARRgLCclr2UVhErFIBoWEYc0iFBXoOxQ88Cac0RIZSv6CZE738Bg
         bqe8wAOK2hNtPI0GmGtXvtJN88KQbDGqOePmebO3caw/fCA5bMDOvUVQq0bSGCG4iDLy
         6CC5HanrsnveO0QtYsCo1qx2eDGoUBIY+Lv/6LVhQNMo6WRyzQ3/Gv1Um2XO6y8JINO5
         uQAmMcRGvMT/9tZW5SkV3Mh7H16agzm7usl2k92rVOPQ79sHSj3k1cbEvl/aYbXdd+Wb
         4rLQ==
X-Gm-Message-State: AOJu0YzmhtiPU+aY9TYSihJ48qIbANSdHisa/wOVcInmqTEn5InhQBC5
	uvZny2dqVUAx0FVNhhBwlWKYO9S/TAzbcFqMEltweOxdjDbiVruUod+Po3YSqA==
X-Gm-Gg: Acq92OEE2t5dr3gfRJZyxl19p8ohzeouGskEnujYlUz6rIBT26JiAzwoUlfIyl+kAeZ
	fv0ETKECtzl5VfazJeKvD5/3QBmMzD7Tq2GCfk2ZRqfTCYuJmdjwpADHHMJqRVKzoKSoGCt4Z+r
	NK7bKyCn2VDQQ74v1ng0IcxSBR0PNOvw5AofwbkFXnqKY9fHFu0t2DkDSCKSjwn3IW7n1aN4gqr
	m7nIuGqDO0KQaIIKjlcOz1EphzVikRsCevSNs8Z0YDx89AODnlxdj/VB7Aplds2pLW/2Lh5KaMw
	18tgzkjCvb0Bt/O3qe1nL4Dn9kLeXwafw+ND5iUmcUK0Q+bYS/0L0RG69bVYliDnnU0ynJ2fZiX
	IuLhF9AA6SPPTGHTAed5XpjG2jvDgjTqL1+vGg9EOSBJMMzAhfsKiHM6DhX4ITM1ldoR7BsRUvl
	ZqiYbOCVHuB4aijqC3ncChcALYwA1TUgWmk0FGYg==
X-Received: by 2002:a05:6a21:4596:b0:3a3:2819:5d41 with SMTP id adf61e73a8af0-3b427f33678mr2039963637.5.1780151719811;
        Sat, 30 May 2026 07:35:19 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:19 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 0/6] ntfs: validate attribute values on lookup
Date: Sat, 30 May 2026 23:35:08 +0900
Message-ID: <20260530143514.3083601-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v4 supersedes the previous single-patch v3. Per review, it expands
the lookup-time attribute value validation into a series so $VOLUME_NAME
and $INDEX_ROOT can be validated safely.

The first patch keeps the original $FILE_NAME corruption fix and moves
the duplicated non-resident mapping-pairs metadata checks into the common
attribute value validator. It also keeps resident value matching in the
external attribute lookup path on the actual value length and fixes the
matching attrlist duplicate check for resident attributes. The next
patches prepare the volume label write and mount read paths to cope with
a rejected $VOLUME_NAME, add $VOLUME_NAME validation, fix the
ntfs_ir_truncate() shrink ordering issue, and then enable $INDEX_ROOT
validation.

Changes since v3:
- Expand the single patch into a 6-patch series as requested.
- Keep corruption messages using numeric attribute types and drop the
  attribute type name helper.
- Move non-resident mapping-pairs metadata validation into the shared
  ntfs_attr_value_is_valid() helper.
- Preserve resident @val matching in ntfs_external_attr_find() using the
  actual resident value length, and avoid reading the non-resident
  lowest_vcn union member when checking resident attrlist duplicates.
- Make ntfs_write_volume_label() add a replacement only after successful
  removal or after -ENOENT, and propagate other lookup/removal errors.
- Reinitialize the mount-time search context before the
  $VOLUME_INFORMATION lookup, since a rejected $VOLUME_NAME leaves the
  context in an undefined state.
- Add $VOLUME_NAME-specific validation, and reject non-resident
  $VOLUME_NAME records like non-resident $FILE_NAME.
- Include the ntfs_ir_truncate() shrink ordering fix.
- Add $INDEX_ROOT-specific validation on top of the shrink fix.

DaeMyung Kang (6):
  ntfs: validate attribute values on lookup
  ntfs: do not replace volume name after lookup errors
  ntfs: reinit search context before volume information lookup
  ntfs: validate resident volume name values on lookup
  ntfs: update index root allocated size before shrink
  ntfs: validate resident index root values on lookup

 fs/ntfs/attrib.c   | 203 +++++++++++++++++++++++++++++++++++++----------------
 fs/ntfs/attrlist.c |  11 ++-
 fs/ntfs/index.c    |  18 ++++-
 fs/ntfs/super.c    |  12 +++-
 4 files changed, 174 insertions(+), 70 deletions(-)


base-commit: 8553f258a57607dbde0b8baab47459aa28eb92f7
-- 
2.43.0
