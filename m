Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCED423148
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515594; cv=none; b=pwKao6p4OlaWp9G3X6tS4a6LNF4aZaWIPllOLWPWEGLt4LqRweuuhxlA0dyuXaeZdKWq4PQGUdq/1Hlr4ilLnCY9dzIY7kEwhsS9ImCD3AmkeQ8wCaWSaL9LWM2GJ4EhZCXXD8TxkweDgPN4S3yY8mg9mdorlf4OXbxR85xaoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515594; c=relaxed/simple;
	bh=BFtepgnp/PlnOpupuJFh72epy+jS/rjS4N7q0VTscnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsiqEVPDMCnt1Xo7HQVS4h59WwiA3Xp8HWIJCnCPIRjMHeQS1nDDb5UWSaF//Q6zbGxKqTh/q5rPTv4O3KlR81M4Bt6yCLf8+SFKgDWX5q39w3VIxhB5jtJq18KUaPLmXRy4wFAQM7cS8rhMGrfpUXCooU2DLxm2WtpZcaVixT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxfxT8D2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxfxT8D2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8720818aeso3810295ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515591; x=1779120391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TqYJrlh6iNG/bwZqH/TNG2Kiv2CgDG6sq7EqRVuJDM=;
        b=HxfxT8D2DZ/HHTsXka4G6Gv60Te4g4iAd3zATkYTWkoaI1enxB4xo3cJ+5qEHZDTDW
         gU5GTm19O6RKNEl8WYvahigRGG9GkH6wNLOyRaQ/DDOFhszluIT3B8H/A5e67o4Ox8J2
         pQ/B9Kbbk58sjw/HdFlqKGhEFHWkzUAKLGArWBSvpuVi0WIxylb6vEl9JeHMR+Jq9E0G
         lJ2v5FK11QHhe6jqAdTiwQWYRPm+YooaaBolT/RfltpE2+rnAtcEhqTWxK2HXzbgiaE3
         0/Rm5EBrsImo7JVPcyTm8f37tuYpVTXmF/vAhsXDiFi9CSVqzhBUJxwmh3hQnSFk/WGg
         0obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515591; x=1779120391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TqYJrlh6iNG/bwZqH/TNG2Kiv2CgDG6sq7EqRVuJDM=;
        b=qWVGiZ5y+CzaNTT1osU/AmWtTlV97pOeKCItDzHY6RmsJVhd/oKXKuxFzETSqk6V2z
         4c/ux/UVkJsUqU6e1ppcI35GwMsXQMkxCYl4yPE7aGyTiW4NhgyGcb9Vy+6Fl31bseTf
         ayywZfYN1xdwJel3NjMwkLpVE9Aql+0Rfd+tetG2V9gLIsgEqQqq2hGvnBbs/q2wxI6o
         BgvYKj43+JPclMgDBWBcVt0EZAoSiqJO6DhY3kW3n6LiUMhZb3hQkJxTHlTI0bHS5YPP
         dSide+da5lh/ZnIWzwq42Y/2ObZIrpTO7gAdL8/XHhs9Xt7ed/UV3C9qqq2jXzr2FVoN
         QRrQ==
X-Gm-Message-State: AOJu0Yz5Mxrjdkqf2+LKnR2ZsBCkQAEXOMfnfpCVvPRSG0xahTfIKSmz
	2UZMNNWJZpo5CMRR5kzzQ3o5OPOlC2iGsKwq/i8PyycwlcOs/Ivnjmxu
X-Gm-Gg: Acq92OHxfXgHRUGxFV6cILPh16RRWcJyJ5r1fHExRXNf5lpCutA+nwPgTiUlBPTIaEY
	LxvtFaBOLTgNXb+yKJAjOBkIW+pG6ZkQoPYbNbjx9ZMhBsVI7VKYY440IiSCuDRa9mST6g30uB7
	ap5bST+d3nqDfMFfTiLVZLhJ/6Rg8cYkRAdyjlnV4Ra0B8NQ332Xc3kNWvrU214fjNd70r5wBcA
	PKgo590+9h30FvkUjhPj5a2MSZJkJ2qKdCaq/+JSclxUnjCsI57kYp0bDLQWoR+wOH1G/xe+tnq
	KeXsGwA82owy4hzfwrjhKhL8ZHlbNQD7ElvUKzQz2Pf1B3NCx0SRQaaTf/7y1+gwe9Nlb6+ppm9
	X6c8tI4P8CohPdL8ryoJRBZaEd79ZiHl5VNWCPeutgg81SWryDlJUKeNiO1GujMWX7RX83NTsAl
	z8Jx3VOr4m74h/ILOTejBrExGgwdY=
X-Received: by 2002:a17:902:da84:b0:2b2:eb6b:72f2 with SMTP id d9443c01a7336-2ba7f5444a2mr140161645ad.7.1778515590676;
        Mon, 11 May 2026 09:06:30 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm112447045ad.43.2026.05.11.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:06:30 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/3] ntfs: fix quota out-of-date marking
Date: Tue, 12 May 2026 01:06:22 +0900
Message-ID: <20260511160626.1268612-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes NTFS quota out-of-date marking in fs/ntfs.

The driver already has quota compatibility code: it loads
FILE_Extend/$Quota, opens the $Q index, and has
ntfs_mark_quotas_out_of_date() to set QUOTA_FLAG_OUT_OF_DATE so Windows
can rescan quota usage.  The failures were not an intentional quota block;
the code could not reach and update the $Quota/$Q defaults entry correctly.

Patch 1 fixes ntfs_index_lookup() so callers looking up view indexes get
the index entry value instead of the key.  Directory $I30 callers keep the
existing key-return behavior.  The patch uses the index root type, not the
collation rule, to choose between $FILE_NAME keys and view-index values. It
also validates the returned value bounds without truncating the minimum
offset, excludes the child VCN tail from INDEX_ENTRY_NODE value ranges, and
clears the returned context pointers before returning an invalid view-index
entry error.  The matched-entry data exposure and validation are moved into
a small helper, ntfs_index_lookup_set_data(), so the done label stays flat
and the bounds check has a single return.

Patch 2 fixes ntfs_mark_quotas_out_of_date() to look up $Quota/$Q by the
$Q index name, not $I30.

Patch 3 calls ntfs_mark_quotas_out_of_date() during initial read-write mount
as well as the existing read-only to read-write remount path.  The init
sequence is wrapped in a small helper, ntfs_init_quota_for_mount(), which
captures each call result in a local variable, derives the failure reason,
and gates the read-only downgrade on policy in one place — keeping
ntfs_load_system_files() flat.

QEMU/virtme testing:

- The original remount-rw reproducer failed with:
  "Lookup of quota defaults entry failed."
- After changing only the quota index name, the same path exposed the second
  bug and failed with:
  "Quota defaults entry size is invalid.  Run chkdsk."
- With this series applied:
  - read-only mount followed by remount,rw succeeds
  - with the $Quota/$Q defaults flags prepared as 0x00000011, remount,rw
    persists 0x00000211
  - direct rw mount with the same prepared image also persists 0x00000211

DaeMyung Kang (3):
  ntfs: return view index entry data from lookup
  ntfs: use $Q when marking quotas out of date
  ntfs: mark quotas out of date on initial rw mount

 fs/ntfs/index.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/ntfs/index.h |  3 +-
 fs/ntfs/quota.c |  3 +-
 fs/ntfs/super.c | 46 ++++++++++++++++++++++++++--------
 4 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.43.0
