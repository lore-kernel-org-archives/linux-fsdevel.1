Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503514A4F0
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809451; cv=none; b=ePakR3Np1ndNFlPwzibqc/VwkVvoLKjGkWnUPOzDkFMXXOzVxhDsj3Tc3BCDIoFY2yTBG3pR+tzj1pNZlLWc2WchuAhDABgOWL5SqjgUaYGQBdkJmlANVT+afUv2mZTREIiqmhzhEX1ymreFfnStSyzSLzVu6TH7CAs7nvTeRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809451; c=relaxed/simple;
	bh=BzcwqwmkbuNr2Myu7m9WfZdIqMCu8JCUo6H4qhFJ0FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwTfaiCkT3Y9S4LA0zVL0bB7nj5VvB8ycIXg42sUyF8xXh0xJ9BOm6/qY0VR4Gpns13IvBsbakCwcmlzbOD2LwqhX6y5eVUfsDZEACxGm1107rm5RexrP1dQ7kq1b2QduKePYJbNHT8TEBplLaDkQEYUCAatgItje5+xeuVo0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTCUKbcx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTCUKbcx"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c857fd61f8aso99926a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 22:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780809448; x=1781414248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKWyZ9RL9JnW73ObQxrP4w2rasSr9tGKj3O0aXlEuyk=;
        b=kTCUKbcxOXQyLslfOlod8raW9+5LJ98ehTeQ/xLiW/Dmd52hW7ZXDYPnVlwI/j7kNw
         OpnFNsVc9itwcnQRJFj5be1rEawFCO8Sw7sTpLeK5Cjf8hFZyZJj6T9SwFGuSqevbZAn
         20qwRtj4WcPiOufOnWHSV0E49PurlU/tkBOPVxhKaeYQD5NNvhTkSe1OZvU6ovn7pvM+
         QiG0J7Bwry+VH99bF4KwttVVLhdsiiKGojqdnJoyivWmWmnX1LDws6Gt+85d15H/Jysm
         gE3M+LmDKbIsmpu3CaP8aID0YUUaZapLNjpex06UinEdN3BwBvfy2cJnQbeEFC3VKZFq
         crZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809448; x=1781414248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKWyZ9RL9JnW73ObQxrP4w2rasSr9tGKj3O0aXlEuyk=;
        b=lXa+b+BCgC6IAz1xycojhS2Tr/3PcVk6h1LjaCcHigu8fED9RPSJtVjCCJyqLxjvwQ
         nOHg12wDegRyBvUpSGnEbMp7LvTK3cZqXbGcQYww+u/T15XI8iz3JlVUkUPhJ+64iDXn
         oWVB/9g7ll2+LRK2dK6/nMbb24B/g6QGBShQ+4wOtBq5fwskd7480isr1ZF8bH5OT+Bj
         MQdJsV+BufgMGpyBEqZx1l0oq5eXYyTHHyoAd6HtRii+oQFNAZm95V+FhSzOxS0ip0m5
         4Rqhd6PJAvSCq6aiBIUzp/uz1TKPkOp/DWahUayS87f/mWZU+DnpUhb6BmXrQeZmzxRx
         W4hg==
X-Gm-Message-State: AOJu0YxGmi+uJS+BpocQFs/OEQ3SXL4DlGOBWWgm3N2idZVA7j/M1GIK
	K5D0Cj6itifo4lUhEl5CNc5gBAnj5WlD+NVi3xKDD1O5YVptQcoqlGbmnRl6yw==
X-Gm-Gg: Acq92OHmsoix58D8fanI9BQalAlSn6idkxWDny+gD+R5Lbdpw6rqNABOoqnU94xX2q7
	ffULxWBbYZf+sB0cfzuLfIfWb6cFjWs4B+BC+f+taso+nEYNFMO9Ehz9WEpij4xh0xvI740jt7a
	qrm/1I9tdXZce1dNs5X64awMXz3XeBjDiKffFXRhGyVwuMgPpCTFdg5qxmBggvexViBZjP1nlQh
	nqfpHUMdUGuvnLl6qdPo+ub8t/yyT669SgKnFp6Lxiy+qhesI63Fuat/QfNWpUFDWOZuraXJK+j
	vwFhwoHdhZMESqteiusujughs+FFF4XZf0AJnDK70R30sg4pJcJF1e3XUVmz7eEYGKT9BOa5Om9
	ZfjxThhkzUfpFU7nqdrwU8wSaJWF+hJoqKXgaFgDAn8CG/NOU7vv3pSlR4ybmFHlo4yrM//3yOz
	KoXaSz0PWQEY4kFrTLYVGzslcs9EY=
X-Received: by 2002:a05:6a00:1146:b0:842:5a15:6fa6 with SMTP id d2e1a72fcca58-842b0e8decfmr4577687b3a.3.1780809448349;
        Sat, 06 Jun 2026 22:17:28 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm14494648b3a.50.2026.06.06.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:17:27 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v5 0/4] ntfs: finish index root lookup validation
Date: Sun,  7 Jun 2026 14:17:19 +0900
Message-ID: <20260607051723.1499833-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v5 is based on the current linux-ntfs ntfs-next branch at commit
c864077b8d73 ("ntfs: use d_splice_alias() for ->lookup() return value").
That branch already contains v4 patches 1/6 through 4/6, the
ntfs_readdir() index-root entries_offset validation, and the initial
resident $INDEX_ROOT lookup validator. This series does not resend those
applied patches.

The extent inode lifetime fix is independent of this attribute
validation work and is not included in this series.

The merged lookup-time $INDEX_ROOT validator does not yet validate
index.allocated_size. Enabling that check exposed a generic/013 failure
in earlier testing because ntfs_ir_reparent() could publish a larger
resident root header before growing the resident value. In the failing
case, the root had value_len=48, index_size=32, index_length=40, and
allocated_size=40, so allocated_size validation correctly rejected the
transient layout and ntfsprogs-plus ntfsck reported a corrupt index root.
Patches 2 and 3 are the prerequisite resize-ordering fixes for enabling
that allocated_size validation: patch 2 fixes the grow side, and patch 3
keeps the shrink side consistent for the same validator.

Patch 1 also finishes the lookup contract for resident-only attributes.
The current shared validator rejects non-resident $FILE_NAME and
$VOLUME_NAME records, but other resident-only attribute types can still
pass the non-resident path. That is unsafe for callers such as
$STANDARD_INFORMATION and $VOLUME_INFORMATION users that read
data.resident.value_offset after lookup, and it also makes the
$INDEX_ROOT lookup contract incomplete. The patch factors the existing
checks into a resident-only helper and extends it to the remaining
resident-only types.

Patch 4 extends the merged $INDEX_ROOT validator to check
index.allocated_size. The driver does consume root index.allocated_size
as the capacity field in
ntfs_ie_add() when deciding whether an insert can be done in place, and
ntfs_ie_insert() does not re-check that boundary. The validation only
rejects layouts where allocated_size extends past the resident value;
valid slack remains allowed as index_length <= allocated_size <= the
resident index area.

The current series applies cleanly to linux-ntfs ntfs-next commit
c864077b8d73 ("ntfs: use d_splice_alias() for ->lookup() return value")
with `git am -p3`. checkpatch.pl --strict and git diff --check were clean.

The same final validator and resize-ordering changes were also tested on
the earlier clean v4 application stack used for runtime testing. A KASAN
kernel with CONFIG_NTFS_FS=y built successfully, and KASAN generic/013
passed three consecutive runs. ntfsprogs-plus ntfsck v1.0.0, built from
ntfsprogs-plus revision 53943dae, reported the three resulting generic/013
test images clean with `ntfsck -n` (errors:0, fixed:0).

Changes since v4:
- Do not resend v4 patches 1/6 through 4/6, which have already been
  applied.
- Add a resident-only attribute helper and reject non-resident records
  for the remaining resident-only attribute types.
- Add the ntfs_ir_reparent() grow-before-header fix required before
  enabling the allocated_size part of the $INDEX_ROOT validator.
- Keep the ntfs_ir_truncate() shrink-ordering fix, now framed as the
  shrink-side consistency fix for lookup-time $INDEX_ROOT validation.
- Rework the final patch as an incremental allocated_size check for the
  $INDEX_ROOT validator already merged in ntfs-next.

DaeMyung Kang (4):
  ntfs: reject non-resident records for resident-only attributes
  ntfs: grow index root value before reparent header update
  ntfs: update index root allocated size before shrink
  ntfs: validate index root allocated_size on lookup

 fs/ntfs/attrib.c | 24 ++++++++++++++--
 fs/ntfs/index.c  | 96 ++++++++++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.43.0
