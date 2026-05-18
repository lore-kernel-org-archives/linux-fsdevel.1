Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349015665C
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123172; cv=none; b=cAk6at0NmNzXw18Fn7XQVNAkfT4iVH1nrM40DpFHxqJw9kH7HpatG6kxE+TqEkAKtN3n/lBU1UUeYSusi4gAa6OquXN5niOjA06i5Lz72DTtKM/H6MfKcjdzRHM84Wk+gK+xjZhlg8uvzebRarzCsVBVOuFzC45BeghavlEODA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123172; c=relaxed/simple;
	bh=USEKATtRMiFiwWlGwSjTTGVWkHT8xLZEblrWxgEs3TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoXeqOAGqGTI0wyIaIIgJA0WV8FRfFA/alfzO8WSySJQZqhZMdwa1V21WCXnhDEE8Jusgfxl+7AKWPbU0fl0I6LasGbhzmEmRoZFKmm9bbX4urYRvsgmkPGWM0IBuHnOAVuZSAFXsxgq/iiqTwD6AD8YX6HucqKM9qDcDfJmJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=rmKeL9wF; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="rmKeL9wF"
X-KPN-MessageId: d6ff70aa-52d9-11f1-b189-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d6ff70aa-52d9-11f1-b189-005056abad63;
	Mon, 18 May 2026 18:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=M7B7kKE0eLi9GOIOi1kULGBY3rbxyElnnDLj0aVHnjQ=;
	b=rmKeL9wFyCinC4djiCEWxhF7CrIu1pHZjZZfBMJ7UTqltJeYnYEUHQ825yBqG0ogMiTBraAliFTgi
	 ++O/6XhildIokJX3k76jbKfYZ5vyaDxtjpeUqDq+tkj+6b9SR3eOWU/M+L+5+cnqUM8B5q+bz2nuSV
	 zO1wK/wYa+A2sfZkYfDhHrtUqxqEWChH707xxv3y2ltme3u6INoXAUyclC3OIUpt9rebYDoYuc0hHw
	 cDa1D/n/N3t2ZOp1rYSXzlj+5awmIoYWBK2r5XqIDZtKDehb2haeFPuchixT0WEm4yEm6D6YCdXkS1
	 vEjhg+dIBiwB3FZ4iWFgbGCaa+vHMww==
X-KPN-MID: 33|Pumk+v5QEMb/tWBIF4yScYnp0HwIclVNAS6v3cq7Br+82OOBMCendVRQhOvaEl7
 RCCIulP6T4jMLFUsVfPNGOGPnLAIxSeNdLTfNhQI0pYE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gPwIyX8fQ2PCUud7AEkpvKL2s7DTB1mS7l8GdlEjGqjedawuOzdIHkVLL/JxpKs
 TbiE6UkdbcD6hMmo7x5vK/g==
Received: from daedalus.home (unknown [178.227.141.244])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d412cc48-52d9-11f1-8011-005056ab7447;
	Mon, 18 May 2026 18:51:39 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jori.koolstra@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [RFC PATCH v4 0/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Mon, 18 May 2026 18:52:35 +0200
Message-ID: <20260518165237.2084042-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements new semantics for the O_CREAT|O_DIRECTORY flag
combination for open*(2): perform a mkdir and open the resulting
directory; return a pinning fd (which mkdir does not).

Feedback by Christian Brauner and Aleksa Sarai on the v2 rfc of this
patch was to not introduce a new syscall (mkdirat2) but implement this
functionality as O_CREAT|O_DIRECTORY in open*(2). I had some very silly
bugs that syzbot alerted me of in v3, so here is v4...

Three comments from me upfront:

- This patch just EINVAL bans O_CREAT|O_DIRECTORY for filesystems that
  define atomic_open(). I figure it is better to (dis)allow on a fs per
  fs basis. So feedback per filesystem on what is the appropriate course
  of action on receiving O_CREAT|O_DIRECTORY would be very welcome.

- If we create a regular file with mknod, before creation
  security_path_mknod() is called, and after creation
  security_path_post_mknod(). If we create a regular file using O_CREAT
  (and this is also pre-patch) only security_path_mknod() is called. Is
  this the correct behaviour?

- open_last_lookups() locks the parent inode like like: 

		inode_lock(dir->d_inode);

  should this perhaps be

		inode_lock_nested(dir, I_MUTEX_PARENT);

  to stay consistent with the start_dirop() path that is used by
  filename_create() for instance in mknod(2)? I get that we are only
  locking one inode here at most, so it does not really matter, but
  now one regular file create path does set the lockdep and the other
  does not.

Jori Koolstra (2):
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/namei.c                                    | 180 +++++++++++-----
 fs/open.c                                     |  25 ++-
 include/uapi/asm-generic/fcntl.h              |   2 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_dir.c          | 200 ++++++++++++++++++
 7 files changed, 342 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

-- 
2.54.0

