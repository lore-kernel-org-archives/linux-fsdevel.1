Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815225;
	b=Bl3Vb3kXa/R4UZEW2RhsRabq8sVcYDvoN2ZYfGD+7hKozCKWIq1DpV/jd009R5v9pfMv
	 c3zbcC8zJWVY6Rng44jSy7TEIUU3X7xyt/kjtu7zyp1jX65bU7gmK+9Z/bmy4vQq8xMI5
	 krBdaz2Oh3Xp6SXdDYi70e4HLevV6CaKpwO4bOhT5f+pAAc029tjbYW0ouDzDFpySItml
	 yY7RXduUQU04k0Y4cNvysIbfsjs0i9PyHTNvQlLaG4U2Ukhm6tE3kJ1rgoysytK+zSIp4
	 xKjC/g0apPAm3mtRTZ19l3XefU2rZRT15x1W5ACQdbMJ5X8CaBCA7/2j6KTMNxkJjOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815225;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QS+RFzYYs6EY3mLVW/oXk1QJzBbByUuQ69LxvNIG7j0=;
	b=rtK+qxtQG5KeK5KdcghndTBwb/BeQFMJxGbtiIkJjS/E+NPzZcHumzdN6o9M2zMB539M
	 hkfI/ezftSfCj27DzFiUMgpQCyndfEaRG6lX6mPP2rdBUp3XlnPWFbjIj3tGQf3w46VmR
	 mcwOyv5QFlL8ug4Jsnu7dgeTcIqBcI+pDFgDHdawEgxmXZ+JbFxJmPYy5pjWFa7F9lIy5
	 HIIRR0a+9kgM6GRTyYBC4V5mDlnxNHM+o2pLMHghvLtDOXh6MbH1ajnrhIuOHEBmbpO6K
	 Diyjabtoc1xvrh2PTu7Gp2iWqS5PKe/4mH7nA7pYIOZDIIka78lvyqKr8NfOysp0lRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F35606A31D;
	Sat, 24 Oct 2026 04:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F35606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xKT8Q-00EPeW-QM;
	Sat, 24 Oct 2026 00:13:34 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2 1/2] pidfs: do not report fields that do not fit into the caller's struct
Date: Sat, 24 Oct 2026 00:13:33 -0400
Message-ID: <20261024041334.831273-2-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024041334.831273-1-nickolai@csail.mit.edu>
References: <20261017020634.792390-1-nickolai@csail.mit.edu>
 <20261024041334.831273-1-nickolai@csail.mit.edu>
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

The documentation of struct pidfd_info promises that "If the structure
size is too small to contain a field (requested or not), to avoid
confusion the mask will not contain a bit for that field", and asks
userspace to trust the returned mask when deciding which fields hold
valid data.

pidfd_info() does not keep that promise. It builds kinfo.mask without
looking at the size encoded in the ioctl command, and
copy_struct_to_user() then truncates the copy to that size. A caller
that passes a 64-byte struct (PIDFD_INFO_SIZE_VER0) and requests
PIDFD_INFO_COREDUMP or PIDFD_INFO_SUPPORTED_MASK gets a mask with
PIDFD_INFO_COREDUMP, PIDFD_INFO_COREDUMP_SIGNAL, PIDFD_INFO_COREDUMP_CODE
and PIDFD_INFO_SUPPORTED_MASK set, while the coredump_* and
supported_mask fields behind the 64 bytes were never written. Trusting
the mask as documented, userspace then reads whatever its own buffer
held at those offsets. The same happens for a 72- or 80-byte struct
and the fields added after it.

Clear the bits of the fields that lie beyond the caller's size before
the copy, in the one place that knows both the final mask and the size.
A request for a field that cannot be returned is thereby answered the
way the header describes: the field is simply absent from the mask.

Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    The three size thresholds follow the field layout: coredump_mask and
    coredump_signal end at PIDFD_INFO_SIZE_VER1 (72), coredump_code at
    PIDFD_INFO_SIZE_VER2 (80), supported_mask at PIDFD_INFO_SIZE_VER3 (88).
    Masking the request bits early instead (before the coredump and
    supported_mask blocks run) would save a little work for such callers
    but leaves PIDFD_INFO_COREDUMP set by the dumpable-state fallback for a
    live task; clearing the result once before copy_struct_to_user() covers
    every way a bit can be set.

 fs/pidfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7f8c323ce6cb8..cdb0916eae71b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -485,6 +485,14 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		kinfo.supported_mask = PIDFD_INFO_SUPPORTED;
 	}
 
+	/* Only report fields that fit into the caller's struct. */
+	if (usize < PIDFD_INFO_SIZE_VER1)
+		kinfo.mask &= ~(PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL);
+	if (usize < PIDFD_INFO_SIZE_VER2)
+		kinfo.mask &= ~PIDFD_INFO_COREDUMP_CODE;
+	if (usize < PIDFD_INFO_SIZE_VER3)
+		kinfo.mask &= ~PIDFD_INFO_SUPPORTED_MASK;
+
 	/* Are there bits in the return mask not present in PIDFD_INFO_SUPPORTED? */
 	WARN_ON_ONCE(~PIDFD_INFO_SUPPORTED & kinfo.mask);
 	/*
-- 
2.53.0

