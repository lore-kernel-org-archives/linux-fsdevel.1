Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E848D885
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000147; cv=none; b=dsBMD8DzKzfByEDU6nldnHNJ5zD+0drlfTpDGoqWwVNwwIlW/yoJyQb12OgKNzD9+Y3hwKakfJJcslqGtyvcSGF20g2BlGjaW8Vf5ZhcUKbac5GqzrnuW+YkfrIRamponMHz8Y07G6MBrZJY2rUKfHz50aaHzjs0z2ZFl2J6uRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000147; c=relaxed/simple;
	bh=a+3vxOkeLt21AlXl1uAe/FaYpCPjm4kRzdwaC1txkJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CVjbuwOzDcey2hi7oXo2U2Z9jAF/ECSh7nwEZtrrE8dfULtk7Yh0d1RTaZI+eKAOUGFbzz0rqVEo5YtguM6//9gKTGR7dELqLV6cxAoNSfvaXXj50egAI8qrOPyBaAvh9LssEnRG4vtaBMeyF2nikU5DoId7K5EOdn/0bCtoq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfZ0KwFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfZ0KwFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327351F000FF;
	Mon, 21 Sep 2026 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000145;
	bh=IJ4XjXcV0nXXfgqEKNDxHFaKiKC73zfxZQFUKjHBGB0=;
	h=From:Subject:Date:To:Cc;
	b=OfZ0KwFglGd1iQTUcfvzmWIhSADC/CbGQ0eN6tSUIXe7wBxioUIvmfO6TDcfN4Sid
	 rcpCe9IpwAgASnWgPomWvsD8/nQWpZU26s4McQq8MZIhSqsRVBGzyv9CQUEeJuNoH5
	 YeFeQ8TApnM9FqzHwS2aqeB2dbXyW6bRbsOurtyyuc1TGPJkYuk/7h43XG9J+eUCGE
	 4Aeidt0w5g2SLAguIYkGdsTdKT8QVfDl83x9KW1k81SQT4dlCNtHcM0Pmge9Ecny4e
	 mlPH5sXBvZa5I0fKAqcW3UHxR76KLt/2/1piX8l7f0aWdy/LzaD8KsgID3SPAvZWJa
	 YX8w7Whx32BQg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/10] files,close_range: add
 CLOSE_RANGE_{CLOEXEC_ONLY,EXCEPT}
Date: Mon, 21 Sep 2026 16:15:28 +0200
Message-Id: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMQQ6CMBCF4auQWTtNi5GgVzGG0HEqVQKkg0pCu
 LsdXbr8X16+FYRTZIFTsULiV5Q4DjncrgDq2uHGGK+5obRlZY+uxveYHhhiz0j9KNwkPTW8EE8
 zsrOWgt/Xh8pBJqbEIS5f/nz5tTz9nWlWUx++FUafEep0Ut2obv51o1/Ytg8PKNlXtAAAAA==
X-Change-ID: 20260918-work-file-close_range_except-e100cfb38561
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a+3vxOkeLt21AlXl1uAe/FaYpCPjm4kRzdwaC1txkJ4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOH5dGVj0cwq9nknAlXlSh5XX5iwYo/9VY7MFObnp
 aIOmf/edpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEv5rhD9fnP0JGi/15l68/
 s8//iuufDNmVq+6rhDpURS+3N8ucsIaR4fmSE3GT65zSivTaX+prhjgxiHGkO177mCk8US+puNW
 HGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

close_range(CLOSE_RANGE_CLOEXEC) marks a range of file descriptors
close-on-exec. It only marks them. The file descriptors are only ever
closed during an exec. This series adds two new flags to extend the
abilities of close_range():

(1) CLOSE_RANGE_EXCEPT

    While regular close_range() operates on all file descriptors in the
    range [fd, max_fd] and not on any others, CLOSE_RANGE_EXCEPT makes
    close_range() operate on all file descriptors outside of the range.

    When combined with CLOSE_RANGE_UNSHARE dup_fd() never takes a
    reference on what is dropped.

    A task between clone(CLONE_FILES | CLONE_VM | CLONE_VFORK) and
    execve() that has the descriptors for the child in one window can
    shed the rest of the shared table in one call:

            close_range(lo, hi, CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT)

    Nothing outside of the window is referenced by the child at any point.

(2) CLOSE_RANGE_CLOEXEC_ONLY closes the close-on-exec file descriptors
    in the range

    Whatever the caller deliberately passes down, stdio, LISTEN_FDS, an
    inherited pipe, remains where it is.

    The handful of close-on-exec descriptors the caller still needs for the
    exec such as the executable, an error pipe, can sit in a specific
    range. A task between clone(CLONE_FILES) and execve() may do:

            clone(CLONE_FILES | CLONE_VM | CLONE_VFORK)
            child: close_range(lo, hi, CLOSE_RANGE_UNSHARE |
                                       CLOSE_RANGE_CLOEXEC_ONLY |
                                       CLOSE_RANGE_EXCEPT)
            child: rearrange descriptors in the now private table
            child: execve()

    Between the clone and the close_range() the child holds no reference of
    its own on any file because copy_files() only bumps the fdtable
    refcount. So a close() in the parent takes effect immediately. The
    unshare also never takes a reference on the fds it leaves behind either.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (10):
      file: let dup_fd() leave the punched hole behind
      selftests/core: test the hole CLOSE_RANGE_UNSHARE leaves behind
      file: rename dup_fd()'s punch_hole to range
      file: let dup_fd() drop everything outside of the range
      close_range: turn the flags into an enum
      file: add CLOSE_RANGE_EXCEPT
      selftests/core: test CLOSE_RANGE_EXCEPT
      file: let dup_fd() drop only close-on-exec descriptors
      file: add CLOSE_RANGE_CLOEXEC_ONLY
      selftests/core: test CLOSE_RANGE_CLOEXEC_ONLY

 fs/file.c                                       | 200 ++++-
 include/linux/fdtable.h                         |   9 +
 include/uapi/linux/close_range.h                |  31 +-
 tools/testing/selftests/core/close_range_test.c | 951 ++++++++++++++++++++++++
 4 files changed, 1151 insertions(+), 40 deletions(-)
---
base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
change-id: 20260918-work-file-close_range_except-e100cfb38561

