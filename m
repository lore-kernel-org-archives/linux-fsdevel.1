Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741F42F6F2;
	Fri, 10 Jul 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694773; cv=none; b=enQ9hT9FnH4niSletZiZ2kaTIvoa/6J5kXzN3lu87pUoUUn5xEPxTBvKlCSvdtK3XOUpIjj8qNaFgGfpRny6RgCipT2ILA2QSlXSrlY3FjQcHRSspD55sHvHG1nIZlkGnPiYCMEMpqnHgS3/65IpuJ5BXEt/btj0WAbzKEv3WDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694773; c=relaxed/simple;
	bh=elAE6D5Z++pEyg1DyynZG9mJNbmNvM6lzkncroj9yek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHJl6Jz6EQ9qnlNsbXUa1eXxYmD13t7BmicWV6qV7KJJBjxYtL9eW8QVQ/2TVehyvZDD0nGM1HCAbZfOP1OGeYRABDYuh+q36EwLqv/GasWrtHCp5Qmv2gylLXVtYEELJ5JNrcRyGZl82nJRrIe57RUL4aJBBLK/DHAxlwjhET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCvB8fsI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3qdUi3R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCvB8fsI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3qdUi3R"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783694770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cNxbM391+Qm3cGBLaONG5xv7fKBiXEdYVvGFwCkYBdE=;
	b=UCvB8fsIfRz7eQbjSvm6R9nnSsi87XOTbOFr0pgLS61IhnuME60Icy4fA1BuCN0xuA/3Q0
	pzVTHNMU8hiZsJ7Wdi5x/4WhxuqIGHLpM1L40/8sCUTP4lKc5BJjc7mRpOT5dZC6oEebDH
	cWee3AYJcwW2Y8mrdA1sJHTQib6RP2Hc6b3+U7lzpzqBs3q7c2Pzi2xN+HvFwAXTOUjzxo
	jqNlg4TavjdQRSzdTOl8JpsOVOvQMMyuYT43cCjYZyqooX5MeIHh4Bp31pCZJeMTk8uMpp
	6JSB/OZUB1fHeviN1x1E1bK+jE2A2gb0e+LBH2JOvUKkBpIya9O1Ln6fsamM1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783694770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cNxbM391+Qm3cGBLaONG5xv7fKBiXEdYVvGFwCkYBdE=;
	b=i3qdUi3RLz8QnJDBe0cnUZKhqk+V4oSoxswgo7rphDJqxbGp8JJCmgscnz+QUO3rHyA4Ys
	+5/Fb4y4A2bMAzCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Chris Down <chris@chrisdown.name>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH printk 0/3] Introduce sync mode
Date: Fri, 10 Jul 2026 16:51:50 +0206
Message-ID: <20260710144609.194487-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

As proposed in an LKML thread [0], here is a series to introduce a
new console feature to use synchronous printing. The feature is
activated using the keyword "sync" in the console= command line
argument. For example:

   console=ttyS0,115200,sync

Sync mode is only available for nbcon consoles that provide a
safe write_atomic() callback. Specifying it for other consoles
will have no effect other than a log entry that sync mode is not
supported.

Patch 3/3 shamelessly copied an implementation from Chris Down
to parse and update the console options. (Chris's version of 
find_and_remove_console_option() is here [1]). I slightly extended
the function to support valueless-options.

At some point we may want to add a sysfs interface to toggle sync
mode.

John Ogness

[0] https://lore.kernel.org/lkml/87v7aruub1.fsf@jogness.linutronix.de
[1] https://lore.kernel.org/lkml/77aa59337507e067f3a4ad7e15375893612bcfa3.1763492585.git.chris@chrisdown.name

John Ogness (3):
  printk: Introduce console sync mode
  proc: Add console sync support for /proc/consoles
  printk: Support setting console sync mode via console=

 Documentation/admin-guide/serial-console.rst |   8 ++
 fs/proc/consoles.c                           |   1 +
 include/linux/console.h                      |   2 +
 kernel/printk/console_cmdline.h              |   1 +
 kernel/printk/internal.h                     |   2 +
 kernel/printk/nbcon.c                        |  42 ++++++--
 kernel/printk/printk.c                       | 104 +++++++++++++++++++
 7 files changed, 154 insertions(+), 6 deletions(-)


base-commit: 080d60fffa8e0d285871cde8395438006a9b5b0c
-- 
2.47.3

