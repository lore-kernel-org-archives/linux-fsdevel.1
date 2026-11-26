Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710706;
	b=ZSOzjbndLGN5SzjGkwI7u7KV8NHekUfqUzeRacEqWcG329kLrUXn5GIbAMoUmXZggdDF
	 0JtLkk5VlGtWPQzhLDS2TJUpAeo4BLEeu1hL+zKemkGyU1Mo+e52uWaXmxOtZE3JoXLwV
	 7riSAOvCP0C8q0zcEUiTHZ2iYIWl3BlbdEQ9/u3geXihLBFUyH7guh+8KSfoI3mksSYkx
	 /kDn2bHo18P0lOgXKKNehY01VeBJIPBXUd2yQC0gipr4GKpRbr9Lh8j8GX/dH8z3vwiPD
	 40I6SeTzXdUc1e/AT23FLPm497Qfl6PPKx30iPV8lR0+uuMEt+kL7h08l7UgT+z1RTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OPwcu3THbOq+3XWyQQ+nL5e2PeyQBnz7B0EEXV1jfaY=;
	b=QltoI+XQiI6n9FPSa3Z+AXOxuDV1Btzlt+ubNC6F/GJ+PPq3vJR4AEUsFJFn+WTsXZFm
	 djf1dvsy0OA9bMNbwT9vxnPjMwNSl4VLIlpBZHJu+owhD3DgvngaBSjcwjs+I0cVztOZI
	 jipD+oGbvRRBBZnkTblENRv2f780qbinOQXRwSNcvbgeegwuwJKJyEUnlNr5Oh1SE/zXI
	 ESnkwq54k0TFmZOumLM6iOZsJY1fdmpGE6x791ZW7raYLamuYx6kl7zHv/EJ79hPEbyfZ
	 LKaTweBwNCyTK/lyhK2iA7XW7gnZ2BL06u4LDzSnsqdlb5ZWmwnuzkJOT+21aoU4NYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhVaPyMJ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F69606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F69606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhVaPyMJ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso56545125e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710705; x=1796315505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPwcu3THbOq+3XWyQQ+nL5e2PeyQBnz7B0EEXV1jfaY=;
        b=fhVaPyMJ7OSZKu+EfBR8QJPG6D2mMYRvOGv38yu4nUA1P3yn1DsfxVBQ0+khtEVapy
         2rKHvWryXzuJCGetU24K/q5+tTgl94BktvfxWS7UUR9ERY0H5ej9eALqz0Z7fm5Siyzf
         drLCOM2QaTY7MOaVp63tDZ5jzY++BxDTn5lvjce9YocznzQfBG8TrunqO8kaO6QQnsUc
         4ekYKo9SBTD5k4eki8wffLdGPthgAHLz/xhj9Mo8JcNXzyg9DLuv9xKijzMCOMwJpGo0
         QYNd650J94JGcDVe1VKHNp4Vf/D/0OF5wYOa7E0Wy73fqCr6hk8/4dQ+XovV2YKaVfFb
         60pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710705; x=1796315505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPwcu3THbOq+3XWyQQ+nL5e2PeyQBnz7B0EEXV1jfaY=;
        b=rQHeAKnngTkZ3867BTllI2UwRzARkTNRvERi1CLutbaxcP+DoviynxYVlY4KhmYWpP
         MAWzBcjj8p2fEyXMK8yauvy16ziKAXejpawad9z0MSgPZQNZfPDxnh1hAEizOzKjrho4
         0H5A/FpDTJXoIhuAsedAYXacV633qagmdcdYFIhAsNqShYreWiJ1IpQoMbTWGEYYxDeU
         I1vRJqq09GLt+JVgEQlJS1te/EwAJc4ml1/JN3ZOkXDcGLeKsg/FaI2dUtU3QVV6vr2U
         jFOV7S8TMdqIaTTBmrkZLFsFF/8Iu6/jVWoffYxirLMU/yUN89k+Hr96dQwNESdjNhQM
         mT0g==
X-Forwarded-Encrypted: i=1; AL+hErH97ZkvuX2mS4e3xxZYq6lWJZEoYcsYnqZB31xKMpFUFMru68f9o2amEj+A/Vq7spgXP473tROkZzLJl4sb@vger.kernel.org
X-Gm-Message-State: APuU4Z8vCJvT4lVxp1yEn8Fr22LcS9uDnxUjq5StjcQzIKEZfVEuWbV+
	VwzfE4hcVuSdSoyovwMbQhedfKFqKjIoDouGyGh7yjKU6YHBeaRhNgsN
X-Gm-Gg: AZFdTZepACxL+zLlYHZmCLl/2woiIlHf2smFlb9YbcgET7xUyQuqFzU2zDX9YuGJpv1
	y/v776MvfoXzDnQUrU5d10xLy6bufd4Zw/9sdXEWwyTN546iMlbrZXyA6nU5pOF87HyzQ7tp2y3
	GtrnPJDv5wL8UvYjvxzo9gxgCMtMG5fERz48KQns0mUtaZYyV4pX0DRosASGVhkfUD4FoVVNC4i
	q0nka9Yi/tXIRYKR1TsbmsVIWZyrGB4Tg3qNJXt3zkvHa2B5JgCrPNxMoBQV+rdrQ+teMYJRko1
	xh1DwTDq3V/+WCard68P+K6NhKy1pu2KOA6hLI4kQwcrZVjKrDUjzsx3wRzk7h5Jr4lkPINnLkf
	3gbEKyHQ+1KBCV8iZRIPX3QDLk/PylYoYMgSAZmAMQkwds0DyH4IAnSUHtK3HiJ7nHpxh7NX3Yw
	uA5h3QyehFGCH1WMrMtKth8Ee6h22HWQHR+Ea+8LarQgQC4c9uNXslL2E5qta5eYjENXSGNuiAW
	tdd8HDpp4I0I0avXZSt1VqfR3gj9sS7FRJHa+ZR8IV9bpN4780U+NFKbMOD4YbTSXX1Xm1J65wy
	nBYIARGVp7X9J/2H9Cuqxhph
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb887c3ae7mr436997625e9.1.1795710704643;
        Thu, 26 Nov 2026 08:31:44 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm721964995e9.11.2026.11.26.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:31:44 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lauri Gates <lauri.gates@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <dgc@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH v2 0/4] Add f*_xflags_{rw,ro}_mask flags to the fileattr API
Date: Thu, 26 Nov 2026 17:31:10 +0100
Message-ID: <20261126163114.403846-1-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This is a follow up patch series stemmed from [1] and [2], splitting the
_mask change for the fileattr API into its own separate patch.

The first patch is a preparatory cleanup so that the code in the later
patches can be formatted better.

The second patch updates fscrypt_prepare_setflags() to take FS_XFLAG_*
xflags instead of legacy FS_*_FL flags.

The third patch is the actual implementation, which introduces:
- fa_xflags_{rw,ro}_mask fields to struct file_attr
- fsx_xflags_{rw,ro}_mask fields and has_masks selector to struct file_kattr
- AT_FILE_ATTR_MASKS at_flag for file_[gs]etattr()

These masks have the following semantics:
- rw_mask:
  * for filesystems: advertise which xflags they support changing
  * for userspace: specify which xflags it wants to modify
- ro_mask:
  * for filesystems: advertise which xflags they support only reading
  * for userspace: ignored

This allows userspace to not have to do a RMW cycle when using the
file_[gs]etattr() syscalls, avoiding possible race conditions and
simplifying their usage.

Patch 3/4 also introduces the missing FS_XFLAG_PROJID flag so that
programs like chattr can leverage the new mask API.
FS_XFLAG_PROJID is kept out of the legacy FS_XFLAGS_MASK and so it's
defined as part of a new FS_FILE_ATTR_XFLAGS_MASK group of xflags that
will be used moving forward for any new xflag (like the one proposed in [2]).

Patch 4/4 converts fs/ntfs to this new API, to show how it can benefit
filesystem drivers too, and for this purpose adds FS_XFLAG_COMPR and
FS_XFLAG_ENCRYPT from their FS_COMPR_FL and FS_ENCRYPT_FL counterparts.

The series has been tested with custom xfstests [3] (generic/816-835,
xfs/611, xfs/673) across NTFS, ext4 (project quotas), XFS (project
quotas and extent size hints), Btrfs, and F2FS.
Note: these tests were written by gemini and not manually checked,
before sending them upstream (if needed) I'll have to review/rewrite
them manually.

Note 2: there are apparently quite a few bugs with overlayfs and a few
other issues, but I wanted to get the final API design out first.

v2 changes:
- make fa_xflags_{rw,ro}_mask in struct file_attr __u64;
- add AT_FILE_ATTR_MASKS to opt in to mask semantics instead of needing
  unreliable heuristics on usize and mask values;
- reject intermediate sizes between VER0 and VER1;
- reject non-zero masks on SET without AT_FILE_ATTR_MASKS;
- add patch 2/4 for fscrypt_prepare_setflags;
- add xflags_to_flags() / flags_to_xflags() and
  fileattr_set_{legacy_to_mask,mask_to_legacy}() to translate between
  legacy RMW callers/filesystems and _mask callers/filesystems;
- clamp fa->fsx_xflags to rw_user_mask in file_attr_to_fileattr();
- update fileattr_set_prepare() to validate capabilities and projid
  changes against rw_user_mask / xflags;
- move the rw_mask == 0 early-return no-op from file_setattr() into
  vfs_fileattr_set();
- put FS_XFLAG_COMPR in FS_XFLAG_RDONLY_MASK only (keep FS_XFLAG_ENCRYPT
  in both FS_XFLAG_COMMON and FS_XFLAG_RDONLY_MASK);
- update ntfs_fileattr_set() to apply only bits selected in
  fsx_xflags_rw_mask;

Thanks,
koraynilay

[1]: https://lore.kernel.org/CAOQ4uxg8aVcWyNiFDk8djdn-M3xJcu_7-kRxVq9jjFsbcGp1ew@mail.gmail.com/
[2]: https://lore.kernel.org/CAOQ4uxjVQ9cjV=_jBjQtNg9zCuWUEJT9KNYMKV+1jwBkHen5OA@mail.gmail.com/
[3]: https://github.com/koraynilay/xfstests/tree/patches-in-queue

koraynilay (4):
  vfs: use goto out on error in vfs_fileattr_set()
  fscrypt: update fscrypt_prepare_setflags() to use xflags
  vfs: add xflags mask to fileattr API
  ntfs: switch to the new xflags fileattr API

 fs/crypto/hooks.c          |  10 +-
 fs/file_attr.c             | 357 +++++++++++++++++++++++++++++++++----
 fs/ntfs/file.c             | 109 +++++------
 include/linux/fileattr.h   |  14 +-
 include/linux/fscrypt.h    |   6 +-
 include/uapi/linux/fcntl.h |   6 +
 include/uapi/linux/fs.h    |   9 +-
 7 files changed, 409 insertions(+), 102 deletions(-)


base-commit: 3857587d9d6fa44d40d1c73bde6a39f6f7a5216c
-- 
2.56.0

