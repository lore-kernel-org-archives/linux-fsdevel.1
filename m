Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019C280037
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037309; cv=none; b=cuA4SG1sxJWfGScaeNkUxYGvIrCYFl9CPAUhF1NIK9yy86MFdpfnUA7AhCy0Hr3loDpipMeRttvlE/ywkkix4734gf79gpRBUigvwFtlKFLIt4ThLir1DWjD56KzwGtIHp1xQ+2KkEeiLgNPPmyJzVwHY+iLKRj/vD6LIhgUaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037309; c=relaxed/simple;
	bh=NX9sxun1XImawaW3HNJPif9/m7BqzSn01p3yn71f0CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXYP3kupxFaoWLWNuXHDHeq3ONQ23DWSXNEmVvcESmyY4mqGoLe+S6oBe6Bx2KEr/rc/0+U5fhb613CsyJHFf5cPrEH0UnnykZ5OqJlykU+QQVn1dEo0oDp3UIyAuGcAcWZdjfxv/QrhD4tqoTAghFuCjCghh5XHGPW23LFxCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WDtAkJ3v; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WDtAkJ3v"
X-KPN-MessageId: 10f6524d-5212-11f1-8ff5-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 10f6524d-5212-11f1-8ff5-005056999439;
	Sun, 17 May 2026 19:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ddj1lfdufowCrUnJjx1R0uoyRGQWv1F2QGbinrCyE+8=;
	b=WDtAkJ3vUvVzP07rhnYb7PeUTd1Hefl7GYr/D8hRj5fBKN0Eqa70JkciV2ehjjRIGE6IdD228pUiw
	 afSh5M6yZJtTgTY9OrH6NGvjg4QlxX7CqNBK7XV4Rr2nIY62ZzOkE0osNqOQFi8ReOhicSa998BCRc
	 9xjmufGvT5m+XSEvdJj1rJgey/lsPQjfniPOhK0puRKn/pzkf65b3SVjsMfYQjlym/5fE7BUmoTcMe
	 KT7bEctt11mRnEo05rrsu65Robrek3J2XyRp0BfaQohjOESqBT9Gbhjvzymsld8snMmPG2FmX9bdAX
	 +Uc8mnTdRbAqAjTTMSmBsfHxsg2HNlQ==
X-KPN-MID: 33|lLROOmM72CnLS70l6Z8OowqRjHlpI9YplwGf2UoQQLeBZJo2GDobZCbB1X5TK2s
 VpIiU54VuLRhZJkakRzzqj8hOUyrocmMCKoYIUuA8tFg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XuNk1UKl5nzZtJqejfO5DPIH6Hty3P29vTXRJ233QdKWQpIc0pcNY7d6XPmFx0g
 G7qN3lrArbNcPFWurDD4oPA==
Received: from daedalus.home (unknown [178.227.141.161])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0ed154c3-5212-11f1-abb2-00505699b758;
	Sun, 17 May 2026 19:01:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v3 0/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 17 May 2026 19:02:42 +0200
Message-ID: <20260517170244.1832119-1-jkoolstra@xs4all.nl>
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
directory, and return a pinning fd (which mkdir does not).

Feedback on the v2 rfc of this patch was to not introduce a new syscall
(mkdirat2) but implement this functionality as O_CREAT|O_DIRECTORY in
open*(2).

Two comments from me upfront:

- This patch just EINVAL bans O_CREAT|O_DIRECTORY for filesystems that
  define atomic_open(). I figure it is better to (dis)allow on a fs per
  fs basis. So feedback per filesystem on what is the appropriate course
  of action on receiving O_CREAT|O_DIRECTORY would be very useful.
- If we create a regular file with mknod, before creation
  security_path_mknod() is called, and after creation
  security_path_post_mknod(). If we create a regular file using O_CREAT
  (and this is also pre-patch) only security_path_mknod() is called. Is
  this the correct behaviour?

Jori Koolstra (2):
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/namei.c                                    | 186 +++++++++++-------
 fs/open.c                                     |  23 +--
 include/uapi/asm-generic/fcntl.h              |   2 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_directory.c    | 147 ++++++++++++++
 7 files changed, 283 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_directory.c

-- 
2.54.0

