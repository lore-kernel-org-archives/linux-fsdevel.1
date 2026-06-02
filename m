Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B783D333A;
	Tue,  2 Jun 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422718; cv=none; b=DxARg+DfUbs7lI7TQ1pPeKGS3vHfQxz7muT41uK7096UTcn5Eu0VZmKonl7GYhHrLWObKMh4iHDCIpjsEUyAbcwUvtuqBuNhc8sAOieb6g92GRRqDx4Bn+GuTa2GrHKQIJ5fNbJTJLjcoJ6wPZ25ZxDRizrtFevTWMXJ9vyeieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422718; c=relaxed/simple;
	bh=3ci/hbEoVGCBTOrIA5XRYnSg5tJH02x5F9iniWA2FEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYMWwG7LFfmwd8iD+aXuyksiMMkpXzO5aU2CSHd0aUcdtRS3CbuTBpG92cEbbnCUb2fp1BiB/46g7i+MKOza7hgk14WgDcSkmj9w8nElBKIzfMevwoq7tT9FjFlhJX38L6BSTBAtWFdd97z9pli99sU21HV1/nUB/TGYl/Hzvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvWY7Uf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8l2Lj1h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvWY7Uf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8l2Lj1h"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780422715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFXp5znFbgJjYsfAFbPyD409nOv0oE1uOXzaWe8XUqA=;
	b=BvWY7Uf6flMYXlIjZPvzYYfLBVFs/4qy7MMEg9dK5HQMblXs6X6dIJoP4CY+mvxpHTfklA
	YVLG199tcIWCiy/l2C8i6o43iolz6c75Ye2g6ewi9saDtucKQNi59pVcHnCbxmCVr55TVQ
	bZclu6vmr2Gdxi4xA04tQP509K3aFmRUJmtp/OhaK4uSCW3cDblPXAj1q7Muct5mUv4NrD
	DZz72eUqATkOBn5ZZU5uJxorvm4Z7ltqwYnQMxY4WxXiiLu6qQWz/p6NRMhbVdu/pOkEsf
	moBTcIAOwzKPasc39g1L9z7N/QRJX1k7oP0gFQYWs84yIjNoKyCmZ+4+P48+Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780422715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFXp5znFbgJjYsfAFbPyD409nOv0oE1uOXzaWe8XUqA=;
	b=v8l2Lj1h4Oz3tRToIvEU9AFfmjBYE+MJyQtTRysAyPiCPMCGO/lB8fzOtYcfzuUlnLuCkV
	9PVeoKkqp4siRaAA==
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 0/2] eventpoll: Fix epoll_wait() report false negative
Date: Tue,  2 Jun 2026 19:51:44 +0200
Message-ID: <cover.1780422137.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While staring at epoll, I noticed ep_events_available() looks wrong. I
wrote a small program to confirm, and yes it is definitely wrong.

This series adds a reproducer to kselftest, and fix the bug.

v3: rebase onto vfs tree
v2: Switch to seqlock solution

Nam Cao (2):
  selftests/eventpoll: Add test for multiple waiters
  eventpoll: Fix epoll_wait() report false negative

 fs/eventpoll.c                                | 20 ++++++++-
 .../filesystems/epoll/epoll_wakeup_test.c     | 45 +++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

--=20
2.47.3

