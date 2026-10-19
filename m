Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434598;
	b=fyRYgk9UrxS3ksqOcN2sxYwkzdEog4Kp7S4xQVcd6Yl6MBQ47Q8UZoG42J3Y7lkR4eKY
	 qd5MctvOtPS12O6PZA1uhG+V9EpPEROWD2F25STozotGifLbx63fCzTCIEP/BzUODf2WA
	 ceQCp3/1hD6XIrX2FZQjRQSM+MY66ON2+206C4H7bgWxnHokYtjQiKQpZun6TE6687OLi
	 4BD01Mq1/eJxqTrlBMKXOTV9fbYBKr/UPVPPxI570IXqKN4onDFHIiH3UKjU0c9PUWfF0
	 zSMVtaW1LfwhipbjPRHZQiknU6bveq4ouwqwo7DET5t/uOkYkNxNObrLz/iCaItxxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ryMN7FspYYeuz9q2JwGP8JZkmnnmqzmHQjeHzQubOBI=;
	b=GuKDSM6L+76QRkLJconbWC7b62vlD0lu+KDgylsI5fHcuG/mdelsfrCIR4t1S2RidX8y
	 yeMaah5dLysMzE09t1Obtjdjb5SRQ4dhL5BGDchnZzqt25sZ+U0+f8HuWYKiC5lG9J41K
	 NdeHwy/kgteLWEynaUr13HDZWS989mQWw+RlP1IOmNrDU6PvPTXfAujjFfVTDuJhMWMgg
	 OHSrbqbFIfi7u2wQzJiptmacP8bmY+U+tfhDYWLcxFDO4xlTzGVIm0uJtZxdL/Qr5Gz0m
	 IBOokaL9PyE4w5mKZfJiEya7TVu/Tn142kv9Mag+rE1vHobqS70tXbSYcMcasfrxxdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q5Q35urr;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE55606A32D
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 18:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE55606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q5Q35urr
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35ef6b49813so4600107eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792434597; x=1793039397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryMN7FspYYeuz9q2JwGP8JZkmnnmqzmHQjeHzQubOBI=;
        b=q5Q35urr6rCgOeG2epMNHEQvKgYthXGp521NM1MXNt3XXReE+JJIpWG0cIjS0uIcEk
         Aq6NeSKfc/eLfgYuZc1PH9xDTri5E6b6z4z2Ef/aFMR0HJ469oxDV0xel+ROneGh/imO
         6nZv3ssnkA3ShD3k5y5l347ksRb/w06LH+dKrw1oVNwg1Mljso23Twjqi+7Mm9plkwJl
         ILFMGOxy5EGKoRy31OldeknkpaII5Q//pW0gztLmwHxWUD5a0C46Zs/v/orLZoxieO3E
         RSkT+lAhSY1Q85LhyCiV80UJ+k3mQlfOEmREQiK3wtdI2H3TvnWhIjo3ahfY0kSRh+ID
         mGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792434597; x=1793039397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryMN7FspYYeuz9q2JwGP8JZkmnnmqzmHQjeHzQubOBI=;
        b=KR4DUeKSZGFnCJ8rngVDL7JHXUYQdrF32rwP2oOwqr4/V4sEXk4yV6P2tDTSMbZHuJ
         kgL7raYHftAV+qpOKnX/EK36i/jhV0SwBSiKacDYaiCOSOLsoDuhncJLpiVKz3yFJ59u
         CWBlzauFcGH2Q2JwTxj4ZW1Su2Ne3hjbsBlgD5IBmS0YTMClBzJixF1AXa9j+aCa7e8G
         ZcHqf+f0SWGGDswlUnc3lppiEPAXB6S9IINMrLxcPg53KyTNRkJvwmgNl5X/DnDBHRe3
         6YdSCbJCfPBzmqeqsQ/8XgLPN74bet6ot0KclYqF5jbS+J9a7gjKFax8Dcs975yltZ4U
         PuFA==
X-Forwarded-Encrypted: i=1; AKwUvBzZ1GV81FQqWt3YcvBJ6NEDyMpzfQlGGA5i6o+zlILmUl1yZtkSwroTbqIr0/Embk/37w9KkYB2fj7MyBOk@vger.kernel.org
X-Gm-Message-State: AFq9FYJArYqjE52fL9SWWeAFUT3QJVr4ZANZEfYNgdMx3wIyJ/JJzy1k
	o4CsLEMyVpfLTClHyThU3WyFgkHNu1kPLE1OiBvzoDQNW+WMdyKa4nmE
X-Gm-Gg: AYBFou20eszr/qRk5jQsDcsfeYMckj7PBg2hBLF/GkniOlm/LPaLya8CbPwwIyTLIzF
	4mYs42Vwa9ztu2AIolHrY7zZcq2RQ8D91i39EEmKd7cFof2ugoe5o5YZIptnPwwzQ9dt3EtRvQI
	S2SINWt1b/PKAy4BPQ3Asz8HNRU25F50efj/5NGZJt5NG7TQ6/ww+hBbyqrfA2k+nVZBHjyuz5R
	ShHKZ+SlnX9Is1GammKfQawPqBDwzOM0LvtLr9A7M8mJ/Ual1g+vuyERtav8GEA7eJq3ZAK4nRj
	R5S0Hzpy6CP6L0yBO7i9EgsumjHDWPSCpYrWnR2+uSIVQttS6FsB7Z7dkqpyrGx0fL6wSixDFve
	rrAW5usp9YD1mr5NWrm8Fti1CzNQs8r1Fe7Ze+l4osane/BR4zpChn0dObgOnAhaaYOt0o0GPJE
	lR2CirXfOvNm+J7DKN3rpqATQ15C+Nggn5N5NKNYx08a7hJOqT7qQFB4bkNjhvTNfJ5UHyFnePi
	HogjApgYWJnS+smA1xp0KImSwzUXkP8Rpo=
X-Received: by 2002:a05:7301:7305:b0:34e:9923:e372 with SMTP id 5a478bee46e88-361a2b35aefmr11654736eec.29.1792434596820;
        Mon, 19 Oct 2026 11:29:56 -0700 (PDT)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b792bsm35009576eec.5.2026.10.19.11.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:29:54 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: target-maintainer@vger.kernel.org
Cc: Pranith Kumar <bobby.prani@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] eventpoll: separate nested-check objects by cache line
Date: Mon, 19 Oct 2026 11:29:33 -0700
Message-ID: <f1968f55f65acf6e2f4edccb280e9d8c4dabe3d4.1792433364.git.bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792432666.git.bobby.prani@gmail.com>
References: <cover.1792432666.git.bobby.prani@gmail.com>
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

The generation stamp, topology rwsem, and global mutex occupy one
64-byte line in the ARM64 build. Readers of the stamp can therefore
share a line with frequent rwsem updates from independent workers.

Align the stamp and rwsem independently on SMP builds. This leaves
the mutex on a separate line as well. The rwsem reader count remains
a shared object; this change only removes mixed-object sharing.

On the local four-core workload, nested throughput rose
from 5,325,959 to 5,487,081 pairs/s (+3.03%) over the parallel-add
change.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 fs/eventpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5f7cd03107b3..ffe2c12858ab 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -422,7 +422,7 @@ static long max_user_watches __read_mostly;
 static DEFINE_MUTEX(epnested_mutex);
 /* Hash collisions only reduce concurrency. */
 #define EP_FILE_LOCK_BITS 8
-static DECLARE_RWSEM(epnested_rwsem);
+static __cacheline_aligned_in_smp DECLARE_RWSEM(epnested_rwsem);
 static struct mutex ep_file_mutexes[1 << EP_FILE_LOCK_BITS];
 
 static struct mutex *ep_file_mutex(struct file *file)
@@ -430,7 +430,7 @@ static struct mutex *ep_file_mutex(struct file *file)
 	return &ep_file_mutexes[hash_ptr(file, EP_FILE_LOCK_BITS)];
 }
 
-static u64 loop_check_gen = 0;
+static u64 loop_check_gen __cacheline_aligned_in_smp;
 
 #define PATH_ARR_SIZE 5
 
-- 
2.47.3

