Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0939EF30
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549319; cv=none; b=iquh04j7c47tUetQtc2jTo6Db/hjoRVq8aP226xbC87dzZld1EcJV8zcRtkOkcsA2us8xbygnWDOBwIvkqMsQ670wVGD9rangLy64vh7XsgBQS8THXJErw259P3gsPiOi5grI0e+jrLyxKYh9YtyB2DnjltFZ6o1j9AQoORkWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549319; c=relaxed/simple;
	bh=C5r4ww8Ifnvew0an6ZthN5YCgNIjJPKD9B4WNSaLwiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2Uq8OiHTSrHHSGeH8tCUbFAhA021ZaKkB/X3A4iAK1FzPaJ2AYuwThWInWzXLxUqal3tzvIwdw64ud9xS+ynBaQ1HwQj4v5ozq5vQlYvfcDdPzDrjyVUvhev1uNqcS+sj4dLWhOPvO6Wk9pXJSmnIPQz3hBw6lP5FOxrpezdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=P9Dhbc0F; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="P9Dhbc0F"
X-KPN-MessageId: 82cca90a-2940-11f1-8a9a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 82cca90a-2940-11f1-8a9a-005056ab378f;
	Thu, 26 Mar 2026 19:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=pBEQIKTiU3fwZ6Nij+WjfgEGwFKmXgDXRlbHjibsZEQ=;
	b=P9Dhbc0F1KfKylqt9InxrrdeZSw71yvyP53ULvLHkj9kpEVmThnN0rhGL24d2Iob7ZEHGKf5RpDjf
	 OoS5tUdvSLA5ndeLoj2zh3pKZfRcO0q2pOnYongXfyoNR4mWCdFHP8Vt5swWFw4+9lzK5Pi25jkyFN
	 NkHl6D0z7LTc0PAyeYltGCg0QFseHBv1I8iN1n4L1MYboS9yKvo/HVMl4emUiK68jeyB4sbQu3ohQR
	 NFjaMaxINb07KFkGZm0yiSLoX0GP75FwfVShNVeijQAVxlzA27WBamHcNMjjLbvmmLeAvNtClNXEfk
	 4X5C7G5FFj0yo6R3QuId+6Ru1Juz+uQ==
X-KPN-MID: 33|TaeqvgRrLobnIERyjTd7kzO7lPDiE3GRNvy3UApQoMJo63BihqXgdakmW/1nsZV
 6uH9L2b1JbGXpdioLTQkGmQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hpxKMcZcI4xNXRN1VZKPGY0DcSK88opBLORxA/W2xZR3BaE1n6C1RE0HRp4yQh/
 TIdLPkFsVFNJK4xJehlFUXw==
Received: from daedalus.home (unknown [178.231.230.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7f75c826-2940-11f1-b8e8-005056ab7584;
	Thu, 26 Mar 2026 19:20:47 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>,
	Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 0/3] vfs: transitive upgrade restrictions for fds
Date: Thu, 26 Mar 2026 19:20:11 +0100
Message-ID: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add upgrade restrictions to openat2(). Extend struct open_how to allow
setting transitive restrictions on using file descriptors to open other
files. A use case for this feature is to block services or containers
from re-opening/upgrading an O_PATH file descriptor through e.g.
/proc/<pid>/fd/<nr> or OPENAT2_EMPTY_PATH (if upstreamed) as O_WRONLY.

The implementation idea is this: magic paths like /proc/<pid>/fd/<nr>
(currently the only one of its sort AFAIK) go through nd_jump_link() to
hard set current->nameidata. To include information about the fd
yielding the magic link, we add a new struct jump_how as a parameter.
This struct may include restictions or other metadata attached to the
magic link jump other than the struct path to jump to. So far it has
only one unsigned int field: allowed_upgrades. This is a flag int that
(for now) may be either READ_UPGRADABLE, WRITE_UPGRADABLE, or
DENY_UPGRADES.

The idea is that you can restrict what kind of open flags may be used
to open files in any way using this fd as a starting point
(transitively). The check is enforced in may_open_upgrade(), which is
just the old may_open() with an extra test. To keep this state attached
to the fds, we add a field f_allowed_upgrades to struct file. Then
in do_open(), after success, we compute:

	file->f_allowed_upgrades =
		op->allowed_upgrades & nd->allowed_upgrades;

where op is the struct open_flags that is build from open_how in
build_open_flags(), and nd->allowed_upgrades is set during path
traversal either in path_init() or nd_jump_link().

The implementation and the idea are a bit rough; it is the first bit of
less trivial work I have done on the kernel, hence the RFC status. I
include some selftests which this patch passes (on my machine at least),
and nothing seems to break on a fresh vng kernel. But obviously there
may be many things I am overlooking.

The original idea for this features comes form the UAPI group kernel
feature idea list [1].

[1] https://github.com/uapi-group/kernel-features?tab=readme-ov-file#upgrade-masks-in-openat2

v2: includes tests and the related OPENAT2_EMPTY_PATH patch in a series.

Jori Koolstra (3):
  vfs: add support for empty path to openat2(2)
  vfs: transitive upgrade restrictions for fds
  selftest: add tests for OPENAT2_EMPTY_PATH and allowed_upgrades

 fs/fcntl.c                                    |   4 +-
 fs/file_table.c                               |   2 +
 fs/internal.h                                 |   1 +
 fs/namei.c                                    |  41 ++-
 fs/open.c                                     |  20 +-
 fs/proc/base.c                                |  24 +-
 fs/proc/fd.c                                  |   6 +-
 fs/proc/internal.h                            |   4 +-
 include/linux/fcntl.h                         |  11 +-
 include/linux/fs.h                            |   1 +
 include/linux/namei.h                         |  15 +-
 include/uapi/linux/openat2.h                  |  10 +
 tools/include/uapi/linux/openat2.h            |  53 ++++
 tools/testing/selftests/openat2/Makefile      |   4 +-
 tools/testing/selftests/openat2/helpers.c     |   2 +-
 tools/testing/selftests/openat2/helpers.h     |  40 +--
 .../testing/selftests/openat2/upgrade_test.c  | 242 ++++++++++++++++++
 17 files changed, 417 insertions(+), 63 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h
 create mode 100644 tools/testing/selftests/openat2/upgrade_test.c

-- 
2.53.0

