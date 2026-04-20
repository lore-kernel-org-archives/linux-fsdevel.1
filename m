Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC73AC0E9;
	Mon, 20 Apr 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691965; cv=none; b=BZ7alHeCDpvlGciXWgG6CnvhbGzTmxHIq3hCCRkkpfGwNQ238dKggybeuallLRVGM5mYCEw3JDkHr4JQ6HUDD/c97gNnT8VKeolPsdVe0FDykBr05NqZNmIr6X6oZ2ZP/9Ox/m2Zpi8CWhPNBsacaSWJjI5QI4izc3strFGS9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691965; c=relaxed/simple;
	bh=iGKUrAWyqAzRf4aYmyWkH/uQRw9E60UxprO7RB5zYwE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DU55g7zXfc8UiF/noDpoQ6pYB/SFQvINNrOQl1YPwDPJWmoeQoee6UwPamwXpMwQXElOjLvSSbNe4l9HHx0eIwtOc5QeDJnN4ZY06ePgjJFGxBnRnVmB3kWZGvrmLP/8webgc7tEGb/ZKPbgky5m14GZtIbkR6sMlQTzuqS2Feo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nittEY/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nittEY/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7237C19425;
	Mon, 20 Apr 2026 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691964;
	bh=iGKUrAWyqAzRf4aYmyWkH/uQRw9E60UxprO7RB5zYwE=;
	h=From:Subject:Date:To:Cc:From;
	b=nittEY/c+VSluIreEAfYfv9NCL+EmNqWWNblT4T+rFGdamBUai9afDvQ66KTSjiZY
	 hYE9IHOnhZzi3WkGT5EmZvtX2MpEM7cHRcDnlHlpsqqqyy6w3TbdkFvqXPQaRqp39q
	 xeCV1J1xsB1+5pIzbMFAIBreC3mUip2QcKA7S7emyRM2l2+eZUaNwG6sCyCG5hbWMj
	 sP/Ee3Dq33bLzkViWHXwoRzJQctFHn9Cukm81Gci9u+SQwScKTeV+f0AKfHSVpZWGS
	 mKU85NZlbB+8pvVga2q/GUOhZe3lPcHTqjBHPgbJ2NIh0hqj0DNjngv0j27B/wSGW+
	 /celYI0WJd+FA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] pidfs: small fixes
Date: Mon, 20 Apr 2026 15:32:34 +0200
Message-Id: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMq5mkC/yWMyw6CMBBFf4XM2ppS+xj4FeOiLVOpRiAdfCSEf
 xd0eW7uOQswlUwMbbVAoVfmPA4b1IcKYu+HK4ncbQxKKiu1kuI9lruYcpdY2NoodE1q9EnDJky
 FUv78YufLn/kZbhTnvbA/gmcSofgh9vv08DxTOZJzujOpDlE5jyahwRDJWUQjG0JrExJ6TbCuX
 wGY59iwAAAA
X-Change-ID: 20260420-work-pidfs-6152879f9434
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iGKUrAWyqAzRf4aYmyWkH/uQRw9E60UxprO7RB5zYwE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+0/qVWvE95e/BEn8J1nCeeJ8TXt91mLrXZN3bc+x0i
 t4dwVXxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ/4CR4dh7x7wpHhxcDXdj
 5Jrqll5krtikn76ds8FC6Xq/uOW0Z4wMzQeb/Bd7vUu5+n6q4cO+F/ee5JblO181efx89WYb/up
 PbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Three independent pidfs bug fixes, each with a Fixes: tag.

Patch 1 fixes PIDFD_THREAD flag loss when pidfds are opened via file
handles. PIDFD_THREAD is defined as O_EXCL, and do_dentry_open() strips
O_EXCL from f_flags, so thread pidfds obtained via open_by_handle_at()
silently end up with PIDTYPE_TGID scope. pidfs_alloc_file() already
restored the flag after dentry_open(); factor that into a shared
pidfs_open_file() helper and use it from pidfs_export_open() too.
Without this, pidfd_send_signal() on a thread pidfd reopened from a
file handle delivers to the entire thread group instead of the
specific thread.

Patch 2 fixes pidfs_xattr_get() returning 0 when no xattrs have ever
been set (attr->xattrs == NULL). The VFS interprets 0 as "xattr exists
with a zero-length value", so getxattr() on a pidfd reports success
for non-existent xattrs. Return -ENODATA instead, matching
simple_xattr_get().

Patch 3 enforces the documented PIDFD_GET_INFO contract that the
kernel must not set a mask bit unless the user buffer is large enough
to carry the corresponding field. Today PIDFD_INFO_COREDUMP,
PIDFD_INFO_COREDUMP_SIGNAL and PIDFD_INFO_SUPPORTED_MASK are returned
in the mask without checking usize against PIDFD_INFO_SIZE_VER1/VER2.
copy_struct_to_user() stops at min(usize, ksize) so no kernel memory
leaks, but userspace that trusts the mask as documented will read its
own uninitialized buffer as if it were valid data. Gate the mask bits
on usize.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      pidfs: fix PIDFD_THREAD flag loss when opening pidfds via file handles
      pidfs: return -ENODATA from pidfs_xattr_get() when no xattrs exist
      pidfs: don't report pidfd_info fields that won't fit in the user buffer

 fs/pidfs.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)
---
base-commit: e774d5f1bc27a85f858bce7688509e866f8e8a4e
change-id: 20260420-work-pidfs-6152879f9434

