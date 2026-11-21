Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289696;
	b=o90hG56XcO19K6I3yVbfTuR04w7wU1zjJICGvDUAS+6+TGYnqJ/y9Q+bGbntNP5oJG1e
	 r4gQxeZrbhZFm88A7dHdAUFR6L1C6qwxDbFRkRTciq02xvry91F5W0Sw0CWqGOnSjMx/k
	 9ekZtkZnw6iO16t1Wg/S5LyB0Jg8s2HC5VF9LUlVP3w5zLkx5a9ZQwn8QVoWuur5IeX4W
	 lw9Ri1Y3tcb7BcNXZuNbXfluOqFgE3gwfCkUHqQ5H/lO/OPJjlpy4Gpu/bCg4cYAZ+J4K
	 QOBuHboLkA+nUVQzxVjjhFGquOVeBRbc+dG4jkFPo8fT3FjRXLA6jKh/E4BEo+so1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n5ZnpCxALSpimlZbz+ysdwCQ7qxNjOgOx10w71IS4KQ=;
	b=UJ03VvsDywFyyxSgZEfZBkSaG5cV34Zbn4aNqr+N5MwoDy0pNCB8jK9jXw2xQTfy+zvA
	 pUXx2rKgFJokrdB84YBNLu3PmX6hwaAAQg7kTQasU+8M0H27k+TUHx0dtnwq7BF8DAj/G
	 dYQ5tbfuQTf51i4AvBEYID58SduL1Kawt5zPhN53QyZe8wMmT807iyKZV8bztHdTB/CJM
	 DM+SIQKdi1tZ8y27iGOqvRJ2WgZuZrcgdh1UJ+73lYXWM1gv+IY6GY85zetmsCx0k/iss
	 LF46yf8ld71fsupOYL9NZKjtAUEclR6mXf8sw2W1SbvXYddfYY7JFudxzqdxF6ncetA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFfjWxj3;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9D606A320
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 19:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F9D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFfjWxj3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so7924625e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795289694; x=1795894494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5ZnpCxALSpimlZbz+ysdwCQ7qxNjOgOx10w71IS4KQ=;
        b=jFfjWxj3Yvj4oNqD7D+livIIw1prdztnBFVWXeISH05y72ksTpXjmPM0Z05gSL+Mu8
         whT/jP3IRkvo8MpCsIqeIZzyDDG5A/ewg09CW1cZGaGa1sNKOK5nQ2VnHkkepxvv5d0z
         9QICjsYFNotjwblXS3EybXhYxR4ynCk92SdOVHZJbbmWYnp5knlfcJeDQKIplLVe3q5G
         9QPRamiXuXSYLbLio5MQTG3ADwDZzglS4+6TUWlwRx+3otCncuwMHiNS3izRx6uGWWpF
         kkqrbFZPfC48f5QvLGrQNKxisZjyUYKcMUk2/t4OlCcvjJ7dnrvJCrZTgLaTyMcYzJeI
         qdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795289694; x=1795894494;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5ZnpCxALSpimlZbz+ysdwCQ7qxNjOgOx10w71IS4KQ=;
        b=ySDtKLDo5n4TZI7yP+1yINMp3STxHvN2+gvMg6250pBnfBZzh2Jxdc7qZJvlpdoxre
         mwyKVfGoig2ixG7hFawg04qqVdS66sBJLzYlT4W7rBBL16j7Z4xcCOfd4oGscx8fiRnA
         pO65lXzrbLbZem5SCIQHxdYh1d6eVDYV8YcUBVldBm65Z+17osQyXOfGe7pyNYRVpCXd
         TazYscaYt6AsClIxDen4t2WZCI1OoYV19InrN8JtLCTrYeivZ9WJfwSqTvOwIaUdXzij
         0n1/fsLwpeFdP57iQnagvAfR7hF1QOassaOjEdR0tdtcgAHgeOLuicHdRYxH9h76zdN/
         y64g==
X-Forwarded-Encrypted: i=1; AL+hErE65SoGEgGs09pmNHsL70RO/B69MMoU4Eq7C8Ra/bQA/NzPn/urKrumzQkD2A0O0eOpW0bFesdlLqmnRX3g@vger.kernel.org
X-Gm-Message-State: APuU4Z+tNdEksDWQBtaDP5OcqK0B87In0tGgfMcda+fv6bjLFdbfQBjC
	N1puRclsOOkBQ/SgLbsVM6H6Gkl6c0oMmVlduOeVqzo6SmjA+QRiTnXK
X-Gm-Gg: AZFdTZeQ2cUjilT6v0KPEPzBrBzS2362uiykqoyzmO0IcEid8GpywY/OjGs+Trlzmto
	O2FZh9Nv/KbdGnX6d4s/yvy8Qcyg1rMjJIAigIdwbD9fiIz4kSC1/vViMxYuZaIDguSAh5eFLJE
	FtJ14UvQIa/yEgrcFN48Ma8NnHrsdZ2ww/srTlSXH2FJ/mJh7I1hwwm6soYuwTaVUKb+JCcikXf
	UPONs3gR5tXYWEXkoTwBEw53L95Y/4YpKrlUnoQj5yRq6S17aSGJl6RBojmGinqpERyc99KXaSM
	9iab9fYFpZvQrSfuGfSzTiwM6DSnVJ9z3dqNVLdGuUACgLcUbrTVj/LtB+zv7giFcZxicyWi5RK
	5eL/ZOkQUQjRwOt9qnaRNp7lNqgiNKYmNN5QseQc2STE8uTjSwnWIvJD00WuzBqpArsfR8nqOp8
	pIgwycDeXbL6IE6OHzHK0fFJKDkNvmKAn+OdafWTdiDjIhISopTsSmOhAy9vvo3UJcfjT3dvxXP
	gpdaY/oVuUZiRq+ZcXriXOqKOym7CxyVH810jmjwRRhlr9BOLFQyrsfOTt8kxtFIxL1xQdEyIrC
	OXwHSq+f+ZX6erFUAO5gpb9cjWfIZ79x5BS9JJi/ivBFVVeAuA==
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb88817920mr169852215e9.22.1795289693852;
        Sat, 21 Nov 2026 11:34:53 -0800 (PST)
Received: from NullSecurityX.localdomain ([178.244.203.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm69591845e9.2.2026.11.21.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:34:53 -0800 (PST)
From: =?UTF-8?q?Ozan=20A=C4=9Fdepe=20=28NullSecurityX=29?= <agdepeozan@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	corbet@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ozan=20A=C4=9Fdepe=20=28NullSecurityX=29?= <agdepeozan@gmail.com>
Subject: [PATCH] Documentation: failfs: setns() back out needs no privileges
Date: Sat, 21 Nov 2026 22:34:46 +0300
Message-ID: <20261121193446.105396-1-agdepeozan@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "Leaving" section says the remaining way out of failfs is setns()
with a mount namespace file descriptor and that it requires
CAP_SYS_ADMIN over the target mount namespace as well as CAP_SYS_CHROOT
and CAP_SYS_ADMIN in the caller's user namespace. That reads as if an
unprivileged task in failfs that holds no namespace file descriptor
cannot get out.

It can. A pidfd names the namespaces of another task without a path
lookup. create_user_ns() refuses chrooted callers, but userns_install()
does not, and the caller owns every user namespace created by its
effective uid below its own. setns(pidfd, CLONE_NEWUSER | CLONE_NEWNS)
on a task that runs in such a user namespace and in a mount namespace
owned by it passes validate_nsset(), userns_install() and
mntns_install(), and mntns_install() resets root and working directory
to the root of that mount namespace. Rootless containers, bubblewrap
and browser sandboxes all run such tasks.

Verified on v7.3 with an unprivileged caller: after
fchroot(FD_FAILFS_ROOT) open("/etc/passwd") and unshare(CLONE_NEWUSER)
fail as documented, and after setns(pidfd, CLONE_NEWUSER | CLONE_NEWNS)
open("/etc/passwd") succeeds.

The section already says leaving is not a guaranteed interface and that
seccomp has to restrict setns() among others, so only describe the path
accurately.

The issue was found during an AI-assisted review of fs/ and
kernel/user_namespace.c. The reproducer, the documentation text and
this changelog were drafted with the assistant and reviewed and tested
by the submitter.

Fixes: a45a6605cd04 ("Documentation: add failfs documentation")
Signed-off-by: Ozan Ağdepe (NullSecurityX) <agdepeozan@gmail.com>
---
 Documentation/filesystems/failfs.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/failfs.rst b/Documentation/filesystems/failfs.rst
index 21ff2db79..c34e29403 100644
--- a/Documentation/filesystems/failfs.rst
+++ b/Documentation/filesystems/failfs.rst
@@ -65,9 +65,18 @@ implementation, not a guaranteed interface, and may be loosened later.
 For now a process that entered failfs counts as chrooted, so it cannot
 create user namespaces to regain ``CAP_SYS_CHROOT``, and ``chroot(2)``
 or ``fchroot(2)`` back out require ``CAP_SYS_CHROOT``. The remaining way
-out today is ``setns(2)`` with a mount namespace file descriptor, which
-requires ``CAP_SYS_ADMIN`` over the target mount namespace as well as
+out today is ``setns(2)`` into a mount namespace, which requires
+``CAP_SYS_ADMIN`` over the target mount namespace as well as
 ``CAP_SYS_CHROOT`` and ``CAP_SYS_ADMIN`` in the caller's user namespace
-and resets both root and working directory. A process that holds no such
-file descriptor and restricts ``*chdir()``/``*chroot()``/``setns()`` via
-seccomp cannot currently get back out.
+and resets both root and working directory.
+
+That way out does not need privileges or a namespace file descriptor. A
+pidfd names the namespaces of another task without a path lookup, and
+joining an existing user namespace is not refused for a chrooted task
+the way creating one is. An unprivileged caller can thus leave with
+``setns(pidfd, CLONE_NEWUSER | CLONE_NEWNS)`` on any task it may access
+in ``PTRACE_MODE_READ`` mode that runs in a user namespace owned by the
+caller's effective uid and in a mount namespace owned by that user
+namespace. A process that restricts
+``*chdir()``/``*chroot()``/``setns()`` via seccomp cannot currently get
+back out.
-- 
2.53.0

