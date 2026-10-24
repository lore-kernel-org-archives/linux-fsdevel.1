Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815225;
	b=rPsstY3tSGp4wFUiLjsA6eHFvfp9tQynHZnc4YP05x7RFsm3fKeUY+gwwhdVX6jJRFuD
	 ggj58Q62ijePv15JGtDIDt8HwSFaGVpuRguPUc+DXeG557YI7mTUdoNMaXu7MsyytefZh
	 KLkbSN7GRYCYKHFeGfoJv+OS2yyp6ufURyuRV/MYugoh/BR/wykrVPzRfbizRDNXddAIv
	 YoagqClQB+tHNviqg6rF/gl5/9B54q8m29aYNXnzFzfXJBJ3Cch1Ml32X3Yr90xhbWtj3
	 YBmIdaCPseb+7KqukKN0AmO72HrXp5vIhTwMfhzm3bqsoqto6xtGEPN89MQVkI7YULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815225;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tok1er5AmW1mSYkj3WLtobkd9nTdl7poVUwqFdX2ADs=;
	b=5ATESCcZZNN84/zrvD+KyOcT6QpfWY+R0QCm2fykAxAovS1ncT9+LDhYJ2uXJHZL86Hz
	 BbIUNUl86q/4Z+qAJwl8wGcXlHPGIQaG41Lz18qC0xa7ZObVQ3bI1QV5Z0zt8+1h5Snck
	 yhkIaH0Fi076PYgIj9ehQm0edGPCQ7OuwbhFoxAAPrwhGie3XLKlrSEcgn3+mCDIupiNd
	 fGcva9svRehkgRWLbXYApu+FIpZfuLgZGs/NKJRFkheLgn+IVgZz03XYoXYDXxCKCfThY
	 QYT+vRXI1KgHZuCjD0D5bvXQLZ1v3/OjxbCzH3vqsahguAs/GHUiez3UlpnWBHwr9UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CBA606A31B;
	Sat, 24 Oct 2026 04:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CBA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xKT8Q-00EPeW-NU;
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
Subject: [PATCH v2 0/2] pidfs: do not report fields that do not fit into the caller's struct
Date: Sat, 24 Oct 2026 00:13:32 -0400
Message-ID: <20261024041334.831273-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017020634.792390-1-nickolai@csail.mit.edu>
References: <20261017020634.792390-1-nickolai@csail.mit.edu>
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

PIDFD_GET_INFO sets the mask bits of fields that lie beyond the struct
size the caller passed, although the uapi header promises that the mask
names no such field and tells userspace to rely on the mask. Patch 1
clears those bits before the copy. Patch 2 adds a selftest for it.

Tested in a QEMU x86_64 guest: the new test fails without patch 1 and
passes with it, and the other pidfd selftests give the same results with
and without patch 1. Built with W=1 for x86_64.

The bug was found and fixed with the assistance of an AI agent.

Changes in v2:
- Split the selftest into its own patch (Christian Brauner).
- Rebased onto current mainline. struct pidfd_info has no new fields
  since v1, so the size checks are unchanged.

v1: https://lore.kernel.org/all/20261017020634.792390-1-nickolai@csail.mit.edu/

Nickolai Zeldovich (2):
  pidfs: do not report fields that do not fit into the caller's struct
  selftests/pidfd: test that fields beyond the struct size are not
    reported

 fs/pidfs.c                                    |  8 ++++
 tools/testing/selftests/pidfd/pidfd.h         | 16 +++++++
 .../testing/selftests/pidfd/pidfd_info_test.c | 48 +++++++++++++++++++
 3 files changed, 72 insertions(+)


base-commit: 17bb0e2f6c8043f70a693a5f3797471cbed354c8
-- 
2.53.0

