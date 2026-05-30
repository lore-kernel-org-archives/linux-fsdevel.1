Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524136920D;
	Sat, 30 May 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133931; cv=none; b=nhVhFAg/EpK0AwyEB+Q2s5kUiIonXfZdrKKWgXxpxJ9vJy3+LG3KAnptxX1jYErRs7UmI+zUfUjK9B+JSWAWk6hqBY8CREG8u++GFweLoTol6LOzLXKc4PM19JHg+YFcYl40Zlox3xxneSTwmDIwvVjtHwRr3gC9EKVVVOyXHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133931; c=relaxed/simple;
	bh=pWTLBwiGlrxcyJ+0RK+Ry99mfk6JSH5M0IlflqTGqiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byk8H2F8fci8Oki+wPydYavAh0Uea5L0KU5urCQh4H7BF1PSjh5/S8g/kVk1DuIo7h2uAMcK5Agb6cGmUDbrRSACzYfTjKWbNb7gNjkIvkRNz96mTH1TdcBOgiaQOiFZN3GETdBAHPouVQXWWZ52pu8MXCl5/wo3mwG/6P481Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQxDAuJN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7Z9AnG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQxDAuJN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7Z9AnG/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780133921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FVZrerUcr6b8wyTsKl742IIvubpJCahaogmndvD3sJg=;
	b=TQxDAuJNZWjcrPpoz5NB/gnDo/0UrB440P4hJDdLCWrb3BsF9sRW9PaPq2Wi1uWXlS89h8
	uExb6C+O5RKRFHEZB1Gro7FxGuc2IQkULEMJKmWzuurNbsZhC3sYLObCTTAJBsUjk3twZg
	vbkda7eeKitRiFTTVCfeFTUIyYlgKNWMk/2bo9Cq9rsEZza9H3WF0vJuVSSt4KSozZTixa
	pPas16k/CEofUitc+O3Xe4oyxm797LKlc1/RH2rUAxJvKIkekvo8YT5p26Mc44ES+uu8PR
	EwRapVqYRM8qfejxHWAjMrIc8882WOQX2e+nZIQR4fopWMCp+RmjLryBkKh+/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780133921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FVZrerUcr6b8wyTsKl742IIvubpJCahaogmndvD3sJg=;
	b=S7Z9AnG/pcQf4DHHQL3nD1mCArjgMGlTJ0laoqP/fY7upY+vImkh6EJ1ydMLqx/6XFZ2ca
	NlAdMvE2ULYr9TBg==
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
Subject: [PATCH v2 0/2] eventpoll: Fix epoll_wait() report false negative
Date: Sat, 30 May 2026 11:37:30 +0200
Message-ID: <cover.1780133499.git.namcao@linutronix.de>
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

v2: Switch to seqlock solution

Nam Cao (2):
  selftests/eventpoll: Add test for multiple waiters
  eventpoll: Fix epoll_wait() report false negative

 fs/eventpoll.c                                | 20 ++++++++-
 .../filesystems/epoll/epoll_wakeup_test.c     | 45 +++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

--=20
2.47.3

